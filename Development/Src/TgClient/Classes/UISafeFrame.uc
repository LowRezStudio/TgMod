class UISafeFrame extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UISAFEFRAME_STEPCOUNT = 20;

const UISAFEFRAME_MIN = 0.9f;

const UISAFEFRAME_MAX = 1.f;

var GFxObject m_mcAdjust;
var GFxObject m_mcAccept;

defaultproperties
{
    m_Name="UISafeFrame"
}
