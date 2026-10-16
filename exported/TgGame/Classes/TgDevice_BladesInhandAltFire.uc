class TgDevice_BladesInhandAltFire extends TgDevice
    native(ChampBlades)
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x65
    if(Current.m_bHandDevice && ((IsFiring()) || IsTimerActive('FirePreHitDelay')) || IsTimerActive('FirePostHitDelay'))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bAimThroughReticule=true
    m_vMeshViewOffset=(X=15.0000000,Y=0.0000000,Z=-4.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=10.0000000,Y=8.0000000,Z=-7.0000000)
}