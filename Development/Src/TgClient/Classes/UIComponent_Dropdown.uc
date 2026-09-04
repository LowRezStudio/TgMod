class UIComponent_Dropdown extends UIComponent
    native(UIList)
    config(Engine)
    dependson(UIComponent_List);

var UIComponent_GamepadKey m_pGamepadKey;
var UIComponent_List m_pList;
var UIComponent_Interactable m_pBlocker;
var UICListEntry m_Button;
