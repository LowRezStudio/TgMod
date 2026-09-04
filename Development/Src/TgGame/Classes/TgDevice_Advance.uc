class TgDevice_Advance extends TgDevice_Charge
    native(ChampRuckus)
    hidecategories(Navigation)
    config(Engine);

var bool m_bHasCharged;
var repnotify bool r_bHasAerialAssault;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasAerialAssault;
}

simulated event ReplicatedEvent(name VarName) { }

simulated function Rotator GetChargeDirection() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool ShouldInterruptReloadOnFire() { }

function bool ShouldApplyHitSpecialOnTouch(Actor Target) { }

state DeviceFiring {}

defaultproperties
{
    m_bUsePhysFlying=true
    m_bCanLeftClickCancel=false
    m_bForce3PViewWhileFiring=false
}
