class UIComponentPool extends UIComponent
    native(UIComponent)
    config(Engine);

var array<UIComponent> m_ActivePooledItems;
var array<UIComponent> m_InactivePooledItems;
