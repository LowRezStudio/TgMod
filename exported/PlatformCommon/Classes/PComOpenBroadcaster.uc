class PComOpenBroadcaster extends Object
    native
    config(Game);

enum EPComOpenBroadcasterState
{
    POBS_Idle,                      // 0
    POBS_WaitingForFacebookWebBrowserLoaded,// 1
    POBS_WaitingForFacebookNewPublishFlow,// 2
    POBS_FacebookNewPublishError,   // 3
    POBS_WaitingForFacebookLogin,   // 4
    POBS_WaitingForFacebookPublish, // 5
    POBS_FacebookPublishFinished,   // 6
    POBS_Streaming,                 // 7
    POBS_Quitting,                  // 8
    POBS_MAX                        // 9
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
//var delegate<PreloadWebBrowser> __PreloadWebBrowser__Delegate;
//var delegate<IsWebBrowserLoaded> __IsWebBrowserLoaded__Delegate;
//var delegate<OpenWebBrowser> __OpenWebBrowser__Delegate;
//var delegate<CloseWebBrowser> __CloseWebBrowser__Delegate;

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
    local WebRequest WebRequest;

    WebRequest = new (self) Class'IpDrv.WebRequest';
    WebRequest.DecodeFormData(InRequest, 512, 4096);
    return WebRequest;
    //return ReturnValue;    
}

defaultproperties
{
    FacebookAppId="1871049266456588"
    FacebookApprovedDomain="www.hirezstudios.com"
    CurrentSettings=(bAllowWebcam=false,bAllowMicrophone=false,bAllowDesktopAudio=true)
}