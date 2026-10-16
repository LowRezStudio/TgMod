// Ability HUD module: everything about rendering the spectated player's five
// ability slots and cast bars. The interface is small — the server samples a
// device into the replicated struct, the client syncs the scene, and target
// switches reset the caches — while the implementation holds all per-target
// render state (cast-bar chase, ult ring, icon frame latches, width caches).
class TmAbilityHud extends Object
    dependson(TgObject);

// Server-sampled ability state pushed every 0.15s (remote pawns don't simulate cooldowns)
struct transient TmAbilityState
{
    var int DeviceId;
    var int Ammo;
    var int AmmoMax;
    var int CooldownPct;  // 0-100 remaining fraction
    var int CooldownSecs; // whole seconds remaining (timer label)
    var int Status;       // 1=locked(red slash), 2=ready, 3=cooling, 4=firing(spinner)
};

const ULT_SLOT = 2;
const ULT_DIM_ALPHA = 35.0;
// Full-ult burst grows the slot root; the neighbors "push" is just overlap.
const ULT_FULL_Y = 870.0;
const ULT_FULL_W = 280.0;
const ULT_FULL_H = 310.0;
const ULT_REST_Y = 894.0;
const ULT_REST_W = 218.7;
const ULT_REST_H = 242.2;
const ULT_RING_SCALE = 150.0;

// --- client render state (all of it per-followed-target) ---

var transient int LastStatus[5];        // previous tick's status for ready-transition flash detection
var transient int LastIconFrame[5];     // last icon frame written per slot; skips redundant GotoAndStopI/FadeIn
var transient int LastUltPhase;         // previous tick's ult phase (1=charging, 2=full) for pulse edge detection
var transient float UltRingNext;        // client TimeSeconds for the next recurring ready-ring flash
var transient int LastCastId[3];
var transient int LastCastCurMs[3];
var transient int CastShown[3];         // visibility latch per bar (US3 forbids bool arrays)
var transient float CastRecvTime[3];    // client TimeSeconds when each bar's CurMs last advanced
var transient float PredMs[3];          // chased fill position in ms (smoothing)
var transient float LastHudTick;        // client TimeSeconds of previous PostRender pass
var transient array<GFxObject> CastWidthCache; // [clip, full width] pairs for fill scaling
var transient array<float> CastWidths;

// --- shared (server + client): the UI index -> equip point layout ---

static function int GetSkillEqPoint(int UiIndex)
{
    switch (UiIndex)
    {
        case 0: return 1;   // Primary LMB
        case 1: return 3;   // Q
        case 2: return 2;   // Ultimate
        case 3: return 4;   // F
        case 4: return 16;  // Alt Fire RMB
    }
    return 0;
}

// --- server sampling ---

// Status and ammo from a live device. The caller owns the DeviceId fallback
// to PRI r_PlayerDevices (it has the pawn and PRI at hand).
static function SampleAbilityState(TgDevice Dev, out TmAbilityState S)
{
    local float Remaining, Initial;

    if (Dev == none)
        return;

    if (Dev.NativeIsFiring() || Dev.IsFiring())
    {
        S.Status = 4; // active -> icon spinner
    }
    // Only abilities get the cooldown sweep; weapons cool between shots.
    else if (Dev.IsAbility() && Dev.IsDeviceCoolingDown())
    {
        S.Status = 3; // cooling
        Remaining = Dev.GetCooldownRemaining();
        Initial = Dev.GetCooldownTimerManager().GetTimeInitial(0);
        if (Initial > 0.0)
        {
            S.CooldownPct = int(FClamp(Remaining / Initial, 0.0, 1.0) * 100.0);
            S.CooldownSecs = int(Remaining) + 1;
        }
    }
    else if (Dev.IsDeviceFiringLockedForUI())
    {
        S.Status = 1; // locked -> red slash overlay
    }
    else
    {
        S.Status = 2; // ready
    }

    if (Dev.r_nMaxAmmoClipCount > 0)
    {
        S.Ammo = Dev.GetCurrentAmmoAmount();
        S.AmmoMax = Dev.r_nMaxAmmoClipCount;
    }
}

