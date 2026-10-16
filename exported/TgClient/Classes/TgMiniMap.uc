class TgMiniMap extends Object
    native(GameUI);

const TG_MAX_TOTAL_PING = 10;

enum TgMapOrientation
{
    TMO_NORMAL,                     // 0
    TMO_ROTATE_180,                 // 1
    TMO_MAX                         // 2
};

enum MiniMapIconLayer
{
    MMap_Layer_Enemy_Deployable,    // 0
    MMap_Layer_Friendly_Deployable, // 1
    MMap_Layer_Enemy_Bot,           // 2
    MMap_Layer_Friendly_Bot,        // 3
    MMap_Layer_Enemy_Player,        // 4
    MMap_Layer_Friendly_Player,     // 5
    MMap_Layer_Neutral_Factory,     // 6
    MMap_Layer_Friendly_Factory,    // 7
    MMap_Layer_Enemy_Factory,       // 8
    MMap_Layer_Neutral_CapturePoint,// 9
    MMap_Layer_Enemy_CapturePoint,  // 10
    MMap_Layer_Friendly_CapturePoint,// 11
    MMap_Layer_Targeting,           // 12
    MMap_Layer_Local_Player_Pet,    // 13
    MMap_Layer_Local_Player,        // 14
    MMap_Layer_MAX                  // 15
};

enum MiniMapPortalLayer
{
    MMap_Portal_Layer_Enemy,        // 0
    MMap_Portal_Layer_Friendly,     // 1
    MMap_Portal_Layer_MAX           // 2
};

enum MinimapDisplayType
{
    MDT_Friendly,                   // 0
    MDT_Enemy,                      // 1
    MDT_FriendlyCB,                 // 2
    MDT_EnemyCB,                    // 3
    MDT_Neutral,                    // 4
    MDT_Pending,                    // 5
    MDT_MAX                         // 6
};

struct native FogMaskData
{
    var int nSize;
    var int nMapDrawLocationX;
    var int nMapDrawLocationY;
    var bool bLocationChanged;
    var bool bVisionRangeChanged;
    var native const transient BitArray_Mirror m_MaskPoints;

    structdefaultproperties
    {
        nSize=0
        nMapDrawLocationX=0
        nMapDrawLocationY=0
        bLocationChanged=false
        bVisionRangeChanged=false
    }
};

struct native MiniMapEntity
{
    var Vector vLocation;
    var TgObject.MiniMapEntityType eType;
    var int nSubType;
    var int nProfileId;
    var TgObject.TgMapTeam Team;
    var int nVisionRange;
    var bool bIsDead;
    var ReplicationInfo RepInfo;
    var int GenericState;
    var int nIdx;
    var bool bMarked;
    var bool bVisibleOnMap;
    var bool bValidTarget;
    var bool bHovered;
    var bool bFlashHighlight;
    var bool bVisible;
    var float fAlpha;
    var float fHealthPCT;
    var MaterialInstanceConstant MIC;
    var bool bHasNoIcon;
    var int nDrawSize;
    var int nHitSize;
    var Vector vRect;
    var FogMaskData FogMaskData;

    structdefaultproperties
    {
        vLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        eType=MiniMapEntityType.MMap_LocalSpectator
        nSubType=0
        nProfileId=0
        Team=TgMapTeam.MAPTEAM_1
        nVisionRange=0
        bIsDead=false
        RepInfo=none
        GenericState=0
        nIdx=0
        bMarked=false
        bVisibleOnMap=false
        bValidTarget=false
        bHovered=false
        bFlashHighlight=false
        bVisible=false
        fAlpha=0.0000000
        fHealthPCT=0.0000000
        MIC=none
        bHasNoIcon=false
        nDrawSize=0
        nHitSize=0
        vRect=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        FogMaskData=(nSize=0,nMapDrawLocationX=0,nMapDrawLocationY=0,bLocationChanged=false,bVisionRangeChanged=false)
    }
};

struct native MiniMapPingInfo
{
    var float fServerStartTime;
    var float fClientStartTime;
    var TgRepInfo_Player pingedPri;
    var Vector vPingedLoc;
    var bool bIsPinging;
    var TgObject.PING_TYPE eType;
    var int nIconSize;
    var MaterialInstanceConstant pingMIC;
    var TgRepInfo_Player sourcePRI;
    var int SourceIndex;
    var Vector vSourceWorldLocation;

