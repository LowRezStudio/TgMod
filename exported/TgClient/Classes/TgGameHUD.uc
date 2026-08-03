class TgGameHUD extends TgClientHUD
    transient
    native(GameUI)
    config(Game)
    hidecategories(Navigation);

enum GameHudState
{
    GHS_None,                       // 0
    GHS_Match,                      // 1
    GHS_Summary,                    // 2
    GHS_MAX                         // 3
};

enum TgClientVisibilityMode
{
    CVM_NORMAL,                     // 0
    CVM_ENEMY,                      // 1
    CVM_PLAYERS,                    // 2
    CVM_ALL,                        // 3
    CVM_MAX                         // 4
};

enum HelpPromptType
{
    HPT_None,                       // 0
    HPT_Cards,                      // 1
    HPT_Mount,                      // 2
    HPT_MAX                         // 3
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

// Export UTgGameHUD::execPlayIntro(FFrame&, void* const)
native function PlayIntro();

// Export UTgGameHUD::execFinishIntro(FFrame&, void* const)
native function bool FinishIntro();

// Export UTgGameHUD::execInitOverlayMoviePlayer(FFrame&, void* const)
native function InitOverlayMoviePlayer();

// Export UTgGameHUD::execUpdateOverlay(FFrame&, void* const)
native function UpdateOverlay();

// Export UTgGameHUD::execUpdateDebugDraws(FFrame&, void* const)
native function UpdateDebugDraws();

// Export UTgGameHUD::execUpdateHoverTarget(FFrame&, void* const)
native function UpdateHoverTarget();

// Export UTgGameHUD::execUpdatePlayerStatUI(FFrame&, void* const)
native function bool UpdatePlayerStatUI(TgPawn changedPawn);

// Export UTgGameHUD::execUpdatePlayerReady(FFrame&, void* const)
native function UpdatePlayerReady(TgRepInfo_Player PRI);

// Export UTgGameHUD::execUpdateReleaseTimeRemaining(FFrame&, void* const)
native function UpdateReleaseTimeRemaining(float fTimeRemaining);

// Export UTgGameHUD::execPingWorldLocation(FFrame&, void* const)
native function PingWorldLocation(Vector PingLocation, TgObject.PING_TYPE Type);

// Export UTgGameHUD::execEndMission(FFrame&, void* const)
native function EndMission(bool bPlayerAttacker, TgObject.GAME_WIN_STATE finalWinState);

// Export UTgGameHUD::execUpdateRoundSetupTimer(FFrame&, void* const)
native function UpdateRoundSetupTimer(float SetupTimeRemaining, float TimeStamp);

// Export UTgGameHUD::execOnRoundSetupStarted(FFrame&, void* const)
native function OnRoundSetupStarted();

// Export UTgGameHUD::execOpenBurnMenu(FFrame&, void* const)
native exec function OpenBurnMenu();

// Export UTgGameHUD::execOpenDeckMenu(FFrame&, void* const)
native exec function OpenDeckMenu();

// Export UTgGameHUD::execPurchaseCard(FFrame&, void* const)
native exec function PurchaseCard(int nId);

// Export UTgGameHUD::execToggleVGS(FFrame&, void* const)
native exec function ToggleVGS();

// Export UTgGameHUD::execToggleMinimap(FFrame&, void* const)
native exec function ToggleMinimap();

// Export UTgGameHUD::execViewScoreboard(FFrame&, void* const)
native exec function ViewScoreboard(bool bShow, optional bool bAcceptsInput = false, optional UIHudScoreboard pScoreboard);

// Export UTgGameHUD::execToggleScoreBoard(FFrame&, void* const)
native exec function ToggleScoreBoard(optional bool bAcceptsInput = false);

// Export UTgGameHUD::execToggleDeathRecap(FFrame&, void* const)
native exec function ToggleDeathRecap();

// Export UTgGameHUD::execChangePotGClassModel(FFrame&, void* const)
native exec function ChangePotGClassModel(int nIndex, int nClassId, int nSkinId, int nHeadId, int nDeviceId, int nDeviceSkinId, TgSkeletalMeshActor_Loader.LobbyAnimPose pose, optional bool bAsync = true);

// Export UTgGameHUD::execEnablePotGCamera(FFrame&, void* const)
native exec function EnablePotGCamera(bool bEnabled);

// Export UTgGameHUD::execChangePotGCameraTransform(FFrame&, void* const)
native exec function ChangePotGCameraTransform(float fXOffset, float fYOffset, float fZOffset, float fYawOffset, float fPitchOffset, float fRollOffset);

// Export UTgGameHUD::execTestPrecache(FFrame&, void* const)
native exec function TestPrecache(int nBotId, int nSkinId, int nWeaponSkinId, int nHeadId, optional bool bAll = false);

// Export UTgGameHUD::execPrecacheClass(FFrame&, void* const)
native exec function PrecacheClass(string godName, optional string skinName, optional string weaponSkinName);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    m_MiniMap = new Class'TgClient.TgMiniMap';
    m_TargetingMap = new Class'TgClient.TgMiniMap_Targeting';
    m_Blinder = new Class'TgClient.TgBlinder';
    // End:0xD0
    if(m_MiniMap != none)
    {
        m_MiniMap.CreateMiniMapTexture();
        m_MiniMap.Init(TgPlayerController(Owner));
        m_MiniMap.UpdateMiniMapTexture();
    }
    // End:0x159
    if(m_TargetingMap != none)
    {
        m_TargetingMap.CreateMiniMapTexture();
        m_TargetingMap.Init(TgPlayerController(Owner));
        m_TargetingMap.UpdateMiniMapTexture();
        ShowTargetingMap(false);
    }
    InitOverlayMoviePlayer();
    ResetViewCenterPoint();
    //return;    
}

