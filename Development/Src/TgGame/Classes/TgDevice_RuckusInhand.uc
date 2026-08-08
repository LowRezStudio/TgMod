class TgDevice_RuckusInhand extends TgDevice_DualWield
    native(ChampRuckus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgDevice);

var float m_fSpinAmount;
var float m_fCurrentSpinScale;
var (Spin) float m_fStartingSpinRate;
var (Spin) float m_fMaxSpinRate;
var (Spin) float m_fDurationToMaxSpin;
var (Spin) float m_fSpinDownRate;
var (Spin) float m_fSlowestFireDelay;
var float m_fFiringMoveSpeedModifier;
var bool m_bLeftMouseMovePenalty;
var bool m_bInFireLoop;
var bool m_bAltFireSpinning;
var bool m_bHexaFireSpinning;
var (MovePenalty) float m_fMoveSpeedDecreaseInterpolationDuration;
var (MovePenalty) float m_fMoveSpeedIncreaseInterpolationDuration;
var float r_fRecyclerPercent;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRecyclerPercent;
}

simulated function bool ShouldConsumeAmmo(int nFireRequestID, optional array<ImpactToValidate> Impacts) { }

reliable server function SetLeftMouseMovePenalty(bool bLeftMouseMovePenalty) { }

simulated function Tick(float DeltaTime) { }

simulated function SetCurrentSpinScale(float fCurrentSpinScale) { }

simulated function bool RequireMovementForAimAssist() { }

state DeviceFiring {}

defaultproperties
{
    m_fStartingSpinRate=0.0010000
    m_fMaxSpinRate=20.0000000
    m_fDurationToMaxSpin=1.0000000
    m_fSpinDownRate=1.0000000
    m_fSlowestFireDelay=0.3000000
    m_fFiringMoveSpeedModifier=1.0000000
    m_fMoveSpeedDecreaseInterpolationDuration=0.5000000
    m_fMoveSpeedIncreaseInterpolationDuration=0.5000000
    m_vProjectileSpawnOffset2=(X=5.0000000,Y=-18.0000000,Z=-7.0000000)
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_bParentAnimComponent1PHead=true
    m_vMeshViewOffset=(X=10.0000000,Y=0.0000000,Z=-3.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=5.0000000,Y=18.0000000,Z=-7.0000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_RuckusInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'LightForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=0.9900000,fMinAccuracy=0.9400000,fAccuracyLossPerShot=0.0050000,fAccuracyGainPerSec=0.3500000,fAccuracyGainDelay=0.2000000)
}
