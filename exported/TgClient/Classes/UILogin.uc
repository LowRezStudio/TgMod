class UILogin extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

enum UILoginState
{
    UILS_NONE,                      // 0
    UILS_INPUT,                     // 1
    UILS_WAITING,                   // 2
    UILS_LOADING,                   // 3
    UILS_EULA,                      // 4
    UILS_CREATE,                    // 5
    UILS_TRYCREATE,                 // 6
    UILS_LOGGEDIN,                  // 7
    UILS_MAX                        // 8
};

var int m_nScroll;
var byte m_eState;
var bool m_bAnimLogo;
var bool m_bSaveName;
var bool m_bHaveInput;
var float m_fRotation;
var float m_fAnimTimer;
var float m_fLoginTimer;
var float m_fLoadingTimer;
var float m_fTextTimerIn;
var float m_fTextTimerOut;
var GFxObject m_mcFade;
var GFxObject m_mcLogo;
var GFxObject m_mcInput;
var GFxObject m_mcInputName;
var GFxObject m_mcInputPass;
var GFxObject m_mcInputSave;
var GFxObject m_mcInputCaps;
var GFxObject m_mcInputLogin;
var GFxObject m_mcInputMessage;
var GFxObject m_mcQueue;
var GFxObject m_mcVersion;
var GFxObject m_mcLoginMsg;
var GFxObject m_mcCreate;
var GFxObject m_mcCreateError;
var GFxObject m_mcCreateInput;
var GFxObject m_mcCreateSubmit;
var GFxObject m_mcCreateCancel;
var GFxObject m_mcLoading;
var GFxObject m_mcLoadingTF;
var GFxObject m_mcLoadingFrame;
var GFxObject m_mcLoadingAnimA;
var GFxObject m_mcLoadingAnimB;
var GFxObject m_mcEULA;
var GFxObject m_mcEULATF;
var GFxObject m_mcEULATitle;
var GFxObject m_mcEULAAccept;
var GFxObject m_mcEULADecline;
var GFxObject m_mcEULAGamepadBtns[2];
var GFxObject m_mcConsoleLogin;
var GFxObject m_mcConsoleLoginPrompt;
var GFxObject m_mcConsoleLoginChangeUser;
var GFxObject m_mcConsoleLoginFeedback;
var array<string> m_sEULA;

defaultproperties
{
    m_bAnimLogo=true
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_bBlur=true
    m_Name="UILogin"
}