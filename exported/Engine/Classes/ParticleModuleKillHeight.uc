class ParticleModuleKillHeight extends ParticleModuleKillBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Kill) RawDistributionFloat Height;
var(Kill) bool bAbsolute;
var(Kill) bool bFloor;
var(Kill) bool bApplyPSysScale;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleKillHeight.DistributionHeight'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionHeight'
    begin object name="DistributionHeight" class=Engine.DistributionFloatConstant
    end object
    Height=(Distribution=Distribution=DistributionHeight,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
    bSupported3DDrawMode=true
}