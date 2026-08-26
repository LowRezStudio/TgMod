class UIUtils extends Object
    abstract
    dependson(TgObject);

const ULT_SLOT = 2;
const ULT_DIM_ALPHA = 35.0;
// Native ready-pulse pose (UUIComponent_HudSkillIcon_Ult::Update).
const ULT_PULSE_X = 870.0;
const ULT_PULSE_W = 280.0;
const ULT_PULSE_H = 310.0;

// Health-bar frames shared with other mods.
const HEALTH_FRAME_SHIELD = 5;
const HEALTH_FRAME_SHADOW = 6;
const MAX_FILL_TICKS      = 100;
const MAX_HEAL_ENTRIES    = 12;

/** Copies DisplayInfo + Width/Height from SrcParent.GetObject(Name) to DstParent.GetObject(Name). */
static function MirrorClip(GFxObject DstParent, GFxObject SrcParent, string ClipName)
{
    local GFxObject Src, Dst;
    Src = SrcParent.GetObject(ClipName);
    Dst = DstParent.GetObject(ClipName);
    if (Src == none || Dst == none) return;
    Dst.SetDisplayInfo(Src.GetDisplayInfo());
    Dst.SetWidth(Src.GetWidth());
    Dst.SetHeight(Src.GetHeight());
}

/** SetText on the first existing text holder: Parent.TF -> Text -> textField -> SetText. */
static function bool SetGameText(GFxObject Parent, coerce string Text)
{
    local GFxObject TF;
    local string Names[3];
    local int i;

    if (Parent == none) return false;
    Names[0] = "TF";
    Names[1] = "Text";
    Names[2] = "textField";
    for (i = 0; i < 3; i++)
    {
        TF = Parent.GetObject(Names[i]);
        if (TF != none) { TF.SetText(Text); return true; }
    }
    Parent.SetText(Text);
    return true;
}

/** Dst.SetText(Src.GetText()) with none guards. */
static function MirrorText(GFxObject Dst, GFxObject Src)
{
    if (Dst == none || Src == none) return;
    Dst.SetText(Src.GetText());
}

// TextureLoader (tgscript.widgets.TextureLoader)

/** Loads Url into a CLIK UILoader/TextureLoader; no-ops if _source already Url. */
static function bool LoadTextureLoader(GFxObject Loader, string Url)
{
    local array<ASValue> Args;
    local ASValue V;
    local GFxObject Holder;

    if (Loader == none) return false;
    if (Url == "" || Url == "undefined") return false;

    if (Loader.GetString("_source") != Url)
    {
        Loader.SetString("_source", "");
        Loader.SetString("source", Url);
        V.Type = AS_String;
        V.S = Url;
        Args.AddItem(V);
        Loader.Invoke("load", Args);
    }
    Loader.SetVisible(true);
    Loader.SetBool("_visible", true);
    Loader.SetBool("visible", true);
    Loader.SetFloat("_alpha", 100.0);
    Loader.SetAlpha(100.0);
    Holder = Loader.GetObject("contentHolder");
    if (Holder != none)
    {
        Holder.SetVisible(true);
        Holder.SetAlpha(100.0);
    }
    return true;
}

static function bool SyncIcon(GFxObject CloneIcon, GFxObject OrigIcon)
{
    local string Url;
    if (CloneIcon == none || OrigIcon == none) return false;
    Url = OrigIcon.GetString("initialSource");
    if (Url == "" || Url == "undefined") return false;
    return LoadTextureLoader(CloneIcon, Url);
}

