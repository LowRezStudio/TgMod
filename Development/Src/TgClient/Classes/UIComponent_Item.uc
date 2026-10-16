class UIComponent_Item extends UIComponent
    native(UIComponent)
    config(Engine);

var protected GFxObject m_mcName;
var protected GFxObject m_mcType;
var protected GFxObject m_mcDescription;
var protected GFxObject m_mcArtIcon;
var protected GFxObject m_mcFrame;
var protected UIDataItem m_Item;
var protected bool m_bCacheDirty;
var protected bool m_bDataDirty;
var protected bool m_bUseBaseName;
var protected string m_sDescription;
var protected string m_sType;
var protected const float m_fDescriptionCenterOffset;
var int m_nTickCallback;

defaultproperties
{
    m_fDescriptionCenterOffset=135.0000000
    m_sLoadName="Card"
    m_sConstructName="Card"
}
