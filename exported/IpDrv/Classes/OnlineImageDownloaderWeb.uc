class OnlineImageDownloaderWeb extends Object
    config(Engine);

enum EOnlineImageDownloadState
{
    PIDS_NotStarted,                // 0
    PIDS_Downloading,               // 1
    PIDS_Succeeded,                 // 2
    PIDS_Failed,                    // 3
    PIDS_MAX                        // 4
};

struct OnlineImageDownload
{
    var string URL;
    var HttpRequestInterface HTTPRequest;
    var OnlineImageDownloaderWeb.EOnlineImageDownloadState State;
    var bool bPendingRemoval;
    var Texture2DDynamic Texture;

    structdefaultproperties
    {
        URL=""
        HTTPRequest=none
        State=EOnlineImageDownloadState.PIDS_NotStarted
        bPendingRemoval=false
        Texture=none
    }
};

var array<OnlineImageDownload> DownloadImages;
var config int MaxSimultaneousDownloads;
//var delegate<OnOnlineImageDownloaded> __OnOnlineImageDownloaded__Delegate;

delegate OnOnlineImageDownloaded(OnlineImageDownload CachedEntry)
{
    //return;    
}

function Texture GetOnlineImageTexture(string URL)
{
    local int FoundIdx;

    FoundIdx = DownloadImages.Find('URL', URL);
    // End:0x96
    if((FoundIdx != -1) && int(DownloadImages[FoundIdx].State) == int(2))
    {
        return DownloadImages[FoundIdx].Texture;
    }
    return none;
    //return ReturnValue;    
}

private final function int GetOpenDownloadImagesSlot()
{
    local int FoundIdx;

    FoundIdx = DownloadImages.Find('bPendingRemoval', true);
    // End:0x60
    if(FoundIdx == -1)
    {
        FoundIdx = DownloadImages.Length;
        DownloadImages.Length = DownloadImages.Length + 1;
    }
    return FoundIdx;
    //return ReturnValue;    
}

