class UIHudTeam extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDTEAM_COUNT = 5;
const UIHUDTEAM_STATS = 10;
const UIHUDTEAM_LOADOUTSIZE = 5;
const UIHUDTEAM_ITEMSLOTS = 4;
const UIHUDTEAM_STREAK_MIN_STREAK = 5;
const UIHUDTEAM_STREAK_FADE_CEILING = 20;

enum UIHudTeamDisplayMode
{
    TeamDisplayMode_Top,            // 0
    TeamDisplayMode_SidesWithItems, // 1
    TeamDisplayMode_SidesWithCards, // 2
    TeamDisplayMode_KDA,            // 3
    TeamDisplayMode_MAX             // 4
};

enum UIHudTeamStatsMode
{
    TeamStatsMode_Credits,          // 0
    TeamStatsMode_Damage,           // 1
    TeamStatsMode_Shielding,        // 2
    TeamStatsMode_Healing,          // 3
    TeamStatsMode_ObjectiveTime,    // 4
    TeamStatsMode_MAX               // 5
};

enum UIHudTeamAnimGroup
{
    TeamAnimGroup_Team,             // 0
    TeamAnimGroup_Stats,            // 1
    TeamAnimGroup_MAX               // 2
};

struct native TEAMPLAYER_INFO
{
    var int nRespawn;
    var bool bHealth;
    var bool bRespawn;
    var bool bVisible;
    var float fHealth;
    var float fRespawn;
    var int nUlt;
    var bool bSelected;
    var init string sIcon;
    var float fUltIconScale;
    var GFxObject pObj;
    var GFxObject pIcon;
    var GFxObject pIconDead;
    var GFxObject pHealth;
    var GFxObject pHealthTip;
    var GFxObject pHealthBG;
    var float fHealthBarWidth;
    var GFxObject pRespawn;
    var GFxObject pDeadX;
    var GFxObject pUlt;
    var GFxObject pUltReady;
    var GFxObject pSelected;
    var int nStreak;
    var float fStreakAnimOffset;
    var GFxObject pStreak;
    var GFxObject pStreakAdd1;
    var GFxObject pStreakAdd2;
    var GFxObject pStreakCount;

    structdefaultproperties
    {
        nRespawn=0
        bHealth=false
        bRespawn=false
        bVisible=false
        fHealth=0.0000000
        fRespawn=0.0000000
        nUlt=0
        bSelected=false
        sIcon=""
        fUltIconScale=0.0000000
        pObj=none
        pIcon=none
        pIconDead=none
        pHealth=none
        pHealthTip=none
        pHealthBG=none
        fHealthBarWidth=0.0000000
        pRespawn=none
        pDeadX=none
        pUlt=none
        pUltReady=none
        pSelected=none
        nStreak=0
        fStreakAnimOffset=0.0000000
        pStreak=none
        pStreakAdd1=none
        pStreakAdd2=none
        pStreakCount=none
    }
};

struct native TEAMPLAYER_INFO_EXTENDED extends TEAMPLAYER_INFO
{
    var bool bItemsVisible;
    var bool bCardsVisible;
    var UICardDisplayGroup CardDisplayGroup;
    var init string sPlayerName;
    var GFxObject pPlayerName;
    var int nCredits;
    var GFxObject pCredits;
    var int nKills;
    var int nDeaths;
    var int nAssists;
    var GFxObject pKDA;
};

struct native TEAMSTAT_INFO
{
    var GFxObject pObj;
    var GFxObject pIcon;
    var GFxObject pText;
    var GFxObject pTip;
    var GFxObject pBar;
    var GFxObject pBackground;
    var GFxObject pMask;
    var init string sIcon;
    var float fMaskBaseWidth;

    structdefaultproperties
    {
        pObj=none
        pIcon=none
        pText=none
        pTip=none
        pBar=none
        pBackground=none
        pMask=none
        sIcon=""
        fMaskBaseWidth=0.0000000
    }
};

var bool m_bShowPlayers;
var string m_sSpectatingText;
var GFxObject m_mcSpectating;
var GFxObject m_mcSpectatingTF;
var GFxObject m_mcPlayers;
var TEAMPLAYER_INFO m_mcPlayerRed[5];
var TEAMPLAYER_INFO m_mcPlayerBlue[5];
var GFxObject m_mcTeamBlueName;
var GFxObject m_mcTeamBlueScore;
var GFxObject m_mcTeamRedName;
var GFxObject m_mcTeamRedScore;
var GFxObject m_mcTeamBlueTopBG;
var GFxObject m_mcTeamRedTopBG;
var GFxObject m_mcPlayersSide;
var GFxObject m_mcPlayersSideBlueBG;
var GFxObject m_mcPlayersSideRedBG;
var TEAMPLAYER_INFO_EXTENDED m_mcPlayerSideRed[5];
var TEAMPLAYER_INFO_EXTENDED m_mcPlayerSideBlue[5];
var GFxObject m_mcStats;
var GFxObject m_mcStatsTitle;
var TEAMSTAT_INFO m_mcStatsEntry[10];
var GFxObject m_mcRespawn;
var TEAMPLAYER_INFO m_mcRespawnRed[5];
var TEAMPLAYER_INFO m_mcRespawnBlue[5];
var int m_nSpectatorMode;
var int m_nStatsMode;
var float m_fStatsUpdateTimer;

