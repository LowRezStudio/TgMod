class UIHudChatBox extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const CHAT_COUNT = 8;
const CHAT_VGS_CALLOUT_COUNT = 5;
const CHAT_VGS_CALLOUT_TOTAL_COUNT = 40;

var int m_nScroll;
var int m_nLineNumber;
var bool m_bLobby;
var bool m_bFadeFrame;
var bool m_bHighlight;
var bool m_bHideInput;
var float m_fBuffer;
var float m_fOffset;
var float m_fInputPosY;
var float m_fInputWidth;
var float m_fOutputWidth;
var float m_fOutputTimer[8];
var string m_sRemaining;
var string m_sLastInput;
var TgChatData m_pChatData;
var int m_nChannel;
var int m_nMaxWidth;
var int m_nPrevIndex;
var string m_sReplyName;
var string m_sRecipient;
var GFxObject m_Buffer;
var GFxObject m_Highlight;
var GFxObject m_Output;
var GFxObject m_OutputText[8];
var GFxObject m_OutputVgsCallout[40];
var GFxObject m_OutputFrame;
var GFxObject m_OutputScroll;
var GFxObject m_mcCloseBtn;
var GFxObject m_Input;
var GFxObject m_InputBtn;
var GFxObject m_InputHelp;
var GFxObject m_InputText;
var GFxObject m_InputChan;
var GFxObject m_InputFrame;
var array<bool> m_bVGSText;
var array<string> m_Messages;
var array<string> m_PrevChats;
var array<ChannelData> m_Shortcuts;

defaultproperties
{
    m_fBuffer=5.0000000
    m_fOffset=25.0000000
    m_fOutputWidth=470.0000000
    m_Shortcuts[0]=(nChannel=0,sName="r")
    m_Shortcuts[1]=(nChannel=0,sName="reply")
    m_Shortcuts[2]=(nChannel=0,sName="w")
    m_Shortcuts[3]=(nChannel=0,sName="whisper")
    m_Shortcuts[4]=(nChannel=0,sName="c")
    m_Shortcuts[5]=(nChannel=0,sName="clan")
    m_Shortcuts[6]=(nChannel=0,sName="l")
    m_Shortcuts[7]=(nChannel=0,sName="local")
    m_Shortcuts[8]=(nChannel=0,sName="g")
    m_Shortcuts[9]=(nChannel=0,sName="game")
    m_Shortcuts[10]=(nChannel=0,sName="t")
    m_Shortcuts[11]=(nChannel=0,sName="twitch")
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_BOT
    m_bVisibleOnLoad=true
    m_Name="UIHudChatBox"
}