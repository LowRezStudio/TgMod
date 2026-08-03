class TgLobbyHUD extends TgClientHUD
    transient
    native(LobbyUI)
    config(Game)
    hidecategories(Navigation);

const LOBBY_PLAYERS_PER_TEAM = 10;

enum LobbyHudState
{
    LHS_None,                       // 0
    LHS_Offline,                    // 1
    LHS_Lobby,                      // 2
    LHS_Match,                      // 3
    LHS_Summary,                    // 4
    LHS_MAX                         // 5
};

enum UIHeaderState
{
    UIHS_NONE,                      // 0
    UIHS_HOME,                      // 1
    UIHS_PLAY,                      // 2
    UIHS_SHOP,                      // 3
    UIHS_CARD,                      // 4
    UIHS_MAX                        // 5
};

enum UIMapFrame
{
    UIMF_NONE,                      // 0
    UIMF_ENCHANTED_FOREST,          // 1
    UIMF_TEMPLE_RUINS,              // 2
    UIMF_OUTPOST,                   // 3
    UIMF_GLACIER_KEEP,              // 4
    UIMF_SERPENT_TEMPLE,            // 5
    UIMF_SINISTRAL,                 // 6
    UIMF_ARENA,                     // 7
    UIMF_DEATHGATE,                 // 8
    UIMF_DISTRICT,                  // 9
    UIMF_GLACIER_KEEP_V2,           // 10
    UIMF_MAX                        // 11
};

struct native LobbyTransitionPlayer
{
    var int nClassId;
    var init string sPlayerName;
    var init string sClassName;

    structdefaultproperties
    {
        nClassId=0
        sPlayerName=""
        sClassName=""
    }
};

struct native LobbyTransitionData
{
    var LobbyTransitionPlayer FriendlyTeam[10];
    var LobbyTransitionPlayer EnemyTeam[10];

    structdefaultproperties
    {
        FriendlyTeam[0]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[1]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[2]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[3]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[4]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[5]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[6]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[7]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[8]=(nClassId=0,sPlayerName="",sClassName="")
        FriendlyTeam[9]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[0]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[1]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[2]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[3]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[4]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[5]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[6]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[7]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[8]=(nClassId=0,sPlayerName="",sClassName="")
        EnemyTeam[9]=(nClassId=0,sPlayerName="",sClassName="")
    }
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

// Export UTgLobbyHUD::execIsEulaSigned(FFrame&, void* const)
native function bool IsEulaSigned();

// Export UTgLobbyHUD::execHaveEOMLobbyData(FFrame&, void* const)
native function bool HaveEOMLobbyData();

// Export UTgLobbyHUD::execSetUpEOMLobby(FFrame&, void* const)
native function SetUpEOMLobby();

// Export UTgLobbyHUD::execChangeClassModel(FFrame&, void* const)
native exec function ChangeClassModel(int nClassId, int nSkinId, int nHeadId, int nDeviceId, int nDeviceSkinId, int nPedestalSkinId, TgSkeletalMeshActor_Loader.LobbyAnimPose pose, optional TgCameraModifier_LobbyCameraTransition.CameraTransType camDirection = 1, optional bool bAsync = true, optional TgObject.EModelHighlightType HighlightType = 0, optional int MVPDeviceId);

// Export UTgLobbyHUD::execRotateModel(FFrame&, void* const)
native exec function bool RotateModel(float fValue);

// Export UTgLobbyHUD::execChangeTeamModel(FFrame&, void* const)
native exec function ChangeTeamModel(bool bFriendly, int nIndex, int nClassId, int nSkinId, int nHeadId, int nDeviceId, int nDeviceSkinId, int nPedestalSkinId, TgSkeletalMeshActor_Loader.LobbyAnimPose pose, optional bool bAsync = true, optional TgObject.EModelHighlightType HighlightType = 0, optional int MVPDeviceId, optional int nCharacterXP = -1, optional delegate<OnMeshUpdated> MeshUpdatedDelegate);

// Export UTgLobbyHUD::execSwitchToCamera(FFrame&, void* const)
native exec function TgLobbyCamera SwitchToCamera(TgLobbyCamera.ELobbyCameraTag CamTag, optional TgCameraModifier_LobbyCameraTransition.CameraTransType camDirection = 1, optional bool bForce = false, optional ViewTargetTransitionParams BlendParams);

// Export UTgLobbyHUD::execDisplayCharacter(FFrame&, void* const)
native function DisplayCharacter();

// Export UTgLobbyHUD::execTriggerLazyPrecache(FFrame&, void* const)
native function TriggerLazyPrecache();

// Export UTgLobbyHUD::execTryPushScene(FFrame&, void* const)
native function TryPushScene(string sName, optional bool bSkipPrivilegeCheck = false);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetTimer(1.0000000, false, 'TriggerLazyPrecache');
    // End:0x8C
    if(!WorldInfo.IsPlayInEditor())
    {
        PlayerOwner.ClientSetCameraFade(true, MakeColor(0, 0, 0), vect2d(1.0000000, 1.0000000), 2.0000000);
    }
    //return;    
}

