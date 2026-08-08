class UIFade extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var GFxObject m_mcBlocker;
var GFxObject m_mcEndOfRoundText;

defaultproperties
{
    m_Name="UIFade"
}
