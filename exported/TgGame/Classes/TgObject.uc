class TgObject extends Object
    native;

const FEET_TO_UNREAL_UNITS = 16;
const UNREAL_UNITS_TO_FEET = 0.0625;
const MAX_DECK_SIZE = 15;
const MIN_FOV = 80;
const MAX_FOV = 120;
const DODM_HIDE = 0;
const DODM_SHOW_OWNED_INDICATOR = 1;
const DODM_SHOW_FRIENDLY_INDICATOR = 2;
const DODM_SHOW_ENEMY_INDICATOR = 4;
const DODM_SHOW_OWNED_HEALTHBAR = 8;
const DODM_SHOW_FRIENDLY_HEALTHBAR = 16;
const DODM_SHOW_ENEMY_HEALTHBAR = 32;
const DODM_SHOW_OWNED_SILHOUETTE = 64;
const DODM_SHOW_FRIENDLY_SILHOUETTE = 128;
const DODM_SHOW_ENEMY_SILHOUETTE = 256;
const DODM_SHOW_OWNED_HEALING_INDICATOR = 256;
const DODM_SHOW_FRIENDLY_HEALING_INDICATOR = 512;
const DODM_SHOW_ENEMY_PROJECTILE_RING = 1024;
const DODM_BLINK_ON_PROJECTILE_RING = 2048;
const DODM_SHOW_PROJECTILE_AS_DEPLOYABLE = 4096;
const DODM_SHOW_FRIENDLY_PLAYER_ICON = 8192;
const DODM_SHOW_ENEMY_PLAYER_ICON = 16384;
const DODM_MODIFIER_ALWAYS_SHOW = 32768;
const DODM_MODIFIER_FULL_SCALE = 65536;
const DODM_SHOW_OWNED_ALL_OVERLAYS = 73;
const DODM_SHOW_FRIENDLY_ALL_OVERLAYS = 146;
const DODM_SHOW_ENEMY_ALL_OVERLAYS = 292;
const DODM_SHOW_ALL_INDICATORS = 7;
const DODM_SHOW_ALL_HEALTHBAR = 56;
const DODM_SHOW_ALL_SILHOUETTE = 448;
const DODM_SHOW_EVERYTHING = 511;
const EQ_MAX_LOAD_DEVICE = 15;
const TG_EQP_POINT_MAX = 33;
const CONTEXT_NOTIFY_ATTACK = 116959;
const CONTEXT_NOTIFY_DEFEND = 116960;
const CONTEXT_NOTIFY_BE_CAREFUL = 116961;
const CONTEXT_NOTIFY_PING = 117584;
const CONTEXT_NOTIFY_ENEMY = 117670;
const CONTEXT_NOTIFY_MIA = 117676;
const CONTEXT_NOTIFY_GANK = 117671;
const CONTEXT_NOTIFY_HELP = 117672;
const CONTEXT_NOTIFY_INCOMING = 117673;
const CONTEXT_NOTIFY_RETREAT = 117674;
const CONTEXT_NOTIFY_RETURNED = 117675;
const CONTEXT_NOTIFY_SELF_ATTACK = 118524;
const CONTEXT_NOTIFY_SELF_DEFEND = 118525;
const CONTEXT_NOTIFY_SELF_GANK = 118526;
const CONTEXT_NOTIFY_SELF_RETURNED = 118527;
const CONTEXT_NOTIFY_SELF_RETREAT = 118528;
const CONTEXT_NOTIFY_WARD_HERE = 122294;
const ITEM_QUALITY_EPIC = 1162;
const ITEM_QUALITY_RARE = 1163;
const ITEM_QUALITY_UNCOMMON = 1164;
const ITEM_QUALITY_COMMON = 1165;
const VV_BOT_RANK_FAMILIAR = 10425;
const VV_BOT_RANK_MINION = 10123;
const VV_BOT_RANK_TOWER = 10127;
const VV_BOT_RANK_GUARDIAN = 10124;
const VV_BOT_RANK_PHOENIX = 10125;
const VV_BOT_RANK_GOD = 10126;
const VV_BOT_RANK_MONSTER = 10085;
const VV_BOT_RANK_BUFFMONSTER = 10178;
const VV_BOT_RANK_NEUTRAL_BOSS = 10270;
const VV_BOT_RANK_DECOY = 10679;
const VV_BOT_RANK_DEPLOYABLE = 10678;
const VV_BOT_RANK_ELITE_MINION = 10787;
const VV_BOT_RANK_SIEGE_WALL = 11104;
const VV_BOT_RANK_TURRET = 15115;
const TGPAWN_GENERIC_EFFECT_GROUP_SITUATIONAL_01 = 10693;
const TGPAWN_GENERIC_EFFECT_GROUP_SITUATIONAL_02 = 10694;
const TGPAWN_GENERIC_EFFECT_GROUP_SITUATIONAL_03 = 11080;
const TGPAWN_GENERIC_EFFECT_GROUP_SITUATIONAL_04 = 11081;
const TGPAWN_GENERIC_EFFECT_GROUP_SITUATIONAL_05 = 11082;
const TGPAWN_GENERIC_EFFECT_GROUP_SITUATIONAL_06 = 11083;
const EFFECT_GROUP_SITUATIONAL_BOOST = 10915;
const TGPAWN_ON_LANDED = 15043;
const TG_BACK_HIT_ANGLE = 120.0;
const BOT_ID_BARIK_TURRET = 2151;
const BOT_ID_YING_ILLUSION = 2273;
const CHAMPION_ID_BARIK = 2073;
const CHAMPION_ID_CASSIE = 2092;
const CHAMPION_ID_EVIE = 2094;
const CHAMPION_ID_FERNANDO = 2071;
const CHAMPION_ID_GROHK = 2093;
const CHAMPION_ID_BUCK = 2147;
const CHAMPION_ID_PIP = 2056;
const CHAMPION_ID_RUCKUS = 2149;
const CHAMPION_ID_SKYE = 2057;
const CHAMPION_ID_ANDROXUS = 2205;
const CHAMPION_ID_GROVER = 2254;
const CHAMPION_ID_KINESSA = 2249;
const CHAMPION_ID_YING = 2267;
const CHAMPION_ID_DROGOZ = 2277;
const CHAMPION_ID_BOMBKING = 2281;
const CHAMPION_ID_VIKTOR = 2285;
const CHAMPION_ID_MAKOA = 2288;
const CHAMPION_ID_MALDAMBA = 2303;
const CHAMPION_ID_SHALIN = 2307;
const CHAMPION_ID_TYRA = 2314;
const CHAMPION_ID_MAEVE = 2338;
const CHAMPION_ID_TORVALD = 2322;
const CHAMPION_ID_INARA = 2348;
const CHAMPION_ID_LEX = 2362;
const CHAMPION_ID_ORACLE = 2372;
const CHAMPION_ID_WILLO = 2393;
const CHAMPION_ID_FLAK = 2404;
const CHAMPION_ID_DARKLORD = 2420;
const CHAMPION_ID_PRINCESS = 2417;
const CHAMPION_ID_ASTRO = 2431;
const CHAMPION_ID_OWL = 2438;
const CHAMPION_ID_DEMON = 2472;
const CHAMPION_ID_LAZARUS = 2477;
const CHAMPION_ID_PVE_BARIK_TURRET1 = 2326;
const CHAMPION_ID_PVE_BARIK_TURRET2 = 2337;
const CHAMPION_ID_PVE_FERNANDO_SHIELD = 2331;
const CHAMPION_ID_PVE_GROVER_HEALS = 2333;
const CHAMPION_ID_PVE_MAKOA_ULT = 2324;
const CHAMPION_ID_PVE_MAKOA_HOOK = 2245;
const CHAMPION_ID_PVE_MAKOA_SPIN = 2243;
const CHAMPION_ID_PVE_MAKOA_SHIELD = 2323;
const CHAMPION_ID_PVE_PIP_HEALS = 2339;
const CHAMPION_ID_PVE_VIKTOR_GRENADE1 = 2354;
const CHAMPION_ID_PVE_VIKTOR_GRENADE2 = 2356;
const CHAMPION_ID_PVE_VIKTOR_GRENADE3 = 2357;
const CHAMPION_ID_PVE_TORVALD_ROOT1 = 2342;
const CHAMPION_ID_PVE_TORVALD_ROOT2 = 2373;
const CHAMPION_ID_PVE_FERNANDO_FB1 = 2328;
const CHAMPION_ID_PVE_FERNANDO_FB2 = 2330;
const CHAMPION_ID_PVE_FERNANDO_FB3 = 2329;
const CHAMPION_ID_PVE_FERNANDO_FB4 = 2367;
const CHAMPION_ID_PVE_BUCK_LEAP1 = 2352;
const CHAMPION_ID_PVE_BUCK_LEAP2 = 2351;
const CHAMPION_ID_PVE_BUCK_LEAP3 = 2366;
const CHAMPION_ID_PVE_BUCK_NET1 = 2349;
const CHAMPION_ID_PVE_BUCK_NET2 = 2353;
const CHAMPION_ID_PVE_PIP_POLY1 = 2361;
const CHAMPION_ID_PVE_SKYE_POISON = 2336;
const STARTER_DECK_BARIK = 769;
const STARTER_DECK_CASSIE = 770;
const STARTER_DECK_EVIE = 772;
const STARTER_DECK_FERNANDO = 771;
const STARTER_DECK_GROHK = 773;
const STARTER_DECK_BUCK = 774;
const STARTER_DECK_PIP = 775;
const STARTER_DECK_RUCKUS = 776;
const STARTER_DECK_SKYE = 777;
const STARTER_DECK_ANDROXUS = 783;
const COMPLETE_DECK_BARIK = 757;
const COMPLETE_DECK_CASSIE = 758;
const COMPLETE_DECK_EVIE = 760;
const COMPLETE_DECK_FERNANDO = 759;
const COMPLETE_DECK_GROHK = 765;
const COMPLETE_DECK_BUCK = 764;
const COMPLETE_DECK_PIP = 761;
const COMPLETE_DECK_RUCKUS = 762;
const COMPLETE_DECK_SKYE = 763;
const COMPLETE_DECK_ANDROXUS = 782;
const COMPLETE_DECK_GROVER = 796;
const COMPLETE_DECK_KINESSA = 793;
const LOCAL_SILHOUETTE_RED = 1.0f;
const LOCAL_SILHOUETTE_GREEN = 0.7f;
const LOCAL_SILHOUETTE_BLUE = 0.1875f;
const LOCAL_SILHOUETTE_ALPHA = 0.25f;
const FRIENDLY_SILHOUETTE_RED = 0.0f;
const FRIENDLY_SILHOUETTE_GREEN = 1.0f;
const FRIENDLY_SILHOUETTE_BLUE = 1.0f;
const FRIENDLY_SILHOUETTE_ALPHA = 0.25f;
const ENEMY_SILHOUETTE_RED = 1.0f;
const ENEMY_SILHOUETTE_GREEN = 0.0f;
const ENEMY_SILHOUETTE_BLUE = 0.0f;
const ENEMY_SILHOUETTE_ALPHA = 0.25f;
const WALL_HACK_DIST_SQ = 64000000;
const SIMPROJ_VECTOR_MUNGE_FACTOR = 100;

