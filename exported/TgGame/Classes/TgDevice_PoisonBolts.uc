class TgDevice_PoisonBolts extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation);

var TgDevice_SkyeInhand m_CachedInhand;

// Export UTgDevice_PoisonBolts::execCanReload(FFrame&, void* const)
native function bool CanReload(optional bool bIsAutoReload = false);

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bAimThroughReticule=true
    m_bUsesBurstFire=true
    m_vMeshViewOffset=(X=15.0000000,Y=0.0000000,Z=-4.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=10.0000000,Y=8.0000000,Z=-7.0000000)
    m_nBurstTotalShots=3
}