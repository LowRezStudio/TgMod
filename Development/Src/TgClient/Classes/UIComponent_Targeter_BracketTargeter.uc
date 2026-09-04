class UIComponent_Targeter_BracketTargeter extends UIComponent_Targeter
    native(UIComponent)
    config(Engine);

var GFxObject m_mcTargeterLeft;
var GFxObject m_mcTargeterRight;
var float m_fSideTargeterAspectRatio;

defaultproperties
{
    m_bCenterTargeter=true
}
