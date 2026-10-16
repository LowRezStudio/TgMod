class TgGameHUD extends TgClientHUD
    transient
    native(GameUI)
    config(Game)
    hidecategories(Navigation);

enum GameHudState {
    GHS_None,  // 0
    GHS_Match,  // 1
    GHS_Summary,  // 2
};

enum TgClientVisibilityMode {
    CVM_NORMAL,  // 0
    CVM_ENEMY,  // 1
    CVM_PLAYERS,  // 2
    CVM_ALL,  // 3
};

enum HelpPromptType {
    HPT_None,  // 0
    HPT_Cards,  // 1
    HPT_Mount,  // 2
};

var int m_nLastUpgrade;
var bool m_bGameWon;
var bool m_bGameOver;
var bool m_bHasMounted;
var bool m_bUpdateMinimapThisTick;
var float m_fFireTime;
var float m_fFireTimer;
var float m_fMMUpdateTimer;
var Actor m_LastTarget;
var TgBlinder m_Blinder;
var TgMiniMap m_MiniMap;
var TgMiniMap_Targeting m_TargetingMap;
var float m_fLastMinimapUpdateTime;
var int m_nPotGModelPose;
var int m_nPotGModelSkin;
var int m_nPotGModelHead;
var int m_nPotGModelClass;
var int m_nPotGModelDevice;
var int m_nPotGModelDeviceSkin;

native function PlayIntro();  // Export UTgGameHUD::execPlayIntro(FFrame&, void* const)

native function bool FinishIntro();  // Export UTgGameHUD::execFinishIntro(FFrame&, void* const)

native function InitOverlayMoviePlayer();  // Export UTgGameHUD::execInitOverlayMoviePlayer(FFrame&, void* const)

native function UpdateOverlay();  // Export UTgGameHUD::execUpdateOverlay(FFrame&, void* const)

native function UpdateDebugDraws();  // Export UTgGameHUD::execUpdateDebugDraws(FFrame&, void* const)

native function UpdateHoverTarget();  // Export UTgGameHUD::execUpdateHoverTarget(FFrame&, void* const)

native function bool UpdatePlayerStatUI(TgPawn changedPawn);  // Export UTgGameHUD::execUpdatePlayerStatUI(FFrame&, void* const)

native function UpdatePlayerReady(TgRepInfo_Player PRI);  // Export UTgGameHUD::execUpdatePlayerReady(FFrame&, void* const)

native function UpdateReleaseTimeRemaining(float fTimeRemaining);  // Export UTgGameHUD::execUpdateReleaseTimeRemaining(FFrame&, void* const)

native function PingWorldLocation(Vector PingLocation, TgObject.PING_TYPE Type);  // Export UTgGameHUD::execPingWorldLocation(FFrame&, void* const)

native function EndMission(bool bPlayerAttacker, TgObject.GAME_WIN_STATE finalWinState);  // Export UTgGameHUD::execEndMission(FFrame&, void* const)

native function UpdateRoundSetupTimer(float SetupTimeRemaining, float TimeStamp);  // Export UTgGameHUD::execUpdateRoundSetupTimer(FFrame&, void* const)

native function OnRoundSetupStarted();  // Export UTgGameHUD::execOnRoundSetupStarted(FFrame&, void* const)

native exec function OpenBurnMenu();  // Export UTgGameHUD::execOpenBurnMenu(FFrame&, void* const)

native exec function OpenDeckMenu();  // Export UTgGameHUD::execOpenDeckMenu(FFrame&, void* const)

native exec function PurchaseCard(int nId);  // Export UTgGameHUD::execPurchaseCard(FFrame&, void* const)

native exec function ToggleVGS();  // Export UTgGameHUD::execToggleVGS(FFrame&, void* const)

native exec function ToggleMinimap();  // Export UTgGameHUD::execToggleMinimap(FFrame&, void* const)

native exec function ViewScoreboard(bool bShow, optional bool bAcceptsInput=false, optional UIHudScoreboard pScoreboard);  // Export UTgGameHUD::execViewScoreboard(FFrame&, void* const)

native exec function ToggleScoreBoard(optional bool bAcceptsInput=false);  // Export UTgGameHUD::execToggleScoreBoard(FFrame&, void* const)

native exec function ToggleDeathRecap();  // Export UTgGameHUD::execToggleDeathRecap(FFrame&, void* const)

native exec function ChangePotGClassModel(int nIndex, int nClassId, int nSkinId, int nHeadId, int nDeviceId, int nDeviceSkinId, TgSkeletalMeshActor_Loader.LobbyAnimPose pose, optional bool bAsync=true);  // Export UTgGameHUD::execChangePotGClassModel(FFrame&, void* const)

native exec function EnablePotGCamera(bool bEnabled);  // Export UTgGameHUD::execEnablePotGCamera(FFrame&, void* const)

native exec function ChangePotGCameraTransform(float fXOffset, float fYOffset, float fZOffset, float fYawOffset, float fPitchOffset, float fRollOffset);  // Export UTgGameHUD::execChangePotGCameraTransform(FFrame&, void* const)

native exec function TestPrecache(int nBotId, int nSkinId, int nWeaponSkinId, int nHeadId, optional bool bAll=false);  // Export UTgGameHUD::execTestPrecache(FFrame&, void* const)

native exec function PrecacheClass(string godName, optional string skinName, optional string weaponSkinName);  // Export UTgGameHUD::execPrecacheClass(FFrame&, void* const)

simulated event PostBeginPlay() { }

event PostRender() { }

simulated event PreDemoRewind() { }

simulated function DrawMiniMap(Canvas theCanvas) { }

exec function ToggleOverlay() { }

exec function UpdateMMTimer(float fNew) { }

function TgMiniMap GetMapByName(string MapName) { }

exec function PingMap(float X, float Y, string Type, string MapName) { }

exec function HoverMap(float X, float Y, string MapName) { }

function ShowTargetingMap(bool bShow) { }

function PlayDeviceFailResponse(TgObject.EDeviceFailType failType, bool IsAbility) { }

defaultproperties
{}
