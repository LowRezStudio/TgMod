class PComGameViewportClient extends GameViewportClient within Engine
    transient
    native
    config(Engine);

var transient PComOpenBroadcaster OpenBroadcaster;
var transient PComInputLightingEffect InputLightingEffect;
var config bool bUseDynamicResolutionScaler;
var native transient Pointer DynamicResolutionScaler;

native function InitDynamicResolutionScaler();  // Export UPComGameViewportClient::execInitDynamicResolutionScaler(FFrame&, void* const)

native function int GetCurrentGameSettingsVersion();  // Export UPComGameViewportClient::execGetCurrentGameSettingsVersion(FFrame&, void* const)

native function HandleGameSettingsMigration(int OldGameSettingsVersion);  // Export UPComGameViewportClient::execHandleGameSettingsMigration(FFrame&, void* const)

native function CheckGameSettingsVersion();  // Export UPComGameViewportClient::execCheckGameSettingsVersion(FFrame&, void* const)

exec function SetRTMPSettings(bool bAllowWebcam, bool bAllowMicrophone, bool bAllowDesktopAudio) { }

exec function StartRTMPStreaming(string InServer, string InKey) { }

exec function StopRTMPStreaming() { }

exec function StartFacebookStreaming() { }

event bool Init(out string OutError) { }
