class TgDeploy_OppressorMine extends TgDeployable
    native(ChampKinessa)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const MAX_OPPRESSOR_MINE_TARGETS = 5;

var TgPawn m_CachedPawnOwner;
var TgRepInfo_TaskForce m_CachedEnemyTaskForce;
var repnotify Actor r_CurrentTargets[5];
var int m_nBeamFXID;
var TgSpecialFx m_BeamFXs[5];
var bool m_bNeedsNetDirtyUpdate;
var TgPawn_LanePusherBase r_StuckCart;
var Rotator r_StuckRotation;
var Vector r_CartOffset;
var float m_fAmplitudeRadiusScale;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_CartOffset, r_CurrentTargets, r_StuckCart, r_StuckRotation;
}

native function bool IsValidTarget(Actor Target);  // Export UTgDeploy_OppressorMine::execIsValidTarget(FFrame&, void* const)

native function int FilterCurrentTargets(int maxTargets);  // Export UTgDeploy_OppressorMine::execFilterCurrentTargets(FFrame&, void* const)

native function FilterNewTargets(out array<TgPawn> newTargets);  // Export UTgDeploy_OppressorMine::execFilterNewTargets(FFrame&, void* const)

native function ApplyEffects(Actor Target);  // Export UTgDeploy_OppressorMine::execApplyEffects(FFrame&, void* const)

native function RemoveEffects(Actor Target);  // Export UTgDeploy_OppressorMine::execRemoveEffects(FFrame&, void* const)

native function UpdateAllBeams();  // Export UTgDeploy_OppressorMine::execUpdateAllBeams(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event DestroyIt(optional bool bSkipFx) { }

simulated event bool DamageShouldEnterCombat() { }

defaultproperties
{}
