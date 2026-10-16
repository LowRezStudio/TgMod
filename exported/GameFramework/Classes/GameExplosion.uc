class GameExplosion extends Object
    native
    editinlinenew;

var() bool bDirectionalExplosion;
var transient bool bIgnoreInstigator;
var() bool bAllowTeammateCringes;
var transient bool bFullDamageToAttachee;
var() bool bAttachExplosionEmitterToAttachee;
var() bool bPerformRadialBlurRelevanceCheck;
var() bool bCausesFracture;
var() bool bAllowPerMaterialFX;
var() bool bParticleSystemIsBeingOverriddenDontUsePhysMatVersion;
var() bool bSkipDefaultPhysMatParticleSystem;
var() bool bUseMapSpecificValues;
var() bool bUseOverlapCheck;
var() bool bOrientCameraShakeTowardsEpicenter;
var() bool bAutoControllerVibration;
var() float DirectionalExplosionAngleDeg;
var() float DamageDelay;
var() float Damage;
var() float DamageRadius;
var() float DamageFalloffExponent;
var transient Actor ActorToIgnoreForDamage;
var() Class<Actor> ActorClassToIgnoreForDamage;
var() Class<Actor> ActorClassToIgnoreForKnockdownsAndCringes;
var() Class<DamageType> MyDamageType;
var() float KnockDownRadius;
var() float KnockDownStrength;
var() float CringeRadius;
var() Vector2D CringeDuration;
var() float MomentumTransferScale;
var() ParticleSystem ParticleEmitterTemplate;
var() float ExplosionEmitterScale;
var Actor HitActor;
var Vector HitLocation;
var Vector HitNormal;
var() SoundCue ExplosionSound;
var() SoundCue ExplosionSoundHurtSomeone;
var() export editinline PointLightComponent ExploLight;
var() float ExploLightFadeOutTime;
var() export editinline RadialBlurComponent ExploRadialBlur;
var() float ExploRadialBlurFadeOutTime;
var() float ExploRadialBlurMaxBlur;
var() float FractureMeshRadius;
var() float FracturePartVel;
var() editinline CameraShake CamShake;
var() editinline CameraShake CamShake_Left;
var() editinline CameraShake CamShake_Right;
var() editinline CameraShake CamShake_Rear;
var() float CamShakeInnerRadius;
var() float CamShakeOuterRadius;
var() float CamShakeFalloff;
var() Class<EmitterCameraLensEffectBase> CameraLensEffect;
var() float CameraLensEffectRadius;

defaultproperties
{
    bCausesFracture=true
    bAutoControllerVibration=true
    CringeDuration=(X=-1.0000000,Y=-1.0000000)
    MomentumTransferScale=1.0000000
    ExplosionEmitterScale=1.0000000
    ExploRadialBlurMaxBlur=2.0000000
    CamShakeFalloff=2.0000000
}