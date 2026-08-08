class TgInventoryObject_Device extends TgInventoryObject
    native(Inventory)
    config(Engine);

var TgDevice s_Device;
var int m_nDeviceInstanceId;
var int c_nNumFindDeviceFails;
var int m_nStackCount;
var native const Pointer m_pAmDevice;

native function SetInstanceCount(int nInstanceCount);  // Export UTgInventoryObject_Device::execSetInstanceCount(FFrame&, void* const)

native function bool IsCard();  // Export UTgInventoryObject_Device::execIsCard(FFrame&, void* const)
