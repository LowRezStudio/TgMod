class UIComponent_TargeterManager extends UIComponent
    native(UIComponent)
    config(Engine);

var TgGfxScene m_mcOwningScene;
var Class pTargeterClass;
var byte m_TargeterID;
var array<UIComponent_Targeter> m_Targeters;
