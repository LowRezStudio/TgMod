class TgDevice_Pounce extends TgDevice_Charge
    native(ChampBlades)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Blades m_CachedBlades;
var bool m_bHasBounced;

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Pounce::execGetTargetingAim(FFrame&, void* const)

simulated function bool HasCachedBlades() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool IsPostHitLockOutActive() { }

simulated function PostHitLockOut() { }

reliable server function ServerBounceOff(Actor Other) { }

reliable client simulated function ClientBounceOff() { }

simulated function BounceOff() { }

state DeviceFiring {}

defaultproperties
{
    m_bStopOnHitType=CSHT_GodOnly
    m_ChargeTimingType=CFT_PreFire
    m_bUsePhysFlying=true
    m_bIgnoreHumanoids=false
    m_vHitProxySizeOffset=(X=0.0000000,Y=12.0000000,Z=0.0000000)
    m_DeviceEmoteAt=DEA_Custom
    m_bForce3PViewWhileFiring=false
}
