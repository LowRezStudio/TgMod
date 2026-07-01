class PComGameViewportClient extends GameViewportClient within Engine
    transient
    native
    config(Engine);

var transient PComOpenBroadcaster OpenBroadcaster;
var transient PComInputLightingEffect InputLightingEffect;
var config bool bUseDynamicResolutionScaler;
var native transient Pointer DynamicResolutionScaler;

// Export UPComGameViewportClient::execInitDynamicResolutionScaler(FFrame&, void* const)
native final function InitDynamicResolutionScaler();

// Export UPComGameViewportClient::execGetCurrentGameSettingsVersion(FFrame&, void* const)
native function int GetCurrentGameSettingsVersion();

// Export UPComGameViewportClient::execHandleGameSettingsMigration(FFrame&, void* const)
native function HandleGameSettingsMigration(int OldGameSettingsVersion);

// Export UPComGameViewportClient::execCheckGameSettingsVersion(FFrame&, void* const)
native final function CheckGameSettingsVersion();

exec function SetRTMPSettings(bool bAllowWebcam, bool bAllowMicrophone, bool bAllowDesktopAudio)
{
    //return;    
}

exec function StartRTMPStreaming(string InServer, string InKey)
{
    //return;    
}

exec function StopRTMPStreaming()
{
    //return;    
}

exec function StartFacebookStreaming()
{
    //return;    
}

event bool Init(out string OutError)
{
    CheckGameSettingsVersion();
    OpenBroadcaster = new (self) Class'PComOpenBroadcaster';
    InputLightingEffect = new (self) Class'PComInputLightingEffect';
    InitDynamicResolutionScaler();
    return super.Init(OutError);
    //return ReturnValue;    
}
