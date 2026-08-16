class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

// --- Followed-player ability data, replicated server -> this spec's client -----
struct transient SpecAbility {
    var string DeviceName;     // "" = slot empty
    var float CooldownPct;     // 0 = ready, 1 = just started, -1 = no timer
    var float CooldownRemain;
    var int CurrentAmmo;
    var int MaxAmmo;
};
var transient SpecAbility Abilities[5];

var transient TgPawn FollowPawn;
var transient bool bTimerOn;

const ABILITY_SLOTS = 5;

simulated function ForwardToSpectatingMatch() {
    super.ForwardToSpectatingMatch();
    if (WorldInfo.NetMode != NM_DedicatedServer)
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
}

// Read helper for the viewport client's PostRender (draws the ability bar).
simulated function SpecAbility GetAbility(int i) {
    if (i >= 0 && i < ABILITY_SLOTS)
        return Abilities[i];
}

// Called (server + client) when the spec follows a new target.
function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams) {
    super.SpectatorSetViewTarget(VT, TransitionParams);
    if (Role == ROLE_Authority) {
        FollowPawn = TgPawn(VT);
        if (!bTimerOn) {
            ClearTimer('TickFollowAbilities');
            SetTimer(0.15, true, 'TickFollowAbilities');
            bTimerOn = true;
        }
    }
}

// Server: sample the followed pawn's abilities and push cooldown/ammo to the spec.
simulated function TickFollowAbilities() {
    local int i, slot;
    local int EquipSlots[5];
    local TgDevice Dev;
    local TgTimerManager TM;
    local float remain, total;
    local SpecAbility A;

    EquipSlots[0] = 1;    // primary weapon (LMB)
    EquipSlots[1] = 16;   // alt fire (RMB)
    EquipSlots[2] = 3;    // Q ability
    EquipSlots[3] = 4;    // F ability
    EquipSlots[4] = 2;    // ultimate (E)

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
