class TgDevice_ChainSequence extends TgDevice
    abstract
    native(Devices)
    hidecategories(Navigation);

var int m_nChainCount;
var float m_fChainResetTimer;
var const float m_fChainResetDuration;

simulated event int GetChainMax()
{
    return 1;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    local int nChainMax;

    super.FireAmmunition();
    nChainMax = GetChainMax();
    // End:0x77
    if(nChainMax > 1)
    {
        m_nChainCount++;
        // End:0x64
        if(m_nChainCount >= nChainMax)
        {
            m_nChainCount = 0;
            OnChainReset();
        }
        m_fChainResetTimer = m_fChainResetDuration;
    }
    //return;    
}

simulated function UpdateDesiredFireMode()
{
    // End:0x28
    if((GetChainMax()) > 1)
    {
        m_nDesiredFireMode = byte(m_nChainCount);        
    }
    else
    {
        super.UpdateDesiredFireMode();
    }
    //return;    
}

simulated event OnChainReset()
{
    //return;    
}

defaultproperties
{
    m_fChainResetDuration=5.0000000
}