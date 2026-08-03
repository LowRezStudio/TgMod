class ParticleEventManager extends Actor
    abstract
    native(Particle)
    notplaceable
    hidecategories(Navigation);

event HandleParticleModuleEventSendToGame(ParticleModuleEventSendToGame InEvent, const out Vector InCollideDirection, const out Vector InHitLocation, const out Vector InHitNormal, const out name InBoneName)
{
    //return;    
}
