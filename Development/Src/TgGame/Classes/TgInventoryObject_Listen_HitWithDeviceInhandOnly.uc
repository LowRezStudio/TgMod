class TgInventoryObject_Listen_HitWithDeviceInhandOnly extends TgInventoryObject_Listen_HitWithDevice
    config(Engine);

defaultproperties
{
    m_bIgnoreChildDevice=true
    m_bAutoProcOnInhand=true
}
