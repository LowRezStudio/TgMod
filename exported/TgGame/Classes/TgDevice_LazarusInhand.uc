class TgDevice_LazarusInhand extends TgDevice_ChainSequence
    native(ChampLazarus)
    hidecategories(Navigation);

simulated event int GetChainMax()
{
    return 2;
    //return ReturnValue;    
}

defaultproperties
{
    m_fChainResetDuration=3.0000000
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Wide
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_fAltFireLockOutTime=0.0000000
}