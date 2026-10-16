class TgGameDC_Device extends TgDataChunk within GFxMoviePlayer
    native(GameUI);

var int m_nDeviceId;
var int m_nDeviceInstanceId;
var int m_nPointsAllocated;
var TgSynchronizedTimer m_CooldownTimer;
//var delegate<usc_get_mode_tooltip_delegate> __usc_get_mode_tooltip_delegate__Delegate;
//var delegate<usc_set_cast_mode_delegate> __usc_set_cast_mode_delegate__Delegate;

// Export UTgGameDC_Device::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgGameDC_Device::execDeviceChangeEvent(FFrame&, void* const)
native function DeviceChangeEvent(TgDevice Dev, TgDevice.EDeviceChangeEvent Event);

// Export UTgGameDC_Device::execUpdateValues(FFrame&, void* const)
native function UpdateValues(TgDevice Dev);

// Export UTgGameDC_Device::execUpdateSelected(FFrame&, void* const)
native function UpdateSelected(bool bSelected);

// Export UTgGameDC_Device::execUpdateCanFire(FFrame&, void* const)
native function UpdateCanFire(TgDevice Dev);

// Export UTgGameDC_Device::execUpdateCooldown(FFrame&, void* const)
native function UpdateCooldown(TgDevice Dev);

// Export UTgGameDC_Device::execUpdatePtsAlloc(FFrame&, void* const)
native function UpdatePtsAlloc(TgDevice Dev);

// Export UTgGameDC_Device::execUpdateInstanceCount(FFrame&, void* const)
native function UpdateInstanceCount(TgDevice Dev);

// Export UTgGameDC_Device::execUpdateCastMode(FFrame&, void* const)
native function UpdateCastMode();

// Export UTgGameDC_Device::execNotifyMapChange(FFrame&, void* const)
native function NotifyMapChange();

delegate usc_get_mode_tooltip_delegate()
{
    //return;    
}

// Export UTgGameDC_Device::execusc_get_mode_tooltip(FFrame&, void* const)
native function usc_get_mode_tooltip(int nRank);

delegate usc_set_cast_mode_delegate()
{
    //return;    
}

// Export UTgGameDC_Device::execusc_set_cast_mode(FFrame&, void* const)
native function usc_set_cast_mode(int nCastMode);
