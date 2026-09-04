class TgGameDC_DeviceList extends TgDataChunk within GFxMoviePlayer
    native(GameUI)
    config(Engine);

const NUM_UI_DEVICES = 25;

var TgGameDC_Device m_DeviceList[25];

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_DeviceList::execInitializeData(FFrame&, void* const)

native function TgGameDC_Device GetDeviceChunk(TgDevice Dev);  // Export UTgGameDC_DeviceList::execGetDeviceChunk(FFrame&, void* const)

native function DeviceChangeEvent(TgDevice Dev, TgDevice.EDeviceChangeEvent Event);  // Export UTgGameDC_DeviceList::execDeviceChangeEvent(FFrame&, void* const)

native function UpdateDevice(TgDevice Dev);  // Export UTgGameDC_DeviceList::execUpdateDevice(FFrame&, void* const)

native function UpdateSelected(TgDevice Dev);  // Export UTgGameDC_DeviceList::execUpdateSelected(FFrame&, void* const)

native function UpdatePtsAlloc(TgDevice Dev);  // Export UTgGameDC_DeviceList::execUpdatePtsAlloc(FFrame&, void* const)

native function SetEmpty(TgObject.TG_EQUIP_POINT eSlot);  // Export UTgGameDC_DeviceList::execSetEmpty(FFrame&, void* const)