event PostRender()
{
    super.PostRender();
    UpdateOverlay();
    UpdateHoverTarget();
    UpdateDebugDraws();
    DrawMiniMap(Canvas);
    //return;    
}

simulated event PreDemoRewind()
{
    super(Actor).PreDemoRewind();
    // End:0x38
    if(m_MiniMap != none)
    {
        m_MiniMap.RemoveAllEntities();
    }
    // End:0x66
    if(m_TargetingMap != none)
    {
        m_TargetingMap.RemoveAllEntities();
    }
    //return;    
}

simulated function DrawMiniMap(Canvas theCanvas)
{
    // End:0x5B
    if((m_MiniMap != none) && m_MiniMap.ShouldRender())
    {
        m_MiniMap.Draw(theCanvas);
    }
    //return;    
}

exec function ToggleOverlay()
{
    //return;    
}

exec function UpdateMMTimer(float fNew)
{
    m_fMMUpdateTimer = fNew;
    //return;    
}

function TgMiniMap GetMapByName(string MapName)
{
    // End:0x28
    if(MapName == "MapFrame_mc")
    {
        return m_MiniMap;        
    }
    else
    {
        // End:0x54
        if(MapName == "MissionMapFrame_mc")
        {
            return m_TargetingMap;
        }
    }
    return none;
    //return ReturnValue;    
}

exec function PingMap(float X, float Y, string Type, string MapName)
{
    local bool bHandled;
    local Vector WorldLoc, mapLoc;
    local TgObject.PING_TYPE Pt;
    local array<ReplicationInfo> repInfos;
    local TgMiniMap Minimap;

    Minimap = GetMapByName(MapName);
    bHandled = false;
    mapLoc.X = X;
    mapLoc.Y = Y;
    mapLoc.Z = 0.0000000;
    Pt = 0;
    // End:0xC9
    if(Type == "retreat")
    {
        Pt = 2;        
    }
    else
    {
        // End:0xEA
        if(Type == "alert")
        {
            Pt = 4;
        }
    }
    // End:0x25A
    if((Minimap != none) && Minimap.VerifyMapLocation(X, Y))
    {
        WorldLoc = Minimap.MapToWorld(mapLoc);
        Minimap.GetRepInfosForLocation(mapLoc, repInfos);
        // End:0x1F8
        if(TgPlayerController(Owner) != none)
        {
            bHandled = TgPlayerController(Owner).PingMap(WorldLoc, repInfos, Pt);
        }
        // End:0x25A
        if(!bHandled && Minimap == m_MiniMap)
        {
            Minimap.PingMap(X, Y, Pt);
        }
    }
    //return;    
}

exec function HoverMap(float X, float Y, string MapName)
{
    local TgMiniMap Minimap;

    Minimap = GetMapByName(MapName);
    // End:0xB3
    if(Minimap != none)
    {
        // End:0x94
        if(Minimap.VerifyMapLocation(X, Y))
        {
            Minimap.HoverMap(X, Y);            
        }
        else
        {
            Minimap.ClearHover();
        }
    }
    //return;    
}

