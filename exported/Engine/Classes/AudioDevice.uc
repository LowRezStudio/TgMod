class AudioDevice extends Subsystem
    transient
    native(AudioDevice)
    config(Engine);

enum ESoundClassName
{
    Master,                         // 0
    ESoundClassName_MAX             // 1
};

enum EDebugState
{
    DEBUGSTATE_None,                // 0
    DEBUGSTATE_IsolateDryAudio,     // 1
    DEBUGSTATE_IsolateReverb,       // 2
    DEBUGSTATE_TestLPF,             // 3
    DEBUGSTATE_TestStereoBleed,     // 4
    DEBUGSTATE_TestLFEBleed,        // 5
    DEBUGSTATE_DisableLPF,          // 6
    DEBUGSTATE_DisableRadio,        // 7
    DEBUGSTATE_MAX                  // 8
};

enum ETTSSpeaker
{
    TTSSPEAKER_Paul,                // 0
    TTSSPEAKER_Harry,               // 1
    TTSSPEAKER_Frank,               // 2
    TTSSPEAKER_Dennis,              // 3
    TTSSPEAKER_Kit,                 // 4
    TTSSPEAKER_Betty,               // 5
    TTSSPEAKER_Ursula,              // 6
    TTSSPEAKER_Rita,                // 7
    TTSSPEAKER_Wendy,               // 8
    TTSSPEAKER_MAX                  // 9
};

struct native Listener
{
    var const PortalVolume PortalVolume;
    var Vector Location;
    var Vector Up;
    var Vector Right;
    var Vector Front;
    var Vector Velocity;

    structdefaultproperties
    {
        PortalVolume=none
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Up=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Right=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Front=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native AudioClassInfo
{
    var const int NumResident;
    var const int SizeResident;
    var const int NumRealTime;
    var const int SizeRealTime;

    structdefaultproperties
    {
        NumResident=0
        SizeResident=0
        NumRealTime=0
        SizeRealTime=0
    }
};

var const config int MaxChannels;
var const config int CommonAudioPoolSize;
var const config float LowPassFilterResonance;
var const config float MinCompressedDurationEditor;
var const config float MinCompressedDurationGame;
var const config string ChirpInSoundNodeWaveName;
var const SoundNodeWave ChirpInSoundNodeWave;
var const config string ChirpOutSoundNodeWaveName;
var const SoundNodeWave ChirpOutSoundNodeWave;
var native const Pointer CommonAudioPool;
var native const int CommonAudioPoolFreeBytes;
var const export editinline transient array<export editinline AudioComponent> AudioComponents;
var const export editinline transient array<export editinline AudioComponent> AudioComponentsToStop;
var native const array<Pointer> Sources;
var native const array<Pointer> FreeSources;
var native const map{VOID,VOID} WaveInstanceSourceMap;
var native const bool bGameWasTicking;
var transient bool bSoundSpawningEnabled;
var native const array<Listener> Listeners;
var native const QWord CurrentTick;
var() map{VOID,VOID} SoundClasses;
var map{VOID,VOID} SourceSoundClasses;
var map{VOID,VOID} CurrentSoundClasses;
var map{VOID,VOID} DestinationSoundClasses;
var native const map{VOID,VOID} SoundModes;
var native const Pointer Effects;
var native const name BaseSoundModeName;
var native const SoundMode CurrentMode;
var native const Double SoundModeStartTime;
var native const Double SoundModeFadeInStartTime;
var native const Double SoundModeFadeInEndTime;
var native const Double SoundModeEndTime;
var native const int ListenerVolumeIndex;
var native const InteriorSettings ListenerInteriorSettings;
var native const Double InteriorStartTime;
var native const Double InteriorEndTime;
var native const Double ExteriorEndTime;
var native const Double InteriorLPFEndTime;
var native const Double ExteriorLPFEndTime;
var native const float InteriorVolumeInterp;
var native const float InteriorLPFInterp;
var native const float ExteriorVolumeInterp;
var native const float ExteriorLPFInterp;
var const export editinline AudioComponent TestAudioComponent;
var native const Pointer TextToSpeech;
var native const AudioDevice.EDebugState DebugState;
var transient float TransientMasterVolume;
var transient float LastUpdateTime;
var Class<AudioComponent> DefaultAudioComponentClass;
var globalconfig string DefaultAudioComponentClassName;
var init config string DefaultAudioDevice;

// Export UAudioDevice::execListAudioDevices(FFrame&, void* const)
native function ListAudioDevices(init out array<init string> InstalledDevices);

// Export UAudioDevice::execChangeAudioDevice(FFrame&, void* const)
native function ChangeAudioDevice(string NewAudioDevice);

// Export UAudioDevice::execSetSoundMode(FFrame&, void* const)
native final function bool SetSoundMode(name NewMode);

// Export UAudioDevice::execFindSoundClass(FFrame&, void* const)
native final function SoundClass FindSoundClass(name SoundClassName);

defaultproperties
{
    TransientMasterVolume=1.0000000
    DefaultAudioComponentClassName="TgGame.TgAudioComponent"
}