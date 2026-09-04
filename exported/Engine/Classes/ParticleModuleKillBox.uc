class ParticleModuleKillBox extends ParticleModuleKillBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Kill) RawDistributionVector LowerLeftCorner;
var(Kill) RawDistributionVector UpperRightCorner;
var(Kill) bool bAbsolute;
var(Kill) bool bKillInside;
var(Kill) bool bAxisAlignedAndFixedSize;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleKillBox.DistributionLowerLeftCorner'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLowerLeftCorner'
    begin object name="DistributionLowerLeftCorner" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleKillBox.DistributionUpperRightCorner'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionUpperRightCorner'
    begin object name="DistributionUpperRightCorner" class=Engine.DistributionVectorConstant
    end object
    LowerLeftCorner=(Distribution=Distribution=DistributionLowerLeftCorner,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    UpperRightCorner=(Distribution=Distribution=DistributionUpperRightCorner,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bAxisAlignedAndFixedSize=true
    bUpdateModule=true
    bSupported3DDrawMode=true
}