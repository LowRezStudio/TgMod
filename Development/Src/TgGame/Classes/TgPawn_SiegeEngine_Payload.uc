class TgPawn_SiegeEngine_Payload extends TgPawn_Juggernaut
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

enum EAutoMovePayload {
    AUTOMOVE_None,  // 0
    AUTOMOVE_Forward,  // 1
    AUTOMOVE_Backward,  // 2
};

enum EPayloadControlState {
    PAYLOADCONTROL_None,  // 0
    PAYLOADCONTROL_Ally,  // 1
    PAYLOADCONTROL_Enemy,  // 2
    PAYLOADCONTROL_Contested,  // 3
};

var float s_fTotalSplineLength;
var float s_fPreviousSplineLength;
var bool r_bEnable;
var const bool m_bRequireLineOfSightForNearby;
var private repnotify bool r_bMovingBackwards;
var private bool r_bCanAutoPushForward;
var const float m_fBaseSpeedScale;
var const float m_fNearbyProximityDistance;
var TgCollisionProxy m_NearbyCollisionProxy;
var array<TgPawn> m_TouchingPlayers;
var array<TgPawn> m_VisiblePlayers;
var const float m_fSpeedScaleIncreasePerFriendly;
var const float m_fLineOfSightUpdatePeriod;
var float m_fNextLineOfSightUpdateTime;
var const float s_fTimeUntilMoveBackwards;
var const float m_fMoveBackSpeedScale;
var private repnotify TgPawn_SiegeEngine_Payload.EAutoMovePayload r_eMoveWithoutAllies;
var private TgPawn_SiegeEngine_Payload.EPayloadControlState m_eControlState;
var repnotify byte r_nFriends;
var repnotify byte r_nEnemies;
var private const float m_fAutoPushForwardDelay;
var private const float r_fAutoPushForwardSpeedScale;
var private const float m_fStopAutoPushDelay;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bCanAutoPushForward, r_bEnable, r_bMovingBackwards, r_eMoveWithoutAllies;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_fAutoPushForwardSpeedScale;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bDemoRecording || m_bRequireLineOfSightForNearby) r_nEnemies, r_nFriends;
}

native function PostPawnSetupServer();  // Export UTgPawn_SiegeEngine_Payload::execPostPawnSetupServer(FFrame&, void* const)

native function CreateCollisionProxy();  // Export UTgPawn_SiegeEngine_Payload::execCreateCollisionProxy(FFrame&, void* const)

native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);  // Export UTgPawn_SiegeEngine_Payload::execSetSpline(FFrame&, void* const)

native function UpdatePayloadProgress();  // Export UTgPawn_SiegeEngine_Payload::execUpdatePayloadProgress(FFrame&, void* const)

native function bool IsNonCombat();  // Export UTgPawn_SiegeEngine_Payload::execIsNonCombat(FFrame&, void* const)

native function bool NativeIsContested();  // Export UTgPawn_SiegeEngine_Payload::execNativeIsContested(FFrame&, void* const)

native function bool NativeIsMovingBackwards();  // Export UTgPawn_SiegeEngine_Payload::execNativeIsMovingBackwards(FFrame&, void* const)

native function bool VisibilityCheck(Actor Target);  // Export UTgPawn_SiegeEngine_Payload::execVisibilityCheck(FFrame&, void* const)

native function UpdateFriendEnemyCounts();  // Export UTgPawn_SiegeEngine_Payload::execUpdateFriendEnemyCounts(FFrame&, void* const)

native function bool IsImmuneToDamage();  // Export UTgPawn_SiegeEngine_Payload::execIsImmuneToDamage(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event bool PostPawnSetup() { }

simulated event OnGroupChange() { }

function SetEnable(bool bEnable) { }

simulated function OnEnableChanged() { }

singular simulated function FullUpdate() { }

simulated function bool HasFriendlyPlayersNearby() { }

simulated function bool HasEnemyPlayersNearby() { }

simulated function bool IsContested() { }

simulated function ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated function ProxyUnTouch(Actor Other) { }

simulated function AddNearbyPlayer(Actor Other) { }

simulated function RemoveNearbyPlayer(Actor Other) { }

simulated function UpdateAlliesNearbyBehavior(optional bool bSkipCountUpdate=false) { }

simulated function SetPayloadControlState(TgPawn_SiegeEngine_Payload.EPayloadControlState NextControlState) { }

function StartAutoMoveForward(optional bool bSkipUpdate) { }

function StopAutoMoveForward(optional bool bSkipUpdate) { }

function SetMoveWithoutAllies(TgPawn_SiegeEngine_Payload.EAutoMovePayload eMove, optional bool bSkipFullUpdate) { }

function UpdateBackwardsTimers() { }

simulated function StartMovingBackwards() { }

simulated function StopMovingBackwards() { }

event ToggleCanAutoPushFoward(bool bEnable) { }

function UpdateAutoPushState() { }

simulated function Tick(float DeltaSeconds) { }

simulated event Destroyed() { }

defaultproperties
{}
