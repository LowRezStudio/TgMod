class TgDevice_Counter extends TgDevice
    native(ChampDarklord)
    hidecategories(Navigation)
    config(Engine);

var bool r_bInterruptAfterCounterAttack;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bInterruptAfterCounterAttack;
}

simulated event bool ShouldLockFiring(TgDevice Current) { }

event bool CanTriggerCounterAttack() { }

function CounterDelay() { }

simulated function UpdateOutroLockoutTime() { }

state DeviceFiring {}

defaultproperties
{
    r_bInterruptAfterCounterAttack=true
    m_DeviceTimerBarType=DTBT_PreHit
    m_bAlwaysStartCooldown=true
    m_bUsesOutroLockout=true
}