    structdefaultproperties
    {
        fServerStartTime=0.0000000
        fClientStartTime=0.0000000
        pingedPri=none
        vPingedLoc=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        bIsPinging=false
        eType=PING_TYPE.PT_NORMAL
        nIconSize=0
        pingMIC=none
        sourcePRI=none
        SourceIndex=0
        vSourceWorldLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native BuffMonsterMIC
{
    var MaterialInstanceConstant SpawnedMIC;
    var MaterialInstanceConstant DroppedMIC;
    var MaterialInstanceConstant TimerMIC;

    structdefaultproperties
    {
        SpawnedMIC=none
        DroppedMIC=none
        TimerMIC=none
    }
};

struct native LayerIndex
{
    var init array<init int> Entries;

    structdefaultproperties
    {
        Entries=none
    }
};

var int m_nMiniMapMode;
var bool m_bShouldDisplayMiniMap;
var bool m_bHasMiniMapTexture;
var bool m_bRequiresLOS;
var bool m_bUseFlashSizing;
var bool m_bSpectating;
var float m_fLastUpdateTime;
var MaterialInstanceConstant m_MiniMapBaseMIC;
var MaterialInstanceConstant m_MiniMapMIC;
var Texture2DDynamic m_DynamicMask;
var int m_nMaskSize;
var float m_fIconScale;
var Vector2D m_vMapLocation;
var int m_nMapSize;
var native const transient Pointer m_MiniMapRender;
var TgPlayerController m_OwnerPC;
var int m_nWorldMapSize;
var MaterialInstanceConstant m_MICPinging;
var MaterialInstanceConstant m_MICPingingEnemy;
var MaterialInstanceConstant m_MICRetreat;
var MaterialInstanceConstant m_MICRetreatEnemy;
var MaterialInstanceConstant m_MICAlert;
var MaterialInstanceConstant m_MICAlertEnemy;
var MaterialInstanceConstant m_MICAlertSilent;
var MaterialInstanceConstant m_MICLocalPlayer;
var MaterialInstanceConstant m_MICLocalSpectator;
var array<Texture2D> m_TextureRefs;
var MaterialInstanceConstant m_MICPlayer[MinimapDisplayType];
var MaterialInstanceConstant m_MICMinion[MinimapDisplayType];
var MaterialInstanceConstant m_MICTower[MinimapDisplayType];
var MaterialInstanceConstant m_MICTitan[MinimapDisplayType];
var MaterialInstanceConstant m_MICPhoenix[MinimapDisplayType];
var MaterialInstanceConstant m_MICCapturePoint[MinimapDisplayType];
var MaterialInstanceConstant m_MICLanePusher[MinimapDisplayType];
var MaterialInstanceConstant m_MICTowerOlympus[TgMapTeam];
var MaterialInstanceConstant m_MICTitanOlympus[MinimapDisplayType];
var MaterialInstanceConstant m_MICPhoenixOlympus[TgMapTeam];
var MaterialInstanceConstant m_MICMonster;
var LinearColor m_PortalLinkColor[MinimapDisplayType];
var BuffMonsterMIC m_MICBuffMonster[MinimapFactoryType];
var MaterialInstanceConstant m_MICTowerDestroyed;
var MaterialInstanceConstant m_PlayerBackground[MinimapDisplayType];
var MaterialInstanceConstant m_TowerAttackBackground[MinimapDisplayType];
var native const map{VOID,VOID} m_IconMap;
var private native const transient BitArray_Mirror m_MaskPoints;
var TgMiniMap.TgMapOrientation m_Orientation;
var TgObject.TgMapTeam m_LocalTeam;
var TgGameHUD.TgClientVisibilityMode m_VisibilityMode;
var byte bUpdateCapturePoint[5];
var private native const transient map{VOID,VOID} m_EntityMap;
var init array<init LayerIndex> m_PortalLayeringIdx;
var init array<init LayerIndex> m_LayeringIdx;
var array<MiniMapPingInfo> m_IndependentPings;

// Export UTgMiniMap::execDraw(FFrame&, void* const)
native function Draw(Canvas theCanvas);

// Export UTgMiniMap::execInit(FFrame&, void* const)
native function Init(TgPlayerController PC);

// Export UTgMiniMap::execPingWorldLocation(FFrame&, void* const)
native function PingWorldLocation(Vector PingLocation, TgObject.PING_TYPE Pt);

// Export UTgMiniMap::execShouldRender(FFrame&, void* const)
native function bool ShouldRender();

// Export UTgMiniMap::execPingMap(FFrame&, void* const)
native function PingMap(float X, float Y, TgObject.PING_TYPE Pt);

// Export UTgMiniMap::execHoverMap(FFrame&, void* const)
native function HoverMap(float X, float Y);

// Export UTgMiniMap::execClearHover(FFrame&, void* const)
native function ClearHover();

// Export UTgMiniMap::execMapToWorld(FFrame&, void* const)
native function Vector MapToWorld(Vector Loc);

// Export UTgMiniMap::execWorldToMap(FFrame&, void* const)
native function Vector WorldToMap(Vector Loc);

// Export UTgMiniMap::execGetRepInfosForLocation(FFrame&, void* const)
native function GetRepInfosForLocation(Vector mapLoc, out array<ReplicationInfo> repInfos);

// Export UTgMiniMap::execVerifyMapLocation(FFrame&, void* const)
native function bool VerifyMapLocation(float X, float Y);

// Export UTgMiniMap::execRemoveAllEntities(FFrame&, void* const)
native function RemoveAllEntities();

// Export UTgMiniMap::execClear(FFrame&, void* const)
native function Clear();

simulated function CreateMiniMapTexture()
{
    // End:0x4D
    if(m_DynamicMask == none)
    {
        m_DynamicMask = Class'Engine.Texture2DDynamic'.static.Create(m_nMaskSize, m_nMaskSize, 2, false);
    }
    // End:0x9C
    if(m_MiniMapMIC == none)
    {
        m_MiniMapMIC = new Class'Engine.MaterialInstanceConstant';
        m_MiniMapMIC.SetParent(m_MiniMapBaseMIC);
    }
    //return;    
}

simulated function UpdateMiniMapTexture()
{
    local Texture2D mmTexture;

    mmTexture = m_OwnerPC.WorldInfo.m_MiniMapTexture;
    // End:0x8C
    if(mmTexture != none)
    {
        // End:0x8C
        if(m_MiniMapMIC != none)
        {
            m_MiniMapMIC.SetTextureParameterValue('MiniMapTexture', mmTexture);
        }
    }
    m_bHasMiniMapTexture = mmTexture != none;
    //return;    
}

simulated function UpdateMapSize(int newX)
{
    m_nMapSize = newX;
    //return;    
}

simulated event bool CheckSpectatorState()
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    m_PortalLinkColor[0]=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    m_PortalLinkColor[1]=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    m_PortalLinkColor[2]=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    m_PortalLinkColor[3]=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    m_PortalLinkColor[4]=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    m_PortalLinkColor[5]=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
}