exec function SwitchToCards(bool bEnabled)
{
    ((bEnabled) ? SwitchToCamera(9, 0, true) : SwitchToCamera(1, 0, true));
    //return;    
}

exec function ChangeModel(int BotId, int SkinId, int HeadId, int DeviceID, int DeviceSkinId, int PedestalSkinId, optional byte pose = 0, optional TgLobbyCamera.ELobbyCameraTag CameraTag = 1, optional float BlendTime, optional Camera.EViewTargetBlendFunction BlendFunction, optional float BlendExp, optional TgObject.EModelHighlightType HighlightType, optional int MVPDeviceId)
{
    local ViewTargetTransitionParams BlendParams;

    BlendParams.BlendTime = BlendTime;
    BlendParams.BlendExp = BlendExp;
    BlendParams.BlendFunction = BlendFunction;
    BlendParams.bLockOutgoing = true;
    SwitchToCamera(CameraTag, 0, true, BlendParams);
    ChangeClassModel(BotId, SkinId, HeadId, DeviceID, DeviceSkinId, PedestalSkinId, pose,,, HighlightType, MVPDeviceId);
    //return;    
}

exec function PlayEmote(int nDeviceId)
{
    // End:0x4C
    if(c_CurrentCamera != none)
    {
        c_CurrentCamera.m_ViewTarget.PlayEmote(nDeviceId);
    }
    //return;    
}

exec function StopEmote()
{
    // End:0x43
    if(c_CurrentCamera != none)
    {
        c_CurrentCamera.m_ViewTarget.StopEmote();
    }
    //return;    
}

exec function PlayMVP(int nDeviceId)
{
    // End:0x4D
    if(c_CurrentCamera != none)
    {
        c_CurrentCamera.m_ViewTarget.PlayMVP(nDeviceId, false);
    }
    //return;    
}

exec function StopMVP()
{
    // End:0x43
    if(c_CurrentCamera != none)
    {
        c_CurrentCamera.m_ViewTarget.StopMVP();
    }
    //return;    
}

// Export UTgLobbyHUD::execChangePedestalModel(FFrame&, void* const)
native exec function ChangePedestalModel(TgObject.EPedestalType PedestalType, int BotId, int SkinId, int HeadId, int DeviceID, int DeviceSkinId, optional int MVPId, optional int CharacterMastery = -1);

