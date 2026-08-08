class TgDevice_BombKingInhand extends TgDevice_DualWield
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine);

struct StickyBombPendingDetonate {
    var int nProjID;
    var int nDeployID;
    var Vector vExplodeLocation;
    structdefaultproperties {}
};

var bool r_bHasActiveProjectile;
var bool m_bInDetonationMode;
var array<StickyBombPendingDetonate> m_PendingDetonations;
var array<TgProjectile> m_PendingProjectileConversions;
var const float m_fValidationTolerance;

replication {
    if(((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) && !bNetInitial) r_bHasActiveProjectile;
}

native function bool ValidateStickyBombExplosion(TgProj_BombKingStickyBomb Proj, TgDeploy_BombKingStickyBomb dep, Vector vExplodeLocation, Vector vVelocity);  // Export UTgDevice_BombKingInhand::execValidateStickyBombExplosion(FFrame&, void* const)

simulated function RemovePendingConversion(TgProjectile Proj, int deployID) { }

simulated function ClientProcessBombDetonation(TgProj_BombKingStickyBomb stickyBomb) { }

simulated function ClientTriggerBombDetonation() { }

function ServerTriggerBombDetonation() { }

reliable server function ServerExplodeAtLocation(int projID, int deployID, Vector explodeLocation, Vector vVelocity) { }

simulated event SpecialInstantFire(Vector explodeLocation) { }

reliable client simulated function ClientRestoreBombs() { }

function ServerRestoreBombs() { }

simulated function AddProjectileWaitingForDeployable(TgProj_BombKingStickyBomb stickyBomb) { }

simulated function UpdateActiveProjectiles(optional TgProjectile Proj) { }

simulated delegate DetonatorFiringDelegate();

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_fValidationTolerance=48.0000000
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-9.0000000,Z=-10.0000000)
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_bUseDeviceMeshWhenTargeting=true
    m_bPlayPutAway=true
    m_bLogServerFireFailures=true
    m_fWeaponBob=0.0000000
    m_fMeshFOV=65.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_BombKingInhand'
    m_nLinkedDeviceIDs[0]=14309
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceStickyBomb'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'BasicForceFeedback'
}
