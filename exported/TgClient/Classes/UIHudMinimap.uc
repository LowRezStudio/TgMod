class UIHudMinimap extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUD_MINIMAP_HALFSIZE = 300.0f;
const UIHUD_MINIMAP_IMAGELOADERFRAME = 11;

struct native MinimapInfo
{
    var int nMapId;
    var float fMapSize;
    var float fOffsetX;
    var float fOffsetY;

    structdefaultproperties
    {
        nMapId=0
        fMapSize=0.0000000
        fOffsetX=0.0000000
        fOffsetY=0.0000000
    }
};

var int m_nStaticMapIndex;
var int m_nStaticMapId;
var float m_fFogRotation;
var int m_nMapBoundsCount;
var bool m_bDynamicMapSet;
var float m_fMapSize;
var float m_fOffsetX;
var float m_fOffsetY;
var Vector m_vMapBoundsCenter;
var Vector m_vMapBoundsExtents;
var float m_fUpdateMiniMapTimer;
var GFxObject m_Map;
var GFxObject m_MinimapImageLoader;
var GFxObject m_LocalPlayer;
var GFxObject m_SiegeEngine;
var GFxObject m_SiegeBomb[2];
var GFxObject m_CapturePoint;
var GFxObject m_EnemyGates[3];
var GFxObject m_FriendGates[3];
var GFxObject m_EnemyPlayer[5];
var GFxObject m_EnemyPlayerIcon[5];
var GFxObject m_FriendPlayer[5];
var GFxObject m_FriendPlayerIcon[5];
var GFxObject m_mcFog;
var GFxObject m_mcFogMask;
var GFxObject m_mcFogFrame;
var GFxObject m_mcFogSpinner;
var GFxObject m_mcFogSpinnerMask;
var GFxObject m_mcFogSpinnerAnim;
var array<MinimapInfo> m_MinimapInfo;

defaultproperties
{
    m_MinimapInfo[0]=(nMapId=0,fMapSize=9700.0000000,fOffsetX=-32.0000000,fOffsetY=4.0000000)
    m_MinimapInfo[1]=(nMapId=1,fMapSize=10800.0000000,fOffsetX=105.0000000,fOffsetY=0.0000000)
    m_MinimapInfo[2]=(nMapId=2,fMapSize=7000.0000000,fOffsetX=46.0000000,fOffsetY=148.0000000)
    m_MinimapInfo[3]=(nMapId=3,fMapSize=9800.0000000,fOffsetX=20.0000000,fOffsetY=0.0000000)
    m_MinimapInfo[4]=(nMapId=4,fMapSize=6800.0000000,fOffsetX=180.0000000,fOffsetY=-100.0000000)
    m_MinimapInfo[5]=(nMapId=5,fMapSize=7300.0000000,fOffsetX=-40.0000000,fOffsetY=0.0000000)
    m_MinimapInfo[6]=(nMapId=6,fMapSize=2800.0000000,fOffsetX=0.0000000,fOffsetY=0.0000000)
    m_MinimapInfo[7]=(nMapId=7,fMapSize=6300.0000000,fOffsetX=160.0000000,fOffsetY=-70.0000000)
    m_MinimapInfo[8]=(nMapId=8,fMapSize=5200.0000000,fOffsetX=0.0000000,fOffsetY=0.0000000)
    m_MinimapInfo[9]=(nMapId=9,fMapSize=8800.0000000,fOffsetX=0.0000000,fOffsetY=0.0000000)
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_TOP
    m_eAligningType=UIALIGNINGTYPE.UIALIGNING_RIGHT
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudMinimap"
}