// Server mirror of GetTimerBarInfo, ms precision for client-side fill. A
// RateMs of 0 keeps idle bars off (elapsed = rate - count; GetTimerCount
// returns remaining).
static function SampleCastBar(TgDevice Dev, out int CurMs, out int RateMs)
{
    local float Cur, Rate;

    if (Dev == none)
        return;

    Cur = 0.0;
    Rate = 0.0;

    switch (Dev.m_DeviceTimerBarType)
    {
        case 1: // DTBT_PreHit
        case 2: // DTBT_PostHit
        case 3: // DTBT_PersistTime
        case 4: // DTBT_RefireTime
            Rate = Dev.GetTimerRate(GetTimerBarName(Dev.m_DeviceTimerBarType));
            Cur = Rate - Dev.GetTimerCount(GetTimerBarName(Dev.m_DeviceTimerBarType));
            break;
        case 5: // DTBT_FireHold
            Cur = Dev.GetFireHoldPct();
            Rate = 1.0;
            break;
        case 6: // DTBT_Custom
            Cur = Dev.GetCustomTimerBarCurrentTime();
            Rate = Dev.GetCustomTimerBarMaxTime();
            break;
    }

    if (Rate <= 0.0)
        return;

    CurMs = FClamp(Cur / Rate, 0.0, 1.0) * Rate * 1000.0;
    RateMs = Rate * 1000.0;
}

// int literals: enum constants not visible cross-package
static function name GetTimerBarName(int BarType)
{
    switch (BarType)
    {
        case 1: return 'FirePreHitDelay';   // DTBT_PreHit
        case 2: return 'FirePostHitDelay';  // DTBT_PostHit
        case 3: return 'PersistTimer';      // DTBT_PersistTime
        case 4: return 'RefireTimer';       // DTBT_RefireTime
    }
    return '';
}

// --- client render state lifecycle ---

// Followed-pawn switch: drop per-target latches or the first paint uses stale state.
function ResetForTarget()
{
    local int i;

    for (i = 0; i < 5; i++)
    {
        LastStatus[i] = 0;
        LastIconFrame[i] = 0;
    }
    LastUltPhase = 0;
    UltRingNext = 0.0;
    for (i = 0; i < 3; i++)
        CastShown[i] = 0;
}

/** Hides all five skill slots' icon/CD/timer (no view target). */
function bool BlankScene(UIHudSkills SkillsHUD)
{
    local int i;
    local GFxObject Slot, IconObj, CDBot, CDTop, TimerTF, PctTF;

    // No target: reset latches so the next target gets fresh icons.
    ResetForTarget();

    if (SkillsHUD == none) return false;
    for (i = 0; i < 5; i++)
    {
        Slot = ProbeSkillSlot(SkillsHUD, i);
        if (Slot == none) continue;
        IconObj = Slot.GetObject("Icon");
        CDBot = Slot.GetObject("CDBot");
        CDTop = Slot.GetObject("CDTop");
        TimerTF = Slot.GetObject("Timer");
        PctTF = Slot.GetObject("Percent");
        if (IconObj != none) SkillsHUD.FadeOut(IconObj, 0.05);
        if (CDBot != none) CDBot.SetVisible(false);
        if (CDTop != none) CDTop.SetVisible(false);
        if (TimerTF != none) TimerTF.SetVisible(false);
        if (PctTF != none) PctTF.SetVisible(false);
        if (i == ULT_SLOT)
        {
            // Drop a grown full-ult slot back to its rest pose.
            Slot.SetY(ULT_REST_Y);
            Slot.SetWidth(ULT_REST_W);
            Slot.SetHeight(ULT_REST_H);
        }
    }
    return true;
}

