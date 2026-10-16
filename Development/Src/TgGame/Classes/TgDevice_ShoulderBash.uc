class TgDevice_ShoulderBash extends TgDevice_Charge
    native(ChampFlak)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var bool m_bHasHitTarget;

native function bool UsesTargetingMode();  // Export UTgDevice_ShoulderBash::execUsesTargetingMode(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_ShoulderBash::execGetMoveSpeedMultiplier(FFrame&, void* const)

reliable server function ValidateChargeHit(Actor Other) { }

function ApplyTouchHit(TgPawn InstigatorPawn, Vector vHitLocation, Vector vHitNormal, Actor Target) { }

simulated function bool ShouldStopOnThisHit(Actor Other) { }

state DeviceFiring {}

defaultproperties
{
    m_bStopOnHitType=CSHT_AnyValidTarget
    m_ChargeTimingType=CFT_PostFire
    m_bApplyHitOnTouch=false
    m_bIgnoreMovementCorrection=true
}
