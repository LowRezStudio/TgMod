class TgDevice_LazarusInhand extends TgDevice_ChainSequence
    native(ChampLazarus)
    hidecategories(Navigation)
    config(Engine);

simulated event int GetChainMax() { }

defaultproperties
{
    m_fChainResetDuration=3.0000000
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Wide
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_fAltFireLockOutTime=0.0000000
}
