class ParticleModuleTypeDataBeam extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

enum EBeamMethod
{
    PEBM_Distance,                  // 0
    PEBM_EndPoints,                 // 1
    PEBM_EndPoints_Interpolated,    // 2
    PEBM_UserSet_EndPoints,         // 3
    PEBM_UserSet_EndPoints_Interpolated,// 4
    PEBM_MAX                        // 5
};

enum EBeamEndPointMethod
{
    PEBEPM_Calculated,              // 0
    PEBEPM_Distribution,            // 1
    PEBEPM_Distribution_Constant,   // 2
    PEBEPM_MAX                      // 3
};

var(Beam) ParticleModuleTypeDataBeam.EBeamMethod BeamMethod;
var(Beam) ParticleModuleTypeDataBeam.EBeamEndPointMethod EndPointMethod;
var(Beam) RawDistributionFloat Distance;
var(Beam) RawDistributionVector EndPoint;
var(Beam) int TessellationFactor;
var(Beam) RawDistributionFloat EmitterStrength;
var(Beam) RawDistributionFloat TargetStrength;
var(Beam) RawDistributionVector EndPointDirection;
var(Beam) int TextureTile;
var(Beam) bool RenderGeometry;
var(Beam) bool RenderDirectLine;
var(Beam) bool RenderLines;
var(Beam) bool RenderTessellation;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataBeam.DistributionDistance'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDistance'
    begin object name="DistributionDistance" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleTypeDataBeam.DistributionEndPoint'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionEndPoint'
    begin object name="DistributionEndPoint" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataBeam.DistributionEmitterStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionEmitterStrength'
    begin object name="DistributionEmitterStrength" class=Engine.DistributionFloatConstant
        Constant=1000.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataBeam.DistributionTargetStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTargetStrength'
    begin object name="DistributionTargetStrength" class=Engine.DistributionFloatConstant
        Constant=1000.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleTypeDataBeam.DistributionEndPointDirection'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionEndPointDirection'
    begin object name="DistributionEndPointDirection" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    end object
    Distance=(Distribution=Distribution=DistributionDistance,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    EndPoint=(Distribution=Distribution=DistributionEndPoint,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    TessellationFactor=1
    EmitterStrength=(Distribution=Distribution=DistributionEmitterStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1000.0000000,1000.0000000,1000.0000000,1000.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    TargetStrength=(Distribution=Distribution=DistributionTargetStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1000.0000000,1000.0000000,1000.0000000,1000.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    EndPointDirection=(Distribution=Distribution=DistributionEndPointDirection,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,1.0000000,1.0000000,0.0000000,0.0000000,1.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    RenderGeometry=true
    bSpawnModule=true
    bUpdateModule=true
}