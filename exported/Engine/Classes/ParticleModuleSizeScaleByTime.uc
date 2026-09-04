class ParticleModuleSizeScaleByTime extends ParticleModuleSizeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var() RawDistributionVector SizeScaleByTime;
var() bool bEnableX;
var() bool bEnableY;
var() bool bEnableZ;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleSizeScaleByTime.DistributionSizeScaleByTime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSizeScaleByTime'
    begin object name="DistributionSizeScaleByTime" class=Engine.DistributionVectorConstantCurve
    end object
    SizeScaleByTime=(Distribution=Distribution=DistributionSizeScaleByTime,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bEnableX=true
    bEnableY=true
    bEnableZ=true
    bSpawnModule=true
    bUpdateModule=true
}