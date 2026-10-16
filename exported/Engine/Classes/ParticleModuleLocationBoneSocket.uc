class ParticleModuleLocationBoneSocket extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ELocationBoneSocketSource
{
    BONESOCKETSOURCE_Bones,         // 0
    BONESOCKETSOURCE_Sockets,       // 1
    BONESOCKETSOURCE_MAX            // 2
};

enum ELocationBoneSocketSelectionMethod
{
    BONESOCKETSEL_Sequential,       // 0
    BONESOCKETSEL_Random,           // 1
    BONESOCKETSEL_RandomExhaustive, // 2
    BONESOCKETSEL_MAX               // 3
};

struct native LocationBoneSocketInfo
{
    var() name BoneSocketName;
    var() Vector Offset;

    structdefaultproperties
    {
        BoneSocketName="None"
        Offset=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var(BoneSocket) ParticleModuleLocationBoneSocket.ELocationBoneSocketSource SourceType;
var(BoneSocket) ParticleModuleLocationBoneSocket.ELocationBoneSocketSelectionMethod SelectionMethod;
var(BoneSocket) Vector UniversalOffset;
var(BoneSocket) array<LocationBoneSocketInfo> SourceLocations;
var(BoneSocket) bool bUpdatePositionEachFrame;
var(BoneSocket) bool bOrientMeshEmitters;
var(BoneSocket) bool bInheritVelocityAtSpawn;
var(BoneSocket) name SkelMeshActorParamName;
var float LastUpdateTime;

defaultproperties
{
    SourceType=ELocationBoneSocketSource.BONESOCKETSOURCE_Sockets
    bOrientMeshEmitters=true
    SkelMeshActorParamName="BoneSocketActor"
    bSpawnModule=true
    bUpdateModule=true
    bFinalUpdateModule=true
    bSupported3DDrawMode=true
}