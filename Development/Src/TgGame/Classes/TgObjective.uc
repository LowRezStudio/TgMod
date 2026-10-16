class TgObjective extends Actor
    native(Game)
    placeable
    hidecategories(Navigation)
    config(Engine);

const OBJECTIVE_NEUTRAL_SPECIALFX = 2954;

const OBJECTIVE_FRIENDLY_SPECIALFX = 2929;

const OBJECTIVE_ENEMY_SPECIALFX = 2928;

const OBJECTIVE_PENDING_SPECIALFX = 2930;

const OBJECTIVE_NEUTRAL_FOREGROUND_SPECIALFX = 6286;

const OBJECTIVE_FRIENDLY_FOREGROUND_SPECIALFX = 6289;

const OBJECTIVE_ENEMY_FOREGROUND_SPECIALFX = 6287;

const OBJECTIVE_PENDING_FOREGROUND_SPECIALFX = 6288;

const MIN_CAPTURE_FX_RENDER_DISTANCE = 750;

enum EObjectiveStatus {
    Status_Inactive,  // 0
    Status_Active,  // 1
    Status_PendingActive,  // 2
};

var byte r_nDefenderTaskForceIndex;
var byte r_nControllingTaskForceIndex;
var repnotify byte r_nContestingTaskForceIndex;
var repnotify TgObjective.EObjectiveStatus r_eStatus;
var TgSpecialFx m_InWordIndicatorFX;
var TgSpecialFx m_ForegroundIndicatorFX;
var () int m_nActiveAlertId;
var () int m_nPendingActiveAlertId;
var () int m_nInactiveAlertId;
var () int m_nWaypointMessageOverride;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_eStatus, r_nContestingTaskForceIndex, r_nControllingTaskForceIndex, r_nDefenderTaskForceIndex;
}

simulated event ReplicatedEvent(name VarName) { }

native function SetStatus(TgObjective.EObjectiveStatus NewStatus);  // Export UTgObjective::execSetStatus(FFrame&, void* const)

simulated event OnSetStatus() { }

simulated event OnContestedStatusChanged() { }

defaultproperties
{
    Components[0]=none
    RemoteRole=ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    NetPriority=2.0000000
    SupportedEvents=/* Array type was not detected. */
}