enum INITIALIZEABLE_BOOL
{
    IBOOL_UNINITIALIZED,            // 0
    IBOOL_FALSE,                    // 1
    IBOOL_TRUE,                     // 2
    IBOOL_MAX                       // 3
};

enum GAME_WIN_STATE
{
    GWS_NONE,                       // 0
    GWS_TASKFORCE_TWO_WON,          // 1
    GWS_TASKFORCE_ONE_WON,          // 2
    GWS_TIE,                        // 3
    GWS_MAX                         // 4
};

enum TG_GAME_TYPE
{
    TGT_UNSET,                      // 0
    TGT_CITY,                       // 1
    TGT_ARENA,                      // 2
    TGT_ARENA_PRACTICE,             // 3
    TGT_ARENA_CAPTURE,              // 4
    TGT_ARENA_ESCORT,               // 5
    TGT_ARENA_ESCORT_PRACTICE,      // 6
    TGT_BATTLE,                     // 7
    TGT_BATTLE_EXPERT,              // 8
    TGT_BATTLE_PRACTICE,            // 9
    TGT_BATTLE_JOUST,               // 10
    TGT_BATTLE_CASUAL,              // 11
    TGT_BATTLE_TRAINING,            // 12
    TGT_BATTLE_ARAM,                // 13
    TGT_BATTLE_ARAM_PRACTICE,       // 14
    TGT_POINTCAPTURE,               // 15
    TGT_DOMINATION,                 // 16
    TGT_SINGLEPOINTCAPTUREANDHOLD,  // 17
    TGT_IDOL,                       // 18
    TGT_SIEGE,                      // 19
    TGT_BATTLE_TC,                  // 20
    TGT_BATTLE_SHOOTINGRANGE,       // 21
    TGT_CHAOS,                      // 22
    TGT_CHAOS_PRACTICE,             // 23
    TGT_CHAOSRACE,                  // 24
    TGT_CHAOS_PUSH,                 // 25
    TGT_CHAOS_PAYLOAD,              // 26
    TGT_CHAOS_PAYLOAD_PRACTICE,     // 27
    TGT_CHAOS_CAPTUREANDPAYLOAD,    // 28
    TGT_CHAOS_CAPTUREANDPAYLOAD_PRACTICE,// 29
    TGT_CHAOS_CAPTUREPOINT,         // 30
    TGT_CHAOS_CAPTUREPOINT_PRACTICE,// 31
    TGT_CHAOS_SURVIVAL,             // 32
    TGT_CHAOS_SURVIVAL_PRACTICE,    // 33
    TGT_CHAOS_SHOOTINGRANGE,        // 34
    TGT_CHAOS_TUTORIAL,             // 35
    TGT_CHAOS_PVE,                  // 36
    TGT_CHAOS_PVE_SURVIVAL,         // 37
    TGT_CHAOS_TEAM_DEATH_MATCH,     // 38
    TGT_CHAOS_ONSLAUGHT,            // 39
    TGT_MAX                         // 40
};

