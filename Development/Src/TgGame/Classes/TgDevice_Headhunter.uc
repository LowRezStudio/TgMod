class TgDevice_Headhunter extends TgDevice_Stim
    hidecategories(Navigation)
    config(Engine);

var TgDevice_KinessaInhand m_CachedInhandDevice;
var TgDevice_SniperMode m_CachedSniperModeDevice;
var bool m_bCamFXEnabled;

simulated function OnStartFireRequestSent() { }

simulated function Tick(float DeltaTime) { }

simulated function ToggleCamFX(bool bEnable) { }

simulated function bool HasCachedInhandDevice() { }

simulated function bool HasCachedSniperDevice() { }

state DeviceFiring {}
