class PComJsonHandler extends Object
    native
    config(Engine)
    dependson(PComImageDownloader);

var PComImageDownloader m_pImageDownloader;
var native Pointer m_pCallbackObject;
var init string m_strUrl;
var init string m_strLocalDir;
var init string m_strJson;
var init string m_strName;
var native const Pointer m_pHttp;

native function OnImageDownloaded(PComImageDownload CachedEntry);  // Export UPComJsonHandler::execOnImageDownloaded(FFrame&, void* const)