enum GameTimerState
{
    TGMTS_UNSET,                    // 0
    TGMTS_WAITING_FOR_PLAYERS,      // 1
    TGMTS_SETUP,                    // 2
    TGMTS_MISSION_RUNNING,          // 3
    TGMTS_MISSION_OVERTIME,         // 4
    TGMTS_MISSION_COMPLETE,         // 5
    TGMTS_MISSION_PAUSED,           // 6
    TGMTS_CUSTOM,                   // 7
    TGMTS_ROUND_COMPLETE,           // 8
    TGMTS_MAX                       // 9
};

enum DeviceTargetMode
{
    TGDTM_Self,                     // 0
    TGDTM_Reticle,                  // 1
    TGDTM_Projectile,               // 2
    TGDTM_AOE,                      // 3
    TGDTM_Ground,                   // 4
    TGDTM_Cone,                     // 5
    TGDTM_Linear,                   // 6
    TGDTM_LockOn,                   // 7
    TGDTM_SpawnPoint,               // 8
    TGDTM_WorldMap,                 // 9
    TGDTM_ReticleFindSpot,          // 10
    TGDTM_MAX                       // 11
};

enum DAMAGE_INFO_TYPE
{
    DIT_None,                       // 0
    DIT_Death,                      // 1
    DIT_Damage,                     // 2
    DIT_Status,                     // 3
    DIT_Healing,                    // 4
    DIT_ManaBurn,                   // 5
    DIT_ManaRestore,                // 6
    DIT_Objective,                  // 7
    DIT_Experience,                 // 8
    DIT_Currency,                   // 9
    DIT_Level,                      // 10
    DIT_CritDamage,                 // 11
    DIT_HeadShot,                   // 12
    DIT_Backstab,                   // 13
    DIT_KillingBlow,                // 14
    DIT_Assist,                     // 15
    DIT_KillingBlowWrath,           // 16
    DIT_ShieldDamage,               // 17
    DIT_MAX                         // 18
};

