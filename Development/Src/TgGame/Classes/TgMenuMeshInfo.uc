class TgMenuMeshInfo extends Object
    native
    editinlinenew
    hidecategories(Object)
    config(Engine);

struct LobbyMeshInfo {
    var () Vector Translation;
    var () Rotator Rotation;
    var () float Scale;
    var () SkeletalMesh SkelMesh;
    var () PhysicsAsset PhysAsset;
    var () AnimTree AnimTreeTemplate;
    var () array<AnimSet> AnimSets;
    var () MorphTargetSet MorphTargetSet;
    var () bool bOnlySelfShadow;
    var () array<MaterialInterface> MaterialOverrides;
    var () bool bUseIndividualLightEnvironment;
    var () bool bUseOverlayMesh;
    structdefaultproperties {}
};

struct ParticleSystemInfo {
    var () ParticleSystem ParticleSystem;
    var () name SocketName;
    structdefaultproperties {}
};

var () LobbyMeshInfo MeshInfo;
var () editinline array<TgMenuMeshInfo> Children;
var name ParentSocketName;
var () array<ParticleSystemInfo> AttachedParticleSystems;

native function ConfigureMesh(TgSkeletalMeshActor_Loader lobbyOwner);  // Export UTgMenuMeshInfo::execConfigureMesh(FFrame&, void* const)

native function SetupMeshFromMeshInfo(TgSkeletalMeshComponent SkelComp);  // Export UTgMenuMeshInfo::execSetupMeshFromMeshInfo(FFrame&, void* const)

native function AddFxAttachments(TgSkeletalMeshComponent SkelComp);  // Export UTgMenuMeshInfo::execAddFxAttachments(FFrame&, void* const)

native function bool IsFullyConfigured();  // Export UTgMenuMeshInfo::execIsFullyConfigured(FFrame&, void* const)

function PreloadTextures(float ForceDuration) { }

defaultproperties
{
    MeshInfo=(Translation=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),Scale=1.0000000,SkelMesh=none,PhysAsset=none,AnimTreeTemplate=none,AnimSets=none,MorphTargetSet=none,bOnlySelfShadow=false,MaterialOverrides=none,bUseIndividualLightEnvironment=true,bUseOverlayMesh=true)
}
