class PComBrowserManager extends Object
    native;

const BROWSER_SURFACE_ID = 1;

// Export UPComBrowserManager::execOpenURL(FFrame&, void* const)
native function OpenURL(string URL, optional bool bShowNavButtons = true, optional bool bSetFocus = false);