enum ITEM_EVENT_TYPE
{
    IET_None,                       // 0
    IET_CastStart,                  // 1
    IET_CastComplete,               // 2
    IET_CastInterrupt,              // 3
    IET_ItemPurchase,               // 4
    IET_ItemSell,                   // 5
    IET_AbilityPurchase,            // 6
    IET_MAX                         // 7
};

enum PLAYER_COMBAT_EVENT_TYPE
{
    PCET_None,                      // 0
    PCET_Spawn,                     // 1
    PCET_MAX                        // 2
};

enum TgMapTeam
{
    MAPTEAM_1,                      // 0
    MAPTEAM_2,                      // 1
    MAPTEAM_NEUTRAL,                // 2
    MAPTEAM_MAX                     // 3
};

enum MiniMapEntityType
{
    MMap_LocalSpectator,            // 0
    MMap_LocalPlayer,               // 1
    MMap_Player,                    // 2
    MMap_Bot,                       // 3
    MMap_Factory,                   // 4
    MMap_Deployable,                // 5
    MMap_CapturePoint,              // 6
    MMap_ChaosCapturePoint,         // 7
    MMap_MAX                        // 8
};

enum ETargetingLineStyle
{
    TLS_None,                       // 0
    TLS_MAX                         // 1
};

enum ETargetingPreviewStyle
{
    TPS_None,                       // 0
    TPS_MAX                         // 1
};

enum ETargetingReticleStyle
{
    TRS_None,                       // 0
    TRS_MAX                         // 1
};

enum ETargetingHighlightStyle
{
    THS_None,                       // 0
    THS_Highlight,                  // 1
    THS_HighlightAndMark,           // 2
    THS_HighlightAndBracket,        // 3
    THS_HighlightAndBracketWorld,   // 4
    THS_MAX                         // 5
};

enum AlertPriority
{
    APT_Minimal,                    // 0
    APT_Normal,                     // 1
    APT_High,                       // 2
    APT_Critical,                   // 3
    APT_MAX                         // 4
};

enum AlertType
{
    ATT_Regular,                    // 0
    ATT_Beneficial,                 // 1
    ATT_Detrimental,                // 2
    ATT_Spectator,                  // 3
    ATT_Important,                  // 4
    ATT_MAX                         // 5
};

enum OverlayType
{
    OT_UNKNOWN,                     // 0
    OT_LOCALPLAYER,                 // 1
    OT_PLAYER,                      // 2
    OT_DEPLOYABLE,                  // 3
    OT_MAX                          // 4
};

enum MinimapFactoryType
{
    MMF_None,                       // 0
    MMF_Speed,                      // 1
    MMF_Damage,                     // 2
    MMF_Protection,                 // 3
    MMF_Mana,                       // 4
    MMF_Cooldown,                   // 5
    MMF_HealthRegen,                // 6
    MMF_BonusMinions,               // 7
    MMF_Tower,                      // 8
    MMF_Phoenix,                    // 9
    MMF_CapturePoint,               // 10
    MMF_MinorSpawn,                 // 11
    MMF_GoldFury,                   // 12
    MMF_SiegeSpawner,               // 13
    MMF_MAX                         // 14
};

enum DeployableOverlayIcon
{
    DOI_BLANK,                      // 0
    DOI_TURRET,                     // 1
    DOI_GRUMPY_BOMB,                // 2
    DOI_ILLUSION,                   // 3
    DOI_ILLUSION_ULT,               // 4
    DOI_TIME_BOMB,                  // 5
    DOI_POPPY_BOMB,                 // 6
    DOI_MEGA_TURRET,                // 7
    DOI_OPPRESSOR_MINE,             // 8
    DOI_STICKY_BOMB,                // 9
    DOI_FRAG_GRENADE,               // 10
    DOI_DYNAMIC,                    // 11
    DOI_DARK_CONVERGENCE,           // 12
    DOI_SEEDLING,                   // 13
    DOI_MAX                         // 14
};

enum DeployableOverlayState
{
    DOS_IDLE,                       // 0
    DOS_ACTIVE,                     // 1
    DOS_FINISHED,                   // 2
    DOS_MAX                         // 3
};

enum ENPCVoices
{
    NPCVOICE_VendorMale01,          // 0
    NPCVOICE_VendorMale02,          // 1
    NPCVOICE_VendorMale03,          // 2
    NPCVOICE_VendorMale04,          // 3
    NPCVOICE_VendorMale05,          // 4
    NPCVOICE_VendorMale06,          // 5
    NPCVOICE_VendorMale07,          // 6
    NPCVOICE_VendorMale08,          // 7
    NPCVOICE_VendorMale09,          // 8
    NPCVOICE_VendorMale10,          // 9
    NPCVOICE_VendorFemale01,        // 10
    NPCVOICE_VendorFemale02,        // 11
    NPCVOICE_VendorFemale03,        // 12
    NPCVOICE_VendorFemale04,        // 13
    NPCVOICE_VendorFemale05,        // 14
    NPCVOICE_VendorFemale06,        // 15
    NPCVOICE_VendorFemale07,        // 16
    NPCVOICE_VendorFemale08,        // 17
    NPCVOICE_VendorFemale09,        // 18
    NPCVOICE_VendorFemale10,        // 19
    NPCVOICE_MAX                    // 20
};

enum TgSupportedAspectRatios
{
    TgAR_4x3,                       // 0
    TgAR_5x4,                       // 1
    TgAR_16x9,                      // 2
    TgAR_16x10,                     // 3
    TgAR_Other,                     // 4
    TgAR_MAX                        // 5
};

