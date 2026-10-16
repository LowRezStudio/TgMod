class UIHudVoiceChat extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIVOICECHAT_TEAMPLAYERS = 5;

var float m_fAlphaSpeaking;
var float m_fAlphaNotSpeaking;
var float m_fAlphaMuted;
var float m_fFadeTime;
var GFxObject m_mcAllyPlayers[5];
var GFxObject m_mcAllyPlayerLabels[5];
var GFxObject m_mcAllyPlayerSpeakIcons[5];
var GFxObject m_mcAllyPlayerIcons[5];
var GFxObject m_mcEnemyPlayers[5];
var GFxObject m_mcEnemyPlayerLabels[5];
var GFxObject m_mcEnemyPlayerSpeakIcons[5];
var GFxObject m_mcEnemyPlayerIcons[5];
var string m_sAllyPlayerIcons[5];
var string m_sEnemyPlayerIcons[5];
var UniqueNetId m_LocalPlayerNetId;

defaultproperties
{
    m_fAlphaSpeaking=100.0000000
    m_fFadeTime=0.5000000
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudVoiceChat"
}