function ShowTargetingMap(bool bShow)
{
    // End:0x10
    if(bShow)
    {        
    }
    // End:0x68
    if(m_TargetingMap != none)
    {
        m_TargetingMap.RemoveAllEntities();
        m_TargetingMap.m_bShouldDisplayMiniMap = bShow;
    }
    //return;    
}

function PlayDeviceFailResponse(TgObject.EDeviceFailType failType, bool IsAbility)
{
    // End:0x11
    if(!IsAbility)
    {
        return;
    }
    PlaySoundBase(AkEvent'WW_UI_Default.UI_InGame_Alert_Ability_Cooldown_1P_Play');
    //return;    
}

defaultproperties
{
    m_nLastUpgrade=-1
    m_fFireTime=1.0000000
    m_fMMUpdateTimer=0.1000000
    m_ScenePreloads[0]=(nDepth=1,sName="UIWorldOverlay",sPath="..\\WorldOverlay\\WorldOverlay.swf")
    m_ScenePreloads[1]=(nDepth=2,sName="UIHud",sPath="..\\hud\\hud.swf")
    m_ScenePreloads[2]=(nDepth=5,sName="UIHudVoiceChat",sPath="..\\VoiceChat\\UIVoiceChat.swf")
    m_ScenePreloads[3]=(nDepth=11,sName="UIHudVGS",sPath="..\\VGS\\VGS_Menu.swf")
    m_ScenePreloads[4]=(nDepth=12,sName="UIHudMenu",sPath="..\\hud\\HudMenu.swf")
    m_ScenePreloads[5]=(nDepth=13,sName="UIHudBurns",sPath="..\\hud\\HudBurns.swf")
    m_ScenePreloads[6]=(nDepth=14,sName="UIHudDecks",sPath="..\\hud\\HudDecks.swf")
    m_ScenePreloads[7]=(nDepth=15,sName="UIHudRecap",sPath="..\\DeathRecap\\DeathRecap.swf")
    m_ScenePreloads[8]=(nDepth=16,sName="GameTip",sPath="..\\GameTip\\GameTip.swf")
    m_ScenePreloads[9]=(nDepth=17,sName="UIHudOverlays",sPath="..\\hud\\HudOverlays.swf")
    m_ScenePreloads[10]=(nDepth=18,sName="UIHudScoreboard",sPath="..\\Scoreboard\\Scoreboard.swf")
    m_ScenePreloads[11]=(nDepth=19,sName="UIHudChampionSelect",sPath="..\\hud\\HudChampionSelect.swf")
    m_ScenePreloads[12]=(nDepth=104,sName="UISkills",sPath="..\\Skills\\Skills.swf")
    m_ScenePreloads[13]=(nDepth=196,sName="UISettings",sPath="..\\SettingsMenu\\SettingsMenu.swf")
    m_ScenePreloads[14]=(nDepth=197,sName="UIPopup",sPath="..\\Popup\\Popup.swf")
    m_ScenePreloads[15]=(nDepth=198,sName="UIAchievementPopups",sPath="..\\Popup\\AchievementPopups.swf")
    m_ScenePreloads[16]=(nDepth=199,sName="UIPopupCrafting",sPath="..\\Popup\\PopupCraftingConfirm.swf")
    m_ScenePreloads[17]=(nDepth=200,sName="Cursor",sPath="..\\Cursor\\Cursor.swf")
    m_ScenePreloads[18]=(nDepth=200,sName="UIHudResult",sPath="..\\EndOfMatch\\EndOfMatch.swf")
    m_ScenePreloads[19]=(nDepth=201,sName="UIWebBrowser",sPath="..\\WebBrowser\\WebBrowser.swf")
    m_ScenePreloads[20]=(nDepth=300,sName="UIFade",sPath="..\\Transition\\UIFade.swf")
    m_ScenePreloads[21]=(nDepth=400,sName="UISubtitle",sPath="..\\SubTitle\\SubTitle.swf")
    // Reference: PComPictureInPicture'TgClient.Default__TgGameHUD.PictureInPicture'
    // Archetype: PComPictureInPicture'TgClient.Default__TgClientHUD.PictureInPicture'
    begin object name="PictureInPicture"
    end object
    m_PictureInPicture=PictureInPicture
    bShowOverlays=true
    m_bHasThreadedWork=true
}