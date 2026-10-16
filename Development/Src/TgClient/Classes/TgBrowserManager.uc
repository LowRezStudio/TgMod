class TgBrowserManager extends Object
    native
    config(Engine);

enum WebPageType {
    WPT_Gold,  // 0
    WPT_CreateAccount,  // 1
    WPT_RecoverPassword,  // 2
    WPT_RecoverUsername,  // 3
    WPT_GodPack,  // 4
    WPT_FacebookPromo,  // 5
    WPT_TwitterPromo,  // 6
    WPT_RecruitPromo,  // 7
    WPT_ReferLinkup,  // 8
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

function bool IsBrowserLoaded() { }

native function ExternalOpenURL(string URL, optional bool bAddLang=true);  // Export UTgBrowserManager::execExternalOpenURL(FFrame&, void* const)

native function OpenURL(string URL, optional bool bShowNavButtons=true);  // Export UTgBrowserManager::execOpenURL(FFrame&, void* const)

native function OpenVideo(string URL, optional bool bAddName=true);  // Export UTgBrowserManager::execOpenVideo(FFrame&, void* const)

native function Close();  // Export UTgBrowserManager::execClose(FFrame&, void* const)

native function ResizeView();  // Export UTgBrowserManager::execResizeView(FFrame&, void* const)

native function SetContainer(UIWebBrowser pContainer);  // Export UTgBrowserManager::execSetContainer(FFrame&, void* const)

event Alert() { }

event Gold() { }

event Store() { }

event Booster() { }

event Support() { }

event Profile() { }

event ActivateKey() { }

event CreateAccount() { }

event RecoverPassword() { }

event RecoverUsername() { }

event SubmitBugReport(string sPlayerName) { }

event GodPack() { }

event RankedRules() { }

event FacebookPromo() { }

event TwitterPromo() { }

event RecruitPromo() { }

event PlayerStats(string sPlayerName) { }

event TwitchHelp() { }

event TwitchSignup() { }

event LaunchTournament() { }

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
