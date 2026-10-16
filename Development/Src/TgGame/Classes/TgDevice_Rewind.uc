class TgDevice_Rewind extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var TgDevice_Illusion m_CachedIllusionDevice;

function DoRewindCardLogic(TgDevice_DimensionalLink dimensionalLinkDevice) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=10335
}
