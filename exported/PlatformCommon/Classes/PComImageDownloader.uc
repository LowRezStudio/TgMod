class PComImageDownloader extends Object
    native;

const MAX_SIMULTANEOUS_DOWNLOADS = 8;
const TIME_OUT = 30.f;

enum EPComImageDownloadState
{
    TIDS_NotStarted,                // 0
    TIDS_Downloading,               // 1
    TIDS_Succeeded,                 // 2
    TIDS_Failed,                    // 3
    TIDS_MAX                        // 4
};

struct native PComImageDownload
{
    var init string URL;
    var init string FilePath;
    var private native const Pointer HttpDownloader;
    var OnlineImageDownloaderWeb.EOnlineImageDownloadState State;
    var init array<init byte> Data;
    var bool bPendingRemoval;

    structdefaultproperties
    {
        URL=""
        FilePath=""
        State=EOnlineImageDownloadState.PIDS_NotStarted
        Data=none
        bPendingRemoval=false
    }
};

var init array<init PComImageDownload> DownloadImages;
//var delegate<OnPComImageDownloaded> __OnPComImageDownloaded__Delegate;

delegate OnPComImageDownloaded(PComImageDownload CachedEntry)
{
    //return;    
}

function SetPComImageDownloadedDelegate(delegate<OnPComImageDownloaded> PComImageDownloadedDelegate)
{
    __OnPComImageDownloaded__Delegate = PComImageDownloadedDelegate;
    //return;    
}