/** Drives the UIHudSkills scene's 5 ability slots + cast bars from the replicated state. */
function bool SyncToScene(UIHudSkills SkillsHUD, TgPawn ViewPawn,
                          TmAbilityState Abilities[5], int UltCharge,
                          int CastIds[3], int CastCurMs[3], int CastRateMs[3], string CastNames[3])
{
    local int i, Frame;
    local int DeviceIds[5], Ammo[5], AmmoMax[5], CDPct[5], CDSecs[5], Status[5], PrevStatus[5];
    local float Pct;
    local bool bChanged;
    local GFxObject Slot, IconObj, CDBot, CDTop, TimerTF, PctTF, PulseObj, ShadowObj, ReadyObj, ActiveObj, AmmoObj;
    local GFxObject BtnObj, MouseObj, CastBar, AnimObj, EffectBotObj, EffectTopObj;
    local float CastTarget, ChaseAlpha;

    if (SkillsHUD == none || ViewPawn == none) return false;

    // Prev-status latches for transition detection (slot 2 holds the ult phase).
    for (i = 0; i < 5; i++)
    {
        DeviceIds[i] = Abilities[i].DeviceId;
        Ammo[i] = Abilities[i].Ammo;
        AmmoMax[i] = Abilities[i].AmmoMax;
        CDPct[i] = Abilities[i].CooldownPct;
        CDSecs[i] = Abilities[i].CooldownSecs;
        PrevStatus[i] = LastStatus[i];
        Status[i] = Abilities[i].Status;
        LastStatus[i] = Status[i];
    }
    PrevStatus[ULT_SLOT] = LastUltPhase;
    LastUltPhase = UltCharge >= 100 ? 2 : 1;

    for (i = 0; i < 5; i++)
    {
        if (i == ULT_SLOT) continue;

        Slot = ProbeSkillSlot(SkillsHUD, i);
        if (Slot == none) continue;

        IconObj = Slot.GetObject("Icon");
        CDBot = Slot.GetObject("CDBot");
        CDTop = Slot.GetObject("CDTop");
        TimerTF = Slot.GetObject("Timer");
        PulseObj = Slot.GetObject("Pulse");
        ShadowObj = Slot.GetObject("Shadow");
        ReadyObj = Slot.GetObject("Ready");
        ActiveObj = Slot.GetObject("Active");
        AmmoObj = Slot.GetObject("Ammo");
        BtnObj = Slot.GetObject("Btn");
        MouseObj = Slot.GetObject("Mouse");

        // Remote pawns have no client-side device id; reset the frame cache.
        if (DeviceIds[i] == 0)
        {
            LastIconFrame[i] = 0;
            if (IconObj != none) SkillsHUD.FadeOut(IconObj, 0.05);
            if (CDBot != none) CDBot.SetVisible(false);
            if (CDTop != none) CDTop.SetVisible(false);
            if (TimerTF != none) TimerTF.SetVisible(false);
            continue;
        }

        Frame = FindSkillIconFrameByDeviceId(SkillsHUD, DeviceIds[i], ViewPawn.GetBotId());

        // Status paint on transition only, else the cooldown dim gets repainted.
        bChanged = PrevStatus[i] != Status[i];
        if (bChanged)
        {
            Slot.SetAlpha(100.0);
            if (BtnObj != none) BtnObj.SetAlpha(Status[i] == 2 ? 100.0 : 0.0);
            if (MouseObj != none) MouseObj.SetAlpha(Status[i] == 2 ? 100.0 : 0.0);
            if (IconObj != none)
            {
                IconObj.SetAlpha(Status[i] == 3 ? 50.0 : 100.0);
                if (Frame > 0)
                {
                    SkillsHUD.CancelAnim(IconObj);
                    IconObj.GotoAndStopI(Frame);
                    IconObj.SetVisible(true);
                    IconObj.SetBool("_visible", true);
                }
            }
            if (ShadowObj != none) ShadowObj.SetAlpha(Status[i] == 1 ? 50.0 : 0.0);
            if (ActiveObj != none) ActiveObj.SetVisible(Status[i] == 4);
            if (ReadyObj != none) ReadyObj.SetVisible(Status[i] == 2);

            // Ready flash; skip on the first sample.
            if (Status[i] == 2 && PrevStatus[i] > 0 && PulseObj != none)
            {
                SkillsHUD.CancelAnim(PulseObj);
                PulseObj.SetAlpha(100.0);
                PulseObj.SetWidth(77.0);
                PulseObj.SetHeight(77.0);
                SkillsHUD.Animate(PulseObj, 0.5, UIANIM_ALPHA, 0.0,,, true);
                SkillsHUD.Animate(PulseObj, 0.5, UIANIM_WIDTH, 160.0,, 1, false);
                SkillsHUD.Animate(PulseObj, 0.5, UIANIM_HEIGHT, 160.0,, 1, false);
            }
            else if (Status[i] != 2 && PulseObj != none)
                PulseObj.SetAlpha(0.0);
        }
        else if (Frame > 0 && IconObj != none && LastIconFrame[i] != Frame)
        {
            // Same status, different device (weapon swap): swap art only.
            SkillsHUD.CancelAnim(IconObj);
            IconObj.GotoAndStopI(Frame);
        }
        LastIconFrame[i] = Frame;

        // Cooldown sweep: fill height + mask position track remaining fraction.
        if (Status[i] == 3)
        {
            Pct = float(CDPct[i]) / 100.0;
            if (CDBot != none)
            {
                CDBot.SetVisible(true);
                CDBot.SetHeight(80.0 * Pct);
            }
            if (CDTop != none)
            {
                CDTop.SetVisible(true);
                CDTop.SetY(80.0 - 80.0 * Pct);
            }
            if (TimerTF != none)
            {
                TimerTF.SetVisible(true);
                class'TmCore.UIUtils'.static.SetGameText(TimerTF, string(CDSecs[i]));
            }
        }
        else
        {
            // Level-triggered, so a reset or target switch can't leave the sweep frozen on.
            if (CDBot != none && CDBot.GetBool("_visible")) CDBot.SetVisible(false);
            if (CDTop != none && CDTop.GetBool("_visible")) CDTop.SetVisible(false);
            if (TimerTF != none && TimerTF.GetBool("_visible")) TimerTF.SetVisible(false);
        }

        // Firing spinner spins the Active child, never the icon art.
        if (Status[i] == 4 && ActiveObj != none)
            ActiveObj.SetRotation((ViewPawn.WorldInfo.TimeSeconds - float(int(ViewPawn.WorldInfo.TimeSeconds))) * 360.0);

        if (AmmoObj != none && AmmoMax[i] > 0 && Ammo[i] > 0)
        {
            // Current count only (native has no max field); hidden at 0.
            class'TmCore.UIUtils'.static.SetGameText(AmmoObj, string(Ammo[i]));
            AmmoObj.SetVisible(true);
        }
        else if (AmmoObj != none)
            AmmoObj.SetVisible(false);
    }

    // Ultimate slot.
    Slot = ProbeSkillSlot(SkillsHUD, ULT_SLOT);
    PulseObj = Slot != none ? Slot.GetObject("Pulse") : none;
    if (Slot != none)
    {
        IconObj = Slot.GetObject("Icon");
        PctTF = Slot.GetObject("Percent");
        CDBot = Slot.GetObject("CDBot");
        CDTop = Slot.GetObject("CDTop");
        TimerTF = Slot.GetObject("Timer");
        ShadowObj = Slot.GetObject("Shadow");
        ReadyObj = Slot.GetObject("Ready");
        EffectBotObj = Slot.GetObject("EffectBot");
        EffectTopObj = Slot.GetObject("EffectTop");

        Slot.SetAlpha(100.0);
        Slot.SetVisible(true);
        Slot.SetBool("_visible", true);
        if (Status[ULT_SLOT] == 1 && DeviceIds[ULT_SLOT] == 0 && ShadowObj != none)
            ShadowObj.SetAlpha(50.0);
        else if (ShadowObj != none)
            ShadowObj.SetAlpha(0.0);

        // Applied unconditionally; a cache gate leaves the gray placeholder stuck.
        Frame = FindSkillIconFrameByDeviceId(SkillsHUD, DeviceIds[ULT_SLOT], ViewPawn.GetBotId());
        if (Frame > 0 && IconObj != none)
        {
            SkillsHUD.CancelAnim(IconObj);
            IconObj.GotoAndStopI(Frame);
            IconObj.SetVisible(true);
            IconObj.SetBool("_visible", true);
        }
        LastIconFrame[ULT_SLOT] = Frame;

        if (UltCharge >= 100)
        {
            if (IconObj != none) IconObj.SetAlpha(100.0);
            if (TimerTF != none) TimerTF.SetVisible(false);
            if (PctTF != none) PctTF.SetVisible(false);
            if (CDBot != none) CDBot.SetVisible(false);
            if (CDTop != none) CDTop.SetVisible(false);
            if (ReadyObj != none) ReadyObj.SetVisible(true);

            // Aura clips on at full.
            if (EffectBotObj != none) { EffectBotObj.SetAlpha(100.0); EffectBotObj.SetVisible(true); }
            if (EffectTopObj != none) { EffectTopObj.SetAlpha(100.0); EffectTopObj.SetVisible(true); }

            // Burst grows the slot root, which reads as pushing the neighbors.
            if (PrevStatus[ULT_SLOT] != 2)
            {
                if (PulseObj != none)
                {
                    PulseObj.SetVisible(true);
                    SkillsHUD.CancelAnim(PulseObj);
                    PulseObj.SetAlpha(100.0);
                    PulseObj.SetXScale(100.0);
                    PulseObj.SetYScale(100.0);
                }
                SkillsHUD.Animate(Slot, 0.25, UIANIM_Y, ULT_FULL_Y,,, true);
                SkillsHUD.Animate(Slot, 0.25, UIANIM_WIDTH, ULT_FULL_W,,, true);
                SkillsHUD.Animate(Slot, 0.25, UIANIM_HEIGHT, ULT_FULL_H,,, true);
                UltRingNext = ViewPawn.WorldInfo.TimeSeconds + 0.01;
            }

            // Ring repeats every second while parked at full.
            if (PulseObj != none && ViewPawn.WorldInfo.TimeSeconds >= UltRingNext)
            {
                SkillsHUD.CancelAnim(PulseObj);
                PulseObj.SetAlpha(100.0);
                PulseObj.SetXScale(100.0);
                PulseObj.SetYScale(100.0);
                SkillsHUD.Animate(PulseObj, 1.0, UIANIM_ALPHA, 0.0,,, true);
                SkillsHUD.Animate(PulseObj, 1.0, UIANIM_XSCALE, ULT_RING_SCALE,,, true);
                SkillsHUD.Animate(PulseObj, 1.0, UIANIM_YSCALE, ULT_RING_SCALE,,, true);
                UltRingNext = ViewPawn.WorldInfo.TimeSeconds + 1.0;
            }
        }
        else
        {
            // Restore the rest pose or the slot stays stuck grown.
            if (PrevStatus[ULT_SLOT] == 2)
            {
                SkillsHUD.Animate(Slot, 0.25, UIANIM_Y, ULT_REST_Y,,, true);
                SkillsHUD.Animate(Slot, 0.25, UIANIM_WIDTH, ULT_REST_W,,, true);
                SkillsHUD.Animate(Slot, 0.25, UIANIM_HEIGHT, ULT_REST_H,,, true);
                if (PulseObj != none) PulseObj.SetVisible(false);
                if (EffectBotObj != none) EffectBotObj.SetVisible(false);
                if (EffectTopObj != none) EffectTopObj.SetVisible(false);
            }
            else if (PrevStatus[ULT_SLOT] == 0)
            {
                Slot.SetY(ULT_REST_Y);
                Slot.SetWidth(ULT_REST_W);
                Slot.SetHeight(ULT_REST_H);
                if (PulseObj != none) PulseObj.SetVisible(false);
                if (EffectBotObj != none) EffectBotObj.SetVisible(false);
                if (EffectTopObj != none) EffectTopObj.SetVisible(false);
            }

            // Charging: dimmed icon + charge digits + partial fill.
            if (IconObj != none) IconObj.SetAlpha(ULT_DIM_ALPHA);
            if (TimerTF != none)
            {
                TimerTF.SetVisible(true);
                class'TmCore.UIUtils'.static.SetGameText(TimerTF, string(UltCharge));
            }
            if (PctTF != none) PctTF.SetVisible(true);
            if (CDBot != none)
            {
                CDBot.SetVisible(true);
                CDBot.SetHeight(float(UltCharge) * 1.24);
            }
            if (CDTop != none)
            {
                CDTop.SetVisible(true);
                CDTop.SetY(140.0 - float(UltCharge) * 1.22);
            }
            if (ReadyObj != none) ReadyObj.SetVisible(false);
        }
    }

    // Cast bars: fill width chased per frame from ms samples.
    for (i = 0; i < 3; i++)
    {
        CastBar = SkillsHUD.GetObject("Cast" $ i);
        if (CastBar == none)
            continue;

        if (CastIds[i] != 0)
        {
            // New or remapped cast: reseed the chase or it lerps from the old position.
            if (CastShown[i] == 0 || CastIds[i] != LastCastId[i])
            {
                CastShown[i] = 1;
                PredMs[i] = float(CastCurMs[i]);
                CastRecvTime[i] = ViewPawn.WorldInfo.TimeSeconds;
                LastCastCurMs[i] = CastCurMs[i];
                CastBar.SetVisible(true);
                SkillsHUD.FadeIn(CastBar, 0.05);
                class'TmCore.UIUtils'.static.SetGameText(CastBar, CastNames[i]);
            }
            else if (LastCastCurMs[i] != CastCurMs[i])
            {
                LastCastCurMs[i] = CastCurMs[i];
                CastRecvTime[i] = ViewPawn.WorldInfo.TimeSeconds;
            }

            AnimObj = CastBar.GetObject("Anim");
            if (AnimObj == none) AnimObj = CastBar.GetObject("Bar");
            if (AnimObj == none) AnimObj = CastBar.GetObject("Fill");
            if (AnimObj != none)
            {
                // Chase the latest sample plus local extrapolation; small
                // regressions hold, big ones snap (timer restart).
                CastTarget = float(CastCurMs[i]) + (ViewPawn.WorldInfo.TimeSeconds - CastRecvTime[i]) * 1000.0;
                if (CastTarget >= PredMs[i])
                {
                    ChaseAlpha = FMin((ViewPawn.WorldInfo.TimeSeconds - LastHudTick) * 21.0, 1.0);
                    PredMs[i] += (CastTarget - PredMs[i]) * ChaseAlpha;
                }
                else if (PredMs[i] - CastTarget > 250.0)
                    PredMs[i] = CastTarget;
                PredMs[i] = FClamp(PredMs[i], 0.0, float(Max(CastRateMs[i], 1)));
                AnimObj.SetWidth(CastStoredWidth(AnimObj, CastWidthCache, CastWidths) *
                                 PredMs[i] / float(Max(CastRateMs[i], 1)));
            }
        }
        else
        {
            if (CastShown[i] != 0)
            {
                CastShown[i] = 0;
                SkillsHUD.FadeOut(CastBar, 0.05);
            }
        }
    }
    LastHudTick = ViewPawn.WorldInfo.TimeSeconds;
    for (i = 0; i < 3; i++)
        LastCastId[i] = CastIds[i];
    return true;
}

