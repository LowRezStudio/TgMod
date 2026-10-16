class TgDevice_HealingTotem extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated function bool ShouldInterruptReloadOnFire() { }

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=70.0000000
}
