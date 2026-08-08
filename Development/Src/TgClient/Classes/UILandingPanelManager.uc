class UILandingPanelManager extends PComUIManagerBase
    native
    config(Engine);

struct JsonFeatureData {
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
    structdefaultproperties {}
};

struct JsonDiscountData {
    var int nPackId;
    var int nDiscountPct;
    structdefaultproperties {}
};

var UIGameMoviePlayer m_pMovie;
