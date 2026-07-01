class PComImageDownloader extends Object
    native;

const MAX_SIMULTANEOUS_DOWNLOADS = 8;
const TIME_OUT = 30.f;

enum EPComImageDownloadState
{
    TIDS_NotStarted,
    TIDS_Downloading,
    TIDS_Succeeded,
    TIDS_Failed
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
        State=PIDS_NotStarted
        Data=()
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
    //return;    
}
