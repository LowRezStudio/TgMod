class TgChaosCapturePoint extends TgObjective
    native(Game)
    placeable
    hidecategories(Navigation)
    config(Engine);

const TG_UNCONTESTED = 0;

const TG_TEAM1_CAPTURING = 1;

const TG_TEAM2_CAPTURING = 2;

const TG_CONTESTED = 3;

const TG_CAPTUREPOINT_FOGHORN_FX_ID = 6694;

var () int m_nDisplayNameId;
var () int r_nUniqueCapturePointId;
var () int m_nLaneNumber;
var () int m_nTaskForce;
var () array<TgBotFactory_Minions> m_Taskforce1Factories;
var () array<TgBotFactory_Minions> m_Taskforce2Factories;
var () TgBotFactory_Minions m_GuardianFactory;
var () TgSplineActor m_Taskforce1PathStart;
var () TgSplineActor m_Taskforce2PathStart;
var () array<PlayerStart> m_PlayerBaseSpawnPoints;
var () array<PlayerStart> m_PlayerRespawnPoints;
var transient TgAnimNodeSlot m_CustomAnimNode;
var int c_MICStatus;
var bool c_bConfusedRendering;
var repnotify bool r_bFogActive;
var (Survival) const bool m_bForceSurvival;
var bool m_bAnnouncedDeathFog;
var bool m_bContested;
var bool m_bContestedThisTick;
var transient float m_fLastEnemyCapturingPointMessageTime;
var float m_fMinEnemyCapturingPointMessageTime;
var TgHelpTipActor m_HelpTip;
var float r_fCapturedPct;
var int c_DominationOuterMIC;
var int c_DominationInnerMIC;
var (capturePoint) array<TgStaticMeshActor_CapturePoint> CapturePointMeshActors;
var (capturePoint) array<Volume> m_Volumes;
var (capturePoint) int m_nCapturePriority;
var (capturePoint) Vector m_vIndicatorOffset;
var (Survival) const Class<TgSurvivalFogVolumeDensityInfo> m_TgSurvivalFogVolumeDensityInfoClass;
var TgSurvivalFogVolumeDensityInfo m_ConvergeFog;
var repnotify int r_nFogAboutToBeActive;
var (Survival) float m_fFogFadeInTotalTime;
var int m_nNumTF1OnPoint;
var int m_nNumTF2OnPoint;
var float m_fTF1TouchedPointTimer;
var float m_fTF2TouchedPointTimer;
var array<TgPawn_Character> m_TouchingChampions;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bFogActive, r_fCapturedPct, r_nFogAboutToBeActive, r_nUniqueCapturePointId;
}

native function PlayEnemyCapturingEmote(TgRepInfo_TaskForce Taskforce);  // Export UTgChaosCapturePoint::execPlayEnemyCapturingEmote(FFrame&, void* const)

native function AnnounceFogOfDeath();  // Export UTgChaosCapturePoint::execAnnounceFogOfDeath(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event PreBeginPlay() { }

simulated event PostBeginPlay() { }

simulated event Tick(float DeltaTime) { }

simulated event OnSetStatus() { }

simulated function UpdateFogStatus() { }

simulated function PlayFogHorn() { }

simulated function ShowPathfinder(bool bEnabled) { }

simulated function SpawnHelpTip() { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event UnTouch(Actor Other) { }

function UpdateOccupationStatus() { }

simulated event int GetControllingPlayerCount() { }

simulated function SetFogActive(bool bEnabled) { }

simulated event Destroyed() { }

defaultproperties
{}