enum eTutorialForceableElements
{
    ETBUI_Skills,                   // 0
    ETBUI_ItemShop,                 // 1
    ETBUI_ItemShopButton,           // 2
    ETBUI_Intro,                    // 3
    ETBUI_ItemShopWalkthrough,      // 4
    ETBUI_ActiveItems,              // 5
    ETBUI_ConsumableItems,          // 6
    ETBUI_Escape,                   // 7
    ETBUI_MAX                       // 8
};

enum TG_EQUIP_POINT
{
    EQP_NONE,                       // 0
    EQP_AUTO,                       // 1
    EQP_OFFHAND_1,                  // 2
    EQP_OFFHAND_2,                  // 3
    EQP_OFFHAND_3,                  // 4
    EQP_CARD_1,                     // 5
    EQP_RECALL,                     // 6
    EQP_EMOTE,                      // 7
    EQP_BURN_CARD_1,                // 8
    EQP_BURN_CARD_2,                // 9
    EQP_BURN_CARD_3,                // 10
    EQP_BURN_CARD_4,                // 11
    EQP_SUPPORT_2,                  // 12
    EQP_REGEN,                      // 13
    EQP_EXHAUSTED,                  // 14
    EQP_ULT_CHARGE,                 // 15
    EQP_ALT_FIRE,                   // 16
    EQP_UNUSED_7,                   // 17
    EQP_SUPPORT,                    // 18
    EQP_CARD_2,                     // 19
    EQP_CARD_3,                     // 20
    EQP_CARD_4,                     // 21
    EQP_CARD_5,                     // 22
    EQP_MOUNT,                      // 23
    EQP_COMBO,                      // 24
    EQP_MVPPOSE,                    // 25
    EQP_TALENT,                     // 26
    EQP_ITEM_STORE_9,               // 27
    EQP_ITEM_STORE_10,              // 28
    EQP_ITEM_STORE_11,              // 29
    EQP_ITEM_STORE_12,              // 30
    EQP_ITEM_STORE_13,              // 31
    EQP_ITEM_STORE_14,              // 32
    EQP_MAX                         // 33
};

enum EDeviceFailType
{
    DFT_None,                       // 0
    DFT_Unspecified,                // 1
    DFT_Custom,                     // 2
    DFT_NotEnoughPower,             // 3
    DFT_OnCooldown,                 // 4
    DFT_CannotPlace,                // 5
    DFT_Stunned,                    // 6
    DFT_Silenced,                   // 7
    DFT_Disarmed,                   // 8
    DFT_Crippled,                   // 9
    DFT_FireLockout,                // 10
    DFT_InCombat,                   // 11
    DFT_FullHealth,                 // 12
    DFT_NotOnGround,                // 13
    DFT_NoAmmo,                     // 14
    DFT_TransitioningTo1p,          // 15
    DFT_MAX                         // 16
};

enum EUISettingUpdate
{
    UISU_All,                       // 0
    UISU_AudioVideo,                // 1
    UISU_Interface,                 // 2
    UISU_Control,                   // 3
    UISU_Targeting,                 // 4
    UISU_Gamepad,                   // 5
    UISU_MAX                        // 6
};

enum PING_TYPE
{
    PT_NORMAL,                      // 0
    PT_NORMAL_ENEMY,                // 1
    PT_RETREAT,                     // 2
    PT_RETREAT_ENEMY,               // 3
    PT_ALERT,                       // 4
    PT_ALERT_ENEMY,                 // 5
    PT_SENTINEL,                    // 6
    PT_SENTINEL_ENEMY,              // 7
    PT_ALERT_SILENT,                // 8
    PT_MAX                          // 9
};

enum RecoilHitDir
{
    RECOIL_DIR_FromFront,           // 0
    RECOIL_DIR_FromBack,            // 1
    RECOIL_DIR_FromLeft,            // 2
    RECOIL_DIR_FromRight,           // 3
    RECOIL_DIR_MAX                  // 4
};

enum HitReactionMoveType
{
    HIT_MOVE_TYPE_ALL,              // 0
    HIT_MOVE_TYPE_IDLE,             // 1
    HIT_MOVE_TYPE_MOVING,           // 2
    HIT_MOVE_TYPE_MAX               // 3
};

enum GOD_PANTHEON
{
    PANTHEON_None,                  // 0
    PANTHEON_Egyptian,              // 1
    PANTHEON_Norse,                 // 2
    PANTHEON_Greek,                 // 3
    PANTHEON_Roman,                 // 4
    PANTHEON_Chinese,               // 5
    PANTHEON_Mayan,                 // 6
    PANTHEON_Hindu,                 // 7
    PANTHEON_MAX                    // 8
};

enum ERewardValueType
{
    RVT_None,                       // 0
    RVT_Initial,                    // 1
    RVT_Spool,                      // 2
    RVT_Kill,                       // 3
    RVT_Assist,                     // 4
    RVT_Taken,                      // 5
    RVT_Healing,                    // 6
    RVT_Mitigated,                  // 7
    RVT_Damage,                     // 8
    RVT_Objective,                  // 9
    RVT_Captured,                   // 10
    RVT_Capturing,                  // 11
    RVT_Contesting,                 // 12
    RVT_Destroyed,                  // 13
    RVT_PushingPayload,             // 14
    RVT_ContestingPayload,          // 15
    RVT_RoundWon,                   // 16
    RVT_SuccessfulDefense,          // 17
    RVT_SuccessfulPush,             // 18
    RVT_Cheat,                      // 19
    RVT_Bounty,                     // 20
    RVT_MAX                         // 21
};

