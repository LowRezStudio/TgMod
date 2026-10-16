class TgDevice_HealingTotem extends TgDevice
    hidecategories(Navigation);

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=70.0000000
}