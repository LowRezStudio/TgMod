class UIFooter extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIFOOTER_OPTIONS = 8;

const UIFOOTER_PLAYERS = 5;

const UIFOOTER_OPTION_WIDTH = 1000;

struct FooterOption {
    var int nOption;
    var GFxObject pObj;
    var GFxObject pKey;
    var GFxObject pKeyTF;
    var GFxObject pGlow;
    var GFxObject pGlowTF;
    var GFxObject pTitle;
    var GFxObject pTitleTF;
    var GFxObject pFrame;
    structdefaultproperties {}
};

var GFxObject m_mcFrame;
var GFxObject m_mcBack;
var GFxObject m_mcBackTitle;
var GFxObject m_mcSocial;
var GFxObject m_mcSocialTitle;
var GFxObject m_mcSocialCTA;
var GFxObject m_mcOptions;
var GFxObject m_mcOptionsTitle;
var GFxObject m_mcFriendsOnline;
var bool m_bOptionsEnabled;
var FooterOption m_Option[8];

defaultproperties
{
    m_eSnappingType=UISNAPPING_BOT
    m_Name="UIFooter"
}
