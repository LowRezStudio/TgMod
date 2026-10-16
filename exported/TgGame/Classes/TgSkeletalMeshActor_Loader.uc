class TgSkeletalMeshActor_Loader extends TgSkeletalMeshActor
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader)
    implements(TgSkinnableInterface);

enum LobbyAnimPose
{
    LAP_Match,                      // 0
    LAP_Victory,                    // 1
    LAP_Defeat,                     // 2
    LAP_InGame,                     // 3
    LAP_MAX                         // 4
};

var private native const noexport Pointer VfTable_ITgSkinnableInterface;
var transient TgMenuMeshInfo m_PendingMeshInfo;
var transient TgMenuMeshInfo m_CurrentMeshInfo;
var export editinline TgManifestGroup c_AssetManifestGroup;
var native Pointer m_PendingBot;
var native Pointer m_PendingSkin;
var native Pointer m_PendingHead;
var native Pointer m_PendingDevice;
var native Pointer m_PendingDeviceSkin;
var transient TgSkeletalMeshActor_Loader.LobbyAnimPose m_PendingPose;
var transient TgSkeletalMeshActor_Loader.LobbyAnimPose m_CurrentPose;
var transient TgObject.EModelHighlightType m_HighlightType;
var native Pointer m_PendingMVPDevice;
var native Pointer m_CurrentBot;
var native Pointer m_CurrentSkin;
var native Pointer m_CurrentHead;
var native Pointer m_CurrentDevice;
var native Pointer m_CurrentDeviceSkin;
var native Pointer m_CurrentMVPDevice;
var transient bool m_bWaitingForTextures;
var transient bool m_bIsAsyncLoading;
var() bool m_bAllowOverlays;
var() bool m_bUsesPreviewMesh;
var(Lighting) bool m_bOverrideLightingChannels;
var int m_nAsyncLoadDelayTicksDefault;
var transient int m_nAsyncLoadDelayTicks;
var export editinline transient PointLightComponent m_PointLight;
var export editinline transient array<export editinline TgSkeletalMeshComponent> m_ChildMeshes;
var export editinline transient array<export editinline TgSkeletalMeshComponent> m_SkinMeshes;
var export editinline transient array<export editinline TgSkeletalMeshComponent> m_HeadMeshes;
var export editinline transient array<export editinline TgSkeletalMeshComponent> m_WeaponMeshes;
var export editinline transient LightEnvironmentComponent m_AlternateLightEnvironmentTemplate;
var export editinline transient array<export editinline LightEnvironmentComponent> m_AlternateLightEnvironments;
var MaterialInterface m_OverlayMaterial;
var() export editinline TgCustomCharacterComponent m_CustomCharacterComponent;
var(Lighting) const LightingChannelContainer m_LightingChannels;
var transient array<TgAnimBlendByEmote> m_EmoteBlendNodes;
var transient array<TgAnimNodeEmoteSequence> m_EmoteSequenceNodes;
var MaterialInstanceConstant NonHighlightMaterial;
var transient AnimSet m_EmoteAnimSet;
var transient AnimSet m_MVPAnimSet;
var transient float m_fMaterialAnimationValue;
var transient float m_fMaterialAnimationTarget;
var transient float m_fMaterialAnimationTimer;
//var delegate<OnMeshUpdated> __OnMeshUpdated__Delegate;

delegate OnMeshUpdated()
{
    //return;    
}

// Export UTgSkeletalMeshActor_Loader::execResetAnims(FFrame&, void* const)
native function ResetAnims();

// Export UTgSkeletalMeshActor_Loader::execAllManifestsLoaded(FFrame&, void* const)
native function AllManifestsLoaded();

// Export UTgSkeletalMeshActor_Loader::execSetActive(FFrame&, void* const)
native function SetActive(bool bActive);

// Export UTgSkeletalMeshActor_Loader::execCleanupForAssetSwap(FFrame&, void* const)
native function CleanupForAssetSwap(optional bool bReset = true);

// Export UTgSkeletalMeshActor_Loader::execForceRecalculateMaterial(FFrame&, void* const)
native function ForceRecalculateMaterial();

// Export UTgSkeletalMeshActor_Loader::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);

// Export UTgSkeletalMeshActor_Loader::execPlayLobbyAnim(FFrame&, void* const)
native function PlayLobbyAnim(TgObject.ELobbyAnimState NewAnimState);

// Export UTgSkeletalMeshActor_Loader::execPlayEmote(FFrame&, void* const)
native function PlayEmote(int nDeviceId);

// Export UTgSkeletalMeshActor_Loader::execStopEmote(FFrame&, void* const)
native function StopEmote();

// Export UTgSkeletalMeshActor_Loader::execPlayMVP(FFrame&, void* const)
native function PlayMVP(int nDeviceId, bool bInstant);

// Export UTgSkeletalMeshActor_Loader::execStopMVP(FFrame&, void* const)
native function StopMVP();

