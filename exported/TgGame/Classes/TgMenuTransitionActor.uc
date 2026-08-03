class TgMenuTransitionActor extends Actor
    notplaceable
    hidecategories(Navigation);

var export editinline ParticleSystemComponent m_IntroPSC;
var export editinline ParticleSystemComponent m_LoopPSC;
var export editinline ParticleSystemComponent m_OutroPSC;

simulated function PlayIntro()
{
    // End:0x2F
    if(m_IntroPSC != none)
    {
        m_IntroPSC.ActivateSystem();
    }
    //return;    
}

simulated function PlayOutro()
{
    // End:0x2F
    if(m_OutroPSC != none)
    {
        m_OutroPSC.ActivateSystem();
    }
    //return;    
}

simulated function PlayLoop()
{
    // End:0x2F
    if(m_LoopPSC != none)
    {
        m_LoopPSC.ActivateSystem();
    }
    //return;    
}

simulated function StopLoop()
{
    // End:0x2E
    if(m_LoopPSC != none)
    {
        m_LoopPSC.DeactivateSystem();
    }
    //return;    
}
