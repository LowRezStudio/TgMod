class TgDeploy_DarkConvergence extends TgDeploy_Bomb
    native(ChampOracle)
    placeable
    hidecategories(Navigation)
    config(Engine);

const MAX_DARK_CONVERGENCE_TARGETS = 5;

const DARK_CONVERGENCE_PULL_BEAM_FX_ID = 7681;

struct PullData {
    var TgPawn_Character Character;
    var Vector SourceLocation;
    var Vector TargetLocation;
    structdefaultproperties {}
};

var array<PullData> m_PullDataList;
var repnotify TgPawn_Character r_PulledTargets[5];
var repnotify Vector r_PulledTargetLocations[5];
var array<TgBeamHelper> c_Beams;
var float c_fHideBeamsTimer;
var float s_fValidationRayDistance;
var float s_fValidationRayRadius;
var float s_fValidationRayHeight;
var float s_fValidationMaxFloorOffset;
var float s_fVerticalTargetLocationOffset;

simulated function float GetPullDelay() { }

simulated function float GetPullTime() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function ApplyForcedView() { }

simulated function CreateBeams() { }

simulated function HideBeams() { }

simulated function UpdateBeams() { }

simulated function ApplyHit(out array<ImpactInfo> ImpactList) { }

function StartPull() { }

native simulated function DetermineTeleportLocations();  // Export UTgDeploy_DarkConvergence::execDetermineTeleportLocations(FFrame&, void* const)

simulated function Tick(float DeltaSeconds) { }

defaultproperties
{}
