class PComImageDownloader extends Object
    native
    config(Engine);

const MAX_SIMULTANEOUS_DOWNLOADS = 8;

const TIME_OUT = 30.f;

enum EPComImageDownloadState {
    TIDS_NotStarted,  // 0
    TIDS_Downloading,  // 1
    TIDS_Succeeded,  // 2
    TIDS_Failed,  // 3
};

struct PComImageDownload {
    var init string URL;
    var init string FilePath;
    var private const Pointer HttpDownloader;
    var OnlineImageDownloaderWeb.EOnlineImageDownloadState State;
    var init array<init byte> Data;
    var bool bPendingRemoval;
    structdefaultproperties {}
};

var init array<init PComImageDownload> DownloadImages;

delegate OnPComImageDownloaded(PComImageDownload CachedEntry);

function SetPComImageDownloadedDelegate(delegate<OnPComImageDownloaded> PComImageDownloadedDelegate) { }