enum EPurchaseFailure
{
    TGPF_None,                      // 0
    TGPF_UnknownItem,               // 1
    TGPF_UnavailableItem,           // 2
    TGPF_UnknownOwner,              // 3
    TGPF_NotEnoughCurrency,         // 4
    TGPF_AtStackLimit,              // 5
    TGPF_AlreadyPurchased,          // 6
    TGPF_NoAvailableSlots,          // 7
    TGPF_InvalidUpgrade,            // 8
    TGPF_CannotSell,                // 9
    TGPF_CannotSellInUse,           // 10
    TGPF_Unknown,                   // 11
    TGPF_MAX                        // 12
};

enum EReticuleType
{
    RETICULE_None,                  // 0
    RETICULE_Circle,                // 1
    RETICULE_Drop,                  // 2
    RETICULE_Precise,               // 3
    RETICULE_Wide,                  // 4
    RETICULE_Chain,                 // 5
    RETICULE_ShaLin,                // 6
    RETICULE_Cross,                 // 7
    RETICULE_Maeve,                 // 8
    RETICULE_MAX                    // 9
};

enum EAbilityInfoSlot
{
    SLOT_Ability1,                  // 0
    SLOT_Ability2,                  // 1
    SLOT_Ability3,                  // 2
    SLOT_Perk1,                     // 3
    SLOT_Perk2,                     // 4
    SLOT_Perk3,                     // 5
    SLOT_Perk4,                     // 6
    SLOT_Perk5,                     // 7
    SLOT_Perk6,                     // 8
    SLOT_Perk7,                     // 9
    SLOT_Perk8,                     // 10
    SLOT_Perk9,                     // 11
    SLOT_Perk10,                    // 12
    SLOT_Perk11,                    // 13
    SLOT_Perk12,                    // 14
    SLOT_Perk13,                    // 15
    SLOT_Perk14,                    // 16
    SLOT_MAX                        // 17
};

enum ECardOwner
{
    CARDOWNER_NONE,                 // 0
    CARDOWNER_FREE,                 // 1
    CARDOWNER_SELF,                 // 2
    CARDOWNER_TEAM,                 // 3
    CARDOWNER_MAX                   // 4
};

enum EUITargetingType
{
    UITARGETING_None,               // 0
    UITARGETING_PendingRocketLockOn,// 1
    UITARGETING_RocketLockOn,       // 2
    UITARGETING_MAX                 // 3
};

enum ELanePusherActionPoint
{
    LPAP_None,                      // 0
    LPAP_OuterWall,                 // 1
    LPAP_InnerWall,                 // 2
    LPAP_BaseObjective,             // 3
    LPAP_Checkpoint1,               // 4
    LPAP_Checkpoint2,               // 5
    LPAP_Goal,                      // 6
    LPAP_PayloadBegin,              // 7
    LPAP_MAX                        // 8
};

enum ELobbyAnimState
{
    LobbyAnimState_None,            // 0
    LobbyAnimState_Intro,           // 1
    LobbyAnimState_Emote,           // 2
    LobbyAnimState_MVP,             // 3
    LobbyAnimState_MAX              // 4
};

enum EMountType
{
    MOUNT_None,                     // 0
    MOUNT_Horse,                    // 1
    MOUNT_HorseTest,                // 2
    MOUNT_MAX                       // 3
};

enum EGameEnvironmentRule
{
    GameEnvRule_Normal,             // 0
    GameEnvRule_Chill,              // 1
    GameEnvRule_Foggy,              // 2
    GameEnvRule_HeatWave,           // 3
    GameEnvRule_MAX                 // 4
};

enum EGameRespawnRule
{
    GameRespawnRule_Normal,         // 0
    GameRespawnRule_Phoenix,        // 1
    GameRespawnRule_GrimReaper,     // 2
    GameRespawnRule_MAX             // 3
};

enum EGameMode
{
    GameMode_Siege,                 // 0
    GameMode_Survival,              // 1
    GameMode_CapturePoint,          // 2
    GameMode_MAX                    // 3
};

enum EPolymorphType
{
    Polymorph_None,                 // 0
    Polymorph_Chicken,              // 1
    Polymorph_MAX                   // 2
};

enum EPetPhase
{
    PETPHASE_Default,               // 0
    PETPHASE_CodeOverride,          // 1
    PETPHASE_Heel,                  // 2
    PETPHASE_Follow,                // 3
    PETPHASE_Guard,                 // 4
    PETPHASE_MAX                    // 5
};

enum EPetPosition
{
    PETPOS_Default,                 // 0
    PETPOS_Front,                   // 1
    PETPOS_FrontRight,              // 2
    PETPOS_Right,                   // 3
    PETPOS_BackRight,               // 4
    PETPOS_Back,                    // 5
    PETPOS_BackLeft,                // 6
    PETPOS_Left,                    // 7
    PETPOS_FrontLeft,               // 8
    PETPOS_MAX                      // 9
};

