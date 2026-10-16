class TgAkAudioManagement extends Object
    native(InteractiveAudio);

const MAX_METERING_CALLBACK_SLOTS = 16;

struct native AkMeterCallbackState
{
    var dword dwBusID;
    var bool bActive;
    var float fLevel;
    var float fTimestamp;

    structdefaultproperties
    {
        dwBusID=()
        bActive=false
        fLevel=0.0000000
        fTimestamp=0.0000000
    }
};

var AkMeterCallbackState m_MeterCallbackSlots[16];
var array<dword> dwAllBusses;
var bool m_bInitialized;

// Export UTgAkAudioManagement::execInitialize(FFrame&, void* const)
native function Initialize();

// Export UTgAkAudioManagement::execGetBusUID(FFrame&, void* const)
native function dword GetBusUID(string sBusName);
