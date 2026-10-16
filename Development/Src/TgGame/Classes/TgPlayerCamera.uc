class TgPlayerCamera extends Camera
    transient
    native(View)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgEmitter_CameraEffect_DamageBase, TgObject, TgPawn, TgSpecialFx);

struct PropertyDecayState {
    var float PropertyLevel;
    var float PropertyMax;
    var float LastDecayTimestamp;
    structdefaultproperties {}
};

struct PropertyDecayParams {
    var float LambdaImpulse;
    var float LambdaAccumulation;
    var float AccumulationImpulseMix;
    structdefaultproperties {}
};

var TgPlayerController PlayerOwner;
var () editinline TgCameraModule CurrentCameraMod;
var Class<TgCameraModule> DefaultCameraModuleClass;
var array<TgCameraModule> CameraModuleList;
var Rotator CamAngle;
var Vector CameraLocationLocalToTarget;
var Quat CameraRotationLocalToTarget;
var bool bTweening;
var bool bInterpolatingFOV;
var bool m_bPlayingHeal;
var float fTweenStart;
var float fTweenDuration;
var TgCameraModule LastCameraMod;
var float fFOVInterpStartTimestamp;
var float fFOVInterpStartValue;
var float fFOVInterpEndTimestamp;
var float fLastAppliedFOV;
var float m_fCollisionTraceExtent;
var TgEmitter_CameraEffect_Bleed m_BleedCameraEffect;
var TgEmitter_CameraEffect_Daze m_DazeCameraEffect;
var TgEmitter_CameraEffect_Fire m_FireCameraEffect;
var TgEmitter_CameraEffect_Freeze m_FreezeCameraEffect;
var TgEmitter_CameraEffect_Heal m_HealCameraEffect;
var TgEmitter_CameraEffect_Knockback m_KnockbackCameraEffect;
var TgEmitter_CameraEffect_Mark m_MarkCameraEffect;
var TgEmitter_CameraEffect_Poison m_PoisonCameraEffect;
var TgEmitter_CameraEffect_Venom m_VenomCameraEffect;
var TgEmitter_CameraEffect_Root m_RootCameraEffect;
var TgEmitter_CameraEffect_Slow m_SlowCameraEffect;
var TgEmitter_CameraEffect_Stun m_StunCameraEffect;
var TgEmitter_CameraEffect_Hidden m_HiddenCameraEffect;
var TgEmitter_CameraEffect_Hidden m_GrassCameraEffect;
var TgEmitter_CameraEffect_Teleport m_TeleportCameraEffect;
var TgEmitter_CameraEffect_PreTeleport m_PreTeleportCameraEffect;
var TgEmitter_CameraEffect_CCImmune m_CCImmuneCameraEffect;
var TgEmitter_CameraEffect_Cripple m_CrippleCameraEffect;
var TgEmitter_CameraEffect_Revealed m_RevealedCameraEffect;
var protected transient array<TgEmitter_CameraEffect> m_CameraEffects;
var int m_nCameraEffectIdCounter;
var Class<TgEmitter_CameraEffect_DamageBase> m_HealthDamageCameraEffectClasses[EDamageEffectScreenLocation];
var Class<TgEmitter_CameraEffect_DamageBase> m_ShieldDamageCameraEffectClasses[EDamageEffectScreenLocation];
var PropertyDecayState m_HealthDamageFXState[EDamageEffectScreenLocation];
var PropertyDecayState m_HealingFXState;
var PropertyDecayParams m_HealthDamageFXParams;
var PropertyDecayParams m_HealingFXParams;
var float m_fAccumulateHealing;
var float m_fSecondsSinceLastHealFXUpdate;
var float m_fHealFXUpdatePeriod;
var float m_fHealingFXHalflifeAccumulation;
var float m_fHealingFXHalflifeImpulse;
var float m_fHealingFXReliefFactor;
var float m_fHealingFXAccumulationMix;
var float m_fHealingFXVisibleThreshold;
var float m_fHealingCritFXThreshold;
var float m_fHealthDamageFXHalflifeAccumulation;
var float m_fHealthDamageFXHalflifeImpulse;
var float m_fHealthDamageFXPainFactor;
var float m_fHealthDamageFXAccumulationMix;
var float m_fHealthDamageCritFXThreshold;
var float m_fHealthDamageCritFXAccumulationMix;

native function CameraTrace(out Vector HitLocation, out Vector HitNormal, Vector End, Vector Start, Actor Target);  // Export UTgPlayerCamera::execCameraTrace(FFrame&, void* const)

native function CheckPenetration(Vector CheckLocation, float CheckRadius);  // Export UTgPlayerCamera::execCheckPenetration(FFrame&, void* const)

native function ClearPenetrationList();  // Export UTgPlayerCamera::execClearPenetrationList(FFrame&, void* const)

native function CheckViewTarget(out TViewTarget VT);  // Export UTgPlayerCamera::execCheckViewTarget(FFrame&, void* const)

function float LambdaFromHalflife(float fHalflife) { }

function PostBeginPlay() { }

function InitializeFor(PlayerController PC) { }

function ResetFOV() { }

function SetFOV(float NewFOV) { }

