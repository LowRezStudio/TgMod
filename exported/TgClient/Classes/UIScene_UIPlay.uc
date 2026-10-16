class UIScene_UIPlay extends UIScene
    native(UIComponent)
    implements(DelayQueueInterface);

var private native const noexport Pointer VfTable_IDelayQueueInterface;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderIcon;
var GFxObject m_mcMultiqueueCursor;
var GFxObject m_mcMultiqueueUpDownIndicator;
var UIInteractable_Button m_JoinMultiqueueButton;
var UIComponent_List m_Panels;
var UIComponent_List m_MultiqueuePanels;
var array<UIData> m_PanelStack;
