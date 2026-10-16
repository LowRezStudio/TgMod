class ParticleModuleUberLTISIVCLILIRSSBLIRR extends ParticleModuleUberBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var(Lifetime) noclear export RawDistributionFloat Lifetime;
var(Size) noclear export RawDistributionVector StartSize;
var(Velocity) noclear export RawDistributionVector StartVelocity;
var(Velocity) noclear export RawDistributionFloat StartVelocityRadial;
var(Color) noclear export RawDistributionVector ColorOverLife;
var(Color) noclear export RawDistributionFloat AlphaOverLife;
var(Location) noclear export RawDistributionVector StartLocation;
var(Rotation) noclear export RawDistributionFloat StartRotation;
var(Size) noclear export RawDistributionVector SizeLifeMultiplier;
var(Size) bool SizeMultiplyX;
var(Size) bool SizeMultiplyY;
var(Size) bool SizeMultiplyZ;
var(Rotation) noclear export RawDistributionFloat StartRotationRate;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionLifetime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifetime'
    begin object name="DistributionLifetime" class=Engine.DistributionFloatUniform
        Min=1.0000000
        Max=1.0000000
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionStartSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartSize'
    begin object name="DistributionStartSize" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Min=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionStartVelocity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocity'
    begin object name="DistributionStartVelocity" class=Engine.DistributionVectorUniform
        Max=(X=0.0000000,Y=0.0000000,Z=10.0000000)
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionStartVelocityRadial'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocityRadial'
    begin object name="DistributionStartVelocityRadial" class=Engine.DistributionFloatUniform
    end object
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionColorOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorOverLife'
    begin object name="DistributionColorOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionAlphaOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaOverLife'
    begin object name="DistributionAlphaOverLife" class=Engine.DistributionFloatConstant
        Constant=255.9000000
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    begin object name="DistributionStartLocation" class=Engine.DistributionVectorUniform
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionStartRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotation'
    begin object name="DistributionStartRotation" class=Engine.DistributionFloatUniform
        Max=1.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionLifeMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifeMultiplier'
    begin object name="DistributionLifeMultiplier" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberLTISIVCLILIRSSBLIRR.DistributionStartRotationRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotationRate'
    begin object name="DistributionStartRotationRate" class=Engine.DistributionFloatConstant
    end object
    Lifetime=(Distribution=Distribution=DistributionLifetime,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartSize=(Distribution=Distribution=DistributionStartSize,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartVelocity=(Distribution=Distribution=DistributionStartVelocity,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,10.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,10.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,10.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartVelocityRadial=(Distribution=Distribution=DistributionStartVelocityRadial,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    ColorOverLife=(Distribution=Distribution=DistributionColorOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaOverLife=(Distribution=Distribution=DistributionAlphaOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.9000000,255.9000000,255.9000000,255.9000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartLocation=(Distribution=Distribution=DistributionStartLocation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartRotation=(Distribution=Distribution=DistributionStartRotation,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.0000000,1.0000000,0.0000000,1.0000000,0.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SizeLifeMultiplier=(Distribution=Distribution=DistributionLifeMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SizeMultiplyX=true
    SizeMultiplyY=true
    SizeMultiplyZ=true
    StartRotationRate=(Distribution=Distribution=DistributionStartRotationRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    RequiredModules[0]="ParticleModuleLifetime"
    RequiredModules[1]="ParticleModuleSize"
    RequiredModules[2]="ParticleModuleVelocity"
    RequiredModules[3]="ParticleModuleColorOverLife"
    RequiredModules[4]="ParticleModuleLocation"
    RequiredModules[5]="ParticleModuleRotation"
    RequiredModules[6]="ParticleModuleSizeMultiplyLife"
    RequiredModules[7]="ParticleModuleRotationRate"
    bSpawnModule=true
    bUpdateModule=true
}