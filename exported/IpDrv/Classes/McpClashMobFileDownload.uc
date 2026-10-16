class McpClashMobFileDownload extends OnlineTitleFileDownloadWeb
    config(Engine);

function string GetUrlForFile(string Filename)
{
    local string URL;

    URL = ((((((GetBaseURL()) $ RequestFileURL) $ "?appKey=") $ McpConfig.AppKey) $ "&appSecret=") $ McpConfig.AppSecret) $ "&dlName=";
    return URL;
    //return ReturnValue;    
}

defaultproperties
{
    RequestFileURL="/challengefile"
}