// Export UTgSkeletalMeshActor_Loader::execCancelEmote(FFrame&, void* const)
native function CancelEmote(optional bool bVerifyNoRelevantEmotes, optional TgAnimNodeEmoteSequence Exclude);

// Export UTgSkeletalMeshActor_Loader::execSetMaterialScalarParameterValue(FFrame&, void* const)
native function SetMaterialScalarParameterValue(name szParameterName, float fValue, optional bool bSkin = true, optional bool bHead = true, optional bool bWeapon = true);

simulated function PlayEmoteTimer()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x74 [Loop If]
    if(I < m_ChildMeshes.Length)
    {
        // End:0x66
        if(m_ChildMeshes[I] != none)
        {
            m_ChildMeshes[I].SetHidden(false);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    PlayLobbyAnim(2);
    //return;    
}

simulated event PlayMVPTimer()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x74 [Loop If]
    if(I < m_ChildMeshes.Length)
    {
        // End:0x66
        if(m_ChildMeshes[I] != none)
        {
            m_ChildMeshes[I].SetHidden(false);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    PlayLobbyAnim(3);
    //return;    
}

simulated event PreBeginPlay()
{
    super(Actor).PreBeginPlay();
    c_AssetManifestGroup.__OnAllManifestsLoaded__Delegate = AllManifestsLoaded;
    c_AssetManifestGroup.m_OwningObject = self;
    //return;    
}

simulated event BeginTransition(optional bool bPlayFx = false)
{
    CleanupForAssetSwap(false);
    SetHidden(true);
    //return;    
}

simulated event EndTransition()
{
    SetHidden(false);
    ResetAnims();
    //return;    
}

event PlayChildAnim(TgSkeletalMeshComponent notifySource, name AnimSeqName)
{
    local editinline TgSkeletalMeshComponent SkelComp;
    local TgAnimNodeSlot Slot;

    // End:0x12D
    foreach m_ChildMeshes(SkelComp)
    {
        // End:0x12C
        if((SkelComp != notifySource) && SkelComp.Animations != none)
        {
            Slot = TgAnimNodeSlot(SkelComp.Animations.FindAnimNode('FullBody'));
            // End:0x12C
            if(Slot != none)
            {
                // End:0x108
                if(AnimSeqName != 'None')
                {
                    Slot.PlayCustomAnim(AnimSeqName, 1.0000000, 0.0000000, 0.0000000, false, true);                    
                }
                else
                {
                    Slot.StopCustomAnim(0.0000000);
                }
            }
        }        
    }    
    //return;    
}

event bool PlayParticleEffect(const AnimNotify_PlayParticleEffect AnimNotifyData)
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgManifestGroup'TgGame.Default__TgSkeletalMeshActor_Loader.TgManifestGroup0'
    begin object name="TgManifestGroup0" class=TgGame.TgManifestGroup
    end object
    c_AssetManifestGroup=TgManifestGroup0
    m_bUsesPreviewMesh=true
    m_nAsyncLoadDelayTicksDefault=2
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.AltLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AltLightEnvironment'
    begin object name="AltLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        bSynthesizeSHLight=true
        bIsCharacterLightEnvironment=true
    end object
    m_AlternateLightEnvironmentTemplate=AltLightEnvironment
    m_OverlayMaterial=MaterialInstanceConstant'GOD_CommonAssets.RimLight.MIC_RimLight'
    m_LightingChannels=(bInitialized=true,BSP=false,Static=false,Dynamic=true,CompositeDynamic=false,Skybox=false,Unnamed_1=false,Unnamed_2=false,Unnamed_3=false,Unnamed_4=false,Unnamed_5=false,Unnamed_6=false,Cinematic_1=false,Cinematic_2=false,Cinematic_3=false,Cinematic_4=false,Cinematic_5=false,Cinematic_6=false,Cinematic_7=false,Cinematic_8=false,Cinematic_9=false,Cinematic_10=false,Gameplay_1=false,Gameplay_2=false,Gameplay_3=false,Gameplay_4=false,Crowd=false)
    NonHighlightMaterial=MaterialInstanceConstant'PC_Common.MIC_NonHighlighted'
    c_bLoadMeshAssetts=false
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0.AnimNodeSeq0_1'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0.AnimNodeSeq0'
        begin object name="AnimNodeSeq0_1"
        end object
        Animations=AnimNodeSeq0_1
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
        bSynthesizeSHLight=true
        bIsCharacterLightEnvironment=true
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_Loader.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_Loader.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_Loader.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActor.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=MySilhouette
    Components[2]=FaceAudioComponent
    Components[3]=AltLightEnvironment
    Components[4]=none
    Components[5]=none
    // Reference: CylinderComponent'TgGame.Default__TgSkeletalMeshActor_Loader.Cylinder0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Cylinder0'
    begin object name="Cylinder0" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[6]=Cylinder0
    CollisionComponent=Cylinder0
}