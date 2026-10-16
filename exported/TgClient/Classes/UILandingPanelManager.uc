class UILandingPanelManager extends PComUIManagerBase
    native;

struct native JsonFeatureData
{
    var init string sId;
    var init string sHeader;
    var init string sDesc;
    var init string sData;
    var int nProbability;
    var int nType;
    var int nXpos;
    var int nYpos;
    var int nWidth;
    var int nHeight;
    var bool bIsUsed;
    var bool bIsLive;
    var Texture2DDynamic Texture;

    structdefaultproperties
    {
        sId=""
        sHeader=""
        sDesc=""
        sData=""
        nProbability=0
        nType=0
        nXpos=0
        nYpos=0
        nWidth=0
        nHeight=0
        bIsUsed=false
        bIsLive=false
        Texture=none
    }
};

struct native JsonDiscountData
{
    var int nPackId;
    var int nDiscountPct;

    structdefaultproperties
    {
        nPackId=0
        nDiscountPct=0
    }
};

var UIGameMoviePlayer m_pMovie;
