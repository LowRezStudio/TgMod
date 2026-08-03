class ParticleModuleUberRainImpacts extends ParticleModuleUberBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var(Lifetime) RawDistributionFloat Lifetime;
var(Size) RawDistributionVector StartSize;
var(Rotation) RawDistributionVector StartRotation;
var(Rotation) bool bInheritParent;
var(Size) bool MultiplyX;
var(Size) bool MultiplyY;
var(Size) bool MultiplyZ;
var(Location) bool bIsUsingCylinder;
var(Location) bool bPositive_X;
var(Location) bool bPositive_Y;
var(Location) bool bPositive_Z;
var(Location) bool bNegative_X;
var(Location) bool bNegative_Y;
var(Location) bool bNegative_Z;
var(Location) bool bSurfaceOnly;
var(Location) bool bVelocity;
var(Location) bool bRadialVelocity;
var(Size) RawDistributionVector LifeMultiplier;
var(Location) RawDistributionFloat PC_VelocityScale;
var(Location) RawDistributionVector PC_StartLocation;
var(Location) RawDistributionFloat PC_StartRadius;
var(Location) RawDistributionFloat PC_StartHeight;
var(Location) ParticleModuleLocationPrimitiveCylinder.CylinderHeightAxis PC_HeightAxis;
var(Color) RawDistributionVector ColorOverLife;
var(Color) RawDistributionFloat AlphaOverLife;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberRainImpacts.DistributionLifetime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifetime'
    begin object name="DistributionLifetime" class=Engine.DistributionFloatUniform
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberRainImpacts.DistributionStartSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartSize'
    begin object name="DistributionStartSize" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Min=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberRainImpacts.DistributionStartRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotation'
    begin object name="DistributionStartRotation" class=Engine.DistributionVectorUniform
        Max=(X=360.0000000,Y=360.0000000,Z=360.0000000)
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleUberRainImpacts.DistributionLifeMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifeMultiplier'
    begin object name="DistributionLifeMultiplier" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberRainImpacts.DistributionPC_VelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPC_VelocityScale'
    begin object name="DistributionPC_VelocityScale" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleUberRainImpacts.DistributionPC_StartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPC_StartLocation'
    begin object name="DistributionPC_StartLocation" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberRainImpacts.DistributionPC_StartRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPC_StartRadius'
    begin object name="DistributionPC_StartRadius" class=Engine.DistributionFloatConstant
        Constant=50.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberRainImpacts.DistributionPC_StartHeight'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPC_StartHeight'
    begin object name="DistributionPC_StartHeight" class=Engine.DistributionFloatConstant
        Constant=50.0000000
    end object
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleUberRainImpacts.DistributionColorOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorOverLife'
    begin object name="DistributionColorOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberRainImpacts.DistributionAlphaOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaOverLife'
    begin object name="DistributionAlphaOverLife" class=Engine.DistributionFloatConstant
        Constant=255.9000000
    end object
    Lifetime=(Distribution=Distribution=DistributionLifetime,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartSize=(Distribution=Distribution=DistributionStartSize,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartRotation=(Distribution=Distribution=DistributionStartRotation,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,360.0000000,0.0000000,0.0000000,0.0000000,360.0000000,360.0000000,360.0000000,0.0000000,0.0000000,0.0000000,360.0000000,360.0000000,360.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MultiplyX=true
    MultiplyY=true
    MultiplyZ=true
    bIsUsingCylinder=true
    bPositive_X=true
    bPositive_Y=true
    bPositive_Z=true
    bNegative_X=true
    bNegative_Y=true
    bNegative_Z=true
    bRadialVelocity=true
    LifeMultiplier=(Distribution=Distribution=DistributionLifeMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    PC_VelocityScale=(Distribution=Distribution=DistributionPC_VelocityScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    PC_StartLocation=(Distribution=Distribution=DistributionPC_StartLocation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    PC_StartRadius=(Distribution=Distribution=DistributionPC_StartRadius,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    PC_StartHeight=(Distribution=Distribution=DistributionPC_StartHeight,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    PC_HeightAxis=CylinderHeightAxis.PMLPC_HEIGHTAXIS_Z
    ColorOverLife=(Distribution=Distribution=DistributionColorOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaOverLife=(Distribution=Distribution=DistributionAlphaOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.9000000,255.9000000,255.9000000,255.9000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
    bSupported3DDrawMode=true
}