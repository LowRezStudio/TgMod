class UIComponent_List extends UIComponent
    native(UIList)
    config(Engine);

struct UICListEntry {
    var UIComponent_Interactable pInteractable;
    var UIComponent pDisplay;
    structdefaultproperties {}
};

var protected int m_nSelectedIndex;
var array<UICListEntry> m_ListItems;
var array<UIData> m_ListData;
var protected TgGFxGroup m_grList;
var UIComponent_ScrollBar m_pScrollbarV;
var UIComponent_ScrollBar m_pScrollbarH;
var dword m_dwItemSize;
var dword m_dwDataSize;
var bool m_bExtendVertically;
