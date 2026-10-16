class TgMenuMeshInfo extends Object
    native
    editinlinenew
    hidecategories(Object);

struct native LobbyMeshInfo
{
    var() Vector Translation;
    var() Rotator Rotation;
    var() float Scale;
    var() SkeletalMesh SkelMesh;
    var() PhysicsAsset PhysAsset;
    var() AnimTree AnimTreeTemplate;
    var() array<AnimSet> AnimSets;
    var() MorphTargetSet MorphTargetSet;
    var() bool bOnlySelfShadow;
    var() array<MaterialInterface> MaterialOverrides;
    var() bool bUseIndividualLightEnvironment;
    var() bool bUseOverlayMesh;

    structdefaultproperties
    {
        Translation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Rotation=(Pitch=0,Yaw=0,Roll=0)
        Scale=1.0000000
        SkelMesh=none
        PhysAsset=none
        AnimTreeTemplate=none
        AnimSets=none
        MorphTargetSet=none
        bOnlySelfShadow=false
        MaterialOverrides=none
        bUseIndividualLightEnvironment=true
        bUseOverlayMesh=true
    }
};

struct native ParticleSystemInfo
{
    var() ParticleSystem ParticleSystem;
    var() name SocketName;

    structdefaultproperties
    {
        ParticleSystem=none
        SocketName="None"
    }
};

var() LobbyMeshInfo MeshInfo;
var() editinline array<editinline TgMenuMeshInfo> Children;
var name ParentSocketName;
var() array<ParticleSystemInfo> AttachedParticleSystems;

// Export UTgMenuMeshInfo::execConfigureMesh(FFrame&, void* const)
native function ConfigureMesh(TgSkeletalMeshActor_Loader lobbyOwner);

// Export UTgMenuMeshInfo::execSetupMeshFromMeshInfo(FFrame&, void* const)
native function SetupMeshFromMeshInfo(TgSkeletalMeshComponent SkelComp);

// Export UTgMenuMeshInfo::execAddFxAttachments(FFrame&, void* const)
native function AddFxAttachments(TgSkeletalMeshComponent SkelComp);

// Export UTgMenuMeshInfo::execIsFullyConfigured(FFrame&, void* const)
native function bool IsFullyConfigured();

function PreloadTextures(float ForceDuration)
{
    local TgMenuMeshInfo Child;
    local int I;

    // End:0xD8
    if(MeshInfo.SkelMesh != none)
    {
        I = 0;
        J0x2D:

        // End:0xD8 [Loop If]
        if(I < MeshInfo.SkelMesh.Materials.Length)
        {
            MeshInfo.SkelMesh.Materials[I].SetForceMipLevelsToBeResident(true, true, ForceDuration);
            I++;
            // [Loop Continue]
            goto J0x2D;
        }
    }
    // End:0x118
    foreach Children(Child)
    {
        Child.PreloadTextures(ForceDuration);        
    }    
    //return;    
}

defaultproperties
{
    MeshInfo=(Translation=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),Scale=1.0000000,SkelMesh=none,PhysAsset=none,AnimTreeTemplate=none,AnimSets=none,MorphTargetSet=none,bOnlySelfShadow=false,MaterialOverrides=none,bUseIndividualLightEnvironment=true,bUseOverlayMesh=true)
}