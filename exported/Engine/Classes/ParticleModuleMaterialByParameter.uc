class ParticleModuleMaterialByParameter extends ParticleModuleMaterialBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var() array<name> MaterialParameters;
var() editfixedsize array<MaterialInterface> DefaultMaterials;

defaultproperties
{
    bUpdateModule=true
}