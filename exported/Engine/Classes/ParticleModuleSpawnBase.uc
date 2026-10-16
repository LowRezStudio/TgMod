class ParticleModuleSpawnBase extends ParticleModule
    abstract
    native(Particle)
    editinlinenew
    hidecategories(Object,Object);

var(Spawn) bool bProcessSpawnRate;
var(Burst) bool bProcessBurstList;

defaultproperties
{
    bProcessSpawnRate=true
    bProcessBurstList=true
}