defaultproperties
{
    m_ScenePreloads[0]=(nDepth=0,sName="UIBackground",sPath="..\\Background\\Background.swf")
    m_ScenePreloads[1]=(nDepth=9,sName="UIStoreDetail",sPath="..\\Store\\StoreDetail.swf")
    m_ScenePreloads[2]=(nDepth=10,sName="UIHome",sPath="..\\Home\\Home.swf")
    m_ScenePreloads[3]=(nDepth=11,sName="UIStore",sPath="..\\Store\\Store.swf")
    m_ScenePreloads[4]=(nDepth=13,sName="UIPlay",sPath="..\\Play\\Play.swf")
    m_ScenePreloads[5]=(nDepth=14,sName="UIChests",sPath="..\\Vault\\Chests.swf")
    m_ScenePreloads[6]=(nDepth=15,sName="UIMatchLobby",sPath="..\\Lobby\\MatchLobby.swf")
    m_ScenePreloads[7]=(nDepth=16,sName="UIProfile",sPath="..\\Profile\\Profile.swf")
    m_ScenePreloads[8]=(nDepth=17,sName="UILeaderboard",sPath="..\\Profile\\Leaderboard.swf")
    m_ScenePreloads[9]=(nDepth=18,sName="UICustomGame",sPath="..\\Play\\CustomGame.swf")
    m_ScenePreloads[10]=(nDepth=19,sName="UISocial",sPath="..\\Social\\Social.swf")
    m_ScenePreloads[11]=(nDepth=20,sName="UIEndOfMatchLobby",sPath="..\\Lobby\\EndOfMatchLobby.swf")
    m_ScenePreloads[12]=(nDepth=21,sName="UIQuests",sPath="..\\Rewards\\Quests.swf")
    m_ScenePreloads[13]=(nDepth=22,sName="UICompetitive",sPath="..\\Competitive\\Competitive.swf")
    m_ScenePreloads[14]=(nDepth=110,sName="UIChampion",sPath="..\\Champion\\Champion.swf")
    m_ScenePreloads[15]=(nDepth=111,sName="UIChampionSelect",sPath="..\\Champion\\ChampionSelect.swf")
    m_ScenePreloads[16]=(nDepth=202,sName="UISkills",sPath="..\\Skills\\Skills.swf")
    m_ScenePreloads[17]=(nDepth=206,sName="UITeamInvite",sPath="..\\TeamInvite\\TeamInvite.swf")
    m_ScenePreloads[18]=(nDepth=207,sName="UIFade",sPath="..\\Transition\\UIFade.swf")
    m_ScenePreloads[19]=(nDepth=209,sName="UILogin",sPath="..\\Login\\login.swf")
    m_ScenePreloads[20]=(nDepth=211,sName="UISettings",sPath="..\\SettingsMenu\\SettingsMenu.swf")
    m_ScenePreloads[21]=(nDepth=213,sName="UIAchievementPopups",sPath="..\\Popup\\AchievementPopups.swf")
    m_ScenePreloads[22]=(nDepth=214,sName="UIPopupPartyManager",sPath="..\\Popup\\PopupPartyManager.swf")
    m_ScenePreloads[23]=(nDepth=215,sName="UIAcquisition",sPath="..\\Acquisition\\Acquisition.swf")
    m_ScenePreloads[24]=(nDepth=250,sName="UIFooter",sPath="..\\Footer\\Footer.swf")
    m_ScenePreloads[25]=(nDepth=251,sName="UILobbyChat",sPath="..\\LobbyChat\\LobbyChat.swf")
    m_ScenePreloads[26]=(nDepth=252,sName="UIProfileMini",sPath="..\\ProfileMini\\ProfileMini.swf")
    m_ScenePreloads[27]=(nDepth=253,sName="UIPurchaseGems",sPath="..\\Store\\PurchaseGems.swf")
    m_ScenePreloads[28]=(nDepth=254,sName="UIHeader",sPath="..\\Header\\Header.swf")
    m_ScenePreloads[29]=(nDepth=300,sName="UINotificationCenter",sPath="..\\NotificationCenter\\NotificationCenter.swf")
    m_ScenePreloads[30]=(nDepth=301,sName="UIAccountLinkPopup",sPath="..\\Popup\\AccountLinkPopup.swf")
    m_ScenePreloads[31]=(nDepth=302,sName="UIDailyReward",sPath="..\\DailyReward\\DailyReward.swf")
    m_ScenePreloads[32]=(nDepth=304,sName="UIPopup",sPath="..\\Popup\\Popup.swf")
    m_ScenePreloads[33]=(nDepth=305,sName="UIFullscreenPopup",sPath="..\\Popup\\FullscreenPopup.swf")
    m_ScenePreloads[34]=(nDepth=306,sName="UIInputPopup",sPath="..\\Popup\\InputPopup.swf")
    m_ScenePreloads[35]=(nDepth=307,sName="UIPopupCrafting",sPath="..\\Popup\\PopupCraftingConfirm.swf")
    m_ScenePreloads[36]=(nDepth=308,sName="UICompetitivePopupWelcome",sPath="..\\Competitive\\CompetitivePopupWelcome.swf")
    m_ScenePreloads[37]=(nDepth=309,sName="UICompetitiveRankedDecay",sPath="..\\Competitive\\CompetitivePopupRankDecay.swf")
    m_ScenePreloads[38]=(nDepth=310,sName="UICompetitiveRankChange",sPath="..\\Competitive\\CompetitivePopupRankChange.swf")
    m_ScenePreloads[39]=(nDepth=311,sName="UIWebBrowser",sPath="..\\WebBrowser\\WebBrowser.swf")
    m_ScenePreloads[40]=(nDepth=312,sName="UIMatchInvite",sPath="..\\MatchInvite\\MatchInvite.swf")
    m_ScenePreloads[41]=(nDepth=400,sName="UISafeFrame",sPath="..\\SafeFrame\\UISafeFrame.swf")
    m_bShowCursor=true
    m_bCaptureKeys=true
    // Reference: PComPictureInPicture'TgClient.Default__TgLobbyHUD.PictureInPicture'
    // Archetype: PComPictureInPicture'TgClient.Default__TgClientHUD.PictureInPicture'
    begin object name="PictureInPicture"
    end object
    m_PictureInPicture=PictureInPicture
}