class ParticleModuleAttractorBoneSocket extends ParticleModuleAttractorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EBoneSocketAttractorFalloffType
{
    BSFOFF_Constant,                // 0
    BSFOFF_Linear,                  // 1
    BSFOFF_Exponent,                // 2
    BSFOFF_MAX                      // 3
};

enum ELocationBoneSocketDestination
{
    BONESOCKETDEST_Bones,           // 0
    BONESOCKETDEST_Sockets,         // 1
    BONESOCKETDEST_MAX              // 2
};

enum ELocationBoneSocketDestSelectionMethod
{
    BONESOCKETDESTSEL_Sequential,   // 0
    BONESOCKETDESTSEL_Random,       // 1
    BONESOCKETDESTSEL_RandomExhaustive,// 2
    BONESOCKETDESTSEL_BlendAll,     // 3
    BONESOCKETDESTSEL_MAX           // 4
};

struct native AttractLocationBoneSocketInfo
{
    var() name BoneSocketName;
    var() Vector Offset;

    structdefaultproperties
    {
        BoneSocketName="None"
        Offset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var() ParticleModuleAttractorBoneSocket.EBoneSocketAttractorFalloffType FalloffType;
var(BoneSocket) ParticleModuleAttractorBoneSocket.ELocationBoneSocketDestination DestinationType;
var(BoneSocket) ParticleModuleAttractorBoneSocket.ELocationBoneSocketDestSelectionMethod SelectionMethod;
var() bool bParticleLifeRelative;
var(BoneSocket) bool bAttractAlongLengthOfBone;
var() interp RawDistributionFloat FalloffExponent;
var() interp RawDistributionFloat Range;
var() interp RawDistributionFloat Strength;
var() interp RawDistributionFloat CollisionRadius;
var() interp RawDistributionFloat DragCoefficient;
var() interp RawDistributionFloat DragRadius;
var(BoneSocket) Vector UniversalOffset;
var(BoneSocket) array<AttractLocationBoneSocketInfo> SourceLocations;
var(BoneSocket) name SkelMeshActorParamName;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorBoneSocket.DistributionFalloffExponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionFalloffExponent'
    begin object name="DistributionFalloffExponent" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorBoneSocket.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorBoneSocket.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorBoneSocket.DistributionDragCoefficient'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDragCoefficient'
    begin object name="DistributionDragCoefficient" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorBoneSocket.DistributionDragRadius'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDragRadius'
    begin object name="DistributionDragRadius" class=Engine.DistributionFloatConstant
    end object
    DestinationType=ELocationBoneSocketDestination.BONESOCKETDEST_Sockets
    FalloffExponent=(Distribution=Distribution=DistributionFalloffExponent,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Range=(Distribution=Distribution=DistributionRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DragCoefficient=(Distribution=Distribution=DistributionDragCoefficient,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    DragRadius=(Distribution=Distribution=DistributionDragRadius,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SkelMeshActorParamName="BoneSocketActor"
    bSpawnModule=true
    bUpdateModule=true
    bFinalUpdateModule=true
    bSupported3DDrawMode=true
}