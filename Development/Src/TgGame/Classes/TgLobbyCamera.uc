class TgLobbyCamera extends CameraActor
    native(View)
    hidecategories(Navigation)
    config(Engine);

enum ELobbyCameraTag {
    LobbyCam_Login,  // 0
    LobbyCam_TitleHome,  // 1
    LobbyCam_TitlePlay,  // 2
    LobbyCam_SearchingForMatch,  // 3
    LobbyCam_MatchLobby,  // 4
    LobbyCam_TitleChampions,  // 5
    LobbyCam_ViewAllChampions,  // 6
    LobbyCam_ViewChampion,  // 7
    LobbyCam_TitleChests,  // 8
    LobbyCam_LootChest,  // 9
    LobbyCam_Store,  // 10
    LobbyCam_StoreDetail,  // 11
    LobbyCam_EndOfMatchLobby,  // 12
    LobbyCam_WisdomDetail,  // 13
    LobbyCam_ViewChampionWeapon,  // 14
    LobbyCam_TeamMatchLobby,  // 15
};

var (CameraActor) TgSkeletalMeshActor_Lobby m_ViewTarget;
var (CameraActor) array<TgSkeletalMeshActor_Lobby> m_FriendlyTargets;
var (CameraActor) array<TgSkeletalMeshActor_Lobby> m_EnemyTargets;
var (CameraActor) Vector m_RenderCenterPointOffset;
var transient bool m_bActive;
var () bool m_bAdjustCameraToTarget;
var bool m_bFirstCameraEyeCheck;
var transient int m_nPosition;
var float m_fRemainingTweenTime;
var float m_fTotalTweenTime;
var transient TPOV m_TweenSourcePOV;
var () float m_fLateralOffsetMultiplier;
var () float m_fHorizontalOffsetMultiplier;
var () float m_fViewLateralOffsetMultiplier;
var () float m_fViewHorizontalOffsetMultiplier;
var () float m_fMaxAdjustSpeedTranslation;
var () float m_fMaxAdjustSpeedRotation;
var () Vector m_vViewOffset;
var float m_fFirstCameraEyeCheckTimestamp;
var (CameraActor) TgLobbyCamera.ELobbyCameraTag m_CameraTag;

native function SetActive(bool bActive);  // Export UTgLobbyCamera::execSetActive(FFrame&, void* const)

native function ClearFriendlyTargets();  // Export UTgLobbyCamera::execClearFriendlyTargets(FFrame&, void* const)

native function ClearEnemyTargets();  // Export UTgLobbyCamera::execClearEnemyTargets(FFrame&, void* const)

event TriggerKismetActivationEvent(bool bActive, optional int nPosition=0) { }

event SetPosition(int nPosition) { }

simulated function StartTween(float TweenTime) { }

simulated event GetActorEyesViewPoint(out vector out_Location, out Rotator out_Rotation) { }

simulated function GetCameraView(float DeltaTime, out TPOV OutPOV) { }

defaultproperties
{
    m_bFirstCameraEyeCheck=true
    m_TweenSourcePOV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    m_fLateralOffsetMultiplier=3.0000000
    m_fHorizontalOffsetMultiplier=2.0000000
    m_fViewLateralOffsetMultiplier=1.0000000
    m_fViewHorizontalOffsetMultiplier=1.0000000
    m_fMaxAdjustSpeedTranslation=10000.0000000
    m_fMaxAdjustSpeedRotation=10000.0000000
    SupportedEvents=/* Array type was not detected. */
}
