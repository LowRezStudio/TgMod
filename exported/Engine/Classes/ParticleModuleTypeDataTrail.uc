class ParticleModuleTypeDataTrail extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var(Trail) bool RenderGeometry;
var(Trail) bool RenderLines;
var(Trail) bool RenderTessellation;
var(Trail) bool Tapered;
var(Trail) bool SpawnByDistance;
var(Trail) int TessellationFactor;
var(Trail) RawDistributionFloat Tension;
var(Trail) Vector SpawnDistance;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataTrail.DistributionTension'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTension'
    begin object name="DistributionTension" class=Engine.DistributionFloatConstant
    end object
    RenderGeometry=true
    TessellationFactor=1
    Tension=(Distribution=Distribution=DistributionTension,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SpawnDistance=(X=5.0000000,Y=5.0000000,Z=5.0000000)
}