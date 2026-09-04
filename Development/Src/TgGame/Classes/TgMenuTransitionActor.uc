class TgMenuTransitionActor extends Actor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var export editinline ParticleSystemComponent m_IntroPSC;
var export editinline ParticleSystemComponent m_LoopPSC;
var export editinline ParticleSystemComponent m_OutroPSC;

simulated function PlayIntro() { }

simulated function PlayOutro() { }

simulated function PlayLoop() { }

simulated function StopLoop() { }
