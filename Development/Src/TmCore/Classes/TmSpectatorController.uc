class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

struct transient SpecAbility {
    var string DeviceName;     // "" = slot empty
    var float CooldownPct;     // 0 = ready, 1 = just started, -1 = no timer
    var float CooldownRemain;
    var int CurrentAmmo;
    var int MaxAmmo;
};
var transient SpecAbility Abilities[5];

var transient bool bTimerOn;

const ABILITY_SLOTS = 5;

simulated function ForwardToSpectatingMatch() {
    super.ForwardToSpectatingMatch();
    if (WorldInfo.NetMode != NM_DedicatedServer)
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
}

simulated function SpecAbility GetAbility(int i) {
    if (i >= 0 && i < ABILITY_SLOTS)
        return Abilities[i];
}

public function Class<HUD> GetHudClass(Class<HUD> pNewHudType) {
    `LogInfo('TmSpectatorController', "GetHudClass: requested=" @ pNewHudType @ " -> returning TgClient.TgGameHUD");
    return Class'TgClient.TgGameHUD';
}

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams) {
    super.SpectatorSetViewTarget(VT, TransitionParams);
    if (Role == ROLE_Authority && !bTimerOn) {
        ClearTimer('TickFollowAbilities');
        SetTimer(0.15, true, 'TickFollowAbilities');
        bTimerOn = true;
    }
}

simulated function TickFollowAbilities() {
    local int i, slot;
    local int EquipSlots[5];
    local TgPawn FollowPawn;
    local TgDevice Dev;
    local TgTimerManager TM;
    local float remain, total;
    local SpecAbility A;

    EquipSlots[0] = 1;    // primary weapon (LMB)
    EquipSlots[1] = 16;   // alt fire (RMB)
    EquipSlots[2] = 3;    // Q ability
    EquipSlots[3] = 4;    // F ability
    EquipSlots[4] = 2;    // ultimate (E)

    FollowPawn = TgPawn(GetViewTarget());
    if (FollowPawn == none || FollowPawn.Controller == none || !FollowPawn.IsAliveAndWell()) {
        for (i = 0; i < ABILITY_SLOTS; i++) {
            Abilities[i].DeviceName = "";
            Abilities[i].CooldownPct = -1;
            Abilities[i].CooldownRemain = 0;
            Abilities[i].CurrentAmmo = 0;
            Abilities[i].MaxAmmo = 0;
        }
        ClientUpdateAbilities(Abilities);
        return;
    }

    for (i = 0; i < ABILITY_SLOTS; i++) {
        slot = EquipSlots[i];
        A.DeviceName = "";
        A.CooldownPct = -1;
        A.CooldownRemain = 0;
        A.CurrentAmmo = 0;
        A.MaxAmmo = 0;
        Dev = FollowPawn.GetDeviceByEqPoint(slot);
        if (Dev != none) {
            A.DeviceName = Dev.GetDeviceName();
            if (Dev.r_nMaxAmmoClipCount > 0) {
                A.CurrentAmmo = Dev.GetCurrentAmmoAmount();
                A.MaxAmmo = Dev.r_nMaxAmmoClipCount;
            }
            TM = Dev.GetCooldownTimerManager();
            if (TM != none) {
                remain = Dev.GetCooldownRemaining();
                total = TM.GetTimeInitial(0);
                if (total > 0.0001) {
                    A.CooldownPct = FClamp(remain / total, 0.0, 1.0);
                    A.CooldownRemain = remain;
                }
            }
        }
        Abilities[i] = A;
    }
    ClientUpdateAbilities(Abilities);
}

reliable client function ClientUpdateAbilities(SpecAbility NewAbilities[5]) {
    local int i;
    for (i = 0; i < ABILITY_SLOTS; i++)
        Abilities[i] = NewAbilities[i];
}

// TODO: remove

simulated function DumpScenes()
{
    local TgGameHUD H;
    local int i;

    H = TgGameHUD(myHUD);
    if (H == none) return;

    `LogInfo('TmSpec', "=== SceneStack (" @ H.m_SceneStack.Length @ ") ===");
    for (i = 0; i < H.m_SceneStack.Length; i++)
        DumpSceneEntry(H, H.m_SceneStack[i], "  [" $ i $ "]");

    `LogInfo('TmSpec', "=== PopupStack (" @ H.m_PopupStack.Length @ ") ===");
    for (i = 0; i < H.m_PopupStack.Length; i++)
        DumpSceneEntry(H, H.m_PopupStack[i], "  [" $ i $ "]");

    if (H.m_pMovie != none) {
        `LogInfo('TmSpec', "=== Movie scenes (" @ H.m_pMovie.m_Scenes.Length @ ") ===");
        for (i = 0; i < H.m_pMovie.m_Scenes.Length; i++) {
            if (H.m_pMovie.m_Scenes[i] != none)
                `LogInfo('TmSpec', "  [" $ i $ "] " $ H.m_pMovie.m_Scenes[i].Class.Name $ " (" $ H.m_pMovie.m_Scenes[i].Name $ ")");
        }
    }
}

simulated function name ResolveFind(TgGameHUD H, TgGfxScene S)
{
    local TgGfxScene F;

    F = `UTILS.FindSceneByClassName(H, S.Class.Name);
    return F.Name;
}

simulated function DumpSceneEntry(TgGameHUD H, TgGfxScene S, string Label)
{
    local UIHud U;
    local int i, j;

    if (S == none) return;

    `LogInfo('TmSpec', Label $ " " $ S.Class.Name $ " (" $ S.Name $ ")  find=" $ ResolveFind(H, S));

    for (j = 0; j < S.m_Groups.Length; j++) {
        if (S.m_Groups[j].m_pScene != none)
            `LogInfo('TmSpec', Label $ "   - group: " $ S.m_Groups[j].m_pScene.Class.Name);
    }

    U = UIHud(S);
    if (U == none) return;

    for (i = 0; i < ArrayCount(U.m_mcSubscenes); i++) {
        if (U.m_mcSubscenes[i] != none)
            `LogInfo('TmSpec', Label $ "   - sub:   " $ U.m_mcSubscenes[i].Class.Name $ " (" $ U.m_mcSubscenes[i].Name $ ")");
    }
}
