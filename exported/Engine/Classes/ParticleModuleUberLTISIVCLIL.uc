class ParticleModuleUberLTISIVCLIL extends ParticleModuleUberBase
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

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionLifetime'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifetime'
    begin object name="DistributionLifetime" class=Engine.DistributionFloatUniform
        Min=1.0000000
        Max=1.0000000
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionStartSize'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartSize'
    begin object name="DistributionStartSize" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Min=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionStartVelocity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocity'
    begin object name="DistributionStartVelocity" class=Engine.DistributionVectorUniform
        Max=(X=0.0000000,Y=0.0000000,Z=10.0000000)
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionStartVelocityRadial'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartVelocityRadial'
    begin object name="DistributionStartVelocityRadial" class=Engine.DistributionFloatUniform
    end object
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionColorOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionColorOverLife'
    begin object name="DistributionColorOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionAlphaOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAlphaOverLife'
    begin object name="DistributionAlphaOverLife" class=Engine.DistributionFloatConstant
        Constant=255.9000000
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleUberLTISIVCLIL.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    begin object name="DistributionStartLocation" class=Engine.DistributionVectorUniform
    end object
    Lifetime=(Distribution=Distribution=DistributionLifetime,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartSize=(Distribution=Distribution=DistributionStartSize,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartVelocity=(Distribution=Distribution=DistributionStartVelocity,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,10.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,10.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,10.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartVelocityRadial=(Distribution=Distribution=DistributionStartVelocityRadial,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    ColorOverLife=(Distribution=Distribution=DistributionColorOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    AlphaOverLife=(Distribution=Distribution=DistributionAlphaOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(255.9000000,255.9000000,255.9000000,255.9000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartLocation=(Distribution=Distribution=DistributionStartLocation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    RequiredModules[0]="ParticleModuleLifetime"
    RequiredModules[1]="ParticleModuleSize"
    RequiredModules[2]="ParticleModuleVelocity"
    RequiredModules[3]="ParticleModuleColorOverLife"
    RequiredModules[4]="ParticleModuleLocation"
    bSpawnModule=true
    bUpdateModule=true
}