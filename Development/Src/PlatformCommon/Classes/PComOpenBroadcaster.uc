class PComOpenBroadcaster extends Object
    native
    config(Game);

enum EPComOpenBroadcasterState {
    POBS_Idle,  // 0
    POBS_WaitingForFacebookWebBrowserLoaded,  // 1
    POBS_WaitingForFacebookNewPublishFlow,  // 2
    POBS_FacebookNewPublishError,  // 3
    POBS_WaitingForFacebookLogin,  // 4
    POBS_WaitingForFacebookPublish,  // 5
    POBS_FacebookPublishFinished,  // 6
    POBS_Streaming,  // 7
    POBS_Quitting,  // 8
};

struct PComOpenBroadcasterSettings {
    var () bool bAllowWebcam;
    var () bool bAllowMicrophone;
    var () bool bAllowDesktopAudio;
    structdefaultproperties {}
};

var config string FacebookAppId;
var config string FacebookApprovedDomain;
var config string FacebookLiveUrl;
var transient PComOpenBroadcaster.EPComOpenBroadcasterState CurrentState;
var transient PComOpenBroadcasterSettings CurrentSettings;
var transient Pointer StreamerProcessHandle;

delegate PreloadWebBrowser();

delegate bool IsWebBrowserLoaded();

delegate OpenWebBrowser(string URL);

delegate CloseWebBrowser();

native function bool IsStreaming();  // Export UPComOpenBroadcaster::execIsStreaming(FFrame&, void* const)

native function SetStreamSettings(const out PComOpenBroadcasterSettings InSettings);  // Export UPComOpenBroadcaster::execSetStreamSettings(FFrame&, void* const)

native function QueueFacebookStreaming();  // Export UPComOpenBroadcaster::execQueueFacebookStreaming(FFrame&, void* const)

native function StartFacebookStreaming();  // Export UPComOpenBroadcaster::execStartFacebookStreaming(FFrame&, void* const)

native function StartRTMPStreaming(string InServer, string InKey);  // Export UPComOpenBroadcaster::execStartRTMPStreaming(FFrame&, void* const)

native function StopStreaming();  // Export UPComOpenBroadcaster::execStopStreaming(FFrame&, void* const)

native function ForceStopStreaming();  // Export UPComOpenBroadcaster::execForceStopStreaming(FFrame&, void* const)

native function Tick();  // Export UPComOpenBroadcaster::execTick(FFrame&, void* const)

simulated event WebRequest DecodeFacebookRTMPUrl(string InRequest) { }

defaultproperties
{
    FacebookAppId="1871049266456588"
    FacebookApprovedDomain="www.hirezstudios.com"
    CurrentSettings=(bAllowWebcam=false,bAllowMicrophone=false,bAllowDesktopAudio=true)
}