enum EPlayOfTheGameEventType
{
    POTG_ScoreKill,                 // 0
    POTG_ScoreAssist,               // 1
    POTG_MovementAbility,           // 2
    POTG_OvertimeStarted,           // 3
    POTG_Died,                      // 4
    POTG_RoundEnded,                // 5
    POTG_Healing,                   // 6
    POTG_HealingSelf,               // 7
    POTG_Damage,                    // 8
    POTG_EnvironmentKill,           // 9
    POTG_Shielding,                 // 10
    POTG_DamagePrevented,           // 11
    POTG_DamagePreventedSelf,       // 12
    POTG_HeadShot,                  // 13
    POTG_ContestTime,               // 14
    POTG_ObjectiveTime,             // 15
    POTG_CrowdControlSoft,          // 16
    POTG_CrowdControlHard,          // 17
    POTG_MAX                        // 18
};

enum EThreatLevel
{
    ThreatLevel_Invalid,            // 0
    ThreatLevel_None,               // 1
    ThreatLevel_Low,                // 2
    ThreatLevel_Medium,             // 3
    ThreatLevel_High,               // 4
    ThreatLevel_MAX                 // 5
};

enum EPedestalType
{
    PEDESTAL_FrontLine,             // 0
    PEDESTAL_Flank,                 // 1
    PEDESTAL_Support,               // 2
    PEDESTAL_Damager,               // 3
    PEDESTAL_MAX                    // 4
};

enum EModelHighlightType
{
    HIGHLIGHT_None,                 // 0
    HIGHLIGHT_Body,                 // 1
    HIGHLIGHT_Head,                 // 2
    HIGHLIGHT_Weapon,               // 3
    HIGHLIGHT_MAX                   // 4
};

enum EWeaponMeshSwapRetrieveStrategy
{
    WMSRS_None,                     // 0
    WMSRS_Normal,                   // 1
    WMSRS_PostFire,                 // 2
    WMSRS_MAX                       // 3
};

enum EDamageLocationType
{
    DamageLocationType_None,        // 0
    DamageLocationType_Torso,       // 1
    DamageLocationType_LLeg,        // 2
    DamageLocationType_RLeg,        // 3
    DamageLocationType_LArm,        // 4
    DamageLocationType_RArm,        // 5
    DamageLocationType_Head,        // 6
    DamageLocationType_MAX          // 7
};

struct native EquipDeviceInfo
{
    var int nDeviceId;
    var int nDeviceInstanceId;
    var int nMode;

    structdefaultproperties
    {
        nDeviceId=0
        nDeviceInstanceId=0
        nMode=0
    }
};

struct native AimData
{
    var Vector StartTrace;
    var Vector EndTrace;
    var Vector AimVector;
    var Actor HitActor;
    var float ClientMovementTimeStamp;
    var bool bResult;

    structdefaultproperties
    {
        StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        EndTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        AimVector=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        HitActor=none
        ClientMovementTimeStamp=0.0000000
        bResult=false
    }
};

struct native ObjectiveMICInfo
{
    var int MyTeam;
    var float AmountFilled;
    var int ObjStatus;
    var int IsContested;
    var int Flip;

    structdefaultproperties
    {
        MyTeam=0
        AmountFilled=0.0000000
        ObjStatus=0
        IsContested=0
        Flip=0
    }
};

struct native MeshAssets
{
    var() string m_sSkeletalMesh;
    var() string m_sPhysicsAsset;
    var() string m_sAnimTreeTemplate;
    var() string m_sAnimSets;

    structdefaultproperties
    {
        m_sSkeletalMesh=""
        m_sPhysicsAsset=""
        m_sAnimTreeTemplate=""
        m_sAnimSets=""
    }
};

struct native RewardInfo
{
    var const int RequestedReward;
    var int BoostReward;
    var int ActualReward;
    var int ActualRewardAccum;
    var int BoostRewardAccum;
    var int ErrorMessage;

    structdefaultproperties
    {
        RequestedReward=0
        BoostReward=0
        ActualReward=0
        ActualRewardAccum=0
        BoostRewardAccum=0
        ErrorMessage=0
    }
};

struct native DateTimeWrapper
{
    var QWord qTime;

    structdefaultproperties
    {
        qTime=()
    }
};

struct native TG_HUD_INFO
{
    var bool bEnemy;
    var bool bShowNameplate;
    var bool bShowOverlays;
    var bool bIsTargeted;
    var bool bLocalPlayerHasLOS;

    structdefaultproperties
    {
        bEnemy=false
        bShowNameplate=false
        bShowOverlays=false
        bIsTargeted=false
        bLocalPlayerHasLOS=false
    }
};

struct native ScoreKillData
{
    var Controller Killer;
    var TgRepInfo_Player KillerPRI;
    var TgPawn KillerPawn;
    var native Pointer KillerBotAssembly;
    var bool bKillerIsGod;
    var bool bKillerIsMinion;
    var bool bKillerIsTower;
    var Controller Victim;
    var TgPawn VictimPawn;
    var TgRepInfo_Player VictimPRI;
    var TgRepInfo_TaskForce VictimTaskForce;
    var native Pointer VictimBotAssembly;
    var bool VictimCanScore;
    var bool bVictimIsGod;
    var bool bVictimIsMinion;
    var bool bVictimIsTower;
    var Controller Scorer;
    var TgPawn ScorerPawn;
    var TgRepInfo_Player ScorerPRI;
    var TgRepInfo_TaskForce ScorerTaskForce;
    var bool ScorerCanScore;
    var bool bSuicide;
    var init array<init TgRepInfo_Player> AssistingPlayers;

