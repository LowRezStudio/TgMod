class PComJsonHandler extends Object
    native;

var PComImageDownloader m_pImageDownloader;
var native Pointer m_pCallbackObject;
var init string m_strUrl;
var init string m_strLocalDir;
var init string m_strJson;
var init string m_strName;
var native const Pointer m_pHttp;

// Export UPComJsonHandler::execOnImageDownloaded(FFrame&, void* const)
native function OnImageDownloaded(PComImageDownload CachedEntry);
