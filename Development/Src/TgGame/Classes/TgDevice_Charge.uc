class TgDevice_Charge extends TgDevice_ChainSequence
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject, TgPawn);

enum ChargeFiringType {
    CFT_Fire,  // 0
    CFT_PreFire,  // 1
    CFT_PostFire,  // 2
};

enum ChargeStopOnHitType {
    CSHT_None,  // 0
    CSHT_AnyValidTarget,  // 1
    CSHT_GodOnly,  // 2
    CSHT_NotGod,  // 3
};

var TgPawn.EChargeState m_eChargeState;
var TgDevice_Charge.ChargeStopOnHitType m_bStopOnHitType;
var TgDevice_Charge.ChargeFiringType m_ChargeTimingType;
var bool m_bUsePhysFlying;
var bool m_bUseDamageRadiusForHitProxy;
var bool m_bIgnoreHumanoids;
var bool m_bHitOnce;
var bool m_bApplyHitOnTouch;
var bool m_bApplyHitSpecialOnTouch;
var bool m_bIgnoreRange;
var bool m_bCharging;
var bool m_bStopOnAttachedForcefield;
var bool m_bInterruptDeviceIfChargeEnds;
var bool m_bUseDirectHitSpecial;
var bool m_bChargeBackward;
var bool m_bCanLeftClickCancel;
var bool m_bIgnoreMovementCorrection;
var TgCollisionProxy_Cylinder m_HitProxy;
var Vector m_vHitProxyRelativeLocation;
var Vector m_vHitProxySizeOffset;
var float s_fServerValidationSizeMultiplier;
var Rotator m_rLastChargeDirection;
var array<Actor> s_AppliedList;
var array<Actor> s_HitActors;

native function SetFireMode(int nFireModeNum, optional bool ForceSet=false);  // Export UTgDevice_Charge::execSetFireMode(FFrame&, void* const)

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Charge::execGetTargetingAim(FFrame&, void* const)

native function bool ServerValidateChargeHit(Actor Other);  // Export UTgDevice_Charge::execServerValidateChargeHit(FFrame&, void* const)

simulated event ChargeTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ChargeUnTouch(Actor Other) { }

simulated event StartCharge() { }

simulated event EndCharge() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated event float GetChargeRange() { }

simulated event float GetChargeTime() { }

simulated function float GetChargeSpeed() { }

simulated function bool ShouldStopOnThisHit(Actor Other) { }

event ApplyDamageReduction(out ImpactInfo Impact) { }

simulated function OnValidTargetTouched(Actor Other) { }

simulated function OnStoppedChargeOnHit(Actor Other) { }

simulated function Rotator GetChargeDirection() { }

simulated function EnableCorrection() { }

function ApplyTouchHit(TgPawn InstigatorPawn, Vector vHitLocation, Vector vHitNormal, Actor Target) { }

simulated event bool CanFiringBeCanceledByLeftMouse() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

state DeviceFiring {}

defaultproperties
{
    m_eChargeState=CHARGE_NoTurn
    m_bUseDamageRadiusForHitProxy=true
    m_bIgnoreHumanoids=true
    m_bHitOnce=true
    m_bApplyHitOnTouch=true
    m_bInterruptDeviceIfChargeEnds=true
    m_bCanLeftClickCancel=true
    s_fServerValidationSizeMultiplier=2.0000000
    m_bConsumePowerPoolOnStartFire=true
    m_bAlwaysStartCooldown=true
    m_bForce3PViewWhileFiring=true
}