    structdefaultproperties
    {
        Killer=none
        KillerPRI=none
        KillerPawn=none
        bKillerIsGod=false
        bKillerIsMinion=false
        bKillerIsTower=false
        Victim=none
        VictimPawn=none
        VictimPRI=none
        VictimTaskForce=none
        VictimCanScore=false
        bVictimIsGod=false
        bVictimIsMinion=false
        bVictimIsTower=false
        Scorer=none
        ScorerPawn=none
        ScorerPRI=none
        ScorerTaskForce=none
        ScorerCanScore=false
        bSuicide=false
        AssistingPlayers=none
    }
};

struct native OffhandAnimation
{
    var name m_OffhandUseType;
    var() name m_AnimName;
    var() bool m_bFullBody;

    structdefaultproperties
    {
        m_OffhandUseType="None"
        m_AnimName="None"
        m_bFullBody=false
    }
};

struct native sPingInfo
{
    var TgRepInfo_Player pingedPri;
    var float fStartTime;
    var Vector vPingedLoc;
    var bool bPinging;
    var TgObject.PING_TYPE eType;

    structdefaultproperties
    {
        pingedPri=none
        fStartTime=0.0000000
        vPingedLoc=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        bPinging=false
        eType=PING_TYPE.PT_NORMAL
    }
};

struct native ExtraDamageInfo
{
    var bool bCritical;
    var bool bHeadShot;
    var bool bKillingBlow;
    var bool bCombo;
    var bool bLatent;
    var bool bMarked;
    var bool bNoInstigator;

    structdefaultproperties
    {
        bCritical=false
        bHeadShot=false
        bKillingBlow=false
        bCombo=false
        bLatent=false
        bMarked=false
        bNoInstigator=false
    }
};

struct native OnDamagedParams
{
    var TgPawn attacker;
    var TgDevice Dev;
    var TgEffectGroup eg;
    var ImpactInfo Impact;
    var float fBuffedDamage;
    var float fMitigatedDamage;
    var float fPreDamageHealth;
    var ExtraDamageInfo ExtraInfo;
    var int nPropertyId;

    structdefaultproperties
    {
        attacker=none
        Dev=none
        eg=none
        Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0)
        fBuffedDamage=0.0000000
        fMitigatedDamage=0.0000000
        fPreDamageHealth=0.0000000
        ExtraInfo=(bCritical=false,bHeadShot=false,bKillingBlow=false,bCombo=false,bLatent=false,bMarked=false,bNoInstigator=false)
        nPropertyId=0
    }
};

struct native OnHealedParams
{
    var TgPawn Healer;
    var TgDevice Dev;
    var TgEffectGroup eg;
    var ImpactInfo Impact;
    var float fHealAmount;
    var float fHealthChange;
    var int nPropertyId;
    var bool bPlayCameraHealEffect;

    structdefaultproperties
    {
        Healer=none
        Dev=none
        eg=none
        Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0)
        fHealAmount=0.0000000
        fHealthChange=0.0000000
        nPropertyId=0
        bPlayCameraHealEffect=false
    }
};

struct native AdjustDamageParams
{
    var TgDevice Dev;
    var ImpactInfo Impact;
    var float fBaseDamage;
    var int nPropertyId;
    var bool bCritical;

    structdefaultproperties
    {
        Dev=none
        Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0)
        fBaseDamage=0.0000000
        nPropertyId=0
        bCritical=false
    }
};

struct native AdjustHealParams
{
    var TgDevice Dev;
    var ImpactInfo Impact;
    var float fBaseHeal;
    var int nPropertyId;

    structdefaultproperties
    {
        Dev=none
        Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0)
        fBaseHeal=0.0000000
        nPropertyId=0
    }
};

struct native ChargeHitInfo
{
    var Actor HitActor;
    var float TimeStamp;

    structdefaultproperties
    {
        HitActor=none
        TimeStamp=0.0000000
    }
};

struct native TgAbilityInfo
{
    var int DeviceIds[EAbilityInfoSlot];

    structdefaultproperties
    {
        DeviceIds[0]=0
        DeviceIds[1]=0
        DeviceIds[2]=0
        DeviceIds[3]=0
        DeviceIds[4]=0
        DeviceIds[5]=0
        DeviceIds[6]=0
        DeviceIds[7]=0
        DeviceIds[8]=0
        DeviceIds[9]=0
        DeviceIds[10]=0
        DeviceIds[11]=0
        DeviceIds[12]=0
        DeviceIds[13]=0
        DeviceIds[14]=0
        DeviceIds[15]=0
        DeviceIds[16]=0
    }
};

struct native CardInfo
{
    var int Id;
    var int Count;
    var int Owner;
    var init string sOwner;

    structdefaultproperties
    {
        Id=0
        Count=0
        Owner=0
        sOwner=""
    }
};

struct native WeaponMeshSwapStrategy
{
    var bool bPlayPutAway;
    var TgObject.EWeaponMeshSwapRetrieveStrategy RetrieveStrategy;
    var bool bClearEquipPoint;

    structdefaultproperties
    {
        bPlayPutAway=false
        RetrieveStrategy=EWeaponMeshSwapRetrieveStrategy.WMSRS_None
        bClearEquipPoint=true
    }
};

event IsFriendlyWithLocalPawn()
{
    //return;    
}

event SortDamageDisplay()
{
    //return;    
}

event InitializeDefaultProps()
{
    //return;    
}

event SetTaskForceNumber()
{
    //return;    
}

event StartFire()
{
    //return;    
}

// Export UTgObject::execScriptGetLocalTGPlayerController(FFrame&, void* const)
native static function TgPlayerController ScriptGetLocalTGPlayerController();