// --- skill icon lookup + slot clips ---

/** Spectated champion's m_Skills[] first, then scan every champion. */
static function int FindSkillIconFrameByDeviceId(TgGfxScene DataSource, int DeviceId, int ChampionBotId)
{
    local UIDataManager DM;
    local UIDataChampion Champ;
    local int i, Frame;

    if (DataSource == none || DeviceId == 0 || DataSource.m_pUIData == none) return 0;
    DM = DataSource.m_pUIData;
    if (DM.m_ChampionData == none) return 0;

    // Skill ids may be global (like burn ids), so fall through to all champions.
    if (ChampionBotId > 0)
    {
        for (i = 0; i < DM.m_ChampionData.m_Champions.Length; i++)
        {
            Champ = DM.m_ChampionData.m_Champions[i];
            if (Champ != none && Champ.m_nBotId == ChampionBotId)
                return FindSkillFrameInChampion(Champ, DeviceId);
        }
    }
    for (i = 0; i < DM.m_ChampionData.m_Champions.Length; i++)
    {
        Champ = DM.m_ChampionData.m_Champions[i];
        if (Champ != none)
        {
            Frame = FindSkillFrameInChampion(Champ, DeviceId);
            if (Frame > 0) return Frame;
        }
    }
    return 0;
}

static function int FindSkillFrameInChampion(UIDataChampion Champ, int DeviceId)
{
    local int i;

    for (i = 0; i < Champ.m_Skills.Length; i++)
        if (Champ.m_Skills[i].m_nId == DeviceId)
            return Champ.m_Skills[i].m_nIcon;
    return 0;
}

