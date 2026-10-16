class ParticleModuleSizeScale extends ParticleModuleSizeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var() RawDistributionVector SizeScale;
var() bool EnableX;
var() bool EnableY;
var() bool EnableZ;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSizeScale.DistributionSizeScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSizeScale'
    begin object name="DistributionSizeScale" class=Engine.DistributionVectorConstant
    end object
    SizeScale=(Distribution=Distribution=DistributionSizeScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    EnableX=true
    EnableY=true
    EnableZ=true
    bUpdateModule=true
}