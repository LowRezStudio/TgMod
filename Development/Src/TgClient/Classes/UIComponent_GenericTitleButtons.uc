class UIComponent_GenericTitleButtons extends UIComponent
    native(UIComponent)
    config(Engine);

const UICOMPONENT_GENERICTITLEBUTTONS_TITLECOUNT = 2;

const UICOMPONENT_GENERICTITLEBUTTONS_COLUMNSIZE = 4;

const UICOMPONENT_GENERICTITLEBUTTONS_BUTTONCOUNT = 8;

var GFxObject m_mcTitle[2];
var UIInteractable_Button m_Buttons[8];
var int m_ButtonClickHandles[8];
var TgGFxGroup m_grButtons;