function RequestOnlineImages(array<string> URLs)
{
    local string URL;
    local array<string> UrlPieces, FilePieces;
    local string extension;
    local array<byte> ImageData;
    local int FoundIdx, Idx;

    Idx = 0;
    J0x0B:

    // End:0x93 [Loop If]
    if(Idx < DownloadImages.Length)
    {
        DownloadImages[Idx].bPendingRemoval = URLs.Find(DownloadImages[Idx].URL) == -1;
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    // End:0x528
    foreach URLs(URL)
    {
        FoundIdx = DownloadImages.Find('URL', URL);
        // End:0x10F
        if(FoundIdx != -1)
        {
            OnOnlineImageDownloaded(DownloadImages[FoundIdx]);            
        }
        else
        {
            ParseStringIntoArray(URL, UrlPieces, "/", true);
            // End:0x3F1
            if(Class'IpDrv.OnlineImageDownloaderWebHelper'.static.LoadImageFromTempDir(UrlPieces[UrlPieces.Length - 1], ImageData))
            {
                FoundIdx = GetOpenDownloadImagesSlot();
                DownloadImages[FoundIdx].URL = URL;
                DownloadImages[FoundIdx].HTTPRequest = none;
                DownloadImages[FoundIdx].State = 2;
                DownloadImages[FoundIdx].bPendingRemoval = false;
                // End:0x2A7
                if(DownloadImages[FoundIdx].Texture == none)
                {
                    DownloadImages[FoundIdx].Texture = Class'Engine.Texture2DDynamic'.static.Create(50, 50);
                }
                ParseStringIntoArray(UrlPieces[UrlPieces.Length - 1], FilePieces, ".", true);
                extension = FilePieces[FilePieces.Length - 1];
                // End:0x368
                if((extension ~= "jpeg") || extension ~= "jpg")
                {
                    DownloadImages[FoundIdx].Texture.UpdateMipFromJPEG(0, ImageData);                    
                }
                else
                {
                    // End:0x3C4
                    if(extension ~= "png")
                    {
                        DownloadImages[FoundIdx].Texture.UpdateMipFromPNG(0, ImageData);                        
                    }
                    else
                    {
                        continue;
                        goto J0x528;
                    }
                }
                OnOnlineImageDownloaded(DownloadImages[FoundIdx]);                
            }
            else
            {
                FoundIdx = GetOpenDownloadImagesSlot();
                DownloadImages[FoundIdx].URL = URL;
                DownloadImages[FoundIdx].HTTPRequest = none;
                DownloadImages[FoundIdx].State = 0;
                DownloadImages[FoundIdx].bPendingRemoval = false;
                // End:0x527
                if(DownloadImages[FoundIdx].Texture == none)
                {
                    DownloadImages[FoundIdx].Texture = Class'Engine.Texture2DDynamic'.static.Create(50, 50);
                }
            }
        }        
    }
    J0x528:
    
    Idx = 0;
    J0x534:

    // End:0x59B [Loop If]
    if(Idx < DownloadImages.Length)
    {
        // End:0x58D
        if(DownloadImages[Idx].bPendingRemoval)
        {
            DownloadImages.Remove(Idx--, 1);
        }
        Idx++;
        // [Loop Continue]
        goto J0x534;
    }
    DownloadNextImage();
    //return;    
}

function int GetNumPendingDownloads()
{
    local int Idx, Count;

    Idx = 0;
    J0x0B:

    // End:0x6D [Loop If]
    if(Idx < DownloadImages.Length)
    {
        // End:0x5F
        if(int(DownloadImages[Idx].State) == int(1))
        {
            Count++;
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    return Count;
    //return ReturnValue;    
}

function ClearDownloads(array<string> URLs)
{
    local int Idx;

    Idx = 0;
    J0x0B:

    // End:0x85 [Loop If]
    if(Idx < DownloadImages.Length)
    {
        // End:0x77
        if(URLs.Find(DownloadImages[Idx].URL) != -1)
        {
            DownloadImages.Remove(Idx--, 1);
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function ClearAllDownloads()
{
    DownloadImages.Length = 0;
    //return;    
}

private final function DownloadNextImage()
{
    local int Idx, PendingDownloads;

    PendingDownloads = GetNumPendingDownloads();
    Idx = 0;
    J0x1F:

    // End:0x265 [Loop If]
    if(Idx < DownloadImages.Length)
    {
        // End:0x51
        if(PendingDownloads >= MaxSimultaneousDownloads)
        {
            // [Explicit Break]
            goto J0x265;
        }
        // End:0x257
        if(int(DownloadImages[Idx].State) == int(0))
        {
            DownloadImages[Idx].HTTPRequest = Class'Engine.HttpFactory'.static.CreateRequest();
            // End:0x257
            if(DownloadImages[Idx].HTTPRequest != none)
            {
                DownloadImages[Idx].HTTPRequest.SetVerb("GET");
                DownloadImages[Idx].HTTPRequest.SetURL(DownloadImages[Idx].URL);
                DownloadImages[Idx].HTTPRequest.SetProcessRequestCompleteDelegate(OnDownloadComplete);
                // End:0x257
                if(DownloadImages[Idx].HTTPRequest.ProcessRequest())
                {
                    DownloadImages[Idx].State = 1;
                    PendingDownloads++;
                }
            }
        }
        Idx++;
        // [Loop Continue]
        goto J0x1F;
    }
    J0x265:

    //return;    
}

private final function OnDownloadComplete(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed)
{
    local int FoundIdx;
    local array<byte> ImageData;
    local array<string> Pieces;

    FoundIdx = DownloadImages.Find('HTTPRequest', OriginalRequest);
    // End:0x305
    if(FoundIdx != -1)
    {
        // End:0x28E
        if((bDidSucceed && Response != none) && Response.GetResponseCode() == 200)
        {
            DownloadImages[FoundIdx].State = 2;
            Response.GetContent(ImageData);
            ParseStringIntoArray(OriginalRequest.GetURL(), Pieces, "/", true);
            // End:0x14D
            if(!Class'IpDrv.OnlineImageDownloaderWebHelper'.static.SaveImageToTempDir(Pieces[Pieces.Length - 1], ImageData))
            {
            }
            // End:0x1D8
            if(InStr(Response.GetHeader("Content-Type"), "jpeg", false, true) != -1)
            {
                DownloadImages[FoundIdx].Texture.UpdateMipFromJPEG(0, ImageData);                
            }
            else
            {
                // End:0x262
                if(InStr(Response.GetHeader("Content-Type"), "png", false, true) != -1)
                {
                    DownloadImages[FoundIdx].Texture.UpdateMipFromPNG(0, ImageData);                    
                }
                else
                {
                    DownloadImages[FoundIdx].State = 3;
                }
            }            
        }
        else
        {
            DownloadImages[FoundIdx].State = 3;
        }
        OnOnlineImageDownloaded(DownloadImages[FoundIdx]);
        DownloadImages[FoundIdx].HTTPRequest = none;
    }
    DownloadNextImage();
    //return;    
}

function DebugDraw(Canvas Canvas)
{
    //return;    
}

defaultproperties
{
    MaxSimultaneousDownloads=8
}