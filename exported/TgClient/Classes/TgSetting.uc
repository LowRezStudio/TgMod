class TgSetting extends TgObject
    native(SettingsUI);

enum SETTING_TYPE
{
    SET_RESOLUTION,                 // 0
    SET_ASPECTRATIO,                // 1
    SET_SCREENTYPE,                 // 2
    SET_ANTIALIASING,               // 3
    SET_VERTICALSYNC,               // 4
    SET_DETAILWORLD,                // 5
    SET_DETAILSHADOW,               // 6
    SET_DETAILTEXTURE,              // 7
    SET_DETAILPARTICLE,             // 8
    SET_SHADERQUALITY,              // 9
    SET_GAMMALEVEL,                 // 10
    SET_FOV,                        // 11
    SET_SAFEFRAME,                  // 12
    SET_HUDMINIMAP,                 // 13
    SET_HUDTEAMS,                   // 14
    SET_HUDDAMAGE,                  // 15
    SET_HUDCOMBATLOG,               // 16
    SET_HUDAUTOLEVEL,               // 17
    SET_HUDHEALTHBAR,               // 18
    SET_HUDBLOOM,                   // 19
    SET_HUDCOLOR,                   // 20
    SET_HUDRETICLE,                 // 21
    SET_VOLUMEMASTER,               // 22
    SET_VOLUMEEFFECTS,              // 23
    SET_VOLUMEMUSIC,                // 24
    SET_VOLUMEVOICE,                // 25
    SET_VOLUMENOTIFY,               // 26
    SET_MOUSEINVERT,                // 27
    SET_MOUSESMOOTH,                // 28
    SET_ALLOWGAMEPAD,               // 29
    SET_MOUSESENSITIVITY,           // 30
    SET_XAXISSENSITIVITY,           // 31
    SET_YAXISSENSITIVITY,           // 32
    SET_AIMACCELMODE,               // 33
    SET_AIMACCELBOOST,              // 34
    SET_GAMEPADINVERT,              // 35
    SET_DEADZONEINNER,              // 36
    SET_DEADZONEOUTER,              // 37
    SET_SHOWGAMETIPS,               // 38
    SET_SPECTATE,                   // 39
    SET_SPECTATORPLAYERICONS,       // 40
    SET_SPECTATORSHOWITEMS,         // 41
    SET_SPECTATORBLUETEAMSERIESSCORE,// 42
    SET_SPECTATORREDTEAMSERIESSCORE,// 43
    SET_CONTROLICONSTYLE,           // 44
    SET_HAPTICFEEDBACK,             // 45
    SET_HUDTEAMUI,                  // 46
    SET_VOLUMEVOICECHAT,            // 47
    SET_VOLUMEVOICECHATMIC,         // 48
    SET_ENABLEVOICECHAT,            // 49
    SET_USEVOICECHATPUSHTOTALK,     // 50
    SET_TOGGLEZOOM,                 // 51
    SET_AUDIOPANNING,               // 52
    SET_SCOPESENSITIVITY,           // 53
    SET_RETICLECHANGE,              // 54
    SET_USEPROFANITYFILTER,         // 55
    SET_MAX                         // 56
};

enum SETTING_BINARY
{
    SEB_DISABLED,                   // 0
    SEB_ENABLED,                    // 1
    SEB_MAX                         // 2
};

enum SETTING_SCREENTYPE
{
    SST_WINDOWED,                   // 0
    SST_BORDERLESS,                 // 1
    SST_FULLSCREEN,                 // 2
    SST_MAX                         // 3
};

enum SETTING_ANTIALIASING
{
    SAA_OFF,                        // 0
    SAA_TWO,                        // 1
    SAA_FOUR,                       // 2
    SAA_EIGHT,                      // 3
    SAA_MAX                         // 4
};

enum OPTION_DETAILLEVEL
{
    SDL_LOWEST,                     // 0
    SDL_LOW,                        // 1
    SDL_MEDIUM,                     // 2
    SDL_HIGH,                       // 3
    SDL_MAX                         // 4
};

enum SETTING_AIMACCELMODE
{
    SAIM_DYNAMIC,                   // 0
    SAIM_CLASSIC,                   // 1
    SAIM_PRECISION,                 // 2
    SAIM_MAX                        // 3
};

enum SETTING_DEADZONESIZE
{
    SDZS_MINIMUM,                   // 0
    SDZS_SMALL,                     // 1
    SDZS_MEDIUM,                    // 2
    SDZS_LARGE,                     // 3
    SDZS_MAX                        // 4
};

enum SETTING_AUDIOPANNING
{
    SAP_SPEAKERS,                   // 0
    SAP_HEADPHONES,                 // 1
    SAP_MAX                         // 2
};

struct native OptionData
{
    var float fValue;
    var float fOther;
    var init string sName;

    structdefaultproperties
    {
        fValue=0.0000000
        fOther=0.0000000
        sName=""
    }
};

var float m_fDefault;
var float m_fConfigDefault;
var float m_fOriginal;
var float m_fMax;
var float m_fMin;
var float m_fTemp;
var float m_fValue;
var TgSetting.SETTING_TYPE m_eType;
var array<OptionData> m_Options;
