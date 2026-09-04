class TgDevice_Barrier extends TgDevice
    hidecategories(Navigation)
    config(Engine);

function InitMaxHealth() { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

state DeviceFiring {}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
    m_bCooldownAfterDeployDeath=true
    m_fBottomlessPitCheck=5000.0000000
}
