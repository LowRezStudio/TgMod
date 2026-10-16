class TgChatData extends Object
    native
    config(Engine);

var int m_nId;
var int m_nSoundId;
var int m_nChannel;
var bool m_bWarning;
var bool m_bFeedback;
var bool m_bIsVGS;
var string m_sSender;
var string m_sMessage;
var string m_sSenderColor;
var string m_sSenderClass;
var string m_sMessageColor;
var string m_ColorVGS;
var string m_ColorWarn;
var string m_sWarningToken;

event bool CheckWarning(string Message) { }

event string TokenReplace(string Message, string Token, string sValue) { }

defaultproperties
{
    m_ColorVGS="#BBBBBB"
    m_ColorWarn="#ff0000"
    m_sWarningToken="#WARN#"
}