static function int FindBurnIconFrameByDeviceId(TgGfxScene DataSource, int DeviceId)
{
    local UIDataManager DM;
    local int i;
    if (DataSource == none || DeviceId == 0 || DataSource.m_pUIData == none) return 0;
    DM = DataSource.m_pUIData;
    if (DM.m_CommonData == none) return 0;
    for (i = 0; i < DM.m_CommonData.m_BurnAll.Length; i++)
        if (DM.m_CommonData.m_BurnAll[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnAll[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnA.Length; i++)
        if (DM.m_CommonData.m_BurnA[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnA[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnB.Length; i++)
        if (DM.m_CommonData.m_BurnB[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnB[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnC.Length; i++)
        if (DM.m_CommonData.m_BurnC[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnC[i].m_nIcon;
    for (i = 0; i < DM.m_CommonData.m_BurnD.Length; i++)
        if (DM.m_CommonData.m_BurnD[i].m_nId == DeviceId)
            return DM.m_CommonData.m_BurnD[i].m_nIcon;
    return 0;
}

static function GetSpectatedBurnIds(TgRepInfo_Player ViewPRI, TgPawn ViewPawn, out int DeviceIds[4], out int Powers[4])
{
    local int i, eq;
    local TgDevice Dev;
    for (i = 0; i < 4; i++)
    {
        eq = 8 + i;
        DeviceIds[i] = 0;
        Powers[i] = 0;
        if (ViewPRI != none)
        {
            DeviceIds[i] = ViewPRI.r_PlayerDevices[eq].CurrentDeviceId;
            Powers[i] = ViewPRI.r_PlayerDevices[eq].Power;

            if (DeviceIds[i] != 0 && Powers[i] == 0)
                Powers[i] = ViewPRI.r_PlayerDevices[eq].CurrentDeviceCount;
            if (DeviceIds[i] != 0 && Powers[i] == 0) Powers[i] = 1;
        }

        if (DeviceIds[i] == 0 && ViewPawn != none)
        {
            Dev = ViewPawn.GetDeviceByEqPoint(eq);
            if (Dev != none)
            {
                DeviceIds[i] = Dev.r_nDeviceId;
                if (Powers[i] == 0 && DeviceIds[i] != 0) Powers[i] = 1;
            }
        }
    }
}

static function bool SyncBurnsToScene(UIHudCards CardsHUD, UIHudBurns BurnHUD, int DeviceIds[4], int Powers[4])
{
    local int i, Frame;
    local GFxObject IconObj, PowerLevel, Obj;
    local TgGfxScene DataSource;
    if (CardsHUD == none) return false;
    DataSource = BurnHUD != none ? BurnHUD : CardsHUD;
    for (i = 0; i < 4; i++)
    {
        IconObj = CardsHUD.m_CardDisplayGroup.Items[i].Icon;
        Obj = CardsHUD.m_CardDisplayGroup.Items[i].Obj;
        if (IconObj == none) continue;
        if (DeviceIds[i] == 0)
        {
            CardsHUD.FadeOut(IconObj, 0.05);
            if (Obj != none) CardsHUD.FadeOut(Obj, 0.05);
            continue;
        }

        Frame = FindBurnIconFrameByDeviceId(DataSource, DeviceIds[i]);
        if (Frame == 0 && DataSource != CardsHUD)
            Frame = FindBurnIconFrameByDeviceId(CardsHUD, DeviceIds[i]);
        if (Frame > 0)
        {
            CardsHUD.CancelAnim(IconObj);
            IconObj.GotoAndStopI(Frame);
            CardsHUD.FadeIn(IconObj, 0.05);
            if (Obj != none) { CardsHUD.CancelAnim(Obj); CardsHUD.FadeIn(Obj, 0.05); }
        }
        PowerLevel = CardsHUD.m_CardDisplayGroup.Items[i].PowerLevel;
        if (PowerLevel != none && Powers[i] > 0)
            PowerLevel.GotoAndStopI(Powers[i]);
    }
    return true;
}

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

/** Drives the UIHudSkills scene's 5 ability slots. Mirrors
 *  UUIComponent_HudSkillIcon::UpdateStatus/Update (+_Ult). Caches live on the controller. */
static function bool SyncSkillsToScene(UIHudSkills SkillsHUD, TgPawn ViewPawn,
                                       int StateDeviceIds[5], int StateAmmo[5], int StateAmmoMax[5], int StateCDPct[5], int StateCDSecs[5], int StateStatus[5], int StatePrevStatus[5],
                                       int UltCharge, int CastIds[3], int CastCurMs[3], int CastRateMs[3], string CastNames[3],
                                       out int LastCastId[3], out int LastCastCurMs[3], out int CastShown[3], out float CastRecvTime[3], out float PredMs[3],
                                       out float LastHudTick, out int LastIconFrames[5], out float UltRingNext,
                                       out array<GFxObject> WidthCache, out array<float> CastWidths)
{
    local int i, Frame;
    local float Pct;
    local bool bChanged;
    local GFxObject Slot, IconObj, CDBot, CDTop, TimerTF, PctTF, PulseObj, ShadowObj, ReadyObj, ActiveObj, AmmoObj;
    local GFxObject BtnObj, MouseObj, CastBar, AnimObj;

    if (SkillsHUD == none || ViewPawn == none) return false;

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

        // Gate on replicated ids: client-side reads give 0 for remote pawns. Clearing the
        // frame cache makes the next device re-issue GotoAndStopI + un-dim.
        if (StateDeviceIds[i] == 0)
        {
            LastIconFrames[i] = 0;
            if (IconObj != none) SkillsHUD.FadeOut(IconObj, 0.05);
            if (CDBot != none) CDBot.SetVisible(false);
            if (CDTop != none) CDTop.SetVisible(false);
            if (TimerTF != none) TimerTF.SetVisible(false);
            continue;
        }

        Frame = FindSkillIconFrameByDeviceId(SkillsHUD, StateDeviceIds[i], ViewPawn.GetBotId());

        // Status paint on TRANSITION only (native caches m_nLastStatus); painting per tick
        // re-ran FadeIn over the cooldown dim each sample.
        bChanged = StatePrevStatus[i] != StateStatus[i];
        if (bChanged)
        {
            Slot.SetAlpha(100.0);
            if (BtnObj != none) BtnObj.SetAlpha(StateStatus[i] == 2 ? 100.0 : 0.0);
            if (MouseObj != none) MouseObj.SetAlpha(StateStatus[i] == 2 ? 100.0 : 0.0);
            if (IconObj != none)
            {
                IconObj.SetAlpha(StateStatus[i] == 3 ? 50.0 : 100.0);
                if (Frame > 0)
                {
                    SkillsHUD.CancelAnim(IconObj);
                    IconObj.GotoAndStopI(Frame);
                    IconObj.SetVisible(true);
                    IconObj.SetBool("_visible", true);
                }
            }
            if (ShadowObj != none) ShadowObj.SetAlpha(StateStatus[i] == 1 ? 50.0 : 0.0);
            if (ActiveObj != none) ActiveObj.SetVisible(StateStatus[i] == 4);
            if (ReadyObj != none) ReadyObj.SetVisible(StateStatus[i] == 2);

            // Ready flash: Pulse pop into ready (prev==0 = first sample, skip).
            if (StateStatus[i] == 2 && StatePrevStatus[i] > 0 && PulseObj != none)
            {
                SkillsHUD.CancelAnim(PulseObj);
                PulseObj.SetAlpha(100.0);
                PulseObj.SetWidth(77.0);
                PulseObj.SetHeight(77.0);
                SkillsHUD.Animate(PulseObj, 0.5, UIANIM_ALPHA, 0.0,,, true);
                SkillsHUD.Animate(PulseObj, 0.5, UIANIM_WIDTH, 160.0,, 1, false);
                SkillsHUD.Animate(PulseObj, 0.5, UIANIM_HEIGHT, 160.0,, 1, false);
            }
            else if (StateStatus[i] != 2 && PulseObj != none)
                PulseObj.SetAlpha(0.0);
        }
        else if (Frame > 0 && IconObj != none && LastIconFrames[i] != Frame)
        {
            // Same status, different device (weapon swap): swap art only.
            SkillsHUD.CancelAnim(IconObj);
            IconObj.GotoAndStopI(Frame);
        }
        LastIconFrames[i] = Frame;

        // Cooldown sweep: fill height + mask position track remaining fraction.
        if (StateStatus[i] == 3)
        {
            Pct = float(StateCDPct[i]) / 100.0;
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
                SetGameText(TimerTF, string(StateCDSecs[i]));
            }
        }
        else if (TimerTF != none && TimerTF.GetBool("_visible"))
            TimerTF.SetVisible(false);

        // Firing spinner spins the Active child, never the icon art.
        if (StateStatus[i] == 4 && ActiveObj != none)
            ActiveObj.SetRotation((ViewPawn.WorldInfo.TimeSeconds - float(int(ViewPawn.WorldInfo.TimeSeconds))) * 360.0);

        if (AmmoObj != none && StateAmmoMax[i] > 0)
        {
            SetGameText(AmmoObj, StateAmmo[i] $ "/" $ StateAmmoMax[i]);
            AmmoObj.SetVisible(true);
        }
        else if (AmmoObj != none)
            AmmoObj.SetVisible(false);
    }

    // Ultimate slot. Mirrors UUIComponent_HudSkillIcon_Ult::Update.
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

        Slot.SetAlpha(100.0);
        Slot.SetVisible(true);
        Slot.SetBool("_visible", true);
        if (StateStatus[ULT_SLOT] == 1 && StateDeviceIds[ULT_SLOT] == 0 && ShadowObj != none)
            ShadowObj.SetAlpha(50.0);
        else if (ShadowObj != none)
            ShadowObj.SetAlpha(0.0);

        // Icon art applied unconditionally; a frame-cache gate left it on the gray
        // placeholder after no-target blanks faded the clip out.
        Frame = FindSkillIconFrameByDeviceId(SkillsHUD, StateDeviceIds[ULT_SLOT], ViewPawn.GetBotId());
        if (Frame > 0 && IconObj != none)
        {
            SkillsHUD.CancelAnim(IconObj);
            IconObj.GotoAndStopI(Frame);
            IconObj.SetVisible(true);
            IconObj.SetBool("_visible", true);
        }
        LastIconFrames[ULT_SLOT] = Frame;

        if (UltCharge >= 100)
        {
            if (IconObj != none) IconObj.SetAlpha(100.0);
            if (TimerTF != none) TimerTF.SetVisible(false);
            if (PctTF != none) PctTF.SetVisible(false);
            if (CDBot != none) CDBot.SetVisible(false);
            if (CDTop != none) CDTop.SetVisible(false);
            if (ReadyObj != none) ReadyObj.SetVisible(true);

            // Burst on any phase transition into full (native _Ult::Update), plus a
            // recurring snap+fade ring while parked at 100%.
            if (StatePrevStatus[ULT_SLOT] != 2 && PulseObj != none)
            {
                SkillsHUD.CancelAnim(PulseObj);
                PulseObj.SetAlpha(100.0);
                PulseObj.SetXScale(100.0);
                PulseObj.SetYScale(100.0);
                SkillsHUD.Animate(PulseObj, 0.25, UIANIM_ALPHA, 100.0,,, true);
                SkillsHUD.Animate(PulseObj, 0.25, UIANIM_X, ULT_PULSE_X,, 1, false);
                SkillsHUD.Animate(PulseObj, 0.25, UIANIM_WIDTH, ULT_PULSE_W,, 1, false);
                SkillsHUD.Animate(PulseObj, 0.25, UIANIM_HEIGHT, ULT_PULSE_H,, 1, false);
                UltRingNext = ViewPawn.WorldInfo.TimeSeconds + 1.0;
            }
            else if (StatePrevStatus[ULT_SLOT] == 2 && ViewPawn.WorldInfo.TimeSeconds >= UltRingNext && PulseObj != none)
            {
                SkillsHUD.CancelAnim(PulseObj);
                PulseObj.SetAlpha(100.0);
                PulseObj.SetXScale(100.0);
                PulseObj.SetYScale(100.0);
                SkillsHUD.Animate(PulseObj, 1.0, UIANIM_ALPHA, 0.0,,, true);
                SkillsHUD.Animate(PulseObj, 1.0, UIANIM_XSCALE, 150.0,, 1, false);
                SkillsHUD.Animate(PulseObj, 1.0, UIANIM_YSCALE, 150.0,, 1, false);
                UltRingNext = ViewPawn.WorldInfo.TimeSeconds + 1.0;
            }
        }
        else
        {
            // Charging: dimmed icon + charge digits + partial fill.
            if (IconObj != none) IconObj.SetAlpha(ULT_DIM_ALPHA);
            if (TimerTF != none)
            {
                TimerTF.SetVisible(true);
                SetGameText(TimerTF, string(UltCharge));
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

    // Cast bars (native TickCasting). Fill width updates every tick off ms samples chased
    // per-frame; bar fades in once on activation.
    for (i = 0; i < 3; i++)
    {
        CastBar = SkillsHUD.GetObject("Cast" $ i);
        if (CastBar == none)
            continue;

        if (CastIds[i] != 0)
        {
            bChanged = LastCastCurMs[i] != CastCurMs[i];
            if (bChanged)
            {
                LastCastCurMs[i] = CastCurMs[i];
                CastRecvTime[i] = ViewPawn.WorldInfo.TimeSeconds;
            }
            if (CastShown[i] == 0)
            {
                CastShown[i] = 1;
                CastRecvTime[i] = ViewPawn.WorldInfo.TimeSeconds;
                PredMs[i] = float(CastCurMs[i]);
                CastBar.SetVisible(true);
                SkillsHUD.FadeIn(CastBar, 0.05);
                SetGameText(CastBar, CastNames[i]);
            }
            else if (bChanged || CastIds[i] != LastCastId[i])
                SetGameText(CastBar, CastNames[i]);

            AnimObj = CastBar.GetObject("Anim");
            if (AnimObj == none) AnimObj = CastBar.GetObject("Bar");
            if (AnimObj == none) AnimObj = CastBar.GetObject("Fill");
            if (AnimObj != none)
            {
                // Chase target = last sample + local elapsed; lerp keeps steps monotonic.
                PredMs[i] += FMin(ViewPawn.WorldInfo.TimeSeconds - LastHudTick, 0.1) * 1000.0;
                if (PredMs[i] < float(CastCurMs[i]))
                    PredMs[i] = float(CastCurMs[i]);
                else
                    PredMs[i] += (float(CastCurMs[i]) + (ViewPawn.WorldInfo.TimeSeconds - CastRecvTime[i]) * 1000.0 - PredMs[i]) * 0.35;
                PredMs[i] = FClamp(PredMs[i], 0.0, float(Max(CastRateMs[i], 1)));
                AnimObj.SetWidth(CastStoredWidth(AnimObj, WidthCache, CastWidths) *
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

/** Hides all five skill slots' icon/CD/timer (no view target). */
static function bool BlankSkillsScene(UIHudSkills SkillsHUD)
{
    local int i;
    local GFxObject Slot, IconObj, CDBot, CDTop, TimerTF, PctTF;

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
    }
    return true;
}

static function BuildFillTicks(UIComponent_HealthBar Bar, GFxObject Container, int TeamColor, out int LastCount)
{
    local GFxObject Tick;
    local int i;

    if (Bar == none || Container == none) return;
    if (LastCount == Bar.m_mcHealthBarTicks.Length) return;

    for (i = 0; i < MAX_FILL_TICKS; i++)
    {
        Tick = Container.GetObject("HealthTick" $ i);
        if (Tick != none) Tick.RemoveMovieClip("");
    }
    for (i = 0; i < Bar.m_mcHealthBarTicks.Length; i++)
    {
        Tick = Container.AttachMovie("HealthTick", "HealthTick" $ i);
        Tick.SetDisplayInfo(Bar.m_mcHealthBarTicks[i].GetDisplayInfo());
        Tick.SetWidth(Bar.m_mcHealthBarTicks[i].GetWidth());
        Tick.SetHeight(Bar.m_mcHealthBarTicks[i].GetHeight());
        Tick.SetX(Bar.m_mcHealthBarTicks[i].GetX());
        Tick.GotoAndStopI(TeamColor);
    }
    LastCount = Bar.m_mcHealthBarTicks.Length;
}

static function BuildBorderTicks(UIComponent_HealthBar Bar, GFxObject Group, int TeamColor, out int bBuilt)
{
    local BarTickTypes BT;
    local int i;

    if (bBuilt != 0) return;
    if (Bar == none || Group == none) return;

    for (i = 0; i < Bar.m_BarTickTypes.Length; i++)
    {
        BT = Bar.m_BarTickTypes[i];
        if (BT.eBorderTickType == EHTT_Damage) continue;
        if (i != 0 && BT.mcLeftBorderTick != none)
            CreateBorderTick(Group, BT, BT.mcLeftBorderTick, "BorderTickL" $ i, 0, TeamColor);
        if (i != Bar.m_BarTickTypes.Length - 1 && BT.mcRightBorderTick != none)
            CreateBorderTick(Group, BT, BT.mcRightBorderTick, "BorderTickR" $ i, 1, TeamColor);
    }
    bBuilt = 1;
}

static function CreateBorderTick(GFxObject Group, BarTickTypes BT, GFxObject Src, string InstName, int Depth, int TeamColor)
{
    local GFxObject Tick;
    local int FrameTo;

    Tick = Group.GetObject(BT.sContainerName).AttachMovie("HealthTick", InstName, Depth);
    if (Tick == none) return;

    Tick.SetDisplayInfo(Src.GetDisplayInfo());
    Tick.SetWidth(Src.GetWidth());
    Tick.SetHeight(Src.GetHeight());

    if (BT.eBorderTickType == EHTT_Health) FrameTo = TeamColor;
    else if (BT.eBorderTickType == EHTT_Shield) FrameTo = HEALTH_FRAME_SHIELD;
    else FrameTo = HEALTH_FRAME_SHADOW;
    Tick.GotoAndStopI(FrameTo);
    Tick.SetVisible(true);
}

static function MirrorBarMasks(UIComponent_HealthBar Bar, GFxObject OgGroup, GFxObject Group)
{
    local BarTickTypes BT;
    local GFxObject OgMask, ClMask;
    local int i;

    if (Bar == none || OgGroup == none || Group == none) return;

    for (i = 0; i < Bar.m_BarTickTypes.Length; i++)
    {
        BT = Bar.m_BarTickTypes[i];
        OgMask = OgGroup.GetObject(BT.sMaskName);
        ClMask = Group.GetObject(BT.sMaskName);
        if (OgMask != none && ClMask != none)
        {
            ClMask.SetX(OgMask.GetX());
            ClMask.SetWidth(OgMask.GetWidth());
            ClMask.SetVisible(OgMask.GetBool("_visible"));
        }
    }
}

static function RecolorHealthTicks(UIComponent_HealthBar Bar, GFxObject Container, int TeamColor)
{
    local int NumTicks, HealthN, ShieldN, k;
    local float fH, fS;
    local GFxObject Tick;
    local BarTickTypes BT2;

    if (Bar == none || Container == none) return;
    NumTicks = Bar.m_mcHealthBarTicks.Length;
    if (NumTicks <= 0) return;

    fH = 0.0; fS = 0.0;
    for (k = 0; k < Bar.m_BarTickTypes.Length; k++)
    {
        BT2 = Bar.m_BarTickTypes[k];
        if (BT2.eBorderTickType == EHTT_Health) fH = BT2.fWidth;
        else if (BT2.eBorderTickType == EHTT_Shield) fS = BT2.fWidth;
    }

    HealthN = Clamp(FCeil(fH * float(NumTicks)), 0, NumTicks);
    ShieldN = Clamp(FCeil(fS * float(NumTicks)), 0, NumTicks - HealthN);

    for (k = 0; k < NumTicks; k++)
    {
        Tick = Container.GetObject("HealthTick" $ k);
        if (Tick == none) continue;
        if (k < HealthN) Tick.GotoAndStopI(TeamColor);
        else if (k < HealthN + ShieldN) Tick.GotoAndStopI(HEALTH_FRAME_SHIELD);
        else Tick.GotoAndStopI(HEALTH_FRAME_SHADOW);
        Tick.SetVisible(true);
    }
}

/** Copies display info, size, visibility and alpha from Src to Dst. */
static function MirrorVisual(GFxObject Dst, GFxObject Src)
{
    Dst.SetDisplayInfo(Src.GetDisplayInfo());
    Dst.SetWidth(Src.GetWidth());
    Dst.SetHeight(Src.GetHeight());
    Dst.SetVisible(Src.GetBool("_visible"));
    Dst.SetAlpha(Src.GetFloat("_alpha"));
}

static function SyncShieldText(GFxObject OgGroup, GFxObject Group)
{
    local GFxObject OgST, ClST, OgNow, OgMax, ClNow, ClMax;
    OgST = OgGroup.GetObject("ShieldText");
    ClST = Group.GetObject("ShieldText");
    if (OgST == none || ClST == none) return;
    MirrorVisual(ClST, OgST);
    OgNow = OgST.GetObject("ShieldNow");
    OgMax = OgST.GetObject("ShieldMax");
    ClNow = ClST.GetObject("ShieldNow");
    ClMax = ClST.GetObject("ShieldMax");
    if (OgNow != none && ClNow != none)
    {
        ClNow.SetText(OgNow.GetText());
        ClNow.SetVisible(OgNow.GetBool("_visible"));
        ClNow.SetAlpha(OgNow.GetFloat("_alpha"));
    }
    if (OgMax != none && ClMax != none)
    {
        ClMax.SetText(OgMax.GetText());
        ClMax.SetVisible(OgMax.GetBool("_visible"));
        ClMax.SetAlpha(OgMax.GetFloat("_alpha"));
    }
}

static function SyncCombat(GFxObject OgGroup, GFxObject Group)
{
    local GFxObject OgCombat, ClCombat, OgBar, ClBar;
    OgCombat = OgGroup.GetObject("Combat");
    ClCombat = Group.GetObject("Combat");
    if (OgCombat == none || ClCombat == none) return;
    MirrorVisual(ClCombat, OgCombat);
    OgBar = OgCombat.GetObject("Bar");
    ClBar = ClCombat.GetObject("Bar");
    if (OgBar != none && ClBar != none)
    {
        ClBar.SetDisplayInfo(OgBar.GetDisplayInfo());
        ClBar.SetWidth(OgBar.GetWidth());
        ClBar.SetHeight(OgBar.GetHeight());
        ClBar.SetX(OgBar.GetX());
        ClBar.SetVisible(OgBar.GetBool("_visible"));
        ClBar.SetAlpha(OgBar.GetFloat("_alpha"));
    }
}

static function SyncHealFeedContainer(GFxObject OgGroup, GFxObject Group, optional int MaxEntries)
{
    local GFxObject OgFeed, ClFeed, OgEntry, ClEntry, OgTF, ClTF;
    local int i;
    local string ChildName;

    if (MaxEntries <= 0) MaxEntries = MAX_HEAL_ENTRIES;

    OgFeed = OgGroup.GetObject("HealFeedContainer");
    ClFeed = Group.GetObject("HealFeedContainer");
    if (OgFeed == none || ClFeed == none) return;

    MirrorVisual(ClFeed, OgFeed);

    for (i = 0; i < MaxEntries; i++)
    {
        ChildName = "Entry" $ i;
        OgEntry = OgFeed.GetObject(ChildName);
        if (OgEntry == none) OgEntry = OgFeed.GetObject("HealEntry" $ i);
        if (OgEntry == none) OgEntry = OgFeed.GetObject("HealFeedItem" $ i);
        if (OgEntry == none) OgEntry = OgFeed.GetObject("Item" $ i);
        if (OgEntry == none) OgEntry = OgFeed.GetElementObject(i);
        if (OgEntry == none) continue;

        ClEntry = ClFeed.GetObject(ChildName);
        if (ClEntry == none)
        {
            ClEntry = ClFeed.AttachMovie("HealFeedItem", ChildName, i);
            if (ClEntry == none) ClEntry = ClFeed.AttachMovie("HealEntry", ChildName, i);
            if (ClEntry == none) ClEntry = ClFeed.AttachMovie("Entry", ChildName, i);
            if (ClEntry == none) continue;
        }
        MirrorVisual(ClEntry, OgEntry);
        ClEntry.SetX(OgEntry.GetX());
        ClEntry.SetY(OgEntry.GetY());
        ClEntry.SetText(OgEntry.GetText());
        OgTF = OgEntry.GetObject("TF");
        ChildName = "TF";
        if (OgTF == none) { OgTF = OgEntry.GetObject("Text"); ChildName = "Text"; }
        if (OgTF != none)
        {
            ClTF = ClEntry.GetObject(ChildName);
            if (ClTF != none) ClTF.SetText(OgTF.GetText());
        }
    }
    if (OgFeed.GetText() != "" || ClFeed.GetText() != "")
        ClFeed.SetText(OgFeed.GetText());
}
