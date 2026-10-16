class TgBrowserManager extends Object
    native;

enum WebPageType
{
    WPT_Gold,                       // 0
    WPT_CreateAccount,              // 1
    WPT_RecoverPassword,            // 2
    WPT_RecoverUsername,            // 3
    WPT_GodPack,                    // 4
    WPT_FacebookPromo,              // 5
    WPT_TwitterPromo,               // 6
    WPT_RecruitPromo,               // 7
    WPT_ReferLinkup,                // 8
    WPT_MAX                         // 9
};

var string URLGold;
var string URLAlert;
var string URLStore;
var string URLBooster;
var string URLSupport;
var string URLProfile;
var string URLRedirect;
var string URLActivateKey;
var string URLCreateAccount;
var string URLRecoverPassword;
var string URLRecoverUsername;
var string URLGodPack;
var string URLRanked;
var string URLFacebookPromo;
var string URLTwitterPromo;
var string URLRecruitPromo;
var string URLPlayerStats;
var string URLTwitchSignup;
var string URLTwitchHelp;
var string URLLaunchTournament;
var UIWebBrowser m_pContainer;

function bool IsBrowserLoaded()
{
    return m_pContainer != none;
    //return ReturnValue;    
}

// Export UTgBrowserManager::execExternalOpenURL(FFrame&, void* const)
native function ExternalOpenURL(string URL, optional bool bAddLang = true);

// Export UTgBrowserManager::execOpenURL(FFrame&, void* const)
native function OpenURL(string URL, optional bool bShowNavButtons = true);

// Export UTgBrowserManager::execOpenVideo(FFrame&, void* const)
native function OpenVideo(string URL, optional bool bAddName = true);

// Export UTgBrowserManager::execClose(FFrame&, void* const)
native function Close();

// Export UTgBrowserManager::execResizeView(FFrame&, void* const)
native function ResizeView();

// Export UTgBrowserManager::execSetContainer(FFrame&, void* const)
native function SetContainer(UIWebBrowser pContainer);

event Alert()
{
    OpenURL(URLAlert);
    //return;    
}

event Gold()
{
    OpenURL(URLRedirect $ URLGold);
    //return;    
}

event Store()
{
    OpenURL(URLRedirect $ URLStore);
    //return;    
}

event Booster()
{
    OpenURL(URLRedirect $ URLBooster);
    //return;    
}

event Support()
{
    OpenURL(URLRedirect $ URLSupport);
    //return;    
}

event Profile()
{
    OpenURL(URLRedirect $ URLProfile);
    //return;    
}

event ActivateKey()
{
    OpenURL(URLRedirect $ URLActivateKey);
    //return;    
}

event CreateAccount()
{
    OpenURL(URLRedirect $ URLCreateAccount);
    //return;    
}

event RecoverPassword()
{
    OpenURL(URLRedirect $ URLRecoverPassword);
    //return;    
}

event RecoverUsername()
{
    OpenURL(URLRedirect $ URLRecoverUsername);
    //return;    
}

event SubmitBugReport(string sPlayerName)
{
    OpenURL("http://fs12.formsite.com/HiRez/form39/fill?1=" $ sPlayerName);
    //return;    
}

event GodPack()
{
    OpenURL(URLRedirect $ URLGodPack);
    //return;    
}

event RankedRules()
{
    OpenURL(URLRedirect $ URLRanked);
    //return;    
}

event FacebookPromo()
{
    ExternalOpenURL(URLRedirect $ URLFacebookPromo);
    //return;    
}

event TwitterPromo()
{
    ExternalOpenURL(URLRedirect $ URLTwitterPromo);
    //return;    
}

event RecruitPromo()
{
    OpenURL(URLRedirect $ URLRecruitPromo);
    //return;    
}

event PlayerStats(string sPlayerName)
{
    OpenURL((URLRedirect $ URLPlayerStats) $ sPlayerName);
    //return;    
}

event TwitchHelp()
{
    OpenURL(URLTwitchHelp);
    //return;    
}

event TwitchSignup()
{
    OpenURL(URLTwitchSignup);
    //return;    
}

event LaunchTournament()
{
    ExternalOpenURL(URLRedirect $ URLLaunchTournament);
    //return;    
}

defaultproperties
{
    URLGold="Gold"
    URLAlert="https://www.paladins.com"
    URLStore="STORE"
    URLBooster="Booster"
    URLSupport="Support"
    URLProfile="Profile"
    URLRedirect="https://www.paladins.com/ingameredirect/?dest="
    URLActivateKey="ACTIVATEKEY"
    URLCreateAccount="CREATEACCOUNT"
    URLRecoverPassword="RECOVERPASSWORD"
    URLRecoverUsername="RECOVERUSER"
    URLGodPack="GODS"
    URLRanked="RANKED"
    URLFacebookPromo="FACEBOOK"
    URLTwitterPromo="TWITTER"
    URLRecruitPromo="REFER"
    URLPlayerStats="STATS&player="
    URLTwitchSignup="http://www.twitch.tv/"
    URLTwitchHelp="http://www.twitch.tv/user/reset_password"
    URLLaunchTournament="TOURNEY"
}