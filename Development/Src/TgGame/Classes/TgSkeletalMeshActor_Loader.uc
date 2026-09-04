class TgSkeletalMeshActor_Loader extends TgSkeletalMeshActor
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader)
    implements(TgSkinnableInterface)
    config(Engine)
    dependson(TgObject);

enum LobbyAnimPose {
    LAP_Match,  // 0
    LAP_Victory,  // 1
    LAP_Defeat,  // 2
    LAP_InGame,  // 3
};

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
var () bool m_bAllowOverlays;
var () bool m_bUsesPreviewMesh;
var (Lighting) bool m_bOverrideLightingChannels;
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
var () export editinline TgCustomCharacterComponent m_CustomCharacterComponent;
var (Lighting) const LightingChannelContainer m_LightingChannels;
var transient array<TgAnimBlendByEmote> m_EmoteBlendNodes;
var transient array<TgAnimNodeEmoteSequence> m_EmoteSequenceNodes;
var MaterialInstanceConstant NonHighlightMaterial;
var transient AnimSet m_EmoteAnimSet;
var transient AnimSet m_MVPAnimSet;
var transient float m_fMaterialAnimationValue;
var transient float m_fMaterialAnimationTarget;
var transient float m_fMaterialAnimationTimer;

delegate OnMeshUpdated();

native function ResetAnims();  // Export UTgSkeletalMeshActor_Loader::execResetAnims(FFrame&, void* const)

native function AllManifestsLoaded();  // Export UTgSkeletalMeshActor_Loader::execAllManifestsLoaded(FFrame&, void* const)

native function SetActive(bool bActive);  // Export UTgSkeletalMeshActor_Loader::execSetActive(FFrame&, void* const)

native function CleanupForAssetSwap(optional bool bReset=true);  // Export UTgSkeletalMeshActor_Loader::execCleanupForAssetSwap(FFrame&, void* const)

native function ForceRecalculateMaterial();  // Export UTgSkeletalMeshActor_Loader::execForceRecalculateMaterial(FFrame&, void* const)

native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);  // Export UTgSkeletalMeshActor_Loader::execRecalculateMaterial(FFrame&, void* const)

native function PlayLobbyAnim(TgObject.ELobbyAnimState NewAnimState);  // Export UTgSkeletalMeshActor_Loader::execPlayLobbyAnim(FFrame&, void* const)

native function PlayEmote(int nDeviceId);  // Export UTgSkeletalMeshActor_Loader::execPlayEmote(FFrame&, void* const)

native function StopEmote();  // Export UTgSkeletalMeshActor_Loader::execStopEmote(FFrame&, void* const)

native function PlayMVP(int nDeviceId, bool bInstant);  // Export UTgSkeletalMeshActor_Loader::execPlayMVP(FFrame&, void* const)

native function StopMVP();  // Export UTgSkeletalMeshActor_Loader::execStopMVP(FFrame&, void* const)

native function CancelEmote(optional bool bVerifyNoRelevantEmotes, optional TgAnimNodeEmoteSequence Exclude);  // Export UTgSkeletalMeshActor_Loader::execCancelEmote(FFrame&, void* const)

native function SetMaterialScalarParameterValue(name szParameterName, float fValue, optional bool bSkin=true, optional bool bHead=true, optional bool bWeapon=true);  // Export UTgSkeletalMeshActor_Loader::execSetMaterialScalarParameterValue(FFrame&, void* const)

simulated function PlayEmoteTimer() { }

simulated event PlayMVPTimer() { }

simulated event PreBeginPlay() { }

simulated event BeginTransition(optional bool bPlayFx=false) { }

simulated event EndTransition() { }

event PlayChildAnim(TgSkeletalMeshComponent notifySource, name AnimSeqName) { }

event bool PlayParticleEffect(const AnimNotify_PlayParticleEffect AnimNotifyData) { }

defaultproperties
{}
