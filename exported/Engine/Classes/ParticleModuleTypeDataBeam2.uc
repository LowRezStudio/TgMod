class ParticleModuleTypeDataBeam2 extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EBeam2Method
{
    PEB2M_Distance,                 // 0
    PEB2M_Target,                   // 1
    PEB2M_Branch,                   // 2
    PEB2M_MAX                       // 3
};

enum EBeamTaperMethod
{
    PEBTM_None,                     // 0
    PEBTM_Full,                     // 1
    PEBTM_Partial,                  // 2
    PEBTM_MAX                       // 3
};

struct BeamTargetData
{
    var() name TargetName;
    var() float TargetPercentage;

    structdefaultproperties
    {
        TargetName="None"
        TargetPercentage=0.0000000
    }
};

var(Beam) ParticleModuleTypeDataBeam2.EBeam2Method BeamMethod;
var(Taper) ParticleModuleTypeDataBeam2.EBeamTaperMethod TaperMethod;
var(Beam) int TextureTile;
var(Beam) float TextureTileDistance;
var(Beam) int Sheets;
var(Beam) int MaxBeamCount;
var(Beam) float Speed;
var(Beam) int InterpolationPoints;
var(Beam) bool bAlwaysOn;
var(Rendering) bool RenderGeometry;
var(Rendering) bool RenderDirectLine;
var(Rendering) bool RenderLines;
var(Rendering) bool RenderTessellation;
var(Beam) int UpVectorStepSize;
var(Branching) name BranchParentName;
var(Distance) RawDistributionFloat Distance;
var(Taper) RawDistributionFloat TaperFactor;
var(Taper) RawDistributionFloat TaperScale;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataBeam2.DistributionDistance'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDistance'
    begin object name="DistributionDistance" class=Engine.DistributionFloatConstant
        Constant=25.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataBeam2.DistributionTaperFactor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTaperFactor'
    begin object name="DistributionTaperFactor" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTypeDataBeam2.DistributionTaperScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTaperScale'
    begin object name="DistributionTaperScale" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    BeamMethod=EBeam2Method.PEB2M_Target
    TextureTile=1
    Sheets=1
    Speed=10.0000000
    RenderGeometry=true
    Distance=(Distribution=Distribution=DistributionDistance,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(25.0000000,25.0000000,25.0000000,25.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    TaperFactor=(Distribution=Distribution=DistributionTaperFactor,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    TaperScale=(Distribution=Distribution=DistributionTaperScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}