/** Resolves a skill slot clip: Skill0/1 under GroupA, Skill2 at scene root, Skill3/4 under GroupB. */
static function GFxObject ProbeSkillSlot(UIHudSkills SkillsHUD, int UiIndex)
{
    local GFxObject Group, Slot;
    local string ClipName;

    ClipName = "Skill" $ UiIndex;
    if (UiIndex <= 1) Group = SkillsHUD.GetObject("GroupA");
    else if (UiIndex >= 3) Group = SkillsHUD.GetObject("GroupB");

    if (Group != none)
    {
        Slot = Group.GetObject(ClipName);
        if (Slot != none) return Slot;
    }
    return SkillsHUD.GetObject(ClipName);
}

/** Un-hides the skills HUD at scene/group/slot level (the game hides it for spectators). */
static function ForceSkillsVisible(UIHudSkills SkillsHUD)
{
    local GFxObject Groups[2], Slots[5];
    local int i;

    SkillsHUD.SetVisible(true);
    SkillsHUD.SetBool("_visible", true);
    SkillsHUD.SetFloat("_alpha", 100.0);

    Groups[0] = SkillsHUD.GetObject("GroupA");
    Groups[1] = SkillsHUD.GetObject("GroupB");
    for (i = 0; i < 2; i++)
    {
        if (Groups[i] != none)
        {
            Groups[i].SetVisible(true);
            Groups[i].SetFloat("_alpha", 100.0);
        }
    }

    for (i = 0; i < 5; i++)
    {
        Slots[i] = ProbeSkillSlot(SkillsHUD, i);
        if (Slots[i] != none)
        {
            Slots[i].SetVisible(true);
            Slots[i].SetFloat("_alpha", 100.0);
        }
    }
}

/** Full width of the cast-bar fill, captured once before any SetWidth override. */
static function float CastStoredWidth(GFxObject Obj, out array<GFxObject> Cache, out array<float> Widths)
{
    local int Idx;

    if (Obj == none) return 0.0;
    for (Idx = 0; Idx < Cache.Length; Idx++)
        if (Cache[Idx] == Obj)
            return Widths[Idx];

    Cache.AddItem(Obj);
    Widths.AddItem(Obj.GetWidth());
    return Widths[Widths.Length - 1];
}

defaultproperties
{
}
