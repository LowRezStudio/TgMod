class TgDevice_KingBomb extends TgDevice_Charge
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var (Lockout) float m_fEndFireZoomDurationOverride;

native function bool ShouldInstigatorCollideWith(Actor Other);  // Export UTgDevice_KingBomb::execShouldInstigatorCollideWith(FFrame&, void* const)

simulated function float GetChargeSpeed() { }

simulated event float GetChargeRange() { }

simulated event bool CanBeCanceled() { }

simulated function FireAmmunition() { }

simulated function OutroLockoutTime() { }

function ApplyPostExplodeKnockback() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{
    m_fEndFireZoomDurationOverride=0.1000000
    m_eChargeState=CHARGE_Turn
    m_bStopOnHitType=CSHT_GodOnly
    m_ChargeTimingType=CFT_PreFire
    m_bUseDamageRadiusForHitProxy=false
    m_bIgnoreHumanoids=false
    m_bApplyHitOnTouch=false
    m_vHitProxyRelativeLocation=(X=15.0000000,Y=0.0000000,Z=0.0000000)
    m_vHitProxySizeOffset=(X=20.0000000,Y=10.0000000,Z=0.0000000)
    m_DeviceTimerBarType=DTBT_PreHit
    m_bCarryPreFireToPostFire=false
    m_bForce3PViewWhileFiring=false
    m_bDisableLagCompensation=true
    m_bUsesOutroLockout=true
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceKingBomb'
    m_fOutroLockoutTime=0.7500000
}
