class UILobbyChat extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UILOBBYCHAT_ARROWS = 2;

var int m_nDepth;
var int m_nPosition;
var int m_nOpenIdentity;
var string m_sLocalTabName;
var GFxObject m_mcArrow[2];
var GFxObject m_mcArrowNotify[2];
var array<UIChatTab> m_mcTabs;

defaultproperties
{
    m_sLocalTabName="LocalChatTab"
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_BOT
    m_Name="UILobbyChat"
}