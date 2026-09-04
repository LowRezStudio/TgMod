class TgLobbyHUD extends TgClientHUD
    transient
    native(LobbyUI)
    config(Game)
    hidecategories(Navigation);

const LOBBY_PLAYERS_PER_TEAM = 10;

enum LobbyHudState {
    LHS_None,  // 0
    LHS_Offline,  // 1
    LHS_Lobby,  // 2
    LHS_Match,  // 3
    LHS_Summary,  // 4
};

enum UIHeaderState {
    UIHS_NONE,  // 0
    UIHS_HOME,  // 1
    UIHS_PLAY,  // 2
    UIHS_SHOP,  // 3
    UIHS_CARD,  // 4
};

enum UIMapFrame {
    UIMF_NONE,  // 0
    UIMF_ENCHANTED_FOREST,  // 1
    UIMF_TEMPLE_RUINS,  // 2
    UIMF_OUTPOST,  // 3
    UIMF_GLACIER_KEEP,  // 4
    UIMF_SERPENT_TEMPLE,  // 5
    UIMF_SINISTRAL,  // 6
    UIMF_ARENA,  // 7
    UIMF_DEATHGATE,  // 8
    UIMF_DISTRICT,  // 9
    UIMF_GLACIER_KEEP_V2,  // 10
};

struct LobbyTransitionPlayer {
    var int nClassId;
    var init string sPlayerName;
    var init string sClassName;
    structdefaultproperties {}
};

struct LobbyTransitionData {
    var LobbyTransitionPlayer FriendlyTeam[10];
    var LobbyTransitionPlayer EnemyTeam[10];
    structdefaultproperties {}
};

var int m_nQueue;
var int m_nQueueState;
var int m_nLobbyState;
var int m_nPlayerState;
var int m_nModelPose;
var int m_nModelSkin;
var int m_nModelHead;
var int m_nModelClass;
var int m_nModelDevice;
var int m_nModelDeviceSkin;
var bool m_bJoiningTraining;
var TgLobbyCamera c_CurrentCamera;
var array<string> m_sAdditionalNeededScenes;
var globalconfig array<config int> m_CTAItemIds;
var globalconfig string m_PlayerCTAName;
var TgSkeletalMeshActor_Pedestal m_FrontLinePedestalMeshActor;
var TgSkeletalMeshActor_Pedestal m_FlankPedestalMeshActor;
var TgSkeletalMeshActor_Pedestal m_SupportPedestalMeshActor;
var TgSkeletalMeshActor_Pedestal m_DamagerPedestalMeshActor;


delegate OnMeshUpdated();
native function bool IsEulaSigned();  // Export UTgLobbyHUD::execIsEulaSigned(FFrame&, void* const)

native function bool HaveEOMLobbyData();  // Export UTgLobbyHUD::execHaveEOMLobbyData(FFrame&, void* const)

native function SetUpEOMLobby();  // Export UTgLobbyHUD::execSetUpEOMLobby(FFrame&, void* const)

native exec function ChangeClassModel(int nClassId, int nSkinId, int nHeadId, int nDeviceId, int nDeviceSkinId, int nPedestalSkinId, TgSkeletalMeshActor_Loader.LobbyAnimPose pose, optional TgCameraModifier_LobbyCameraTransition.CameraTransType camDirection=1, optional bool bAsync=true, optional TgObject.EModelHighlightType HighlightType=0, optional int MVPDeviceId);  // Export UTgLobbyHUD::execChangeClassModel(FFrame&, void* const)

native exec function bool RotateModel(float fValue);  // Export UTgLobbyHUD::execRotateModel(FFrame&, void* const)

native exec function ChangeTeamModel(bool bFriendly, int nIndex, int nClassId, int nSkinId, int nHeadId, int nDeviceId, int nDeviceSkinId, int nPedestalSkinId, TgSkeletalMeshActor_Loader.LobbyAnimPose pose, optional bool bAsync=true, optional TgObject.EModelHighlightType HighlightType=0, optional int MVPDeviceId, optional int nCharacterXP=-1, optional delegate<OnMeshUpdated> MeshUpdatedDelegate);  // Export UTgLobbyHUD::execChangeTeamModel(FFrame&, void* const)

native exec function TgLobbyCamera SwitchToCamera(TgLobbyCamera.ELobbyCameraTag CamTag, optional TgCameraModifier_LobbyCameraTransition.CameraTransType camDirection=1, optional bool bForce=false, optional ViewTargetTransitionParams BlendParams);  // Export UTgLobbyHUD::execSwitchToCamera(FFrame&, void* const)

native function DisplayCharacter();  // Export UTgLobbyHUD::execDisplayCharacter(FFrame&, void* const)

native function TriggerLazyPrecache();  // Export UTgLobbyHUD::execTriggerLazyPrecache(FFrame&, void* const)

native function TryPushScene(string sName, optional bool bSkipPrivilegeCheck=false);  // Export UTgLobbyHUD::execTryPushScene(FFrame&, void* const)

simulated event PostBeginPlay() { }

exec function SwitchToCards(bool bEnabled) { }

exec function ChangeModel(int BotId, int SkinId, int HeadId, int DeviceID, int DeviceSkinId, int PedestalSkinId, optional byte pose=0, optional TgLobbyCamera.ELobbyCameraTag CameraTag=1, optional float BlendTime, optional Camera.EViewTargetBlendFunction BlendFunction, optional float BlendExp, optional TgObject.EModelHighlightType HighlightType, optional int MVPDeviceId) { }

exec function PlayEmote(int nDeviceId) { }

exec function StopEmote() { }

exec function PlayMVP(int nDeviceId) { }

exec function StopMVP() { }

native exec function ChangePedestalModel(TgObject.EPedestalType PedestalType, int BotId, int SkinId, int HeadId, int DeviceID, int DeviceSkinId, optional int MVPId, optional int CharacterMastery=-1);  // Export UTgLobbyHUD::execChangePedestalModel(FFrame&, void* const)

defaultproperties
{}
