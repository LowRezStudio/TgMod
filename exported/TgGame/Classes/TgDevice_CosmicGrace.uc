class TgDevice_CosmicGrace extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation);

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}
