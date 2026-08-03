class TgDevice_RepulsorField extends TgDevice_ActiveAura
    native(ChampRuckus)
    hidecategories(Navigation);

var float r_fAtTheReadyRadius;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fAtTheReadyRadius;
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}
