class UIComponent_GenericTitleInputButtons extends UIComponent
    native(UIComponent)
    config(Engine);

const UICOMPONENT_GENERICTITLEINPUTBUTTONS_TITLECOUNT = 2;

const UICOMPONENT_GENERICTITLEINPUTBUTTONS_BUTTONCOUNT = 2;

var GFxObject m_mcTitle[2];
var GFxObject m_mcError;
var UIInteractable_Button m_Buttons[2];
var int m_ButtonClickHandles[2];
var GFxObject m_mcInputTF;
var GFxObject m_mcInputFrame;
var GFxObject m_mcInputFrameHighlight;
var TgGFxGroup m_grButtons;
var UIData_PopupInput m_pData;