event HandleAnimState(int nAnimState, optional int nAnimGroup = 0)
{
    local int I, J;
    local bool bVisible;
    local float fAnimTime;

    fAnimTime = 0.3300000;
    switch(nAnimGroup)
    {
        // End:0x9D0
        case 0:
            TransitionTeamTop(nAnimState == 0, fAnimTime);
            TransitionTeamSides(nAnimState != 0, fAnimTime);
            // End:0x9CD
            if(nAnimState != 0)
            {
                I = 0;
                J0x83:

                // End:0x9CD [Loop If]
                if(I < 5)
                {
                    J = 0;
                    J0x9E:

                    // End:0x3C2 [Loop If]
                    if(J < 4)
                    {
                        bVisible = (nAnimState == 1) && m_mcPlayerSideBlue[I].CardDisplayGroup.Items[J].DeviceID != 0;
                        Animate(m_mcPlayerSideBlue[I].CardDisplayGroup.Items[J].Obj, fAnimTime, 2, ((bVisible) ? 100.0000000 : 0.0000000));
                        Animate(m_mcPlayerSideBlue[I].CardDisplayGroup.Items[J].Obj, fAnimTime, 7, ((bVisible) ? 1.0000000 : 0.0000000));
                        bVisible = (nAnimState == 1) && m_mcPlayerSideRed[I].CardDisplayGroup.Items[J].DeviceID != 0;
                        Animate(m_mcPlayerSideRed[I].CardDisplayGroup.Items[J].Obj, fAnimTime, 2, ((bVisible) ? 100.0000000 : 0.0000000));
                        Animate(m_mcPlayerSideRed[I].CardDisplayGroup.Items[J].Obj, fAnimTime, 7, ((bVisible) ? 1.0000000 : 0.0000000));
                        J++;
                        // [Loop Continue]
                        goto J0x9E;
                    }
                    J = 0;
                    J0x3CD:

                    // End:0x6F3 [Loop If]
                    if(J < 5)
                    {
                        bVisible = (nAnimState == 2) && m_mcPlayerSideBlue[I].CardDisplayGroup.Cards[J].DeviceID != 0;
                        Animate(m_mcPlayerSideBlue[I].CardDisplayGroup.Cards[J].Obj, fAnimTime, 2, ((bVisible) ? 100.0000000 : 0.0000000));
                        Animate(m_mcPlayerSideBlue[I].CardDisplayGroup.Cards[J].Obj, fAnimTime, 7, ((bVisible) ? 1.0000000 : 0.0000000));
                        bVisible = (nAnimState == 2) && m_mcPlayerSideRed[I].CardDisplayGroup.Cards[J].DeviceID != 0;
                        Animate(m_mcPlayerSideRed[I].CardDisplayGroup.Cards[J].Obj, fAnimTime, 2, ((bVisible) ? 100.0000000 : 0.0000000));
                        Animate(m_mcPlayerSideRed[I].CardDisplayGroup.Cards[J].Obj, fAnimTime, 7, ((bVisible) ? 1.0000000 : 0.0000000));
                        J++;
                        // [Loop Continue]
                        goto J0x3CD;
                    }
                    Animate(m_mcPlayerSideBlue[I].pCredits, fAnimTime, 2, ((nAnimState == 1) ? 100.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideBlue[I].pCredits, fAnimTime, 7, ((nAnimState == 1) ? 1.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideRed[I].pCredits, fAnimTime, 2, ((nAnimState == 1) ? 100.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideRed[I].pCredits, fAnimTime, 7, ((nAnimState == 1) ? 1.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideBlue[I].pKDA, fAnimTime, 2, ((nAnimState == 3) ? 100.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideBlue[I].pKDA, fAnimTime, 7, ((nAnimState == 3) ? 1.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideRed[I].pKDA, fAnimTime, 2, ((nAnimState == 3) ? 100.0000000 : 0.0000000));
                    Animate(m_mcPlayerSideRed[I].pKDA, fAnimTime, 7, ((nAnimState == 3) ? 1.0000000 : 0.0000000));
                    I++;
                    // [Loop Continue]
                    goto J0x83;
                }
            }
            // End:0x9FD
            break;
        // End:0x9FA
        case 1:
            TransitionStats(nAnimState != -1, fAnimTime);
            // End:0x9FD
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

event TransitionTeamTop(bool bShow, float fAnimTime)
{
    Animate(m_mcPlayers, fAnimTime, 1, m_mcPlayers.m_fOrigY - ((bShow) ? 0.0000000 : 50.0000000));
    Animate(m_mcPlayers, fAnimTime, 2, ((bShow) ? 100.0000000 : 0.0000000));
    Animate(m_mcPlayers, fAnimTime, 7, ((bShow) ? 1.0000000 : 0.0000000));
    Animate(m_mcTeamBlueName, fAnimTime, 0, m_mcTeamBlueName.m_fOrigX + ((bShow) ? 0.0000000 : 0.0000000));
    Animate(m_mcTeamBlueName, fAnimTime, 1, m_mcTeamBlueName.m_fOrigY - ((bShow) ? 0.0000000 : 90.0000000));
    Animate(m_mcTeamRedName, fAnimTime, 0, m_mcTeamRedName.m_fOrigX - ((bShow) ? 0.0000000 : 0.0000000));
    Animate(m_mcTeamRedName, fAnimTime, 1, m_mcTeamRedName.m_fOrigY - ((bShow) ? 0.0000000 : 90.0000000));
    //return;    
}

event TransitionTeamSides(bool bShow, float fAnimTime)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x323 [Loop If]
    if(I < 5)
    {
        // End:0x198
        if(!bShow || m_mcPlayerSideRed[I].bVisible)
        {
            Animate(m_mcPlayerSideRed[I].pObj, fAnimTime, 0, m_mcPlayerSideRed[I].pObj.m_fOrigX + ((bShow) ? 0.0000000 : 100.0000000));
            Animate(m_mcPlayerSideRed[I].pObj, fAnimTime, 2, ((bShow) ? 100.0000000 : 0.0000000));
            Animate(m_mcPlayerSideRed[I].pObj, fAnimTime, 7, ((bShow) ? 1.0000000 : 0.0000000));
        }
        // End:0x315
        if(!bShow || m_mcPlayerSideBlue[I].bVisible)
        {
            Animate(m_mcPlayerSideBlue[I].pObj, fAnimTime, 0, m_mcPlayerSideBlue[I].pObj.m_fOrigX - ((bShow) ? 0.0000000 : 100.0000000));
            Animate(m_mcPlayerSideBlue[I].pObj, fAnimTime, 2, ((bShow) ? 100.0000000 : 0.0000000));
            Animate(m_mcPlayerSideBlue[I].pObj, fAnimTime, 7, ((bShow) ? 1.0000000 : 0.0000000));
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    Animate(m_mcPlayersSideBlueBG, fAnimTime, 0, m_mcPlayersSideBlueBG.m_fOrigX - ((bShow) ? 0.0000000 : 100.0000000));
    Animate(m_mcPlayersSideBlueBG, fAnimTime, 2, ((bShow) ? 100.0000000 : 0.0000000));
    Animate(m_mcPlayersSideBlueBG, fAnimTime, 7, ((bShow) ? 1.0000000 : 0.0000000));
    Animate(m_mcPlayersSideRedBG, fAnimTime, 0, m_mcPlayersSideRedBG.m_fOrigX + ((bShow) ? 0.0000000 : 100.0000000));
    Animate(m_mcPlayersSideRedBG, fAnimTime, 2, ((bShow) ? 100.0000000 : 0.0000000));
    Animate(m_mcPlayersSideRedBG, fAnimTime, 7, ((bShow) ? 1.0000000 : 0.0000000));
    //return;    
}

event TransitionStats(bool bShow, float fAnimTime)
{
    Animate(m_mcStats, fAnimTime, 0, m_mcStats.m_fOrigX - ((bShow) ? 0.0000000 : 100.0000000));
    Animate(m_mcStats, fAnimTime, 2, ((bShow) ? 100.0000000 : 0.0000000));
    Animate(m_mcStats, fAnimTime, 7, ((bShow) ? 1.0000000 : 0.0000000));
    TransitionTeamSidesSizing(bShow, fAnimTime);
    //return;    
}

// Export UUIHudTeam::execTransitionTeamSidesSizing(FFrame&, void* const)
native function TransitionTeamSidesSizing(bool bSmall, optional float fAnimTime = 0.2500000);

defaultproperties
{
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_TOP
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudTeam"
}