class UIComponent_ItemObtainabilityBanner extends UIComponent
    native(UIComponent)
    config(Engine)
    dependson(UIDataItem);

var protected UIDataItem.SimplifiedItemObtainabilityValue m_eObtainability;

defaultproperties
{
    m_sLoadName="ExclusiveBanner"
}
