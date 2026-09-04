class ParticleModuleLocationEmitter extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ELocationEmitterSelectionMethod
{
    ELESM_Random,                   // 0
    ELESM_Sequential,               // 1
    ELESM_MAX                       // 2
};

var(Location) noclear export name EmitterName;
var(Location) ParticleModuleLocationEmitter.ELocationEmitterSelectionMethod SelectionMethod;
var(Location) bool InheritSourceVelocity;
var(Location) bool bInheritSourceRotation;
var(Location) float InheritSourceVelocityScale;
var(Location) float InheritSourceRotationScale;

defaultproperties
{
    InheritSourceVelocityScale=1.0000000
    InheritSourceRotationScale=1.0000000
    bSpawnModule=true
}