class UIChatTab extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const CHAT_OUTPUT_COUNT = 4;

struct ChannelData {
    var int nChannel;
    var string sName;
    structdefaultproperties {}
};

var int m_nScroll;
var int m_nChannel;
var int m_nIdentity;
var int m_nPrevIndex;
var int m_nLineNumber;
var int m_nOutputCount;
var bool m_bOpen;
var bool m_bCanChat;
var bool m_bCanScroll;
var bool m_bPrevInputState;
var float m_fBuffer;
var float m_fOutputWidth;
var string m_sRecipient;
var string m_sRemaining;
var string m_sLastInput;
var TgChatData m_pChatData;
var GFxObject m_mcClose;
var GFxObject m_mcMinimize;
var GFxObject m_mcOpen;
var GFxObject m_mcOpenTF;
var GFxObject m_mcOpenFrame;
var GFxObject m_mcOpenButton;
var GFxObject m_mcOpenButtonTF;
var GFxObject m_mcOpenButtonEdge;
var GFxObject m_mcOpenButtonMask;
var GFxObject m_mcBuffer;
var GFxObject m_mcButton;
var GFxObject m_mcButtonTF;
var GFxObject m_mcButtonEdge;
var GFxObject m_mcButtonMask;
var GFxObject m_mcButtonHighlight;
var GFxObject m_mcNotify;
var GFxObject m_mcScroll;
var GFxObject m_mcInput;
var GFxObject m_mcInputBtn;
var GFxObject m_mcOutput[4];
var array<string> m_Messages;
var array<string> m_PrevChats;
var array<ChannelData> m_Shortcuts;

defaultproperties
{
    m_fOutputWidth=520.0000000
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
    m_bVisibleOnLoad=true
    m_bResize=false
    m_Name="ChatTab"
}
