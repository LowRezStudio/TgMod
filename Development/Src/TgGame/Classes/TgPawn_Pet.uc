class TgPawn_Pet extends TgPawn
    native(Pawns)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var float m_fOwnerPhysPowerItemPercent;
var float m_fOwnerMagicalPowerItemPercent;
var float m_fOwnerUltilityPowerItemPercent;
var TgObject.EPetPhase s_PetPhase;
var TgObject.EPetPosition s_PetPosition;
var Rotator s_LastPositionAdjustmentRotation;
var Vector s_InterpolatedPetPosition;
var Vector s_InterpolatedPetOwnerPosition;
var float s_fPetPositionDistanceMultiplier;
var float s_fOwnerVelocityTime;
var float s_fSmoothedMaxSpeed;
var transient TgSpecialFx c_BeamFX;
var repnotify Rotator r_InitialOrientation;
var export editinline ParticleSystemComponent c_AimVisibilityMesh;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_InitialOrientation;
}

native function float GetPhysicalPowerItem();  // Export UTgPawn_Pet::execGetPhysicalPowerItem(FFrame&, void* const)

native function float GetMagicalPowerItem();  // Export UTgPawn_Pet::execGetMagicalPowerItem(FFrame&, void* const)

native function float GetUtilityPowerItem();  // Export UTgPawn_Pet::execGetUtilityPowerItem(FFrame&, void* const)

native function bool IsDamageOverTimeImmune();  // Export UTgPawn_Pet::execIsDamageOverTimeImmune(FFrame&, void* const)

native function GetGiantCollisionCylinderSize(out float Radius, out float Height);  // Export UTgPawn_Pet::execGetGiantCollisionCylinderSize(FFrame&, void* const)

native function GetSmallCollisionCylinderSize(out float Radius, out float Height);  // Export UTgPawn_Pet::execGetSmallCollisionCylinderSize(FFrame&, void* const)

native function CorrectLocationWhileChangingSize(float HeightDelta);  // Export UTgPawn_Pet::execCorrectLocationWhileChangingSize(FFrame&, void* const)

native function float GetDefaultMeshScale();  // Export UTgPawn_Pet::execGetDefaultMeshScale(FFrame&, void* const)

native function DirtyAttachmentTransforms();  // Export UTgPawn_Pet::execDirtyAttachmentTransforms(FFrame&, void* const)

native function bool CanSeeActor(Actor Other);  // Export UTgPawn_Pet::execCanSeeActor(FFrame&, void* const)

native function DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted);  // Export UTgPawn_Pet::execDeviceOnStopFire(FFrame&, void* const)

native function DeviceOnKilled(TgDevice Dev, const out ImpactInfo Impact, float fDamage);  // Export UTgPawn_Pet::execDeviceOnKilled(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_Pet::execDeviceAdjustDamage(FFrame&, void* const)

native function DeviceOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_Pet::execDeviceOnDamaged(FFrame&, void* const)

native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);  // Export UTgPawn_Pet::execDeviceOnHit(FFrame&, void* const)

function PossessedBy(Controller C, bool bVehicleTransition) { }

simulated function PostBeginPlay() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function SetAimVisibilityMesh() { }

function bool ShouldScoreKill() { }

simulated function PlayDyingEffects() { }

simulated function PlayDeathAnimation() { }

defaultproperties
{}
