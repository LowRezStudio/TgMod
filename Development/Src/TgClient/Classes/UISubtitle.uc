class UISubtitle extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var float m_fTimer;
var float m_fSwitchTimer;
var string m_sNewSubtitle;
var GFxObject m_mcText;
var GFxObject m_mcFrame;

defaultproperties
{
    m_Name="UISubtitle"
}
