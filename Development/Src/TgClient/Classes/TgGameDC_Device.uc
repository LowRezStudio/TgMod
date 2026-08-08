class TgGameDC_Device extends TgDataChunk within GFxMoviePlayer
    native(GameUI)
    config(Engine);

var int m_nDeviceId;
var int m_nDeviceInstanceId;
var int m_nPointsAllocated;
var TgSynchronizedTimer m_CooldownTimer;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_Device::execInitializeData(FFrame&, void* const)

native function DeviceChangeEvent(TgDevice Dev, TgDevice.EDeviceChangeEvent Event);  // Export UTgGameDC_Device::execDeviceChangeEvent(FFrame&, void* const)

native function UpdateValues(TgDevice Dev);  // Export UTgGameDC_Device::execUpdateValues(FFrame&, void* const)

native function UpdateSelected(bool bSelected);  // Export UTgGameDC_Device::execUpdateSelected(FFrame&, void* const)

native function UpdateCanFire(TgDevice Dev);  // Export UTgGameDC_Device::execUpdateCanFire(FFrame&, void* const)

native function UpdateCooldown(TgDevice Dev);  // Export UTgGameDC_Device::execUpdateCooldown(FFrame&, void* const)

native function UpdatePtsAlloc(TgDevice Dev);  // Export UTgGameDC_Device::execUpdatePtsAlloc(FFrame&, void* const)

native function UpdateInstanceCount(TgDevice Dev);  // Export UTgGameDC_Device::execUpdateInstanceCount(FFrame&, void* const)

native function UpdateCastMode();  // Export UTgGameDC_Device::execUpdateCastMode(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgGameDC_Device::execNotifyMapChange(FFrame&, void* const)

delegate usc_get_mode_tooltip_delegate();

native function usc_get_mode_tooltip(int nRank);  // Export UTgGameDC_Device::execusc_get_mode_tooltip(FFrame&, void* const)

delegate usc_set_cast_mode_delegate();

native function usc_set_cast_mode(int nCastMode);  // Export UTgGameDC_Device::execusc_set_cast_mode(FFrame&, void* const)
