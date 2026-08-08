class TgPawn_SiegeWall extends TgPawn_Tower
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

var () float m_fImpactEffectXRange;
var () float m_fImpactEffectYRange;
var Vector r_vNextImpactEffectLocation;
var () float m_fImpactRecoveryTime;
var float m_fRemainingImpactRecoveryTime;
var () float m_fMaxImpactSize;
var MaterialInstanceConstant m_ImpactMIC;
var bool c_bIsVulnerable;
var bool m_bHasRegisteredObstacle;
var bool m_bSpawnedThisFrame;
var bool m_bQueriedBorderEdges;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_vNextImpactEffectLocation;
}

native function bool IsDebuffImmune();  // Export UTgPawn_SiegeWall::execIsDebuffImmune(FFrame&, void* const)

native function GenerateNewImpactEffectLocation();  // Export UTgPawn_SiegeWall::execGenerateNewImpactEffectLocation(FFrame&, void* const)

native function PlaySpecialEffectEvent(int PlaySpecialEffectIndex, Vector vLoc, Vector vHitNormal, optional Actor inActor);  // Export UTgPawn_SiegeWall::execPlaySpecialEffectEvent(FFrame&, void* const)

native function SendAttackAlert();  // Export UTgPawn_SiegeWall::execSendAttackAlert(FFrame&, void* const)

native function SendDeathAlert();  // Export UTgPawn_SiegeWall::execSendDeathAlert(FFrame&, void* const)

native function PostPawnSetupServer();  // Export UTgPawn_SiegeWall::execPostPawnSetupServer(FFrame&, void* const)

native function RegisterObstacle();  // Export UTgPawn_SiegeWall::execRegisterObstacle(FFrame&, void* const)

native function UnRegisterObstacle();  // Export UTgPawn_SiegeWall::execUnRegisterObstacle(FFrame&, void* const)

native function bool ApplyPawnSetup();  // Export UTgPawn_SiegeWall::execApplyPawnSetup(FFrame&, void* const)

native function bool IsVulnerable();  // Export UTgPawn_SiegeWall::execIsVulnerable(FFrame&, void* const)

simulated function PostBeginPlay() { }

event RegisterWithGRI() { }

function UnRegisterWithGRI() { }

simulated function name GetWallImpactKismetName() { }

simulated event PlayWallImpact() { }

event int GetHPScalingValue() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

defaultproperties
{}
