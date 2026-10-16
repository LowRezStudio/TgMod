class InGameAdManager extends PlatformInterfaceBase
    transient
    native(PlatformInterface);

enum EAdManagerDelegate
{
    AMD_ClickedBanner,              // 0
    AMD_UserClosedAd,               // 1
    AMD_MAX                         // 2
};

var bool bShouldPauseWhileAdOpen;

// Export UInGameAdManager::execInit(FFrame&, void* const)
native event Init();

// Export UInGameAdManager::execShowBanner(FFrame&, void* const)
native function ShowBanner(bool bShowBottomOfScreen);

// Export UInGameAdManager::execHideBanner(FFrame&, void* const)
native function HideBanner();

// Export UInGameAdManager::execForceCloseAd(FFrame&, void* const)
native function ForceCloseAd();

function SetPauseWhileAdOpen(bool bShouldPause)
{
    bShouldPauseWhileAdOpen = bShouldPause;
    //return;    
}

defaultproperties
{
    bShouldPauseWhileAdOpen=true
}