function InterpolateFOV(float NewFOV, float InterpolationTime) { }

function float GetFOVAngle() { }

event TgCameraModule SwitchCameras(Class<TgCameraModule> CameraClass, optional float fTweenTime=0.0000000) { }

function TgCameraModule CreateCamera(Class<TgCameraModule> CameraClass) { }

function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime) { }

function EndLastCameraTween() { }

function ProcessInput(PlayerInput PlayerInput, float DeltaTime) { }

function zoomIn() { }

function ZoomOut() { }

simulated event UpdateCamera(float DeltaTime) { }

native function GetViewLocalToTarget(const Actor InViewTarget, out Vector LocalViewLocation, out Quat LocalViewRotation);  // Export UTgPlayerCamera::execGetViewLocalToTarget(FFrame&, void* const)

native function UpdateCameraLocalToTarget();  // Export UTgPlayerCamera::execUpdateCameraLocalToTarget(FFrame&, void* const)


function ApplyFOVModification(out float FOV) { }

function float GetFOVInterpZoomPct() { }

function PlayBleed(bool bEnabled) { }

function PlayOnFire(bool bEnabled) { }

function PlayFreeze(bool bEnabled) { }

function PlayCCImmuneEffects(bool bEnabled) { }

simulated function Tick(float DeltaSeconds) { }

event PlayHeal(float fHealAmount) { }

function PlayKnockback(bool bEnabled) { }

function PlayPoisoned(bool bEnabled) { }

function PlayVenom(bool bEnabled) { }

function PlayCrippled(bool bEnabled) { }

function PlayRoot(bool bEnabled) { }

function PlaySlow(bool bEnabled) { }

function PlayStun(bool bEnabled) { }

function PlayDaze(bool bEnabled) { }

function PlayMark(bool bEnabled) { }

function PlayPreTeleportFX() { }

function PlayTeleportFx() { }

function PlayHidden(bool bEnabled, optional ParticleSystem Template) { }

function PlayGrass(bool bEnabled, optional ParticleSystem Template) { }

function PlayRevealed(bool bEnabled) { }

event TgEmitter_CameraEffect AddCameraEffect(ParticleSystem Template, optional array<Fx_Sound> SoundList) { }

event RemoveCameraEffect(TgEmitter_CameraEffect CameraEffect) { }

function TgEmitter_CameraEffect FindCameraEffect(Class<TgEmitter_CameraEffect> CameraEffectClass) { }

function PlayDamageCameraEffect(TgEmitter_CameraEffect_DamageBase.EDamageEffectScreenLocation ScreenLocation, float fDamageAmount, bool bCritical) { }

function UpdateDecay(out PropertyDecayState PropState, const PropertyDecayParams PropParams, float fPropertyCurrent) { }

function float MixProperty(const PropertyDecayState PropState, const PropertyDecayParams PropParams) { }

function bool CheckCrit(int ScreenLocation) { }

event TakeHit(Vector Direction, float fDamageAmount, Class<DamageType> DamageType, const out ExtraDamageInfo ExtraInfo, TgPawn.EHitAudioCue eCue) { }

defaultproperties
{
    DefaultCameraModuleClass=Class'TgCameraModule_ThirdPerson'
    m_fCollisionTraceExtent=24.0000000
    m_HealthDamageCameraEffectClasses[0]=Class'TgEmitter_CameraEffect_DamageRight'
    m_HealthDamageCameraEffectClasses[1]=Class'TgEmitter_CameraEffect_DamageTopRight'
    m_HealthDamageCameraEffectClasses[2]=Class'TgEmitter_CameraEffect_DamageTop'
    m_HealthDamageCameraEffectClasses[3]=Class'TgEmitter_CameraEffect_DamageTopLeft'
    m_HealthDamageCameraEffectClasses[4]=Class'TgEmitter_CameraEffect_DamageLeft'
    m_HealthDamageCameraEffectClasses[5]=Class'TgEmitter_CameraEffect_DamageBottomLeft'
    m_HealthDamageCameraEffectClasses[6]=Class'TgEmitter_CameraEffect_DamageBottom'
    m_HealthDamageCameraEffectClasses[7]=Class'TgEmitter_CameraEffect_DamageBottomRight'
    m_fHealFXUpdatePeriod=0.1000000
    m_fHealingFXHalflifeAccumulation=0.3500000
    m_fHealingFXHalflifeImpulse=0.6500000
    m_fHealingFXReliefFactor=0.0100000
    m_fHealingFXAccumulationMix=0.1250000
    m_fHealingFXVisibleThreshold=0.2500000
    m_fHealingCritFXThreshold=2.0000000
    m_fHealthDamageFXHalflifeAccumulation=0.6000000
    m_fHealthDamageFXHalflifeImpulse=1.5000000
    m_fHealthDamageFXPainFactor=0.0012500
    m_fHealthDamageFXAccumulationMix=0.4000000
    m_fHealthDamageCritFXThreshold=1000.0000000
    m_fHealthDamageCritFXAccumulationMix=0.2000000
    ConstrainedAspectRatio=1.7777800
    DefaultAspectRatio=1.7777800
}
