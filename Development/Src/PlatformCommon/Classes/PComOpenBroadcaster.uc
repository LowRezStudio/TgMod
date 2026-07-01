class PComOpenBroadcaster extends Object
    native
    config(Game);

enum EPComOpenBroadcasterState
{
    POBS_Idle,
    POBS_WaitingForFacebookWebBrowserLoaded,
    POBS_WaitingForFacebookNewPublishFlow,
    POBS_FacebookNewPublishError,
    POBS_WaitingForFacebookLogin,
    POBS_WaitingForFacebookPublish,
    POBS_FacebookPublishFinished,
    POBS_Streaming,
    POBS_Quitting
};

struct native PComOpenBroadcasterSettings
{
    var() bool bAllowWebcam;
    var() bool bAllowMicrophone;
    var() bool bAllowDesktopAudio;

    structdefaultproperties
    {
        bAllowWebcam=false
        bAllowMicrophone=false
        bAllowDesktopAudio=true
    }
};

var private native const noexport Pointer VfTable_FCallbackEventDevice;
var config string FacebookAppId;
var config string FacebookApprovedDomain;
var config string FacebookLiveUrl;
var transient PComOpenBroadcaster.EPComOpenBroadcasterState CurrentState;
var transient PComOpenBroadcasterSettings CurrentSettings;
var transient Pointer StreamerProcessHandle;
var delegate<PreloadWebBrowser> __PreloadWebBrowser__Delegate;
var delegate<IsWebBrowserLoaded> __IsWebBrowserLoaded__Delegate;
var delegate<OpenWebBrowser> __OpenWebBrowser__Delegate;
var delegate<CloseWebBrowser> __CloseWebBrowser__Delegate;

delegate PreloadWebBrowser()
{
    //return;    
}

delegate bool IsWebBrowserLoaded()
{
    //return ReturnValue;    
}

delegate OpenWebBrowser(string URL)
{
    //return;    
}

delegate CloseWebBrowser()
{
    //return;    
}

// Export UPComOpenBroadcaster::execIsStreaming(FFrame&, void* const)
native function bool IsStreaming();

// Export UPComOpenBroadcaster::execSetStreamSettings(FFrame&, void* const)
native function SetStreamSettings(const out PComOpenBroadcasterSettings InSettings);

// Export UPComOpenBroadcaster::execQueueFacebookStreaming(FFrame&, void* const)
native function QueueFacebookStreaming();

// Export UPComOpenBroadcaster::execStartFacebookStreaming(FFrame&, void* const)
native function StartFacebookStreaming();

// Export UPComOpenBroadcaster::execStartRTMPStreaming(FFrame&, void* const)
native function StartRTMPStreaming(string InServer, string InKey);

// Export UPComOpenBroadcaster::execStopStreaming(FFrame&, void* const)
native function StopStreaming();

// Export UPComOpenBroadcaster::execForceStopStreaming(FFrame&, void* const)
native function ForceStopStreaming();

// Export UPComOpenBroadcaster::execTick(FFrame&, void* const)
native final function Tick();

simulated event WebRequest DecodeFacebookRTMPUrl(string InRequest)
{
    //return ReturnValue;    
}

defaultproperties
{
    // FacebookAppId="958422817557131"
    // FacebookApprovedDomain="www.smitegame.com"
    // CurrentSettings=(bAllowWebcam=false,bAllowMicrophone=false,bAllowDesktopAudio=true)
}