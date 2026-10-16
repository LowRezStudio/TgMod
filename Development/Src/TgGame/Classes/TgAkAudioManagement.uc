class TgAkAudioManagement extends Object
    native(InteractiveAudio)
    config(Engine);

const MAX_METERING_CALLBACK_SLOTS = 16;

struct AkMeterCallbackState {
    var dword dwBusID;
    var bool bActive;
    var float fLevel;
    var float fTimestamp;
    structdefaultproperties {}
};

var AkMeterCallbackState m_MeterCallbackSlots[16];
var array<dword> dwAllBusses;
var bool m_bInitialized;

native function Initialize();  // Export UTgAkAudioManagement::execInitialize(FFrame&, void* const)

native function dword GetBusUID(string sBusName);  // Export UTgAkAudioManagement::execGetBusUID(FFrame&, void* const)
