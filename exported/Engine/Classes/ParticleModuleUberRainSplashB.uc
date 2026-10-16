class ParticleModuleUberRainSplashB extends ParticleModuleUberBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var(Lifetime) RawDistributionFloat Lifetime;
var(Size) RawDistributionVector StartSize;
var(Color) RawDistributionVector ColorOverLife;
var(Color) RawDistributionFloat AlphaOverLife;
var(Size) RawDistributionVector LifeMultiplier;
var(Size) bool MultiplyX;
var(Size) bool MultiplyY;
var(Size) bool MultiplyZ;
var(Rotation) RawDistributionFloat StartRotationRate;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberRainSplashB.DistributionLifetime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifetime'
    begin object name="DistributionLifetime" class=Engine.DistributionFloatUniform
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberRainSplashB.DistributionStartSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartSize'
    begin object name="DistributionStartSize" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Min=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleUberRainSplashB.DistributionColorOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorOverLife'
    begin object name="DistributionColorOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberRainSplashB.DistributionAlphaOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaOverLife'
    begin object name="DistributionAlphaOverLife" class=Engine.DistributionFloatConstant
        Constant=255.9000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleUberRainSplashB.DistributionLifeMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifeMultiplier'
    begin object name="DistributionLifeMultiplier" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberRainSplashB.DistributionStartRotationRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotationRate'
    begin object name="DistributionStartRotationRate" class=Engine.DistributionFloatConstant
    end object
    Lifetime=(Distribution=Distribution=DistributionLifetime,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartSize=(Distribution=Distribution=DistributionStartSize,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    ColorOverLife=(Distribution=Distribution=DistributionColorOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaOverLife=(Distribution=Distribution=DistributionAlphaOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.9000000,255.9000000,255.9000000,255.9000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    LifeMultiplier=(Distribution=Distribution=DistributionLifeMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MultiplyX=true
    MultiplyY=true
    MultiplyZ=true
    StartRotationRate=(Distribution=Distribution=DistributionStartRotationRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
    bSupported3DDrawMode=true
}