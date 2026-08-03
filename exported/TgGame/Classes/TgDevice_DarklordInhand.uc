class TgDevice_DarklordInhand extends TgDevice_ChainSequence
    native(ChampDarklord)
    hidecategories(Navigation);

simulated event int GetChainMax()
{
    return 3;
    //return ReturnValue;    
}

defaultproperties
{
    m_fChainResetDuration=2.0000000
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Wide
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=12.0000000,Y=1.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=15.0000000,Y=10.0000000,Z=-9.0000000)
    m_fAltFireLockOutTime=0.0000000
}