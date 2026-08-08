class UIHudTarget extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var int m_nOwnerBotId;
var array<UIComponent_TargeterManager> m_TargetingManagers;

defaultproperties
{
    m_eScalingType=UISCALING_FITTALL
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudTarget"
}
