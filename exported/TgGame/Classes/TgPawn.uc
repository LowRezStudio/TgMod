class TgPawn extends GamePawn
    abstract
    native(Pawns)
    nativereplication
    config(Game)
    hidecategories(Navigation)
    implements(TgSkinnableInterface,TgCombatActor,TgObserver_ViewTargetChanged,TgInteractiveAudio);

const TG_MAX_FLASH_EVENTS = 32;
const TG_MIN_RELOAD_SCALE = 0.4f;
const TG_PHYSICALITY_NON_STRUCTURES = 860;
const TG_PHYSICALITY_STRUCTURES = 861;
const TG_PHYSICALITY_PLAYERS = 10034;
const TG_PHYSICALITY_MECHANICALS = 10035;
const TG_PHYSICALITY_DECOYS = 15046;
const TG_PHYSICALITY_PLAYERS_AND_DECOYS = 15047;
const TG_PHYSICALITY_MECHANICALS_AND_DECOYS = 15050;
const TG_SPAWNFX_VALID_DURATION = 5;
const TG_VOLUME_STEALTH_FADE_TIME = 1.0f;
const TG_DISTANCE_FADE_TIME = 1.0f;
const TG_DEFAULT_WINE_MIC = 2430;
const TG_COMBAT_DURATION = 5.0;
const TG_STILL_THRESHOLD = 1.0;
const TG_STILL_DURATION = 5.0;
const TG_CARD_COOLDOWN_ON_DEATH = false;
const MAX_OBSCURING_DEPLOYABLES = 10;
const MAX_BLINDING_DEPLOYABLES = 10;
const MAX_VISIBLE_THROUGH_WALL_INSTIGATORS = 12;
const MAX_VISIBLE_THROUGH_STEALTH_INSTIGATORS = 12;
const TG_PAWN_POLYMORPH_CHICKEN_MESH_ID = 5599;
const TG_PAWN_POLYMORPH_OUT_FX_ID = 6674;
const TG_PAWN_POLYMORPH_IN_FX_ID = 6675;
const PHYS_TWEEN_FLAG_COLLIDE_WITH_WORLD = 1;
const PHYS_TWEEN_FLAG_ROTATE_TOWARDS_TARGET = 2;
const TG_EQP_POINT_MAX = 33;
const GLOBAL_OFFHAND_COOLDOWN = 5.0;
const GLOBAL_OFFHAND_CLIENT_COOLDOWN = 5.1;
const MAX_DEVICE_EQPOINT = 15;
const MAX_NUM_DEPLOYED_BOTS = 3;
const MAX_NUM_PETS = 8;
const TG_ASSIST_TIMEOUT = 5;
const TG_ASSIST_TIMEOUT_OBJ = 10;
const PLAYER_NOT_TAGGED = -1;
const GAMEEVENT_PALADINS_PLAYER_KILL = 1001;
const GAMEEVENT_PALADINS_PLAYER_DEATH = 1002;
const GAMEEVENT_PALADINS_PLAYER_KILL_SUICIDE = 2001;
const GAMEEVENT_PALADINS_PLAYER_KILL_NORMAL = 2002;
const GAMEEVENT_PALADINS_PLAYER_KILL_ASSIST = 2003;
const GAMEEVENT_MATCH_STARTED = 0;
const GAMEEVENT_MATCH_ENDED = 1;
const GAMEEVENT_ROUND_STARTED = 2;
const GAMEEVENT_ROUND_ENDED = 3;
const GAMEEVENT_GAME_CLASS = 6;
const GAMEEVENT_GAME_OPTION_URL = 7;
const GAMEEVENT_GAME_MAPNAME = 8;
const GAMEEVENT_MEMORYUSAGE_POLL = 35;
const GAMEEVENT_FRAMERATE_POLL = 36;
const GAMEEVENT_NETWORKUSAGEIN_POLL = 37;
const GAMEEVENT_NETWORKUSAGEOUT_POLL = 38;
const GAMEEVENT_PING_POLL = 39;
const GAMEEVENT_RENDERTHREAD_POLL = 40;
const GAMEEVENT_GAMETHREAD_POLL = 41;
const GAMEEVENT_GPUFRAMETIME_POLL = 42;
const GAMEEVENT_FRAMETIME_POLL = 43;
const GAMEEVENT_TEAM_CREATED = 50;
const GAMEEVENT_TEAM_GAME_SCORE = 51;
const GAMEEVENT_TEAM_MATCH_WON = 4;
const GAMEEVENT_TEAM_ROUND_WON = 5;
const GAMEEVENT_TEAM_ROUND_STALEMATE = 52;
const GAMEEVENT_PLAYER_LOGIN = 100;
const GAMEEVENT_PLAYER_LOGOUT = 101;
const GAMEEVENT_PLAYER_SPAWN = 102;
const GAMEEVENT_PLAYER_MATCH_WON = 103;
const GAMEEVENT_PLAYER_KILL = 104;
const GAMEEVENT_PLAYER_LOCATION_POLL = 105;
const GAMEEVENT_PLAYER_TEAMCHANGE = 106;
const GAMEEVENT_PLAYER_KILL_STREAK = 107;
const GAMEEVENT_PLAYER_DEATH = 108;
const GAMEEVENT_PLAYER_ROUND_WON = 109;
const GAMEEVENT_PLAYER_ROUND_STALEMATE = 110;
const GAMEEVENT_WEAPON_DAMAGE = 150;
const GAMEEVENT_WEAPON_DAMAGE_MELEE = 151;
const GAMEEVENT_WEAPON_FIRED = 152;
const GAMEEVENT_PLAYER_KILL_NORMAL = 200;
const GAMEEVENT_GENERIC_PARAM_LIST_START = 300;
const GAMEEVENT_GENERIC_PARAM_LIST_END = 400;
const GAMEEVENT_GAME_SPECIFIC = 1000;
const GAMEEVENT_MAX_EVENTID = 0x0000FFFF;

enum ETweenState
{
    TWEEN_None,                     // 0
    TWEEN_Default,                  // 1
    TWEEN_DefaultImmune,            // 2
    TWEEN_TimedKnockup,             // 3
    TWEEN_Damagable,                // 4
    TWEEN_MAX                       // 5
};

enum EGrabState
{
    GRAB_None,                      // 0
    GRAB_ShellSpin,                 // 1
    GRAB_LazarusRush,               // 2
    GRAB_MAX                        // 3
};

enum EChargeState
{
    CHARGE_None,                    // 0
    CHARGE_NoTurn,                  // 1
    CHARGE_NoTurn_RotPawn,          // 2
    CHARGE_NoTurnBackwards,         // 3
    CHARGE_Turn,                    // 4
    CHARGE_Fairy,                   // 5
    CHARGE_MAX                      // 6
};

enum EEmote
{
    EMOTE_None,                     // 0
    EMOTE_Taunt,                    // 1
    EMOTE_Joke,                     // 2
    EMOTE_Laugh,                    // 3
    EMOTE_Health_Low,               // 4
    EMOTE_Kill_Streak,              // 5
    EMOTE_Intro,                    // 6
    EMOTE_Death,                    // 7
    EMOTE_DeathGrunt,               // 8
    EMOTE_DeathFall,                // 9
    EMOTE_FirstBlood,               // 10
    EMOTE_Weapon_1,                 // 11
    EMOTE_Weapon_2,                 // 12
    EMOTE_Ability1,                 // 13
    EMOTE_Ability2,                 // 14
    EMOTE_Ability3,                 // 15
    EMOTE_AbilityUltimate,          // 16
    EMOTE_Mount,                    // 17
    EMOTE_SetOnFire,                // 18
    EMOTE_StunnedOrFrozen,          // 19
    EMOTE_Kill,                     // 20
    EMOTE_KillSiegeEngine,          // 21
    EMOTE_KillGate,                 // 22
    EMOTE_LevelUp,                  // 23
    EMOTE_Victory,                  // 24
    EMOTE_Defeat,                   // 25
    EMOTE_PickWeaponCard,           // 26
    EMOTE_PickArmorCard,            // 27
    EMOTE_PickAbilityCard,          // 28
    EMOTE_KillAssist,               // 29
    EMOTE_UniqueCombat,             // 30
    EMOTE_KillAbility1,             // 31
    EMOTE_KillAbility2,             // 32
    EMOTE_CapturePoint,             // 33
    EMOTE_TakingDamage,             // 34
    EMOTE_EnemyCapturingPoint,      // 35
    EMOTE_OnPointAndFiring,         // 36
    EMOTE_HealedByTeammate,         // 37
    EMOTE_AbilityOnCooldown,        // 38
    EMOTE_Mastery1,                 // 39
    EMOTE_Mastery9,                 // 40
    EMOTE_Mastery12,                // 41
    EMOTE_Mastery15,                // 42
    EMOTE_Train,                    // 43
    EMOTE_GruntHit,                 // 44
    EMOTE_GruntJump,                // 45
    EMOTE_BehindUs,                 // 46
    EMOTE_AboveUs,                  // 47
    EMOTE_Sniper,                   // 48
    EMOTE_MAX                       // 49
};

enum EEmoteCategory
{
    EMOTECAT_None,                  // 0
    EMOTECAT_PlayerVGS,             // 1
    EMOTECAT_AbilityOnCooldown,     // 2
    EMOTECAT_TakingDamage,          // 3
    EMOTECAT_Celebration,           // 4
    EMOTECAT_Kills,                 // 5
    EMOTECAT_Action,                // 6
    EMOTECAT_Context,               // 7
    EMOTECAT_Ultimate,              // 8
    EMOTECAT_Override,              // 9
    EMOTECAT_Movement,              // 10
    EMOTECAT_MAX                    // 11
};

enum EHitAudioCue
{
    CUEHIT_None,                    // 0
    CUEHIT_Pain,                    // 1
    CUEHIT_FromAbove,               // 2
    CUEHIT_FromBehind,              // 3
    CUEHIT_Sniper,                  // 4
    CUEHIT_MAX                      // 5
};

enum TG_DEATH_REASON
{
    DR_NORMAL,                      // 0
    DR_DESPAWN,                     // 1
    DR_RECONNECT,                   // 2
    DR_FREEZE_GIB,                  // 3
    DR_LEX_EXECUTE,                 // 4
    DR_MAX                          // 5
};

enum TG_REP_DEVICE_STATE
{
    RDS_INACTIVE,                   // 0
    RDS_FIRING,                     // 1
    RDS_GENERIC1,                   // 2
    RDS_GENERIC2,                   // 3
    RDS_MAX                         // 4
};

enum STEALTH_TYPE
{
    STEALTH_TYPE_NONE,              // 0
    STEALTH_TYPE_PULSED,            // 1
    STEALTH_TYPE_FADING,            // 2
    STEALTH_TYPE_INSTANT,           // 3
    STEALTH_TYPE_NO_REVEAL,         // 4
    STEALTH_TYPE_MAX                // 5
};

enum TG_POSTURE
{
    TG_POSTURE_DEFAULT,             // 0
    TG_POSTURE_REST,                // 1
    TG_POSTURE_FUSSY,               // 2
    TG_POSTURE_INTRO,               // 3
    TG_POSTURE_ENRAGED,             // 4
    TG_POSTURE_PATROL,              // 5
    TG_POSTURE_GENERICFIRE1,        // 6
    TG_POSTURE_GENERICFIRE2,        // 7
    TG_POSTURE_GENERICFIRE3,        // 8
    TG_POSTURE_DEAD,                // 9
    TG_POSTURE_SEARCHING,           // 10
    TG_POSTURE_FALLING,             // 11
    TG_POSTURE_MOUNT,               // 12
    TG_POSTURE_STASIS,              // 13
    TG_POSTURE_KNOCKBACK,           // 14
    TG_POSTURE_MESMERIZE,           // 15
    TG_POSTURE_DISARMED,            // 16
    TG_POSTURE_SCARED,              // 17
    TG_POSTURE_STUNNED,             // 18
    TG_POSTURE_PULLED,              // 19
    TG_POSTURE_NONE,                // 20
    TG_POSTURE_MAX                  // 21
};

enum TG_PlaySpecialEffect
{
    PLAYFX_Heal,                    // 0
    PLAYFX_RUberLaser,              // 1
    PLAYFX_LUberLaser,              // 2
    PLAYFX_SiegeWallImpact,         // 3
    PLAYFX_GAMMARAY_BUILDUP,        // 4
    PLAYFX_GAMMARAY_FIRE,           // 5
    PLAYFX_Jump,                    // 6
    PLAYFX_SpecialJump,             // 7
    PLAYFX_Land,                    // 8
    PLAYFX_Teleport,                // 9
    PLAYFX_PreTeleport,             // 10
    PLAYFX_Flourish,                // 11
    PLAYFX_MAX                      // 12
};

enum TG_TELEPORT_STATE
{
    TELEPORT_NONE,                  // 0
    TELEPORT_ENTER,                 // 1
    TELEPORT_EXIT,                  // 2
    TELEPORT_ENTER_BLINK,           // 3
    TELEPORT_EXIT_BLINK,            // 4
    TELEPORT_KINESSA_TRANSPORTER_ENTER,// 5
    TELEPORT_KINESSA_TRANSPORTER_EXIT,// 6
    TELEPORT_MAX                    // 7
};

enum OverlayMICType
{
    OMT_None,                       // 0
    OMT_Execute,                    // 1
    OMT_Shield,                     // 2
    OMT_CCImmune,                   // 3
    OMT_CharacterCustom1,           // 4
    OMT_Freeze,                     // 5
    OMT_MAX                         // 6
};

enum OverlayState
{
    OMS_Normal,                     // 0
    OMS_ForceVisible,               // 1
    OMS_ForceHidden,                // 2
    OMS_MAX                         // 3
};

enum EForcedSilhouetteVisibility
{
    FSV_None,                       // 0
    FSV_Visible,                    // 1
    FSV_Hidden,                     // 2
    FSV_MAX                         // 3
};

enum EHitReactionType
{
    HIT_REACTION_Anim,              // 0
    HIT_Reaction_Procedural,        // 1
    HIT_MAX                         // 2
};

enum EMetaGameState
{
    GAMESTATE_NONE,                 // 0
    GAMESTATE_NEUTRAL,              // 1
    GAMESTATE_ACTIVE_POINT,         // 2
    GAMESTATE_ATTACKING,            // 3
    GAMESTATE_DEFENDING,            // 4
    GAMESTATE_TITAN_BATTLE,         // 5
    GAMESTATE_MAX                   // 6
};

enum EBotBehaviorState
{
    BEHAVIORSTATE_IDLE,             // 0
    BEHAVIORSTATE_ENGAGING,         // 1
    BEHAVIORSTATE_FALLBACK,         // 2
    BEHAVIORSTATE_MAX               // 3
};

enum LocalViewerRangeState
{
    LVRS_EffectiveRange,            // 0
    LVRS_MaxRange,                  // 1
    LVRS_BeyondRange,               // 2
    LVRS_MAX                        // 3
};

struct native EEmoteCategoryChance
{
    var float fDefault;
    var float fPlayerVGS;
    var float fAbilityOnCooldown;
    var float fTakingDamage;
    var float fCelebration;
    var float fKills;
    var float fAction;
    var float fContext;
    var float fUltimate;
    var float fOverride;
    var float fMovement;

    structdefaultproperties
    {
        fDefault=0.0000000
        fPlayerVGS=0.0000000
        fAbilityOnCooldown=0.0000000
        fTakingDamage=0.0000000
        fCelebration=0.0000000
        fKills=0.0000000
        fAction=0.0000000
        fContext=0.0000000
        fUltimate=0.0000000
        fOverride=0.0000000
        fMovement=0.0000000
    }
};

struct native EEmoteAbilityChance
{
    var float fDefault;
    var float fAbility1;
    var float fAbility2;
    var float fAbility3;
    var float fMount;

    structdefaultproperties
    {
        fDefault=0.0000000
        fAbility1=0.0000000
        fAbility2=0.0000000
        fAbility3=0.0000000
        fMount=0.0000000
    }
};

struct native TGEQUIP_SLOTS_STRUCT
{
    var int SlotIndices[33];
    var int MiscItems[33];

    structdefaultproperties
    {
        SlotIndices[0]=0
        SlotIndices[1]=0
        SlotIndices[2]=0
        SlotIndices[3]=0
        SlotIndices[4]=0
        SlotIndices[5]=0
        SlotIndices[6]=0
        SlotIndices[7]=0
        SlotIndices[8]=0
        SlotIndices[9]=0
        SlotIndices[10]=0
        SlotIndices[11]=0
        SlotIndices[12]=0
        SlotIndices[13]=0
        SlotIndices[14]=0
        SlotIndices[15]=0
        SlotIndices[16]=0
        SlotIndices[17]=0
        SlotIndices[18]=0
        SlotIndices[19]=0
        SlotIndices[20]=0
        SlotIndices[21]=0
        SlotIndices[22]=0
        SlotIndices[23]=0
        SlotIndices[24]=0
        SlotIndices[25]=0
        SlotIndices[26]=0
        SlotIndices[27]=0
        SlotIndices[28]=0
        SlotIndices[29]=0
        SlotIndices[30]=0
        SlotIndices[31]=0
        SlotIndices[32]=0
        MiscItems[0]=0
        MiscItems[1]=0
        MiscItems[2]=0
        MiscItems[3]=0
        MiscItems[4]=0
        MiscItems[5]=0
        MiscItems[6]=0
        MiscItems[7]=0
        MiscItems[8]=0
        MiscItems[9]=0
        MiscItems[10]=0
        MiscItems[11]=0
        MiscItems[12]=0
        MiscItems[13]=0
        MiscItems[14]=0
        MiscItems[15]=0
        MiscItems[16]=0
        MiscItems[17]=0
        MiscItems[18]=0
        MiscItems[19]=0
        MiscItems[20]=0
        MiscItems[21]=0
        MiscItems[22]=0
        MiscItems[23]=0
        MiscItems[24]=0
        MiscItems[25]=0
        MiscItems[26]=0
        MiscItems[27]=0
        MiscItems[28]=0
        MiscItems[29]=0
        MiscItems[30]=0
        MiscItems[31]=0
        MiscItems[32]=0
    }
};

struct native DeathInfo
{
    var bool bDead;
    var Vector Momentum;
    var Class<DamageType> dmgType;
    var Vector HitLoc;

    structdefaultproperties
    {
        bDead=false
        Momentum=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        dmgType=none
        HitLoc=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native PostureStack
{
    var array<int> GUIDs;
    var array<TgPawn.TG_POSTURE> Postures;
    var int NewPostureGUID;

    structdefaultproperties
    {
        GUIDs=none
        Postures=none
        NewPostureGUID=0
    }
};

struct native PawnDamagerStruct
{
    var TgPawn DamagerPawn;
    var float fTimestamp;

    structdefaultproperties
    {
        DamagerPawn=none
        fTimestamp=0.0000000
    }
};

struct native OverlayMICList
{
    var init array<init MaterialInstanceConstant> MICs;

    structdefaultproperties
    {
        MICs=none
    }
};

struct native OverlayInfo
{
    var export editinline TgSkeletalMeshComponent OverlayMesh;
    var export editinline SkeletalMeshComponent ParentMesh;
    var bool bIs1POverlay;
    var bool bIsVisible;
    var OverlayMICList OverlayMICInstances[OverlayMICType];

    structdefaultproperties
    {
        OverlayMesh=none
        ParentMesh=none
        bIs1POverlay=false
        bIsVisible=false
        OverlayMICInstances[0]=(MICs=none)
        OverlayMICInstances[1]=(MICs=none)
        OverlayMICInstances[2]=(MICs=none)
        OverlayMICInstances[3]=(MICs=none)
        OverlayMICInstances[4]=(MICs=none)
        OverlayMICInstances[5]=(MICs=none)
    }
};

struct SilhouetteInfo
{
};

struct native HealingInfo
{
    var float HealAmount;
    var float TimeStamp;

    structdefaultproperties
    {
        HealAmount=0.0000000
        TimeStamp=0.0000000
    }
};

struct native RigidBodyImpactInfo
{
    var float LastImpactTime;
    var PhysicalMaterial PhysMat;

    structdefaultproperties
    {
        LastImpactTime=0.0000000
        PhysMat=none
    }
};

var private native const noexport Pointer VfTable_ITgSkinnableInterface;
var private native const noexport Pointer VfTable_ITgCombatActor;
var private native const noexport Pointer VfTable_ITgObserver_ViewTargetChanged;
var private native const noexport Pointer VfTable_ITgInteractiveAudio;
var Vector r_vPhysTweenTarget;
var repnotify TgPawn.ETweenState r_eTweenState;
var TgPawn.ETweenState m_eLocalTweenState;
var byte s_BitPackedHitReaction;
var repnotify TgPawn.EGrabState r_eGrabState;
var TgPawn.EGrabState m_eLocalGrabState;
var repnotify TgPawn.EChargeState r_eChargeState;
var TgPawn.TG_DEATH_REASON r_eDeathReason;
var repnotify TgPawn.TG_REP_DEVICE_STATE r_ReplicatedDeviceState[33];
var repnotify TgObject.TG_EQUIP_POINT r_eDesiredInHand;
var TgObject.TG_EQUIP_POINT m_eEquippedInHand;
var byte r_nPackedFireMultiRanges[20];
var TgObject.TG_EQUIP_POINT r_eDesiredAIDevice;
var repnotify TgPawn.STEALTH_TYPE r_eIsStealthed;
var TgPawn.STEALTH_TYPE c_eIsStealthed;
var byte r_nInCombatNonce;
var byte c_nInCombatNonceAck;
var const TgObject.DeployableOverlayIcon m_InitHUDOverlayIcon;
var const TgObject.DeployableOverlayState m_InitHUDOverlayState;
var TgPawn.TG_POSTURE m_ePosture;
var repnotify Controller.EStunType r_eCurrentStunType;
var byte c_nLocalRespawnBeaconHUDState;
var private TgPawn.OverlayMICType m_OverlayCurrentTypeBody;
var private TgPawn.OverlayMICType m_OverlayCurrentTypeWeapon;
var const Scene.ESceneDepthPriorityGroup m_eCharacterCustom1OverlayDepthGroup;
var() TgPawn.EForcedSilhouetteVisibility m_eForcedSilhouetteVisibility;
var() TgPawn.EHitReactionType m_HitReactionType;
var TgObject.EUITargetingType c_UITargetingType;
var protected TgPawn.EMetaGameState m_eMetaGameState;
var protected TgPawn.EBotBehaviorState m_eBotBehaviorState;
var byte m_nIsInIntroState;
var transient TgObject.EPolymorphType c_LocalPolymorph;
var repnotify TgObject.EPolymorphType r_CurrentPolymorph;
var TgObject.EThreatLevel c_ThreatLevel;
var TgObject.EThreatLevel c_LastThreatLevel;
var const TgPawn.LocalViewerRangeState m_RangeStateFromLocalViewer;
var TgPawn.EEmote c_eCurrentAudioEmotePlaying;
var float m_fPhysTweenDist;
var float r_fPhysTweenDuration;
var int m_nPhysTweenPostureId;
var bool r_bPhysTweenInterrupted;
var bool s_bIsInGrass;
var bool r_bGrabInterrupted;
var bool m_PreGrabCollideActors;
var bool m_PreGrabBlockActors;
var bool m_PreGrabCollideWorld;
var bool m_PreGrabCollideComplex;
var bool r_bUsePhysFlyingForCharge;
var bool r_bChargeIgnoreHumanoidBlocking;
var bool m_bWantsCharge;
var bool m_bCanJumpWhileCharging;
var bool m_bCanChargeInAir;
var bool m_bEndChargeInFalling;
var bool m_bIgnoreFriendlyBlocking;
var bool m_bIgnoreEnemyBlocking;
var const bool m_bHasDestroyedMesh;
var bool m_bDefaultPropsInitialized;
var bool m_bAffectedByVortices;
var bool s_LoadMeshServerSide;
var bool c_bDeviceHiddenDueToFullBodyAnim;
var bool c_bMeshHiddenDueToDeath;
var bool c_bHideMeshFromCameraPenetration;
var bool c_bHideMeshFromKismet;
var bool r_bInGlobalOffhandCooldown;
var bool bInGlobalOffhandCooldownClient;
var bool m_bInFireLock;
var bool c_bUpdatesWeaponMesh;
var bool c_bIsStealthMaterialOn;
var repnotify bool r_bIsVolumeStealthed;
var repnotify bool r_bIsVolumeStealthFading;
var bool m_bDisableVolumeStealth;
var repnotify bool r_bDisableVolumeStealth;
var const bool m_bCannotBeVolumeStealthed;
var bool m_bPlayingStealth;
var bool m_bPlayingDetected;
var bool c_bHiddenDueToStealth;
var bool c_bHiddenDueToObscuringDeployable;
var bool r_bCanStartStealthInCombat;
var const bool m_bIsVisionBlocker;
var const bool m_bIsAIVisionBlocker;
var bool m_bApplyDistanceFade;
var bool r_bIsBot;
var bool s_bInvisibleToPets;
var bool s_bCanSeePets;
var transient bool c_bIsFrametestZombie;
var bool r_bIsAnimInStrafeMode;
var bool m_ReachedTargetSoKillRootMotion;
var bool s_bCanApplyEffects;
var bool m_bInitialized;
var bool m_bUseInterrupted;
var bool c_bIgnoreInterruption;
var bool r_bNoEnergyCost;
var bool m_bCheatUseNoEnergy;
var bool m_bCheatNoRecharge;
var bool m_bIsInvisibleToAI;
var repnotify bool r_bInCombatFlag;
var bool s_bIsStill;
var bool m_bHitWallThisTick;
var bool r_bIsAFK;
var bool c_bHandIKEnabledFromAnimSet;
var bool c_bCanDoTurnInPlaceAnim;
var bool c_bIsPlayingTurnInPlaceAnim;
var bool m_bShouldApplyCCImmuneOverlay;
var bool m_bCanBeKnockedBack;
var bool m_bCausesPushblock;
var bool m_bPushblockAffectsFriendlies;
var bool m_bPushblockAffectsEnemies;
var bool m_bIsCrowdControlImmuneKismet;
var bool m_bUseSmoothNetReceiveRotation;
var bool m_bForceSmoothCorrection;
var const bool m_bAlwaysUseAccurateRotation;
var bool r_bHasAccurateRotation;
var bool c_bUpdateSkelMeshWhenNotRendered;
var bool c_bUpdateSkelMeshWhenNotRenderedServer;
var bool r_bSilenced;
var bool r_bDisarmed;
var repnotify bool r_bCrippled;
var bool r_bIsInStasis;
var bool r_bCanBePulled;
var bool s_bHasCrippleEffect;
var bool c_bEnemyMatLoaded;
var repnotify bool r_bIsFlashBang;
var bool r_bIsJumping;
var bool r_bIsShortJump;
var bool m_bIsLanding;
var bool m_bAllowHigherWallJumping;
var bool m_bIgnorePhysCheckForJump;
var bool m_bHasPlayedDeathAnimation;
var bool m_bForceDeathAnim;
var repnotify bool r_bHasRespawnBeacon;
var bool m_bDestroyOnOwnerDeathFlag;
var repnotify bool r_bNeedPlaySpawnFx;
var bool c_bSpawnFxPlayed;
var bool c_bTargeted;
var bool c_bTargetedLightup;
var bool c_bShowDecalRing;
var bool c_bShowTargetedRing;
var bool c_bTargetedRingActive;
var bool c_bApplyDropShadow;
var bool m_bShowNameplate;
var bool r_bInitialIsEnemy;
var bool c_bNeedsAssetLoad;
var bool r_bDebugShowAIDebug;
var bool m_SwapToDestroyedMeshOnTick;
var() bool m_bBlockCamera;
var bool m_bOverlaysEnabled;
var bool m_b1POverlaysActive;
var bool m_bSilhouettesVisible;
var() const bool m_bUseSilhouettes;
var() bool m_bIgnoreTearOffMomentum;
var() bool m_bAcceptsHitReactions;
var bool m_bIsFadingOut;
var bool m_bUseDamageTypeForDeathAnim;
var bool r_bDemoCanPurchaseItems;
var bool s_bHasInteractedWithStore;
var bool m_bDoSmoothCorrectionThisTick;
var bool m_bOnlyTakeHeadshotDamage;
var repnotify bool r_bIsMounted;
var bool r_bUseMountPosture;
var bool m_bIsEnteringMount;
var const bool m_bUpdateEyeHeight;
var bool m_bJustLanded;
var bool m_bLandRecovery;
var bool r_bJustJumped;
var bool m_bStunEnergyRegen;
var bool c_bHealAkEventPlaying;
var bool m_bPainAkEventPlaying;
var repnotify bool r_bIsDazed;
var repnotify bool r_bIsMarked;
var repnotify bool r_bIsBleeding;
var repnotify bool r_bIsOnFire;
var repnotify bool r_bIsRooted;
var repnotify bool r_bIsKnockedBack;
var repnotify bool r_bIsPoisoned;
var repnotify bool r_bIsSlowed;
var repnotify bool r_bIsFrozen;
var repnotify bool r_bIsCCImmune;
var bool r_bIsRevealed;
var bool r_bIsWallHacking;
var bool r_bIsInSelfKnockBack;
var() bool m_bUseOutlines;
var bool m_bIsLeaping;
var bool m_bCanSpawnHealthNuggetsOnDeath;
var bool m_bCanAutoMountOnRespawn;
var bool c_bShowingDisarm;
var bool r_bFirstSpawnWave;
var bool m_bWaitForIntroAnimToEnd;
var bool m_bIntroAnimFinished;
var bool m_bAllowIntroWhiteOut;
var bool m_bIntroWhiteOutActive;
var bool m_bAirAccuracyPenalty;
var bool m_bCanBeHeadShot;
var(Mount) bool c_bHide3PWeaponMeshWhileMounted;
var(Mount) bool r_bMorphMounted;
var transient bool m_bShouldBeFirstPersonLastFrame;
var bool m_bFadeOutOnLifeAfterDeathTimerExpired;
var bool m_bUsesRecoil;
var bool m_bUsingSecondaryPhysicsAsset;
var transient bool m_bWasKilledByEnvironment;
var bool m_bShouldSmoothEyeHeight;
var bool m_bHasAstroBuff;
var bool r_bIsLifted;
var int r_nPhysTweenFlags;
var() string m_sGameplayPackage;
var TgInteractiveAudio m_AsInteractiveAudio;
var TgPawn r_GrabSource;
var float r_fGrabDuration;
var name r_GrabAttachSocket;
var Vector r_vGrabLocationOffset;
var Rotator r_rGrabRotationOffset;
var Vector m_vGrabDestRelLocation;
var Rotator m_rGrabDestRelRotation;
var int m_nPhysGrabPostureId;
var array<TgPawn> s_GrabbedTargets;
var int r_nCannotBeGrabSource;
var array<Actor> m_TeleportNotifyList;
var float r_fChargeInitialYaw;
var float r_fChargeInitialPitch;
var Vector r_vChargeInitialLocation;
var float r_fChargeSpeed;
var float r_fChargeRange;
var const int m_nBodyMeshAsmId;
var native const Pointer m_BodyMeshAssembly;
var native const Pointer m_DestroyedMeshAssembly;
var int m_n1PHeadMeshId;
var int r_nPawnId;
var float c_fLastUpdateTime;
var repnotify TgEffectManager r_EffectManager;
var array<TgProperty> m_Properties;
var repnotify float r_CurrentPropValues[TG_PAWN_PROPERTIES];
var float m_LocalPropValues[TG_PAWN_PROPERTIES];
var float s_PropValuesRepResolution[TG_PAWN_PROPERTIES];
var float s_DefaultPropValues[TG_PAWN_PROPERTIES];
var repnotify float r_fCachedMaxHealth;
var TgAkActorUnoccluded m_AkActorUnoccluded;
var AkEvent c_AkAttackedFromBehind;
var AkEvent c_AkAttackedFromAbove;
var AkEvent c_AkAttackedFromSniper;
var config EEmoteCategoryChance m_EmoteChances;
var config EEmoteAbilityChance m_EmoteChancesAbility;
var int c_nEmoteCameraStackId;
var transient float m_fLastEmoteTime;
var float m_fEmoteGlobalCooldown;
var array<float> m_fLastEmoteCatTimes;
var array<float> m_fLastPlayerVGSEmoteTimes;
var float m_fEmoteNonLocalCooldown;
var float m_fLastNonLocalEmoteTime;
var float m_fSoftLandVelocityCutoff;
var float m_fHardLandVelocityCutoff;
var float s_nSpawnTime;
var int r_nPhysicalType;
var float r_fReconnectTime;
var array<TgCollisionProxy_Vortex> m_CurrentVortexList;
var array<TgDeploy_BlackHole> m_CurrentBlackHoleList;
var Class<TgDamageType> m_DeathDamageType;
var Vector m_DeathHitLocation;
var repnotify EquipDeviceInfo r_EquipDeviceInfo[33];
var TgDevice m_EquippedDevices[33];
var TgDeviceForm c_EquipForm[33];
var name c_EquipFormState[33];
var name c_nmInHandSocket;
var TgDevice c_CurrentTargetingDevice;
var TgDevice c_CurrentStartActionDevice;
var float c_fShouldStartActionTimeStamp;
var TgDevice m_CurrentInHandDevice;
var int c_nLockInHandToTargetingDevice;
var TgSpecialFx c_WorldBracketFX;
var int c_nLastProcessedFlashEventIdx;
var int r_nFirstValidFlashEventIdx;
var repnotify int r_nFlashQueIndex;
var int r_nFlashEvent[32];
var Vector r_vFlashLocation[32];
var Vector r_vFlashRayDir[32];
var float r_vFlashRefireTime[32];
var Actor r_pFlashTarget[32];
var Class<DamageType> r_pFlashDamageType[32];
var int r_nFlashFireInfo[32];
var float r_fFireMultiMaxRange;
var int r_nFireMultiSeed;
var float r_fFireMultiSpreadAngle;
var float s_fTauntAmount;
var float m_fLastPainSound;
var() const export editinline LightEnvironmentComponent LightEnvironment;
var Vector FireLocationOffsets[33];
var float BotTurnAcceleration;
var float BotTurnSpeed;
var float m_fMaxAimAssistStacks;
var float r_fStealthFadeRate;
var TgVisibilityVolume r_CurrentVisibilityVolumes[2];
var repnotify TgDeployable r_ObscuringDeployables[10];
var repnotify TgDeployable r_BlindingDeployables[10];
var Actor r_VisibleThroughWallsInstigators[12];
var Actor r_VisibleThroughStealthInstigators[12];
var const float m_fVolumeStealthDisableTime;
var transient float c_fVolumeFadeValue;
var transient float c_fDistanceFadeValue;
var transient float c_fStealthFadeValue;
var transient float c_fObscuringDeployableFadeValue;
var transient float c_fBlindingDeployableFadeValue;
var transient float c_fCurrentFadeValue;
var transient float c_fDistanceLastCollidingVisionRange;
var float c_fLocalStealthFadeRate;
var TgSpecialFx c_TeleporterEnterFX;
var TgSpecialFx c_TeleporterExitFX;
var TgSpecialFx c_BlinkEnterFX;
var TgSpecialFx c_BlinkExitFX;
var TgSpecialFx c_DetectedFx;
var TgSpecialFx c_PetSuccessfulHitFx;
var const float c_fFxScaleSize;
var float m_fLifeAfterDeathSecs;
var Actor r_aDebugTarget;
var Actor r_aDebugDestination;
var Actor r_aDebugNextNav;
var Vector r_vDebugNextNavMeshPoint;
var Vector r_vDebugSpreadoutLocation;
var int r_nDebugHearingRange;
var int r_nDebugSightRange;
var int r_nDebugFOV;
var string r_sDebugAction;
var string r_sDebugName;
var string r_sDebugFactory;
var Vector s_vOneWayMovement;
var Vector r_vDown;
var float m_fExhaustedPercent;
var float m_fExhaustedPropModifier;
var float m_fExhaustedMinPropModifier;
var float m_fMountFrictionMultiplier;
var float m_fBackpedalPct;
var float m_fMountBackpedalPct;
var repnotify Actor r_TargetActor;
var Actor r_LockedTarget;
var int c_TargetMethod;
var TgPawn s_Pets[8];
var TgPawn m_PetOwner;
var int c_ActivePets;
var Actor s_LastAttacker;
var Actor s_LastAttacked;
var Actor m_CurrentMeleeTarget;
var TgPawn r_Owner;
var int s_nSpawnerDeviceInstId;
var int s_nSpawnerDeviceModeId;
var repnotify DeathInfo r_DeathInfo;
var repnotify int r_nResetCharacter;
var repnotify int r_nLiveRespawn;
var name DyingStateName;
var int m_nSpawnLocationId;
var int m_nSpawnTableId;
var int m_nSpawnTableDetailId;
var PlayerStart m_LastPlayerStart;
var float m_fStandingHeight;
var float m_fStandingRadius;
var float m_fTargetCylinderHeight;
var float m_fTargetCylinderRadius;
var int r_nPacingType;
var Actor m_CurrentUseActor;
var float m_fBaseTranslationOffset;
var float m_fCrouchTranslationOffset;
var float r_fInCombatTime;
var float m_fInCombatTime;
var float m_fPhaseChangeTime;
var float m_fPhaseChangedTimeStamp;
var float m_PhaseChangeRemainingTime;
var repnotify int r_nPhase;
var int c_PreviousPhase;
var const int m_nInitHUDOverlayDisplayMask;
var const float m_InitHUDOverlayEnemyViewDist;
var array<TgAnimNodeSimpleTransitioner> m_SimpleTransitionerNodes;
var array<TgAnimNodeStanceTransitioner> m_StanceTransitionerNodes;
var array<TgAnimBlendByFire> m_FireBlendNodes;
var array<TgAnimNodeBlendByCombatWariness> m_CombatWarinessBlendNodes;
var array<TgAnimBlendByPosture> m_PostureBlendNodes;
var array<AnimNodeBlendList> m_HitOrMissBlendNodes;
var array<TgAnimNodeEmoteSwitch> m_AnimNodeEmoteSwitches;
var array<TgAnimBlendByEmote> m_EmoteBlendNodes;
var array<TgAnimNodeEmoteSequence> m_EmoteSequenceNodes;
var array<TgAnimNodeBlendByIntroduction> m_AnimNodeBlendByIntroductions;
var array<TgAnimNodeBlendByHitReaction> m_AnimNodeBlendByHitReactions;
var array<TgAnimBlendByFireMode> m_DeviceModeBlendNodes;
var array<SkelControlBase> m_SkelControlLocks;
var array<name> m_SkelControlLockNames;
var TgAnimNodeSlot m_UpperBodyAnimNode;
var AnimNodeSequence m_UpperBodyAnimNodeSequence;
var TgAnimNodeSlot m_FullBodyAnimNode;
var const transient int m_nYawOffset;
var PostureStack m_PostureStack;
var float m_fKnockbackMultiplier;
var transient TgBotFactorySpawnable s_PetBotFactory;
var transient array<TgNavigationPointSpawnable> s_PetLocationList;
var float m_fTimeBetweenPetSpawns;
var array<name> m_DeployPetsSocketNames;
var float m_ValidPetSpawnPointDistance;
var() float m_fRBPushStrengthMultiplier;
var() Vector2D m_fRBPushStrengthRange;
var Rotator m_PreviousNetReceiveRotation;
var Rotator m_TargetNetReceiveRotation;
var float m_RotationInterpRate;
var int m_nNetRotationCount;
var int m_nSmoothedRemoteViewPitch;
var int m_nPreviousReceivedRemoteViewPitch;
var int m_nTargetRemoteViewPitch;
var float m_PitchInterpRate;
var int m_nNetViewPitchCount;
var() float m_fSmoothCorrectionRate;
var int m_UnpackedRemoteViewPitch;
var int r_nPackedPitchYawForSpectate;
var native Pointer m_pStatsTracker;
var TgPawn m_LastDamager;
var int m_LastDamagerTimeStamp;
var array<PawnDamagerStruct> s_Damagers;
var float m_fJumpLandingTime;
var config float m_fCeilingTraceDistForWallJumping;
var const float m_fHorseJumpHeightIncrease;
var float m_fDazedStartTime;
var float m_fDazedDuration;
var float m_fDazedInterval;
var const int m_iDazedOrder;
var int m_iDazedNumControlPoints;
var array<float> m_DazedKnots;
var array<Vector2D> m_DazedRotatorControl;
var Vector2D m_vDazedMaxRotator;
var float m_fDazedStrafeStartDirection;
var array<float> m_DazedStrafeChangeTimes;
var Vector2D m_vDazedMinMaxStrafeDuration;
var MaterialInstanceConstant m_DazedWineMIC;
var Actor r_StunTauntTarget;
var array<TgRespawnBeaconExit> m_LocalTouchingRespawnBeacons;
var TgPlayerController c_LocalPC;
var export editinline TgDropShadowDecalComponent c_PlayerCircle;
var MaterialInstanceConstant c_PlayerCircleMIC;
var Material c_CircleTemplate;
var Material c_CircleTemplateSpectator;
var export editinline TgDropShadowDecalComponent c_PlayerDropShadow;
var Material c_PlayerDropShadowTemplate;
var MaterialInstanceConstant c_PlayerDropShadowMIC;
var transient float c_fPlayerDropShadowFade;
var name c_PlayerDropShadowSocketName;
var const Class<TgControlModule> DefaultControlModuleClass;
var float m_fFaceRotationInterpTime;
var float m_fRemainingFaceRotationInterpTime;
var repnotify int r_nBigTeleportCount;
var int c_nTickCheckingState;
var export editinline TgManifestGroup c_AssetManifestGroup;
var TgSpecialFx c_LevelUpFX;
var int c_nLevelUpFxId;
var int s_nKillCombo;
var int s_nKillStreak;
var repnotify int r_nProfileId;
var repnotify int r_nSettingsOverrideId;
var repnotify int r_nSkinId;
var repnotify int r_nHeadSkinId;
var repnotify int r_nWeaponSkinId;
var repnotify int r_nMountSkinId;
var int r_nWardSkinId;
var native const Pointer m_pAmBot;
var native const Pointer m_pAmSkin;
var native const Pointer m_pAmHead;
var native const Pointer m_pAmWeaponSkin;
var native const Pointer m_pAmMountSkin;
var native const array<Pointer> m_pAmAllSkins;
var int c_StunnedPostureID;
var int c_FearedPostureID;
var int c_DisarmedPostureID;
var array<PlayerController> s_Viewers;
var transient TgCarriedFlag m_CurrentFlag;
var transient float m_fLastCTFVolumeTimestamp;
var float m_fDamageTakenRTPC;
var float m_fDamageTakenMax;
var float m_fDamageTakenMaxSustainDuration;
var float m_fDamageTakenRTPCSustainDuration;
var() array<OverlayInfo> m_OverlayInfosBody;
var() array<OverlayInfo> m_OverlayInfosWeapon;
var const MaterialInstanceConstant m_ExecuteOverlayMaterialFriend;
var const MaterialInstanceConstant m_ExecuteOverlayMaterialEnemy;
var const MaterialInstanceConstant m_ShieldOverlayMaterialFriend;
var const MaterialInstanceConstant m_ShieldOverlayMaterialEnemy;
var const MaterialInstanceConstant m_ImmortalOverlayMaterialFriend;
var const MaterialInstanceConstant m_ImmortalOverlayMaterialEnemy;
var const MaterialInstanceConstant m_CharacterCustom1OverlayMaterial;
var const MaterialInstanceConstant m_FreezeOverlayMaterial;
var transient array<SilhouetteInfo> m_SilhouetteInfos;
var() Class<TgSilhouetteComponent> m_SilhouetteClass;
var array<int> m_IgnoredHitPulseIndicies;
var() float m_fHitReactionAIPauseTime;
var() float m_fHitReactionBlendOutTime;
var() float m_fHitReactionTweenTime;
var() float m_fFadeOutTime;
var() float m_fFadeOutSpeed;
var TgSpecialFx m_DeathAnimFX;
var array<TgSkelCon_HitReaction> m_HitReactionSkelControls;
var float m_fRemainingHitReactionPulseTime;
var() float m_fHitReactionPulseTime;
var() float m_fDisorientSpinRate;
var float m_fMaxSmoothNetUpdateDist;
var float m_fNoSmoothNetUpdateDist;
var float m_fSmoothNetUpdateTime;
var Vector m_vMeshTranslationOffset;
var float m_fInitialHealthPercent;
var float c_fHUDHealthPercent;
var float m_fDamageDealtPercentAI;
var float m_fDamageTakenPercentAI;
var array<HealingInfo> m_RecentHealList;
var const float m_fRecentHealExpireTime;
var int m_nCloneExpirationAttacksCount;
var float m_fCloneLeashRange;
var float m_fCloneExpirationTime;
var TgRepInfo_Player r_CloneParentPRI;
var TgAnimNodeBlendList m_SprintBlendNode;
var TgWeaponMeshActor m_WeaponMesh;
var export editinline TgSkeletalMeshComponent m_HeadMesh;
var int m_HeadSilhouetteIndex;
var int m_HeadOverlayIndex;
var repnotify int r_nBodyMeshOverride;
var repnotify int r_nHeadMeshOverride;
var int c_nCurrentHeadMeshID;
var() const float m_BobFootstepFactor;
var float Bob;
var float LandBob;
var float JumpBob;
var float AppliedBob;
var float BobTime;
var Vector WalkBob;
var float m_fOldZ;
var Vector AimSpot;
var Vector AimNoise;
var float m_fAimSpotsetLastRefresh;
var float m_fAimNoiseLastRefresh;
var float m_fAimPitch;
var export editinline AudioComponent m_TakeHitAudioComponent;
var export editinline AudioComponent m_PainAudioComponent;
var AkEvent m_TakeHitAkEvent;
var AkEvent m_TakeHeadShotAkEvent;
var AkEvent c_HealPlayAkEvent;
var AkEvent c_HealStopAkEvent;
var AkEvent m_PainAkEvent;
var float m_fLastPainEvent;
var float m_fPainEventCooldown;
var TgAnimNodePlayFireAnim m_FireAnimNode;
var TgEffectGroup m_StealthPulseEffectGroup;
var float m_fStealthPulseTime;
var float r_fKnockedBackFrictionOverride;
var Vector r_vKnockedBackVelocityOverride;
var int r_nIncomingImpactCount;
var float r_fReloadScale;
var float r_fRefireSpeed;
var TgPawn r_HealTarget;
var() export editinline TgParticleSystemComponent c_HealingBeamPSC;
var export editinline transient TgSkeletalMeshComponent m_OutlineMesh;
var MaterialInstanceConstant m_OutlineMaterial;
var TgNearObjectiveVolume m_NearObjectiveVolume;
var float r_fLeapAirControl;
var float m_fBaseLeapAirControl;
var float m_fKnockAirControl;
var array<TgDeviceVolume> m_HomeguardVolumes;
var float m_LastHomeguardTime;
var export editinline TgSkeletalMeshComponent m_MountMesh;
var int m_nMountPostureId;
var float s_fEndStealthDamage;
var float s_fDamageTakenDuringStealth;
var() float m_fHUDOverlayZOffset;
var() float m_fHUDOverlayMorphMountedZOffset;
var int m_lastDamageSourceSlot;
var float m_fLastMoveTime;
var TgDeployable s_AttachedProjBlocker;
var() float m_fScaleMesh;
var() float m_fScaleMeshChangePerSecond;
var() float m_fScaleCollisionHeight;
var() float m_fScaleCollisionHeightChangePerSecond;
var() float m_fScaleCollisionRadius;
var() float m_fScaleCollisionRadiusChangePerSecond;
var int m_IntroPostureID;
var float r_fIntroTime;
var repnotify float r_fIntroOffset;
var float s_fIntroStartTime;
var float m_fIntroProgress;
var repnotify name r_ReplicatedState;
var array<AnimNodeSequence> m_RespawnNodes;
var array<TgAnimBlendByBuffMonsterIntro> m_BuffCampIntroNodes;
var name m_IntialIntroState;
var name m_nmIntroWhiteOutParamName;
var float m_fIntroWhiteOutScale;
var float m_fIntroWhiteOutUpTime;
var float m_fIntroWhiteOutDownTime;
var int r_nInsideTaskForceBase;
var TgSpecialFx m_HealFX3P;
var TgSpecialFx m_ShieldFX3P;
var float c_fNextTakeHitDisplayGroupTimestamp;
var float c_fNextTakeHitDisplayDelay;
var repnotify Actor r_PolymorphInstigator;
var int m_PrePolymorphHealth;
var int m_PolymorphMaxHealth;
var array<RigidBodyImpactInfo> m_RigidBodyImpacts;
var float c_fServerTimeStamp;
var float m_fZoomDistOverride;
var float m_fZoomDurationOverride;
var float c_fThreatBehind;
var float c_fThreatInEffectiveRange;
var float c_fThreatDistanceSquared;
var float c_fThreatDistance;
var float c_fThreatFocused;
var float c_fThreatFocusTarget;
var float c_fThreatSeenBy;
var float c_fThreatDamaged;
var float c_fThreatOcclusion;
var float c_fThreatBinnedOcclusion;
var float c_fThreatShotAt;
var float c_fThreatUlt;
var float c_fThreatLevelValue;
var float c_fThreatDecayResidual;
var float c_fLastThreatLevelValue;
var float c_fDBGThreatDistanceFeet;
var TgGameplayCurves m_GameplayCurves;
var int m_nSuccessfulHitSpecialFXId;
var array<name> LLegBoneNames;
var array<name> RLegBoneNames;
var array<name> LArmBoneNames;
var array<name> RArmBoneNames;
var array<name> HeadBoneNames;
var name m_HeadShotComponentBoneName;
var export editinline TgHeadShotComponent m_HeadShotComponent;
var(Mount) float m_fMountScaleOverride;
var TgCameraShake m_LandCameraShake;
var TgCameraShake m_JumpCameraShake;
var float m_f1PTransitionFireDelay;
var transient float m_f1PTransitionFireDelayRemaining;
var float m_fEnergyChargeMultiplier;
var float c_fRecreateTrackedProjectilesTimer;
var float m_fRecoilSmoothRate;
var Rotator m_rCurrentRecoil;
var Rotator m_rSmoothedRecoil;
var float m_fSettleDelay;
var float m_fSettleSpeed;
var private float m_fRecoilSettleDeltaTimeOverflow;
var private float m_fRecoilSmoothDeltaTimeOverflow;
var int r_nVoicePackId;
var array<Vector> m_bPendingWallStunNormals;
var float m_fTimeOnNonBaseableSurface;
var float m_fNonBaseableSurfaceAirControlDuration;
var float m_fNonBaseableSurfaceLerpTime;
var float m_fNonBaseableSurfaceRampUpMult;
var float m_fNonBaseableSurfaceMaxMoveAmount;
var float m_fNonBaseableSurfaceGraceTime;
var float m_fNonBaseableSurfaceExitMaxVelocity;
var float m_fNonBaseableSurfaceControlPercent;
var array<MaterialInterface> m_OriginalMaterialsBody;
var array<MaterialInterface> m_OriginalMaterialsHead;
var array<MaterialInterface> m_OriginalMaterialsWeapon;
var array<MaterialInstanceConstant> m_ReplacementMICsBody;
var array<MaterialInstanceConstant> m_ReplacementMICsHead;
var array<MaterialInstanceConstant> m_ReplacementMICsWeapon;
var float m_fEyeHeightSmoothFactor;
var float m_ExecutionMaterialFadeOutTimer;
var float m_ExecutionMaterialFadeOutDuration;
var ForceFeedbackWaveform m_DeathFFWaveform;
var TgDevice m_BuffDevice;
var TgDevice m_PrincessPresenceDebuffDevice;
var TgDevice m_PrincessPresenceBuffDevice;
var float m_fFlourishTimeout;
var int c_nCurrentVGSPlaying;
var array< delegate<On3pTransitionEvent> > m_SingleUseOn3pTransitionDelegates;
//var delegate<On3pTransitionEvent> __On3pTransitionEvent__Delegate;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_bFirstSpawnWave, r_bIsBot, 
        r_bNeedPlaySpawnFx, r_fIntroOffset, 
        r_fIntroTime, r_nHeadSkinId, 
        r_nMountSkinId, r_nPacingType, 
        r_nPawnId, r_nPhysicalType, 
        r_nProfileId, r_nSettingsOverrideId, 
        r_nSkinId, r_nWardSkinId, 
        r_nWeaponSkinId, s_DefaultPropValues;

    // Pos:0x020
    if(((int(Role) == int(ROLE_Authority)) && !bDemoRecording) && (bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_nFirstValidFlashEventIdx;

    // Pos:0x06F
    if((int(Role) == int(ROLE_Authority)) && bDemoRecording || !(bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_fFireMultiMaxRange, r_fFireMultiSpreadAngle, 
        r_nFireMultiSeed, r_nFlashEvent, 
        r_nFlashFireInfo, r_nFlashQueIndex, 
        r_nPackedFireMultiRanges, r_pFlashDamageType, 
        r_pFlashTarget, r_vFlashLocation, 
        r_vFlashRayDir, r_vFlashRefireTime;

    // Pos:0x0BE
    if((int(Role) == int(ROLE_Authority)) && (!bNetOwner || bDemoRecording) || bNetTimelapsePost)
        r_EquipDeviceInfo, r_bHasRespawnBeacon, 
        r_bInitialIsEnemy, r_bIsJumping, 
        r_bIsShortJump, r_eDesiredInHand;

    // Pos:0x0FE
    if((int(Role) == int(ROLE_Authority)) && !bNetOwner || bDemoRecording)
        r_CurrentVisibilityVolumes, r_bIsVolumeStealthFading, 
        r_bIsVolumeStealthed;

    // Pos:0x12F
    if((int(Role) == int(ROLE_Authority)) && ((bNetOwner || bDemoRecording) || bNetTimelapse) || bNetTimelapsePost)
        r_LockedTarget, r_StunTauntTarget, 
        r_bCanBePulled, r_bCanStartStealthInCombat, 
        r_bCrippled, r_bDisarmed, 
        r_bInGlobalOffhandCooldown, r_bIsBleeding, 
        r_bIsCCImmune, r_bIsDazed, 
        r_bIsFlashBang, r_bIsFrozen, 
        r_bIsInSelfKnockBack, r_bIsInStasis, 
        r_bIsKnockedBack, r_bIsMarked, 
        r_bIsOnFire, r_bIsPoisoned, 
        r_bIsRevealed, r_bIsRooted, 
        r_bIsSlowed, r_bIsWallHacking, 
        r_bNoEnergyCost, r_bSilenced, 
        r_fKnockedBackFrictionOverride, r_fLeapAirControl, 
        r_nIncomingImpactCount, r_vKnockedBackVelocityOverride;

    // Pos:0x17C
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_BlindingDeployables, r_CurrentPropValues, 
        r_DeathInfo, r_EffectManager, 
        r_HealTarget, r_ObscuringDeployables, 
        r_Owner, r_ReplicatedDeviceState, 
        r_TargetActor, r_VisibleThroughStealthInstigators, 
        r_VisibleThroughWallsInstigators, r_aDebugDestination, 
        r_aDebugNextNav, r_aDebugTarget, 
        r_bDebugShowAIDebug, r_bDisableVolumeStealth, 
        r_bInCombatFlag, r_bIsAFK, 
        r_bIsAnimInStrafeMode, r_bIsLifted, 
        r_bIsMounted, r_bMorphMounted, 
        r_eCurrentStunType, r_eDeathReason, 
        r_eIsStealthed, r_fCachedMaxHealth, 
        r_fInCombatTime, r_fStealthFadeRate, 
        r_nBigTeleportCount, r_nDebugFOV, 
        r_nDebugHearingRange, r_nDebugSightRange, 
        r_nInCombatNonce, r_nInsideTaskForceBase, 
        r_nLiveRespawn, r_nPhase, 
        r_nResetCharacter, r_sDebugAction, 
        r_sDebugFactory, r_sDebugName, 
        r_vDebugNextNavMeshPoint, r_vDebugSpreadoutLocation, 
        r_vDown;

    // Pos:0x19C
    if(int(Role) == int(ROLE_Authority))
        r_CloneParentPRI, r_CurrentPolymorph, 
        r_GrabAttachSocket, r_GrabSource, 
        r_PolymorphInstigator, r_ReplicatedState, 
        r_bChargeIgnoreHumanoidBlocking, r_bGrabInterrupted, 
        r_bJustJumped, r_bPhysTweenInterrupted, 
        r_bUseMountPosture, r_bUsePhysFlyingForCharge, 
        r_eChargeState, r_eGrabState, 
        r_eTweenState, r_fChargeInitialPitch, 
        r_fChargeInitialYaw, r_fChargeRange, 
        r_fChargeSpeed, r_fGrabDuration, 
        r_fPhysTweenDuration, r_fRefireSpeed, 
        r_fReloadScale, r_nBodyMeshOverride, 
        r_nCannotBeGrabSource, r_nHeadMeshOverride, 
        r_nPhysTweenFlags, r_nVoicePackId, 
        r_rGrabRotationOffset, r_vChargeInitialLocation, 
        r_vGrabLocationOffset, r_vPhysTweenTarget;

    // Pos:0x1AD
    if((int(Role) == int(ROLE_Authority)) && bDemoRecording)
        r_bDemoCanPurchaseItems;

    // Pos:0x1CD
    if(((((bDemoRecording || bNetTimelapse) || m_bAlwaysUseAccurateRotation) && !bSkipActorPropertyReplication || bNetInitial) && bReplicateMovement) && (int(RemoteRole) == int(ROLE_SimulatedProxy)) && bNetInitial || bUpdateSimulatedPosition)
        r_bHasAccurateRotation, r_nPackedPitchYawForSpectate;

    // Pos:0x258
    if(((((int(Role) == int(ROLE_Authority)) && bNetDirty) && !bNetInitial) && !bNetTimelapse) && !bDemoRecording)
        r_fReconnectTime;
}

simulated delegate On3pTransitionEvent()
{
    //return;    
}

// Export UTgPawn::execGetTurnRotatorOverride(FFrame&, void* const)
native function bool GetTurnRotatorOverride(out int nYawOffset);

// Export UTgPawn::execOnViewTargetChanged(FFrame&, void* const)
native function OnViewTargetChanged(optional Actor aNewViewTarget);

// Export UTgPawn::execGetUISkillEqpSlotOverride(FFrame&, void* const)
native function int GetUISkillEqpSlotOverride(int nEquipSlot, optional bool bAltSlot = false);

// Export UTgPawn::execGetLagPredictionTime(FFrame&, void* const)
native final function float GetLagPredictionTime();

// Export UTgPawn::execGetUnclampedLagPredictionTime(FFrame&, void* const)
native final function float GetUnclampedLagPredictionTime();

// Export UTgPawn::execGetTargetActor(FFrame&, void* const)
native function Actor GetTargetActor();

// Export UTgPawn::execGetTargetPawn(FFrame&, void* const)
native function TgPawn GetTargetPawn();

// Export UTgPawn::execSetTargetActor(FFrame&, void* const)
native function SetTargetActor(Actor Target);

// Export UTgPawn::execUpdateShieldFX(FFrame&, void* const)
native function UpdateShieldFX();

// Export UTgPawn::execAreAnyOtherOffhandsLockingFiring(FFrame&, void* const)
native function bool AreAnyOtherOffhandsLockingFiring(TgDevice CurrentDevice);

// Export UTgPawn::execUpdateClientDevices(FFrame&, void* const)
native function UpdateClientDevices(optional bool bForce = false);

// Export UTgPawn::execGetDeviceByEqPoint(FFrame&, void* const)
native function TgDevice GetDeviceByEqPoint(int eEqPoint);

// Export UTgPawn::execCreateDeviceForm(FFrame&, void* const)
native function TgDeviceForm CreateDeviceForm(EquipDeviceInfo Info);

// Export UTgPawn::execDeviceFormChanged(FFrame&, void* const)
native function DeviceFormChanged(optional bool bForceReload = false);

// Export UTgPawn::execApplyPawnSetup(FFrame&, void* const)
native function bool ApplyPawnSetup();

// Export UTgPawn::execInitializeDefaultProps(FFrame&, void* const)
native function InitializeDefaultProps();

// Export UTgPawn::execAddProperty(FFrame&, void* const)
native function AddProperty(int nPropId, float fBase, float fRaw, float FMin, float FMax);

// Export UTgPawn::execGetProperty(FFrame&, void* const)
native function TgProperty GetProperty(int nPropIndex);

// Export UTgPawn::execGetPropertyById(FFrame&, void* const)
native function TgProperty GetPropertyById(int nPropId);

// Export UTgPawn::execSetProperty(FFrame&, void* const)
native function SetProperty(int nPropIndex, float fNewValue);

// Export UTgPawn::execSetPropCurrentValue(FFrame&, void* const)
native function SetPropCurrentValue(int nPropIndex, float nNewValue);

// Export UTgPawn::execResetProperties(FFrame&, void* const)
native function ResetProperties();

// Export UTgPawn::execGetSlowDiminishing(FFrame&, void* const)
native function float GetSlowDiminishing();

// Export UTgPawn::execIsDebuffImmune(FFrame&, void* const)
native function bool IsDebuffImmune();

// Export UTgPawn::execIsDamageOverTimeImmune(FFrame&, void* const)
native function bool IsDamageOverTimeImmune();

// Export UTgPawn::execIsSuperiorCrowdControlImmune(FFrame&, void* const)
native function bool IsSuperiorCrowdControlImmune();

// Export UTgPawn::execIsCrowdControlImmune(FFrame&, void* const)
native function bool IsCrowdControlImmune();

// Export UTgPawn::execCrowdControlBreak(FFrame&, void* const)
native function CrowdControlBreak();

// Export UTgPawn::execSpecialAOEImmunity(FFrame&, void* const)
native function bool SpecialAOEImmunity(Vector AOECenter, TgDeviceFire instigatingFiremode);

// Export UTgPawn::execDrawScaledString(FFrame&, void* const)
native static final function int DrawScaledString(Canvas CanvasToUse, float StartX, float StartY, string NameString, Font NameFont, Color NameColor, float Scale);

// Export UTgPawn::execDrawNameText(FFrame&, void* const)
native static final function int DrawNameText(Canvas CanvasToUse, float StartX, float StartY, string NameString, Font NameFont, Color NameColor, float Scale);

// Export UTgPawn::execNativeCanvasProject(FFrame&, void* const)
native static final function Vector NativeCanvasProject(Canvas CanvasToUse, Vector vLocation);

// Export UTgPawn::execFlashResetReplication(FFrame&, void* const)
native function FlashResetReplication();

// Export UTgPawn::execFlashFireMode(FFrame&, void* const)
native function FlashFireMode(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashTargeting(FFrame&, void* const)
native function FlashTargeting(int nDeviceInstanceId, int nFireModeNum, optional int nEquipSlot, optional int nSocketIndex, optional bool bSuccessfulHit);

// Export UTgPawn::execFlashBuildUp(FFrame&, void* const)
native function FlashBuildUp(int nDeviceInstanceId, int nFireModeNum, optional int nEquipSlot, optional int nSocketIndex, optional float fBuildupTime = 0.0000000);

// Export UTgPawn::execFlashPlayEmote(FFrame&, void* const)
native function FlashPlayEmote(TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execFlashPlayEmoteExcludeOwner(FFrame&, void* const)
native function FlashPlayEmoteExcludeOwner(TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execFlashFire(FFrame&, void* const)
native function FlashFire(int nDeviceInstanceId, int nFireModeNum, Vector vNewLoc, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit, optional float RefireTime);

// Export UTgPawn::execFlashFireMulti(FFrame&, void* const)
native function FlashFireMulti(int nDeviceInstanceId, int nFireModeNum, Vector vAimStart, Vector vAimDir, array<float> hitRanges, float fMaxRange, int nSeed, float fSpreadAngle, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit, optional float RefireTime);

// Export UTgPawn::execFlashFireNoSim(FFrame&, void* const)
native function FlashFireNoSim(int nDeviceInstanceId, int nFireModeNum, Vector vNewLoc, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit, optional float RefireTime);

// Export UTgPawn::execFlashArcing(FFrame&, void* const)
native function FlashArcing(int nDeviceInstanceId, int nFireModeNum, Vector vNewLoc, Vector vOldLoc, Actor Target, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit);

// Export UTgPawn::execFlashStopFire(FFrame&, void* const)
native function FlashStopFire(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashStartFire(FFrame&, void* const)
native function FlashStartFire(int nDeviceInstanceId, int nFireModeNum, float RefireTime, Actor Target, optional int nAmmoRemaining = 0);

// Export UTgPawn::execFlashReload(FFrame&, void* const)
native function FlashReload(int nDeviceInstanceId, float fReloadTime, optional int nAmmoRemaining = 0, optional int nReloadAnimType = 0);

// Export UTgPawn::execFlashCooldown(FFrame&, void* const)
native function FlashCooldown(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashCooldownDone(FFrame&, void* const)
native function FlashCooldownDone(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashBlock(FFrame&, void* const)
native function FlashBlock(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashBlockFx(FFrame&, void* const)
native function FlashBlockFx(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashBlockDone(FFrame&, void* const)
native function FlashBlockDone(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashInterrupt(FFrame&, void* const)
native function FlashInterrupt(int nDeviceInstanceId);

// Export UTgPawn::execFlashSuccessfulHit(FFrame&, void* const)
native function FlashSuccessfulHit(int nDeviceInstanceId, int nFireModeNum, Actor Target, float DamageAmount, Vector HitLocation, Vector HitNormal, optional ExtraDamageInfo ExtraInfo);

// Export UTgPawn::execFlashEventUpdate(FFrame&, void* const)
native function FlashEventUpdate();

// Export UTgPawn::execFlashModeEquipDone(FFrame&, void* const)
native function FlashModeEquipDone(int nDeviceInstanceId, int nFireModeNum);

// Export UTgPawn::execFlashHitReaction(FFrame&, void* const)
native function FlashHitReaction();

// Export UTgPawn::execFlashDestruct(FFrame&, void* const)
native function FlashDestruct(int nDeviceInstanceId, Vector vLocation);

// Export UTgPawn::execFlashChangeMesh(FFrame&, void* const)
native function FlashChangeMesh();

// Export UTgPawn::execFlashTeleportFx(FFrame&, void* const)
native function FlashTeleportFx(int nTeleportState, Vector vLocation);

// Export UTgPawn::execFlashLevelupFx(FFrame&, void* const)
native function FlashLevelupFx();

// Export UTgPawn::execFlashPlaySpecialEffect(FFrame&, void* const)
native function FlashPlaySpecialEffect(int PlaySpecialEffectIndex, optional Vector vLocation, optional Vector vHitNormal, optional Actor inActor);

// Export UTgPawn::execFlashSpawnSpecialFX(FFrame&, void* const)
native function FlashSpawnSpecialFX(int nFxID, Vector vLocation, optional Vector vNormal);

// Export UTgPawn::execFlashPetSuccessfulHit(FFrame&, void* const)
native function FlashPetSuccessfulHit(int nFxID);

// Export UTgPawn::execFlashGeneric1(FFrame&, void* const)
native function FlashGeneric1(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated = false, optional byte byExtraData = 0);

// Export UTgPawn::execFlashGeneric2(FFrame&, void* const)
native function FlashGeneric2(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated = false, optional byte byExtraData = 0);

// Export UTgPawn::execFlashGeneric3(FFrame&, void* const)
native function FlashGeneric3(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated = false, optional byte byExtraData = 0);

// Export UTgPawn::execFlashGeneric4(FFrame&, void* const)
native function FlashGeneric4(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated = false, optional byte byExtraData = 0);

// Export UTgPawn::execFlashGeneric5(FFrame&, void* const)
native function FlashGeneric5(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated = false, optional byte byExtraData = 0);

// Export UTgPawn::execFlashTransitionIn(FFrame&, void* const)
native function FlashTransitionIn(int nDeviceInstanceId, int nFireModeNum, float fTransitionPercent, float fTotalTransitionTime);

// Export UTgPawn::execFlashTransitionOut(FFrame&, void* const)
native function FlashTransitionOut(int nDeviceInstanceId, int nFireModeNum, float fTransitionPercent, float fTotalTransitionTime);

// Export UTgPawn::execFlashHitDirection(FFrame&, void* const)
native function FlashHitDirection(Vector vLocation, int nDamageAmount, Class<DamageType> DamageType, const out ExtraDamageInfo ExtraInfo);

// Export UTgPawn::execFlashKillOrAssist(FFrame&, void* const)
native function FlashKillOrAssist(Actor Target, bool bIsKill);

// Export UTgPawn::execReapplyLevelEffectGroups(FFrame&, void* const)
native function ReapplyLevelEffectGroups(optional int nPrevLevel = 0, optional int nCurrentLevel = 0, optional bool bPreserveParams = false);

// Export UTgPawn::execReapplyLoadoutEffects(FFrame&, void* const)
native function ReapplyLoadoutEffects(optional bool bKeepFiringMount);

// Export UTgPawn::execbIsEditor(FFrame&, void* const)
native function bool bIsEditor();

// Export UTgPawn::execDrawClientDebug(FFrame&, void* const)
native function DrawClientDebug();

// Export UTgPawn::execShowCombo(FFrame&, void* const)
native function ShowCombo(int nPawnId, optional bool bCrit = false);

// Export UTgPawn::execOnSpawnGatesOpened(FFrame&, void* const)
native function OnSpawnGatesOpened();

// Export UTgPawn::execTermRagdoll(FFrame&, void* const)
native function bool TermRagdoll();

// Export UTgPawn::execCancelEmote(FFrame&, void* const)
native function CancelEmote(optional bool bVerifyNoRelevantEmotes, optional TgAnimNodeEmoteSequence Exclude);

// Export UTgPawn::execAddRemoveAnimSetList(FFrame&, void* const)
native function AddRemoveAnimSetList(array<AnimSet> AnimSetList, bool bAdd);

// Export UTgPawn::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgPawn::execIsJumpDisabled(FFrame&, void* const)
native function bool IsJumpDisabled();

// Export UTgPawn::execCanSeeActor(FFrame&, void* const)
native function bool CanSeeActor(Actor Other);

// Export UTgPawn::execSetMeshVisibility(FFrame&, void* const)
native function SetMeshVisibility(bool bVisible);

// Export UTgPawn::execGetSpecialFx(FFrame&, void* const)
native static function TgSpecialFx GetSpecialFx(int nSpecialFxId);

// Export UTgPawn::execCreateMeshComponent(FFrame&, void* const)
native static function MeshComponent CreateMeshComponent(int nMeshId, optional MeshComponent DestComponent, optional bool bPartialFixup = false);

// Export UTgPawn::execAddPet(FFrame&, void* const)
native function AddPet(TgPawn PetPawn);

// Export UTgPawn::execSetPetOwner(FFrame&, void* const)
native function SetPetOwner(TgPawn petOwner);

// Export UTgPawn::execKillPet(FFrame&, void* const)
native function KillPet(TgPawn PetPawn);

// Export UTgPawn::execKillPets(FFrame&, void* const)
native function KillPets();

// Export UTgPawn::execIsMyPet(FFrame&, void* const)
native function bool IsMyPet(Actor Other);

// Export UTgPawn::execReportPetDeath(FFrame&, void* const)
native function ReportPetDeath(TgPawn PetPawn);

// Export UTgPawn::execKillOwnedBots(FFrame&, void* const)
native function KillOwnedBots();

// Export UTgPawn::execAdjustMeshTranslation(FFrame&, void* const)
native function AdjustMeshTranslation();

// Export UTgPawn::execSetTaskForceNumber(FFrame&, void* const)
native function SetTaskForceNumber(int nTaskForce);

// Export UTgPawn::execGetTaskForceNumber(FFrame&, void* const)
native function byte GetTaskForceNumber();

// Export UTgPawn::execGetPRI(FFrame&, void* const)
native function TgRepInfo_Player GetPRI();

// Export UTgPawn::execGetAccuracyModifier(FFrame&, void* const)
native function float GetAccuracyModifier(optional float ClientMovementTimeStamp);

// Export UTgPawn::execModifyAccuracyForReticleBloom(FFrame&, void* const)
native function ModifyAccuracyForReticleBloom(out float fAccuracy);

// Export UTgPawn::execValidateStatsTracker(FFrame&, void* const)
native function ValidateStatsTracker();

// Export UTgPawn::execStatsCleanup(FFrame&, void* const)
native function StatsCleanup();

// Export UTgPawn::execBeginStats(FFrame&, void* const)
native function BeginStats();

// Export UTgPawn::execEndStats(FFrame&, void* const)
native function EndStats();

// Export UTgPawn::execTrackDamagedPlayer(FFrame&, void* const)
native function TrackDamagedPlayer(TgPawn TargetPawn, int nDeviceModeID, int nDamage, int nDamageType, bool bInHand);

// Export UTgPawn::execTrackDamagedBot(FFrame&, void* const)
native function TrackDamagedBot(TgPawn TargetPawn, int nDeviceModeID, int nDamage, int nDamageType, optional bool bIsGod);

// Export UTgPawn::execTrackKilledPlayer(FFrame&, void* const)
native function TrackKilledPlayer(int nDeviceModeID);

// Export UTgPawn::execTrackFromPlayerDeath(FFrame&, void* const)
native function TrackFromPlayerDeath(int nDeviceModeID);

// Export UTgPawn::execTrackKilledBot(FFrame&, void* const)
native function TrackKilledBot(int nDeviceModeID);

// Export UTgPawn::execTrackHealing(FFrame&, void* const)
native function TrackHealing(int nDeviceModeID, float fDamage, float fMissingHealth, int nMaxHealth);

// Export UTgPawn::execTrackSelfHealing(FFrame&, void* const)
native function TrackSelfHealing(float fHealing, float fMissingHealth, int nMaxHealth);

// Export UTgPawn::execTrackBotHealing(FFrame&, void* const)
native function TrackBotHealing(int nDeviceModeID, float fDamage, float fMissingHealth, int nMaxHealth);

// Export UTgPawn::execTrackFired(FFrame&, void* const)
native function TrackFired(int nDeviceModeID);

// Export UTgPawn::execTrackCompleteKillInfo(FFrame&, void* const)
native function TrackCompleteKillInfo(int nKillerCharacterID, int nKillerDeviceModeID, int nVictimCharacterID, int nVictimDeviceModeID, Vector KillerLocation, Vector VictimLocation, Vector PetLocation, bool bPetKill);

// Export UTgPawn::execRemoveTrackFired(FFrame&, void* const)
native function RemoveTrackFired(int nDeviceModeID);

// Export UTgPawn::execTrackHit(FFrame&, void* const)
native function TrackHit(int nDeviceModeID, float fDistance, bool bHitPlayer);

// Export UTgPawn::execTrackReleaseTime(FFrame&, void* const)
native function TrackReleaseTime(int nDeviceModeID, float fReleaseTime);

// Export UTgPawn::execTrackTeamDamage(FFrame&, void* const)
native function TrackTeamDamage(int nDeviceModeID, int nDamage);

// Export UTgPawn::execTrackSelfDamage(FFrame&, void* const)
native function TrackSelfDamage(int nDeviceModeID, int nDamage);

// Export UTgPawn::execTrackTeamKill(FFrame&, void* const)
native function TrackTeamKill(int nDeviceModeID);

// Export UTgPawn::execTrackSelfKill(FFrame&, void* const)
native function TrackSelfKill(int nDeviceModeID);

// Export UTgPawn::execTrackDamageTaken(FFrame&, void* const)
native function TrackDamageTaken(TgPawn theInstigator, int nDamage, int nDamageType);

// Export UTgPawn::execTrackDamageMitigated(FFrame&, void* const)
native function TrackDamageMitigated(int nAmount);

// Export UTgPawn::execUpdateDamagers(FFrame&, void* const)
native function UpdateDamagers(TgPawn Damager);

// Export UTgPawn::execUpdateEnemyAssists(FFrame&, void* const)
native function UpdateEnemyAssists(TgPawn Assister);

// Export UTgPawn::execTrackKill(FFrame&, void* const)
native function TrackKill(TgPawn Killer);

// Export UTgPawn::execTrackDeath(FFrame&, void* const)
native function TrackDeath();

// Export UTgPawn::execUpdateHUDScores(FFrame&, void* const)
native function UpdateHUDScores();

// Export UTgPawn::execSetPhase(FFrame&, void* const)
native function SetPhase(int nNewPhase);

// Export UTgPawn::execPlaySoundCue(FFrame&, void* const)
native function PlaySoundCue(int nSoundCueId);

// Export UTgPawn::execShouldPawnMeshBeHiddenThisTick(FFrame&, void* const)
native function bool ShouldPawnMeshBeHiddenThisTick();

// Export UTgPawn::execShouldInHandDeviceBeHiddenThisTick(FFrame&, void* const)
native function bool ShouldInHandDeviceBeHiddenThisTick();

// Export UTgPawn::execIsInvisibleToAI(FFrame&, void* const)
native function bool IsInvisibleToAI();

// Export UTgPawn::execIsHittable(FFrame&, void* const)
native function bool IsHittable();

// Export UTgPawn::execCalcVolumeFadeValue(FFrame&, void* const)
native function CalcVolumeFadeValue(float fDeltaTime);

// Export UTgPawn::execCalcDistanceFadeValue(FFrame&, void* const)
native function CalcDistanceFadeValue(float fDeltaTime);

// Export UTgPawn::execCalcStealthFadeValue(FFrame&, void* const)
native function CalcStealthFadeValue(float fDeltaTime);

// Export UTgPawn::execCalcObscuringDeployableFadeValue(FFrame&, void* const)
native function CalcObscuringDeployableFadeValue(float fDeltaTime);

// Export UTgPawn::execCalcBlindingDeployableFadeValue(FFrame&, void* const)
native function CalcBlindingDeployableFadeValue(float fDeltaTime);

// Export UTgPawn::execOverrideDistanceFadeRange(FFrame&, void* const)
native function bool OverrideDistanceFadeRange();

// Export UTgPawn::execShouldShowHudOverlay(FFrame&, void* const)
native function bool ShouldShowHudOverlay(TgPawn PlayerPawn);

// Export UTgPawn::execCanBeAffectedByVortices(FFrame&, void* const)
native function bool CanBeAffectedByVortices();

// Export UTgPawn::execForceRecalculateMaterial(FFrame&, void* const)
native function ForceRecalculateMaterial();

// Export UTgPawn::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);

// Export UTgPawn::execUpdateDropShadow(FFrame&, void* const)
native function UpdateDropShadow();

// Export UTgPawn::execUpdateStealthMaterialBasedOnNearbyEnemies(FFrame&, void* const)
native function UpdateStealthMaterialBasedOnNearbyEnemies();

// Export UTgPawn::execSetScalarMaterialParamOnMesh(FFrame&, void* const)
native function SetScalarMaterialParamOnMesh(MeshComponent MeshComp, string sName, float fValue, optional int nMaterialIndex = -1);

// Export UTgPawn::execGetTerminalVelocity(FFrame&, void* const)
native function float GetTerminalVelocity();

// Export UTgPawn::execPlayCurrencyFx(FFrame&, void* const)
native function PlayCurrencyFx(TgRepInfo_Player sourcePRI, int nCurrency, int nMsgId);

// Export UTgPawn::execPlayTeleportFx(FFrame&, void* const)
native function PlayTeleportFx(int nTeleportState, Vector vLoc);

// Export UTgPawn::execPlaySpecialEffectEvent(FFrame&, void* const)
native function PlaySpecialEffectEvent(int PlaySpecialEffectIndex, Vector vLoc, Vector vHitNormal, optional Actor inActor);

simulated function PrepareIntro()
{
    //return;    
}

simulated function PlaySpawnFx()
{
    //return;    
}

// Export UTgPawn::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

// Export UTgPawn::execUpdatePhysicsAsset(FFrame&, void* const)
native function UpdatePhysicsAsset();

// Export UTgPawn::execGetDeviceByInstanceId(FFrame&, void* const)
native function TgDevice GetDeviceByInstanceId(int nDeviceInstanceId);

// Export UTgPawn::execGetDeviceById(FFrame&, void* const)
native function TgDevice GetDeviceById(int nDeviceId);

// Export UTgPawn::execShouldBlockFiringFrom1pSwitch(FFrame&, void* const)
native function bool ShouldBlockFiringFrom1pSwitch();

// Export UTgPawn::execGetCurrentInhandDevice(FFrame&, void* const)
native function TgDevice GetCurrentInhandDevice();

// Export UTgPawn::execIsStealthed(FFrame&, void* const)
native function bool IsStealthed(TgRepInfo_Player Viewer);

// Export UTgPawn::execIsHardStealthed(FFrame&, void* const)
native function bool IsHardStealthed();

// Export UTgPawn::execIsHardRevealed(FFrame&, void* const)
native function bool IsHardRevealed(TgRepInfo_Player Viewer);

// Export UTgPawn::execIsDetector(FFrame&, void* const)
native function bool IsDetector();

// Export UTgPawn::execPlayDetectedFx(FFrame&, void* const)
native function PlayDetectedFx();

// Export UTgPawn::execRemoveDetectedFx(FFrame&, void* const)
native function RemoveDetectedFx();

// Export UTgPawn::execNumVisibilityVolumesTouching(FFrame&, void* const)
native function int NumVisibilityVolumesTouching();

// Export UTgPawn::execFindVisibilityVolume(FFrame&, void* const)
native function int FindVisibilityVolume(TgVisibilityVolume VisVolume);

// Export UTgPawn::execIsInSameVisibilityVolume(FFrame&, void* const)
native function bool IsInSameVisibilityVolume(TgPawn Other);

// Export UTgPawn::execIsInSameVisibilityVolumeBeacon(FFrame&, void* const)
native function bool IsInSameVisibilityVolumeBeacon(TgRespawnBeaconExit Other);

// Export UTgPawn::execGetATouchingVisibilityVolume(FFrame&, void* const)
native function TgVisibilityVolume GetATouchingVisibilityVolume();

// Export UTgPawn::execIsInFriendlyObscuringDeployable(FFrame&, void* const)
native final function bool IsInFriendlyObscuringDeployable();

// Export UTgPawn::execIsInCommonEnemyObscuringDeployable(FFrame&, void* const)
native final function bool IsInCommonEnemyObscuringDeployable(TgPawn Viewer);

// Export UTgPawn::execIsInEnemyObscuringDeployable(FFrame&, void* const)
native final function bool IsInEnemyObscuringDeployable(TgPawn Viewer);

// Export UTgPawn::execIsDeployableObscuredFrom(FFrame&, void* const)
native final function bool IsDeployableObscuredFrom(TgPawn Viewer);

// Export UTgPawn::execIsDeployableBlindedFrom(FFrame&, void* const)
native final function bool IsDeployableBlindedFrom(Actor Viewer);

// Export UTgPawn::execLocalPlayerHasLOS(FFrame&, void* const)
native function bool LocalPlayerHasLOS();

// Export UTgPawn::execGetLocation(FFrame&, void* const)
native function Vector GetLocation();

// Export UTgPawn::execKillDeployables(FFrame&, void* const)
native function KillDeployables(bool bAll);

// Export UTgPawn::execSetMeshScalarValue(FFrame&, void* const)
native function SetMeshScalarValue(name ScalarParam, float ScalarValue);

// Export UTgPawn::execSetMeshVectorValue(FFrame&, void* const)
native function SetMeshVectorValue(name ScalarParam, const out LinearColor ColorValue);

// Export UTgPawn::execSetMeshComponentScalarValue(FFrame&, void* const)
native function SetMeshComponentScalarValue(MeshComponent theMesh, name ScalarParam, float ScalarValue);

// Export UTgPawn::execSetMeshComponentVectorValue(FFrame&, void* const)
native function SetMeshComponentVectorValue(MeshComponent theMesh, name ScalarParam, const out LinearColor ColorValue);

// Export UTgPawn::execGetHealthPercent(FFrame&, void* const)
native function float GetHealthPercent();

// Export UTgPawn::execGetManaPercent(FFrame&, void* const)
native function float GetManaPercent();

// Export UTgPawn::execSyncMana(FFrame&, void* const)
native function SyncMana();

// Export UTgPawn::execRegainPools(FFrame&, void* const)
native function RegainPools(float fDelta);

// Export UTgPawn::execRegainManaPool(FFrame&, void* const)
native function RegainManaPool(float fDelta);

// Export UTgPawn::execRegainEnergyPool(FFrame&, void* const)
native function RegainEnergyPool(float fDelta);

// Export UTgPawn::execIsFriendlyWithLocalPawn(FFrame&, void* const)
native final function bool IsFriendlyWithLocalPawn();

// Export UTgPawn::execPlayFullBodyAnim(FFrame&, void* const)
native function bool PlayFullBodyAnim(name AnimName, float Rate, float BlendInTime, float BlendOutTime, bool bLooping, bool bOverride, optional bool bBlendOutIfVelocityIsGreaterThanZero, optional bool bHideInHandDevice);

// Export UTgPawn::execPlayFullBodyLoopingAnimWithTransition(FFrame&, void* const)
native function float PlayFullBodyLoopingAnimWithTransition(name TransitionAnimName, name LoopingAnimName, float Rate, float BlendInTime, float BlendOutTime);

// Export UTgPawn::execPlayUpperBodyAnim(FFrame&, void* const)
native function PlayUpperBodyAnim(name AnimName, float Rate, float BlendInTime, float BlendOutTime, bool bLooping);

// Export UTgPawn::execCanMove(FFrame&, void* const)
native function bool CanMove();

// Export UTgPawn::execIsNonCombat(FFrame&, void* const)
native function bool IsNonCombat();

// Export UTgPawn::execLoadDazedMIC(FFrame&, void* const)
native function LoadDazedMIC(int FxId);

// Export UTgPawn::execDazedStrafeOffset(FFrame&, void* const)
native function float DazedStrafeOffset(float OffsetFromWorldTime);

// Export UTgPawn::execDazedRotatorOffset(FFrame&, void* const)
native function Vector2D DazedRotatorOffset(float OffsetFromWorldTime);

// Export UTgPawn::execPlayCustomAnimation(FFrame&, void* const)
native function PlayCustomAnimation(int nAnimResId, bool bFullBody, float fTime);

// Export UTgPawn::execUpdatePlayerStatUI(FFrame&, void* const)
native function UpdatePlayerStatUI();

// Export UTgPawn::execUpdateSpectatorStatUI(FFrame&, void* const)
native function UpdateSpectatorStatUI();

// Export UTgPawn::execForceUpdateComponents(FFrame&, void* const)
native function ForceUpdateComponents(optional bool bCollisionUpdate = false, optional bool bTransformOnly = true);

// Export UTgPawn::execAdjustRespawnTime(FFrame&, void* const)
native function float AdjustRespawnTime(float InRespawnTime);

// Export UTgPawn::execIsGod(FFrame&, void* const)
native function bool IsGod();

// Export UTgPawn::execIsGodDecoy(FFrame&, void* const)
native function bool IsGodDecoy();

// Export UTgPawn::execIsStatTrackable(FFrame&, void* const)
native function bool IsStatTrackable();

// Export UTgPawn::execTweenRelRotation(FFrame&, void* const)
native function Rotator TweenRelRotation(float fDeltaSeconds, Rotator currRel, Rotator targetRel);

// Export UTgPawn::execResetSkelControls(FFrame&, void* const)
native function ResetSkelControls(SkeletalMeshComponent SkelComp);

// Export UTgPawn::execIsGrabBreakable(FFrame&, void* const)
native function bool IsGrabBreakable(TgPawn.EGrabState tweenState);

// Export UTgPawn::execIsInOffensiveGrab(FFrame&, void* const)
native function bool IsInOffensiveGrab();

// Export UTgPawn::execIsPerformingOffensiveGrab(FFrame&, void* const)
native function bool IsPerformingOffensiveGrab();

// Export UTgPawn::execIsTweenBreakable(FFrame&, void* const)
native function bool IsTweenBreakable(TgPawn.ETweenState tweenState);

// Export UTgPawn::execIsInOffensiveTween(FFrame&, void* const)
native function bool IsInOffensiveTween();

// Export UTgPawn::execIsConfused(FFrame&, void* const)
native final function bool IsConfused();

// Export UTgPawn::execShouldBeFirstPersonThisTick(FFrame&, void* const)
native function bool ShouldBeFirstPersonThisTick();

// Export UTgPawn::execGiveEnergy(FFrame&, void* const)
native function GiveEnergy(float energy);

// Export UTgPawn::execAllowBoostedJump(FFrame&, void* const)
native function bool AllowBoostedJump();

// Export UTgPawn::execUpdateRespawnBeaconReticule(FFrame&, void* const)
native final function UpdateRespawnBeaconReticule(optional bool bForce);

// Export UTgPawn::execTryToPlayPainAkEvent(FFrame&, void* const)
private native final function TryToPlayPainAkEvent();

// Export UTgPawn::execSmoothCorrectionTranslationTick(FFrame&, void* const)
native function SmoothCorrectionTranslationTick(float DeltaSeconds, optional bool bForce);

// Export UTgPawn::execSetUncompressedRemoteViewPitch(FFrame&, void* const)
native final function SetUncompressedRemoteViewPitch(int Pitch);

// Export UTgPawn::execForceUpdateUncompressedRemoteYaw(FFrame&, void* const)
native final function ForceUpdateUncompressedRemoteYaw();

// Export UTgPawn::execReloadMeshAssemblies(FFrame&, void* const)
native function ReloadMeshAssemblies();

// Export UTgPawn::execGetChargeDirection(FFrame&, void* const)
native function Vector GetChargeDirection();

// Export UTgPawn::execTraceWorldPhysicalGeometry(FFrame&, void* const)
native simulated function PhysicalMaterial TraceWorldPhysicalGeometry(Vector StartLoc, Vector EndLoc, out Vector TraceHitLocation);

// Export UTgPawn::execMySpawnGatesAreOpen(FFrame&, void* const)
native function bool MySpawnGatesAreOpen();

// Export UTgPawn::execSetAkPlayerHealthPercent(FFrame&, void* const)
native function SetAkPlayerHealthPercent(float fPercent);

// Export UTgPawn::execUpdateReverbVolume(FFrame&, void* const)
native function UpdateReverbVolume(Vector WorldLocation, optional ReverbVolume VolumeTouched);

// Export UTgPawn::execGetCurrentReverbVolume(FFrame&, void* const)
native function ReverbVolume GetCurrentReverbVolume();

// Export UTgPawn::execGettReverbVolumeForAudioAltitude(FFrame&, void* const)
native function ReverbVolume GettReverbVolumeForAudioAltitude();

// Export UTgPawn::execPostAkEvent(FFrame&, void* const)
native function PostAkEvent(AkEvent InAkEvent);

// Export UTgPawn::execPostEmoteAkEvent(FFrame&, void* const)
native function PostEmoteAkEvent(AkEvent InAkEvent, TgPawn.EEmote Emote);

// Export UTgPawn::execIsCinematicMode(FFrame&, void* const)
native function bool IsCinematicMode();

// Export UTgPawn::execGetHealth(FFrame&, void* const)
native function float GetHealth();

// Export UTgPawn::execGetMaxHealth(FFrame&, void* const)
native function float GetMaxHealth();

// Export UTgPawn::execGetMana(FFrame&, void* const)
native function float GetMana();

// Export UTgPawn::execGetMaxMana(FFrame&, void* const)
native function float GetMaxMana();

// Export UTgPawn::execGetShieldHealth(FFrame&, void* const)
native function float GetShieldHealth();

// Export UTgPawn::execGetMaxShield(FFrame&, void* const)
native function float GetMaxShield();

// Export UTgPawn::execCanTakeHealthDamage(FFrame&, void* const)
native function bool CanTakeHealthDamage();

// Export UTgPawn::execCanDealHeadShots(FFrame&, void* const)
native function bool CanDealHeadShots();

// Export UTgPawn::execCanTakeHeadShots(FFrame&, void* const)
native function bool CanTakeHeadShots();

// Export UTgPawn::execOnlyTakeHeadShots(FFrame&, void* const)
native function bool OnlyTakeHeadShots();

// Export UTgPawn::execIsImmuneToDamage(FFrame&, void* const)
native function bool IsImmuneToDamage();

// Export UTgPawn::execCanBeExecuted(FFrame&, void* const)
native function bool CanBeExecuted();

// Export UTgPawn::execIsImmuneToHealing(FFrame&, void* const)
native function bool IsImmuneToHealing();

// Export UTgPawn::execBuffDamage(FFrame&, void* const)
native function BuffDamage(Actor Target, TgEffectDamage Effect, ImpactInfo Impact, float fBaseDamage, out float fProratedAmount, out ExtraDamageInfo ExtraInfo);

// Export UTgPawn::execGetSpecialDamageDealtPercentAI(FFrame&, void* const)
native function float GetSpecialDamageDealtPercentAI();

// Export UTgPawn::execGetSpecialDamageTakenPercentAI(FFrame&, void* const)
native function float GetSpecialDamageTakenPercentAI();

// Export UTgPawn::execMitigateHealthDamage(FFrame&, void* const)
native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);

// Export UTgPawn::execGetDamageReductionPerc(FFrame&, void* const)
native function float GetDamageReductionPerc(TgDevice damageDev, TgEffectGroup eg);

// Export UTgPawn::execTakeHealthDamage(FFrame&, void* const)
native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgPawn::execWillHitSuccessfully(FFrame&, void* const)
native function bool WillHitSuccessfully(Actor aInstigator, ImpactInfo Impact);

// Export UTgPawn::execCanBeLifestealInstigator(FFrame&, void* const)
native function bool CanBeLifestealInstigator();

// Export UTgPawn::execCanBeLifestealTarget(FFrame&, void* const)
native function bool CanBeLifestealTarget();

// Export UTgPawn::execCanTakeManaDamage(FFrame&, void* const)
native function bool CanTakeManaDamage();

// Export UTgPawn::execTakeManaDamage(FFrame&, void* const)
native function TakeManaDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgPawn::execCanTakeShieldDamage(FFrame&, void* const)
native function bool CanTakeShieldDamage();

// Export UTgPawn::execCanUsePersonalShield(FFrame&, void* const)
native function bool CanUsePersonalShield();

// Export UTgPawn::execTakePersonalShieldDamage(FFrame&, void* const)
native function int TakePersonalShieldDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgPawn::execShieldDamageAppliesToHealth(FFrame&, void* const)
native function bool ShieldDamageAppliesToHealth();

// Export UTgPawn::execTakeStealthDamage(FFrame&, void* const)
native function TakeStealthDamage(float fDamage);

// Export UTgPawn::execGetDamageToLeaveStealth(FFrame&, void* const)
native function float GetDamageToLeaveStealth();

// Export UTgPawn::execHandleNotificationsForAI(FFrame&, void* const)
native function HandleNotificationsForAI(float fStatChange, TgPawn InstigatorPawn);

// Export UTgPawn::execGetPropCurrentValue(FFrame&, void* const)
native function float GetPropCurrentValue(int nPropIndex);

// Export UTgPawn::execGetPropCurrentValueByName(FFrame&, void* const)
native function float GetPropCurrentValueByName(string propName);

// Export UTgPawn::execGetPropIndex(FFrame&, void* const)
native function int GetPropIndex(int nPropId);

// Export UTgPawn::execGetMarkedPercent(FFrame&, void* const)
native function float GetMarkedPercent(Actor InstigatorPawn);

// Export UTgPawn::execGetMarkedPercentInhand(FFrame&, void* const)
native function float GetMarkedPercentInhand(Actor InstigatorPawn);

// Export UTgPawn::execIsMarkedForMarkShot(FFrame&, void* const)
native function bool IsMarkedForMarkShot();

// Export UTgPawn::execGetEffectManager(FFrame&, void* const)
native function TgEffectManager GetEffectManager();

// Export UTgPawn::execGetDesignType(FFrame&, void* const)
native function TgCombatActor.GameplayDesignType GetDesignType();

// Export UTgPawn::execIsPet(FFrame&, void* const)
native function bool IsPet();

// Export UTgPawn::execGetPetOwner(FFrame&, void* const)
native function Actor GetPetOwner();

// Export UTgPawn::execCheckUiVolumeTriggers(FFrame&, void* const)
native function CheckUiVolumeTriggers();

// Export UTgPawn::execGetTargetCenter(FFrame&, void* const)
native function Vector GetTargetCenter();

// Export UTgPawn::execNativeReplicatedEvent(FFrame&, void* const)
native function bool NativeReplicatedEvent(name VarName);

// Export UTgPawn::execOnLevelUp(FFrame&, void* const)
native function OnLevelUp();

// Export UTgPawn::execOnProjectileExploded(FFrame&, void* const)
native function OnProjectileExploded(TgProjectile ExplodedProjectile, Actor HitActor, Vector HitLocation, Vector HitNormal);

// Export UTgPawn::execOnProjectileHitTarget(FFrame&, void* const)
native function OnProjectileHitTarget(TgProjectile HittingProjectile, Vector HitLocation, Vector HitNormal, out byte bDestroyProjectile);

// Export UTgPawn::execOnPostureChange(FFrame&, void* const)
native function OnPostureChange();

// Export UTgPawn::execNativeGetCollisionHeight(FFrame&, void* const)
native function float NativeGetCollisionHeight();

// Export UTgPawn::execNativeGetCollisionRadius(FFrame&, void* const)
native function float NativeGetCollisionRadius();

// Export UTgPawn::execOnSetPlayerLevel(FFrame&, void* const)
native function OnSetPlayerLevel(TgSeqAct_SetPlayerLevel Action);

// Export UTgPawn::execGetAirControl(FFrame&, void* const)
native function float GetAirControl();

// Export UTgPawn::execCanKnockbackAffectAC(FFrame&, void* const)
native function bool CanKnockbackAffectAC();

// Export UTgPawn::execIsInFireLock(FFrame&, void* const)
native function bool IsInFireLock();

// Export UTgPawn::execConsumePowerPool(FFrame&, void* const)
native function ConsumePowerPool(TgDevice Dev, int nPacingType, float fAmount);

// Export UTgPawn::execGetCurrentPowerPoolValue(FFrame&, void* const)
native function float GetCurrentPowerPoolValue(int nPacingType);

// Export UTgPawn::execGetMaxPowerPoolValue(FFrame&, void* const)
native function float GetMaxPowerPoolValue(int nPacingType);

// Export UTgPawn::execServerUpdateLockedTarget(FFrame&, void* const)
reliable server native function bool ServerUpdateLockedTarget(Actor Locked);

// Export UTgPawn::execHasDeathPostureAnimation(FFrame&, void* const)
native exec function bool HasDeathPostureAnimation();

// Export UTgPawn::execUpdateMountScale(FFrame&, void* const)
native function UpdateMountScale(bool bIsMounted);

// Export UTgPawn::execGetPhysicalPower(FFrame&, void* const)
native function float GetPhysicalPower();

// Export UTgPawn::execGetMagicalPower(FFrame&, void* const)
native function float GetMagicalPower();

// Export UTgPawn::execGetUtilityPower(FFrame&, void* const)
native function float GetUtilityPower();

// Export UTgPawn::execGetPhysicalPowerBot(FFrame&, void* const)
native function float GetPhysicalPowerBot();

// Export UTgPawn::execGetMagicalPowerBot(FFrame&, void* const)
native function float GetMagicalPowerBot();

// Export UTgPawn::execGetUtilityPowerBot(FFrame&, void* const)
native function float GetUtilityPowerBot();

// Export UTgPawn::execGetPhysicalPowerItem(FFrame&, void* const)
native function float GetPhysicalPowerItem();

// Export UTgPawn::execGetMagicalPowerItem(FFrame&, void* const)
native function float GetMagicalPowerItem();

// Export UTgPawn::execGetUtilityPowerItem(FFrame&, void* const)
native function float GetUtilityPowerItem();

// Export UTgPawn::execGetLifeSteal(FFrame&, void* const)
native function float GetLifeSteal();

// Export UTgPawn::execGetLifeStealInstigatorOnly(FFrame&, void* const)
native function float GetLifeStealInstigatorOnly(TgPawn InstigatorPawn);

// Export UTgPawn::execGetVengeanceLifesteal(FFrame&, void* const)
native function float GetVengeanceLifesteal(TgPawn Target);

// Export UTgPawn::execGetCombatDurationReduction(FFrame&, void* const)
native function float GetCombatDurationReduction();

// Export UTgPawn::execGetHealthRegen(FFrame&, void* const)
native function float GetHealthRegen();

// Export UTgPawn::execGetManaRegen(FFrame&, void* const)
native function float GetManaRegen();

// Export UTgPawn::execGetEnergyRegen(FFrame&, void* const)
native function float GetEnergyRegen();

// Export UTgPawn::execGetEnergy(FFrame&, void* const)
native function float GetEnergy();

// Export UTgPawn::execGetMaxEnergy(FFrame&, void* const)
native function float GetMaxEnergy();

// Export UTgPawn::execGetMaxHealthWithoutPercentBuff(FFrame&, void* const)
native function float GetMaxHealthWithoutPercentBuff();

// Export UTgPawn::execGetMaxShieldHealth(FFrame&, void* const)
native function float GetMaxShieldHealth();

// Export UTgPawn::execGetVisionRange(FFrame&, void* const)
native function float GetVisionRange();

// Export UTgPawn::execGetHealingTakenPerc(FFrame&, void* const)
native function float GetHealingTakenPerc();

// Export UTgPawn::execGetHealingTakenOthersPerc(FFrame&, void* const)
native function float GetHealingTakenOthersPerc();

// Export UTgPawn::execApplyDamageTakenScaling(FFrame&, void* const)
native function float ApplyDamageTakenScaling(float Value);

// Export UTgPawn::execGetProtectionCC(FFrame&, void* const)
native function float GetProtectionCC();

// Export UTgPawn::execGetDamageTakenPerc(FFrame&, void* const)
native function float GetDamageTakenPerc();

// Export UTgPawn::execGetDamageTakenPercInhand(FFrame&, void* const)
native function float GetDamageTakenPercInhand();

// Export UTgPawn::execGetDamageTakenPercAOE(FFrame&, void* const)
native function float GetDamageTakenPercAOE();

// Export UTgPawn::execGetDamageTakenPercDirect(FFrame&, void* const)
native function float GetDamageTakenPercDirect();

// Export UTgPawn::execGetDamageTakenPercPhys(FFrame&, void* const)
native function float GetDamageTakenPercPhys();

// Export UTgPawn::execGetDamageCapPercMaxHP(FFrame&, void* const)
native function float GetDamageCapPercMaxHP();

// Export UTgPawn::execGetDamageCapPercCurHP(FFrame&, void* const)
native function float GetDamageCapPercCurHP();

// Export UTgPawn::execGetDamageDealtPerc(FFrame&, void* const)
native function float GetDamageDealtPerc();

// Export UTgPawn::execGetDamageDealtPercBasicAttack(FFrame&, void* const)
native function float GetDamageDealtPercBasicAttack();

// Export UTgPawn::execGetDamageDealtPercPhysical(FFrame&, void* const)
native function float GetDamageDealtPercPhysical();

// Export UTgPawn::execGetDamageDealtPercMagical(FFrame&, void* const)
native function float GetDamageDealtPercMagical();

// Export UTgPawn::execGetDamageDealtPercDeployableTarget(FFrame&, void* const)
native function float GetDamageDealtPercDeployableTarget();

// Export UTgPawn::execGetDamageDealtPercShieldTarget(FFrame&, void* const)
native function float GetDamageDealtPercShieldTarget();

// Export UTgPawn::execGetDamageDealtFlat(FFrame&, void* const)
native function float GetDamageDealtFlat();

// Export UTgPawn::execGetHealBlock(FFrame&, void* const)
native function float GetHealBlock();

// Export UTgPawn::execGetMinimapRequireLOS(FFrame&, void* const)
native function bool GetMinimapRequireLOS();

// Export UTgPawn::execGetBackpedalPercent(FFrame&, void* const)
native function float GetBackpedalPercent();

// Export UTgPawn::execGetUIGroundSpeed(FFrame&, void* const)
native function float GetUIGroundSpeed();

// Export UTgPawn::execGetProcChanceMultiplier(FFrame&, void* const)
native function float GetProcChanceMultiplier();

// Export UTgPawn::execSetSpawnHealth(FFrame&, void* const)
native function SetSpawnHealth();

// Export UTgPawn::execSetSpawnMana(FFrame&, void* const)
native function SetSpawnMana();

// Export UTgPawn::execSetSpawnEnergy(FFrame&, void* const)
native function SetSpawnEnergy();

// Export UTgPawn::execPawnOnDamaged(FFrame&, void* const)
native function PawnOnDamaged(out OnDamagedParams Params);

// Export UTgPawn::execPawnOnPreDamageMitigation(FFrame&, void* const)
native function PawnOnPreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);

// Export UTgPawn::execPawnOnDamageMitigation(FFrame&, void* const)
native function PawnOnDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);

// Export UTgPawn::execPawnOnHealed(FFrame&, void* const)
native function PawnOnHealed(out OnHealedParams Params);

// Export UTgPawn::execPawnOnKilled(FFrame&, void* const)
native function PawnOnKilled(Actor pVictim);

// Export UTgPawn::execPawnOnAssisted(FFrame&, void* const)
native function PawnOnAssisted(Actor pVictim);

// Export UTgPawn::execPawnOnRevive(FFrame&, void* const)
native function PawnOnRevive();

// Export UTgPawn::execPawnOnEnterCombat(FFrame&, void* const)
native function PawnOnEnterCombat();

// Export UTgPawn::execPawnOnExitCombat(FFrame&, void* const)
native function PawnOnExitCombat();

// Export UTgPawn::execPawnOnBecomeStill(FFrame&, void* const)
native function PawnOnBecomeStill();

// Export UTgPawn::execPawnOnEndStill(FFrame&, void* const)
native function PawnOnEndStill();

// Export UTgPawn::execPawnOnXp(FFrame&, void* const)
native function PawnOnXp(out int nXp, Actor Source);

// Export UTgPawn::execPawnOnCurrency(FFrame&, void* const)
native function PawnOnCurrency(out int nCurrency, Actor Source);

// Export UTgPawn::execPawnOnTaskforceRemove(FFrame&, void* const)
native function PawnOnTaskforceRemove(TgRepInfo_TaskForce tf);

// Export UTgPawn::execPawnOnTaskforceAdd(FFrame&, void* const)
native function PawnOnTaskforceAdd(TgRepInfo_TaskForce tf);

// Export UTgPawn::execPawnOnModifyEffectLifeTime(FFrame&, void* const)
native function PawnOnModifyEffectLifeTime(TgEffectGroup eg, out float fLifeTime);

// Export UTgPawn::execPawnCanDisplayImmuneMessage(FFrame&, void* const)
native function bool PawnCanDisplayImmuneMessage();

// Export UTgPawn::execPawnOnStartSprint(FFrame&, void* const)
native function PawnOnStartSprint();

// Export UTgPawn::execPawnOnEndSprint(FFrame&, void* const)
native function PawnOnEndSprint();

// Export UTgPawn::execPawnOnPetSuccessfulHit(FFrame&, void* const)
native function PawnOnPetSuccessfulHit(int nFxID);

// Export UTgPawn::execPawnOnLand(FFrame&, void* const)
native function PawnOnLand();

// Export UTgPawn::execPawnOnLandAfterJump(FFrame&, void* const)
native function PawnOnLandAfterJump();

// Export UTgPawn::execPawnOnLandAfterLeap(FFrame&, void* const)
native function PawnOnLandAfterLeap();

// Export UTgPawn::execPawnOnDamageInterruptedStealth(FFrame&, void* const)
native function PawnOnDamageInterruptedStealth();

// Export UTgPawn::execPawnOnPetAdded(FFrame&, void* const)
native function PawnOnPetAdded(TgPawn Pet, TgPawn petOwner);

// Export UTgPawn::execPawnOnPetDied(FFrame&, void* const)
native function PawnOnPetDied(TgPawn Pet, TgPawn petOwner);

// Export UTgPawn::execPawnOnTeleported(FFrame&, void* const)
native function PawnOnTeleported(TgSpawnTeleporterEntrance From, TgSpawnTeleporterExit To, Vector OriginalPawnLocation);

// Export UTgPawn::execDeviceOnStartBuildup(FFrame&, void* const)
native function DeviceOnStartBuildup(TgDevice Dev);

// Export UTgPawn::execDeviceOnStopBuildup(FFrame&, void* const)
native function DeviceOnStopBuildup(TgDevice Dev, optional bool WasInterrupted = false);

// Export UTgPawn::execDeviceOnFire(FFrame&, void* const)
native function DeviceOnFire(TgDevice Dev);

// Export UTgPawn::execProjectileOnFire(FFrame&, void* const)
native function ProjectileOnFire(TgProjectile Proj);

// Export UTgPawn::execDeviceOnStartFire(FFrame&, void* const)
native function DeviceOnStartFire(TgDevice Dev);

// Export UTgPawn::execDeviceOnStopFire(FFrame&, void* const)
native function DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted = false);

// Export UTgPawn::execDeviceOnStartCooldown(FFrame&, void* const)
native function DeviceOnStartCooldown(TgDevice Dev, float fCooldownTime);

// Export UTgPawn::execDeviceOnStopCooldown(FFrame&, void* const)
native function DeviceOnStopCooldown(TgDevice Dev);

// Export UTgPawn::execDeviceOnPostHit(FFrame&, void* const)
native function DeviceOnPostHit(TgDevice Dev);

// Export UTgPawn::execDeviceOnHit(FFrame&, void* const)
native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);

// Export UTgPawn::execDeviceOnHitSpecial(FFrame&, void* const)
native function DeviceOnHitSpecial(TgDevice Dev, const out ImpactInfo Impact, int nHitSpecialSituationalType);

// Export UTgPawn::execDeviceOnDamaged(FFrame&, void* const)
native function DeviceOnDamaged(out OnDamagedParams Params);

// Export UTgPawn::execDeviceOnHealed(FFrame&, void* const)
native function DeviceOnHealed(out OnHealedParams Params);

// Export UTgPawn::execDeviceOnKilled(FFrame&, void* const)
native function DeviceOnKilled(TgDevice Dev, const out ImpactInfo Impact, float fDamage);

// Export UTgPawn::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn::execDeviceAdjustHeal(FFrame&, void* const)
native function DeviceAdjustHeal(const out AdjustHealParams Params, out float fHeal);

// Export UTgPawn::execDeviceHasEnoughPowerPool(FFrame&, void* const)
native function bool DeviceHasEnoughPowerPool(TgDevice Dev, byte FireModeNum);

// Export UTgPawn::execDeviceOnSetFireMode(FFrame&, void* const)
native function DeviceOnSetFireMode(TgDevice Dev);

// Export UTgPawn::execDeployableOnDeployed(FFrame&, void* const)
native function DeployableOnDeployed(TgDeployable dep);

// Export UTgPawn::execDeployableOnDestroyed(FFrame&, void* const)
native function DeployableOnDestroyed(TgDeployable dep);

// Export UTgPawn::execDeployableOnApplyEffect(FFrame&, void* const)
native function DeployableOnApplyEffect(TgDeployable dep, Actor HitActor);

// Export UTgPawn::execDeployableOnRemoveEffect(FFrame&, void* const)
native function DeployableOnRemoveEffect(TgDeployable dep, Actor HitActor);

// Export UTgPawn::execEffectGroupOnSetActive(FFrame&, void* const)
native function EffectGroupOnSetActive(bool bActive, bool bRemoving, TgEffectGroup EffectGroup);

// Export UTgPawn::execRetouchAllVolumes(FFrame&, void* const)
native function RetouchAllVolumes();

// Export UTgPawn::execSwapToDestroyedMesh(FFrame&, void* const)
native function SwapToDestroyedMesh();

// Export UTgPawn::execSwapToLiveMesh(FFrame&, void* const)
native function SwapToLiveMesh();

// Export UTgPawn::execOnMeshSwapped(FFrame&, void* const)
native function OnMeshSwapped();

// Export UTgPawn::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn::execCacheHitReactionSkelControls(FFrame&, void* const)
native function CacheHitReactionSkelControls();

// Export UTgPawn::execInitializeOverlayMeshComponent(FFrame&, void* const)
native function int InitializeOverlayMeshComponent(SkeletalMeshComponent InMesh, optional bool bIs1POverlay);

// Export UTgPawn::execInitializeOverlayIndexBody(FFrame&, void* const)
native function int InitializeOverlayIndexBody(SkeletalMeshComponent ParentMesh, bool bIs1POverlay);

// Export UTgPawn::execInitializeOverlayIndexWeapon(FFrame&, void* const)
native function int InitializeOverlayIndexWeapon(SkeletalMeshComponent ParentMesh, bool bIs1POverlay);

// Export UTgPawn::execInitializeOverlayInfo(FFrame&, void* const)
native function MaterialInstanceConstant InitializeOverlayInfo(TgPawn.OverlayMICType Type, Texture NormalMap, Texture MaskMap);

// Export UTgPawn::execGetOverlayMaterial(FFrame&, void* const)
native function MaterialInstanceConstant GetOverlayMaterial(TgPawn.OverlayMICType Type);

// Export UTgPawn::execGetOverlayDepthPriority(FFrame&, void* const)
native function Scene.ESceneDepthPriorityGroup GetOverlayDepthPriority(TgPawn.OverlayMICType Type);

// Export UTgPawn::execIs1PBodyOverlay(FFrame&, void* const)
native function bool Is1PBodyOverlay(TgPawn.OverlayMICType Type);

// Export UTgPawn::execIs1PWeaponOverlay(FFrame&, void* const)
native function bool Is1PWeaponOverlay(TgPawn.OverlayMICType Type);

// Export UTgPawn::execIs3PBodyOverlay(FFrame&, void* const)
native function bool Is3PBodyOverlay(TgPawn.OverlayMICType Type);

// Export UTgPawn::execIs3PWeaponOverlay(FFrame&, void* const)
native function bool Is3PWeaponOverlay(TgPawn.OverlayMICType Type);

// Export UTgPawn::execReinitializeOverlays(FFrame&, void* const)
native function ReinitializeOverlays();

// Export UTgPawn::execRemoveOverlayInfo(FFrame&, void* const)
native function bool RemoveOverlayInfo(SkeletalMeshComponent ParentMesh);

// Export UTgPawn::execSwapOverlayMICsBody(FFrame&, void* const)
native function SwapOverlayMICsBody(TgPawn.OverlayMICType Type);

// Export UTgPawn::execSwapOverlayMICsWeapon(FFrame&, void* const)
native function SwapOverlayMICsWeapon(TgPawn.OverlayMICType Type);

// Export UTgPawn::execUpdateOverlayVisibilityBody(FFrame&, void* const)
native function UpdateOverlayVisibilityBody();

// Export UTgPawn::execUpdateOverlayVisibilityWeapon(FFrame&, void* const)
native function UpdateOverlayVisibilityWeapon();

// Export UTgPawn::execToggleOverlay1P3P(FFrame&, void* const)
native function ToggleOverlay1P3P(bool bActivate1P);

// Export UTgPawn::execShouldForceHideOverlaysBody(FFrame&, void* const)
native function bool ShouldForceHideOverlaysBody();

// Export UTgPawn::execShouldForceHideOverlaysWeapon(FFrame&, void* const)
native function bool ShouldForceHideOverlaysWeapon();

// Export UTgPawn::execReplaceMaterial(FFrame&, void* const)
native function ReplaceMaterial(MaterialInstanceConstant materialToUse, optional float ParamValue = 0.0000000);

// Export UTgPawn::execClearReplacementMaterial(FFrame&, void* const)
native function ClearReplacementMaterial();

// Export UTgPawn::execInitializeSilhouetteComponent(FFrame&, void* const)
native function int InitializeSilhouetteComponent(MeshComponent InMesh);

// Export UTgPawn::execReinitializeSilhouettes(FFrame&, void* const)
native function ReinitializeSilhouettes();

// Export UTgPawn::execFindSilhouetteInfo(FFrame&, void* const)
native function int FindSilhouetteInfo(MeshComponent ParentMesh);

// Export UTgPawn::execRemoveSilhouetteInfo(FFrame&, void* const)
native function bool RemoveSilhouetteInfo(MeshComponent ParentMesh);

// Export UTgPawn::execSetSilhouetteState(FFrame&, void* const)
native function SetSilhouetteState(MeshComponent ParentMesh, TgPawn.OverlayState NewState);

// Export UTgPawn::execToggleSilhouetteVisibility(FFrame&, void* const)
native function ToggleSilhouetteVisibility(bool bVisible, optional bool bDead);

// Export UTgPawn::execDropHealthNugget(FFrame&, void* const)
native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn::execDropHealthNuggetTeamOnly(FFrame&, void* const)
native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn::execFxActivateGroupAllMesh(FFrame&, void* const)
native function FxActivateGroupAllMesh(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm, optional bool bSkipWeaponMesh);

// Export UTgPawn::execFxDeactivateGroupAllMesh(FFrame&, void* const)
native function FxDeactivateGroupAllMesh(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bSkipWeaponMesh);

// Export UTgPawn::execFxActivateGroupSelf(FFrame&, void* const)
native function FxActivateGroupSelf(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxReactivateGroupSelf(FFrame&, void* const)
native function FxReactivateGroupSelf(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxDeactivateGroupSelf(FFrame&, void* const)
native function FxDeactivateGroupSelf(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgPawn::execFxActivateGroupBody(FFrame&, void* const)
native function Object FxActivateGroupBody(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxReactivateGroupBody(FFrame&, void* const)
native function Object FxReactivateGroupBody(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxDeactivateGroupBody(FFrame&, void* const)
native function FxDeactivateGroupBody(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgPawn::execFxActivateGroupHead(FFrame&, void* const)
native function Object FxActivateGroupHead(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxReactivateGroupHead(FFrame&, void* const)
native function Object FxReactivateGroupHead(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxDeactivateGroupHead(FFrame&, void* const)
native function FxDeactivateGroupHead(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgPawn::execFxActivateGroupWeapon(FFrame&, void* const)
native function FxActivateGroupWeapon(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxReactivateGroupWeapon(FFrame&, void* const)
native function FxReactivateGroupWeapon(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxDeactivateGroupWeapon(FFrame&, void* const)
native function FxDeactivateGroupWeapon(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgPawn::execFxActivateGroupWeapon1P(FFrame&, void* const)
native function Object FxActivateGroupWeapon1P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxReactivateGroupWeapon1P(FFrame&, void* const)
native function Object FxReactivateGroupWeapon1P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxDeactivateGroupWeapon1P(FFrame&, void* const)
native function FxDeactivateGroupWeapon1P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgPawn::execFxActivateGroupWeapon3P(FFrame&, void* const)
native function Object FxActivateGroupWeapon3P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxReactivateGroupWeapon3P(FFrame&, void* const)
native function Object FxReactivateGroupWeapon3P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);

// Export UTgPawn::execFxDeactivateGroupWeapon3P(FFrame&, void* const)
native function FxDeactivateGroupWeapon3P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);

// Export UTgPawn::execBeginLocalKillRTPC(FFrame&, void* const)
native function BeginLocalKillRTPC();

// Export UTgPawn::execEndLocalKillRTPC(FFrame&, void* const)
native function EndLocalKillRTPC();

// Export UTgPawn::execBeginLocalDeathRTPC(FFrame&, void* const)
native function BeginLocalDeathRTPC();

// Export UTgPawn::execEndLocalDeathRTPC(FFrame&, void* const)
native function EndLocalDeathRTPC();

// Export UTgPawn::execOnEnterItemShop(FFrame&, void* const)
native function OnEnterItemShop();

// Export UTgPawn::execOnLeaveItemShop(FFrame&, void* const)
native function OnLeaveItemShop();

// Export UTgPawn::execOnDismount(FFrame&, void* const)
native function OnDismount();

simulated event int PushPosture(TgPawn.TG_POSTURE Posture)
{
    local int I, NewPostureGUID;
    local bool WasInserted;

    WasInserted = false;
    NewPostureGUID = m_PostureStack.NewPostureGUID;
    ++m_PostureStack.NewPostureGUID;
    I = 0;
    J0x5B:

    // End:0x13F [Loop If]
    if(I < m_PostureStack.Postures.Length)
    {
        // End:0x131
        if(int(m_PostureStack.Postures[I]) > int(Posture))
        {
            m_PostureStack.Postures.InsertItem(I, Posture);
            m_PostureStack.GUIDs.InsertItem(I, NewPostureGUID);
            WasInserted = true;
            // [Explicit Break]
            goto J0x13F;
        }
        ++I;
        // [Loop Continue]
        goto J0x5B;
    }
    J0x13F:

    // End:0x1BD
    if(!WasInserted)
    {
        m_PostureStack.Postures.AddItem(Posture);
        m_PostureStack.GUIDs.AddItem(NewPostureGUID);
        m_ePosture = Posture;
        OnPostureChange();
    }
    return NewPostureGUID;
    //return ReturnValue;    
}

simulated event bool PopPosture(int PostureID)
{
    local int Index;
    local bool Success;

    Success = false;
    Index = m_PostureStack.GUIDs.Find(PostureID);
    // End:0x13E
    if(Index != -1)
    {
        m_PostureStack.GUIDs.Remove(Index, 1);
        m_PostureStack.Postures.Remove(Index, 1);
        // End:0x119
        if(m_PostureStack.Postures.Length > 0)
        {
            m_ePosture = m_PostureStack.Postures[m_PostureStack.Postures.Length - 1];
            OnPostureChange();            
        }
        else
        {
            m_ePosture = 0;
            OnPostureChange();
        }
        Success = true;        
    }
    else
    {
        Success = false;
    }
    return Success;
    //return ReturnValue;    
}

simulated function GetAimAssistBounds(const out Vector ObserverLocation, out float Width, out float Height, out Vector Center)
{
    local TgGameplayCurvesSet_AimAssistBounds BoundsCurves;
    local float fBoundsScaleX, fBoundsScaleY;

    GetAimFrictionExtent(Width, Height, Center);
    // End:0xE6
    if(m_GameplayCurves != none)
    {
        BoundsCurves = TgGameplayCurvesSet_AimAssistBounds(m_GameplayCurves.GetCurvesSetByType(22));
        // End:0xE6
        if(BoundsCurves != none)
        {
            BoundsCurves.GetBoundsScale(VSize(ObserverLocation - Center), fBoundsScaleX, fBoundsScaleY);
            Width *= fBoundsScaleX;
            Height *= fBoundsScaleY;
        }
    }
    //return;    
}

simulated function Actor GetActorFromCombatActor()
{
    return self;
    //return ReturnValue;    
}

function PossessedBy(Controller C, bool bVehicleTransition)
{
    local TgRepInfo_Player TgPRI;

    super(Pawn).PossessedBy(C, bVehicleTransition);
    // End:0x30
    if(BotRankId == -1)
    {
    }
    // End:0x81
    if((TgAIController(C) == none) && !bVehicleTransition)
    {
        C.SetBotRankId(BotRankId);
    }
    // End:0xB8
    if(PlayerReplicationInfo != none)
    {
        PlayerReplicationInfo.SetBotRankId(BotRankId);
    }
    TgPRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x1AE
    if(TgPRI != none)
    {
        TgPRI.UpdateHealth(Health, int(GetMaxHealth()));
        TgPRI.r_PawnOwner = self;
        // End:0x186
        if(TgPRI.r_nPawnId == 0)
        {
            TgPRI.r_nPawnId = r_nPawnId;            
        }
        else
        {
            r_nPawnId = TgPRI.r_nPawnId;
        }
    }
    // End:0x22F
    if(((int(Role) == int(ROLE_Authority)) && TgPRI != none) && !TgPRI.bOnlySpectator)
    {
        ValidateStatsTracker();
        m_LastDamager = none;
        m_LastDamagerTimeStamp = 0;
        s_Damagers.Remove(0, s_Damagers.Length);
    }
    // End:0x286
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && C.IsLocalPlayerController())
    {
        TgPawnControllerSet();
    }
    //return;    
}

function UnPossessed()
{
    local TgRepInfo_Player PRI;

    // End:0x55
    if(TgAIController(Controller) == none)
    {
        Controller.SetBotRankId(Controller.default.BotRankId);
    }
    // End:0xA1
    if(PlayerReplicationInfo != none)
    {
        PlayerReplicationInfo.SetBotRankId(Controller.BotRankId);
    }
    PRI = GetPRI();
    // End:0xE4
    if(PRI != none)
    {
        PRI.r_PawnOwner = none;
    }
    // End:0x103
    if(int(Role) == int(ROLE_Authority))
    {
        SetUncompressedRemoteViewPitch(0);
    }
    StopFiringAllDevices(false, false);
    super(Pawn).UnPossessed();
    //return;    
}

simulated function OnGetTeamIndex(TgSeqAct_GetTeamIndex Action)
{
    local TeamInfo Team;

    Team = GetPRI().r_TaskForce;
    SeqVar_Int(Action.VariableLinks[1].LinkedVariables[0]).IntValue = ((Team == none) ? 255 : Team.TeamIndex);
    //return;    
}

simulated function OnGetTaskForceNumber(TgSeqAct_GetTaskForceNumber Action)
{
    SeqVar_Int(Action.VariableLinks[1].LinkedVariables[0]).IntValue = int(GetTaskForceNumber());
    //return;    
}

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    SetTaskForceNumber(Action.TaskForceNumber);
    //return;    
}

simulated function OnUIAlert(TgSeqAct_UIAlert Action)
{
    local TgPlayerController PC;

    PC = TgPlayerController(Controller);
    // End:0x72
    if(PC != none)
    {
        PC.AddAlertScript(1, 0, 5.0000000, Action.nMsgId);
    }
    //return;    
}

function OnSetCrowdControlImmune(TgSeqAct_SetCrowdControlImmune inAction)
{
    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        m_bIsCrowdControlImmuneKismet = true;        
    }
    else
    {
        // End:0x8C
        if(inAction.InputLinks[1].bHasImpulse)
        {
            m_bIsCrowdControlImmuneKismet = false;            
        }
        else
        {
            m_bIsCrowdControlImmuneKismet = !m_bIsCrowdControlImmuneKismet;
        }
    }
    //return;    
}

event CollisionChanged()
{
    super(Actor).CollisionChanged();
    ModifyPawnPropertiesVolumeChanged();
    //return;    
}

event Falling()
{
    local TgAIController aic;

    aic = TgAIController(Controller);
    // End:0x4A
    if(aic != none)
    {
        aic.Falling();
    }
    //return;    
}

simulated function OnKillpawns(TgSeqAct_Killpawns Action)
{
    // End:0x1C
    if(!IsInState('Dying'))
    {
        Suicide();
    }
    //return;    
}

function OnDespawnBots(TgSeqAct_DespawnBots inAction)
{
    // End:0x1A
    if(!IsHumanControlled())
    {
        Despawn();
    }
    //return;    
}

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    local editinline TgSkeletalMeshComponent smcomp;
    local int I;

    super(Pawn).PostInitAnimTree(SkelComp);
    // End:0x41
    if(Mesh == none)
    {
        smcomp = TgSkeletalMeshComponent(SkelComp);        
    }
    else
    {
        smcomp = TgSkeletalMeshComponent(Mesh);
    }
    // End:0x147
    if(smcomp != none)
    {
        CacheMainMeshReferences(smcomp);
        ClearMultiMeshAnimNodeReferences();
        CacheMultiMeshAnimNodeReferences(smcomp);
        // End:0xD3
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.FixUpReferencesToPawnMesh(smcomp);
        }
        I = 0;
        J0xDE:

        // End:0x147 [Loop If]
        if(I < 33)
        {
            // End:0x139
            if(c_EquipForm[I] != none)
            {
                c_EquipForm[I].Cache3PAnimNodes(smcomp);
            }
            I++;
            // [Loop Continue]
            goto J0xDE;
        }
    }
    //return;    
}

simulated function CacheMainMeshReferences(TgSkeletalMeshComponent smcomp)
{
    local TgAnimNodePlayFireAnim FireNode;

    // End:0x152
    if(smcomp != none)
    {
        m_UpperBodyAnimNode = TgAnimNodeSlot(smcomp.Animations.FindAnimNode('UpperBody'));
        m_FullBodyAnimNode = TgAnimNodeSlot(smcomp.Animations.FindAnimNode('FullBody'));
        m_SprintBlendNode = TgAnimNodeBlendList(smcomp.Animations.FindAnimNode('MountBlend'));
        // End:0x147
        foreach smcomp.AllAnimNodes(Class'TgGame.TgAnimNodePlayFireAnim', FireNode)
        {
            m_FireAnimNode = FireNode;            
        }        
        CacheHitReactionSkelControls();
    }
    //return;    
}

simulated function ClearMultiMeshAnimNodeReferences()
{
    m_StanceTransitionerNodes.Length = 0;
    m_SimpleTransitionerNodes.Length = 0;
    m_FireBlendNodes.Length = 0;
    m_DeviceModeBlendNodes.Length = 0;
    m_CombatWarinessBlendNodes.Length = 0;
    m_PostureBlendNodes.Length = 0;
    m_HitOrMissBlendNodes.Length = 0;
    m_AnimNodeEmoteSwitches.Length = 0;
    m_EmoteBlendNodes.Length = 0;
    m_EmoteSequenceNodes.Length = 0;
    m_AnimNodeBlendByIntroductions.Length = 0;
    m_AnimNodeBlendByHitReactions.Length = 0;
    m_BuffCampIntroNodes.Length = 0;
    m_SkelControlLocks.Length = 0;
    //return;    
}

simulated function CacheMultiMeshAnimNodeReferences(TgSkeletalMeshComponent smcomp)
{
    local array<AnimNode> StanceTransitionerNodes, FireBlendNodes, DeviceModeBlendNodes, CombatWarinessBlendNodes, BlendByPostureNodes, HitOrMissBlendNodes,
	    AnimNodeEmoteSwitches, AnimNodeEmoteBlendNodes, AnimNodeEmoteSequenceNodes, AnimNodeBlendByIntroductions, AnimNodeBlendByHitReactions,
	    AnimNodeBlendByBuffCampIntro;

    local AnimNode AnimNodeSearchIterator;

    // End:0x6C0
    if(smcomp != none)
    {
        smcomp.Animations.GetNodesByClassWrapper(StanceTransitionerNodes, Class'TgGame.TgAnimNodeStanceTransitioner');
        // End:0x8C
        foreach StanceTransitionerNodes(AnimNodeSearchIterator)
        {
            m_StanceTransitionerNodes.AddItem(TgAnimNodeStanceTransitioner(AnimNodeSearchIterator));            
        }        
        StanceTransitionerNodes.Length = 0;
        smcomp.Animations.GetNodesByClassWrapper(StanceTransitionerNodes, Class'TgGame.TgAnimNodeSimpleTransitioner');
        // End:0x116
        foreach StanceTransitionerNodes(AnimNodeSearchIterator)
        {
            m_SimpleTransitionerNodes.AddItem(TgAnimNodeSimpleTransitioner(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(FireBlendNodes, Class'TgGame.TgAnimBlendByFire');
        // End:0x194
        foreach FireBlendNodes(AnimNodeSearchIterator)
        {
            m_FireBlendNodes.AddItem(TgAnimBlendByFire(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(DeviceModeBlendNodes, Class'TgGame.TgAnimBlendByFireMode');
        // End:0x212
        foreach DeviceModeBlendNodes(AnimNodeSearchIterator)
        {
            m_DeviceModeBlendNodes.AddItem(TgAnimBlendByFireMode(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(CombatWarinessBlendNodes, Class'TgGame.TgAnimNodeBlendByCombatWariness');
        // End:0x290
        foreach CombatWarinessBlendNodes(AnimNodeSearchIterator)
        {
            m_CombatWarinessBlendNodes.AddItem(TgAnimNodeBlendByCombatWariness(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(BlendByPostureNodes, Class'TgGame.TgAnimBlendByPosture');
        // End:0x30E
        foreach BlendByPostureNodes(AnimNodeSearchIterator)
        {
            m_PostureBlendNodes.AddItem(TgAnimBlendByPosture(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(HitOrMissBlendNodes, Class'Engine.AnimNodeBlendList');
        // End:0x3B8
        foreach HitOrMissBlendNodes(AnimNodeSearchIterator)
        {
            // End:0x3B7
            if(AnimNodeSearchIterator.NodeName == 'HitOrMissBlendList')
            {
                m_HitOrMissBlendNodes.AddItem(AnimNodeBlendList(AnimNodeSearchIterator));
            }            
        }        
        smcomp.Animations.GetNodesByClassWrapper(AnimNodeEmoteSwitches, Class'TgGame.TgAnimNodeEmoteSwitch');
        // End:0x436
        foreach AnimNodeEmoteSwitches(AnimNodeSearchIterator)
        {
            m_AnimNodeEmoteSwitches.AddItem(TgAnimNodeEmoteSwitch(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(AnimNodeEmoteBlendNodes, Class'TgGame.TgAnimBlendByEmote');
        // End:0x4B4
        foreach AnimNodeEmoteBlendNodes(AnimNodeSearchIterator)
        {
            m_EmoteBlendNodes.AddItem(TgAnimBlendByEmote(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(AnimNodeEmoteSequenceNodes, Class'TgGame.TgAnimNodeEmoteSequence');
        // End:0x532
        foreach AnimNodeEmoteSequenceNodes(AnimNodeSearchIterator)
        {
            m_EmoteSequenceNodes.AddItem(TgAnimNodeEmoteSequence(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(AnimNodeBlendByIntroductions, Class'TgGame.TgAnimNodeBlendByIntroduction');
        // End:0x5B0
        foreach AnimNodeBlendByIntroductions(AnimNodeSearchIterator)
        {
            m_AnimNodeBlendByIntroductions.AddItem(TgAnimNodeBlendByIntroduction(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(AnimNodeBlendByHitReactions, Class'TgGame.TgAnimNodeBlendByHitReaction');
        // End:0x62E
        foreach AnimNodeBlendByHitReactions(AnimNodeSearchIterator)
        {
            m_AnimNodeBlendByHitReactions.AddItem(TgAnimNodeBlendByHitReaction(AnimNodeSearchIterator));            
        }        
        smcomp.Animations.GetNodesByClassWrapper(AnimNodeBlendByBuffCampIntro, Class'TgGame.TgAnimBlendByBuffMonsterIntro');
        // End:0x6AC
        foreach AnimNodeBlendByBuffCampIntro(AnimNodeSearchIterator)
        {
            m_BuffCampIntroNodes.AddItem(TgAnimBlendByBuffMonsterIntro(AnimNodeSearchIterator));            
        }        
        CacheSkelControlLocks(smcomp);
    }
    //return;    
}

simulated function CacheSkelControlLocks(TgSkeletalMeshComponent smcomp)
{
    local name SkelConName;
    local SkelControlBase SkelCon;

    // End:0x7F
    if(smcomp != none)
    {
        // End:0x7E
        foreach m_SkelControlLockNames(SkelConName)
        {
            SkelCon = smcomp.FindSkelControl(SkelConName);
            // End:0x7D
            if(SkelCon != none)
            {
                m_SkelControlLocks.AddItem(SkelCon);
            }            
        }        
    }
    //return;    
}

simulated function ToggleSkelControlLocks(bool bOn)
{
    local SkelControlBase SkelCon;

    // End:0x41
    foreach m_SkelControlLocks(SkelCon)
    {
        SkelCon.SetSkelControlActive(bOn);        
    }    
    //return;    
}

// Export UTgPawn::execAllManifestsLoaded(FFrame&, void* const)
native simulated function AllManifestsLoaded();

simulated event PreBeginPlay()
{
    super(Pawn).PreBeginPlay();
    c_AssetManifestGroup.__OnAllManifestsLoaded__Delegate = AllManifestsLoaded;
    //return;    
}

simulated function SetLocalPlayer()
{
    local TgPlayerController PC;

    // End:0x23
    foreach LocalPlayerControllers(Class'TgGame.TgPlayerController', PC)
    {
        // End:0x23
        break;        
    }    
    c_LocalPC = PC;
    //return;    
}

simulated function PostBeginPlay()
{
    local Rotator R;

    super(Pawn).PostBeginPlay();
    // End:0x28
    if(int(Role) < int(ROLE_Authority))
    {
        FlashResetReplication();
    }
    // End:0x5B
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        SetLocalPlayer();
    }
    // End:0x104
    if((int(Role) == int(ROLE_Authority)) && TgGame(WorldInfo.Game) != none)
    {
        r_nPawnId = TgGame(WorldInfo.Game).GetNextActorInstanceId();
        SetTimer(5.0000000, false, 'ClearSpawnFxTimer');
        r_bNeedPlaySpawnFx = true;
    }
    // End:0x198
    if((int(Role) == int(ROLE_Authority)) && r_EffectManager == none)
    {
        r_EffectManager = Spawn(Class'TgGame.TgEffectManager', self,, vect(0.0000000, 0.0000000, 0.0000000));
        r_EffectManager.r_Owner = self;
        r_EffectManager.Instigator = self;
    }
    R.Yaw = Rotation.Yaw;
    SetRotation(R);
    InitializeDefaultProps();
    UpdateHUDScores();
    //return;    
}

function ClearSpawnFxTimer()
{
    r_bNeedPlaySpawnFx = false;
    //return;    
}

function SetupPIEMesh(GameInfo.PIEPawnMeshTypes PIEPawnType, int BotId)
{
    r_nProfileId = BotId;
    r_nSkinId = 0;
    r_nHeadSkinId = 0;
    r_nWeaponSkinId = 0;
    r_nMountSkinId = 0;
    //return;    
}

function CrushedBy(Pawn OtherPawn)
{
    //return;    
}

simulated event bool PostPawnSetup()
{
    local TgPlayerController PC;

    // End:0x22
    if(int(Role) == int(ROLE_SimulatedProxy))
    {
        DeviceFormChanged(true);        
    }
    else
    {
        MissionTimeUpdate();
    }
    // End:0xC2
    if(Mesh != none)
    {
        Mesh.SetRBChannel(2);
        Mesh.SetRBCollidesWithChannel(2, true);
        Mesh.SetRBCollidesWithChannel(16, false);
        Mesh.SetRBCollidesWithChannel(15, true);
    }
    SetUsePhysicsWithAnimation(!WorldInfo.IsPlayingDemo() && TgPlayerController(GetALocalPlayerController()).AllowRagdoll());
    // End:0x140
    if(IsAliveAndWell())
    {
        FxActivateGroupSelf('WhileAlive', 0);
    }
    // End:0x16E
    if(!WorldInfo.IsPlayingDemo())
    {
        CheckUiVolumeTriggers();
    }
    // End:0x22C
    if(WorldInfo.IsPlayingTimelapse())
    {
        PC = TgPlayerController(GetALocalPlayerController());
        // End:0x22C
        if((((r_nPawnId > 0) && PC != none) && PC.m_nKillCamTargetId == r_nPawnId) && !bTearOff)
        {
            PC.ForceKillCamViewTargetChange(self);
        }
    }
    return true;
    //return ReturnValue;    
}

reliable server function MissionTimeUpdate()
{
    TgRepInfo_Game(WorldInfo.GRI).MissionTimeUpdateAllClients();
    //return;    
}

simulated event bool IsCustomCharacter()
{
    return false;
    //return ReturnValue;    
}

simulated function PreRender(Canvas Canvas)
{
    //return;    
}

function SetDeathZoomInfo(TgPawn theKiller, TgRepInfo_Player theKillerPRI, int nHealthPct, int nDeviceId, optional TgRepInfo_Player OwnerPRI)
{
    //return;    
}

event Suicide()
{
    SetDeathZoomInfo(self, TgRepInfo_Player(PlayerReplicationInfo), Health, 0);
    super(Pawn).Suicide();
    //return;    
}

event Despawn()
{
    r_eDeathReason = 1;
    Suicide();
    //return;    
}

event DespawnOnReconnect()
{
    r_eDeathReason = 2;
    ModifyHealthProp(int(GetHealth()));
    Health = 0;
    Died(none, none, Location);
    //return;    
}

simulated function OnJoinTeam(TgSeqAct_JoinTeam Action)
{
    local TgPawn leader;
    local TgAIController aic;
    local TgRepInfo_Player PRI;

    leader = TgPawn(Action.TeamLeader);
    aic = TgAIController(Controller);
    // End:0x128
    if((leader != none) && aic != none)
    {
        PRI = TgRepInfo_Player(aic.PlayerReplicationInfo);
        // End:0x128
        if(PRI != none)
        {
            PRI.SetTeam(leader.GetPRI().r_TaskForce);
            aic.m_pOwner = leader;
        }
    }
    //return;    
}

simulated function TakeFallingDamage()
{
    //return;    
}

event UpdateDeathReason()
{
    // End:0x78
    if((int(r_eDeathReason) != int(1)) && int(r_eDeathReason) != int(2))
    {
        // End:0x78
        if(r_EffectManager != none)
        {
            // End:0x6C
            if(r_EffectManager.s_FreezeBehaviorCount > 0)
            {
                r_eDeathReason = 3;                
            }
            else
            {
                r_eDeathReason = 0;
            }
        }
    }
    //return;    
}

event bool ShouldScoreKill()
{
    return true;
    //return ReturnValue;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local TgDevice Dev;
    local int I;
    local TgRepInfo_Player killerPlayerRep;
    local TgRepInfo_TaskForce killerTaskForce;
    local TgGame_Paladins TgG;
    local TgPlayerController TgPC;
    local TgPawn TgKillerPawn;
    local TgGameplayEventsWriter TgEventWriter;

    // End:0x2A
    if(dmgType == Class'Engine.DmgType_Suicided')
    {
        dmgType = Class'TgGame.TgDamageType';
    }
    // End:0x5E
    if((int(r_eDeathReason) != int(1)) && int(r_eDeathReason) != int(2))
    {
        TrackDeath();
    }
    // End:0x9E
    if(Killer != none)
    {
        killerPlayerRep = TgRepInfo_Player(Killer.PlayerReplicationInfo);
    }
    // End:0xE4
    if(killerPlayerRep != none)
    {
        killerTaskForce = killerPlayerRep.r_TaskForce;
        // End:0xE4
        if(killerTaskForce == none)
        {
        }
    }
    // End:0x10B
    if(dmgType == Class'TgGame.TgDamageType_FallOutOfWorld')
    {
        PlayEmoteAtWorldLocation(9);        
    }
    else
    {
        // End:0x131
        if(dmgType == Class'TgGame.TgDamageType_PaladinsExecute')
        {
            r_eDeathReason = 4;            
        }
        else
        {
            PlayEmoteAtWorldLocation(7);
        }
    }
    I = 0;
    J0x149:

    // End:0x1D4 [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0x1C6
        if(Dev != none)
        {
            // End:0x1C6
            if(Dev.r_bConsumedOnDeath)
            {
                Dev.ConsumeDevice();
            }
        }
        I++;
        // [Loop Continue]
        goto J0x149;
    }
    InterruptInhandReload();
    // End:0x227
    if(TgAIController(Controller) != none)
    {
        TgAIController(Controller).NotifyKilledBy(Killer);
    }
    // End:0x24B
    if(m_bIgnoreTearOffMomentum)
    {
        TearOffMomentum = vect(0.0000000, 0.0000000, 0.0000000);
    }
    bReplicateMovement = false;
    TgPC = TgPlayerController(Controller);
    // End:0x349
    if(TgPC != none)
    {
        TgPC.ClientPlayForceFeedbackWaveform(m_DeathFFWaveform);
        // End:0x349
        if((Killer != none) && WorldInfo.IsRecordingTimelapse())
        {
            TgKillerPawn = TgPawn(Killer.Pawn);
            // End:0x349
            if(TgKillerPawn != none)
            {
                TgPC.SetKillCamTarget(TgKillerPawn);
            }
        }
    }
    // End:0x3F0
    if(!super(Pawn).Died(Killer, dmgType, HitLocation))
    {
        Health--;
        // End:0x3D1
        if(ShouldScoreKill())
        {
            WorldInfo.Game.ScoreKill(Killer, Controller);
        }
        PlayDying(dmgType, HitLocation);        
    }
    else
    {
        bPlayedDeath = true;
        bTearOff = true;
    }
    // End:0x472
    if(TgRepInfo_Player(PlayerReplicationInfo) != none)
    {
        TgRepInfo_Player(PlayerReplicationInfo).bForceNetUpdate = true;
        TgRepInfo_Player(PlayerReplicationInfo).UpdatePlayerLocation();
    }
    // End:0x4A2
    if((int(Role) == int(ROLE_Authority)) && r_bIsKnockedBack)
    {
        Knock(false);
    }
    // End:0x4C2
    if(int(Role) == int(ROLE_Authority))
    {
        SetHUDOverlayState(ROLE_AutonomousProxy);
    }
    // End:0x4F1
    if(r_Owner != none)
    {
        r_Owner.ReportPetDeath(self);
    }
    TgG = TgGame_Paladins(WorldInfo.Game);
    // End:0x746
    if(TgG != none)
    {
        TgG.OnPawnDied(self);
        // End:0x5A3
        if((!TgG.m_bRespawnBots && Controller != none) && TgAIController_BehaviorGod(Controller) != none)
        {
            Destroy();
        }
        // End:0x746
        if((TgG.GameplayEventsWriter != none) && TgG.GameplayEventsWriter.IsSessionInProgress())
        {
            TgEventWriter = TgGameplayEventsWriter(TgG.GameplayEventsWriter);
            // End:0x6F3
            if(TgEventWriter != none)
            {
                // End:0x6AF
                if((Killer == none) || Killer == Controller)
                {
                    TgEventWriter.LogPaladinsPlayerKillDeath(1002, 2001, Controller, dmgType, Controller);                    
                }
                else
                {
                    TgEventWriter.LogPaladinsPlayerKillDeath(1002, 2002, Controller, dmgType, Killer);
                }
            }
            TgG.GameplayEventsWriter.LogPlayerKillDeath(108, 200, Controller, dmgType, Killer);
        }
    }
    // End:0x860
    if(m_WeaponMesh != none)
    {
        // End:0x7AE
        if(m_WeaponMesh.m_WeaponMesh1P != none)
        {
            m_WeaponMesh.m_WeaponMesh1P.SetHidden(true);
        }
        // End:0x807
        if(m_WeaponMesh.m_HandsMesh != none)
        {
            m_WeaponMesh.m_HandsMesh.SetHidden(true);
        }
        // End:0x860
        if(m_WeaponMesh.m_HeadMesh1P != none)
        {
            m_WeaponMesh.m_HeadMesh1P.SetHidden(true);
        }
    }
    return true;
    //return ReturnValue;    
}

simulated event Destroyed()
{
    local TgDevice Dev;
    local int I;
    local TgPlayerController PC;

    StatsCleanup();
    KillAllOwnedPets();
    // End:0x2E
    if(r_TargetActor != none)
    {
        r_TargetActor = none;
    }
    // End:0x60
    if(m_WeaponMesh != none)
    {
        m_WeaponMesh.Destroy();
        m_WeaponMesh = none;
    }
    // End:0x10C
    if(int(Role) == int(ROLE_Authority))
    {
        I = 0;
        J0x7F:

        // End:0x10C [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0xFE
            if((Dev != none) && Dev.r_bConsumedOnDeath)
            {
                Dev.ConsumeDevice();
            }
            I++;
            // [Loop Continue]
            goto J0x7F;
        }
    }
    // End:0x13A
    if(c_CurrentTargetingDevice != none)
    {
        c_CurrentTargetingDevice.ExitTargetingMode();
    }
    // End:0x18B
    if(r_EffectManager != none)
    {
        r_EffectManager.ClearAllClientEffectForms();
        r_EffectManager.Destroy();
        r_EffectManager = none;
    }
    // End:0x1B2
    if(s_PetBotFactory != none)
    {
        s_PetBotFactory.Destroy();
    }
    I = 0;
    J0x1BD:

    // End:0x205 [Loop If]
    if(I < s_PetLocationList.Length)
    {
        s_PetLocationList[I].Destroy();
        I++;
        // [Loop Continue]
        goto J0x1BD;
    }
    // End:0x25B
    if((AIController(Controller) != none) && !Controller.IsPendingKill())
    {
        Controller.Destroy();
    }
    // End:0x360
    if(WorldInfo.IsPlayingTimelapse())
    {
        PC = TgPlayerController(GetALocalPlayerController());
        // End:0x360
        if((((PC != none) && PC.Pawn != self) && !PC.bDeleteMe || PC.bPendingDelete) && PC.GetViewTarget() == self)
        {
            PC.ForceKillCamViewTargetChange();
        }
    }
    super(Pawn).Destroyed();
    // End:0x39D
    if(m_AkActorUnoccluded != none)
    {
        m_AkActorUnoccluded.LifeSpan = 2.0000000;
    }
    //return;    
}

simulated event KillAllOwnedPets()
{
    // End:0x33
    if(int(Role) == int(ROLE_Authority))
    {
        KillDeployables(true);
        KillPets();
        KillOwnedBots();
    }
    //return;    
}

simulated function bool CanChangeInHandDeviceOrMode()
{
    // End:0x12
    if(IsInState('KnockedDown'))
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated event PutInHandDeviceAwayFast(TgDeviceForm form)
{
    // End:0x3F
    if(int(m_eEquippedInHand) != int(0))
    {
        c_EquipForm[int(m_eEquippedInHand)].EndDevicePuttingDown();
    }
    m_eEquippedInHand = 0;
    //return;    
}

exec function ShowAnimSets()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x46 [Loop If]
    if(I < Mesh.AnimSets.Length)
    {
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function EquipPendingDeviceTimer(optional bool SkipPlayAnim = false)
{
    // End:0x4B
    if(c_EquipForm[int(m_eEquippedInHand)] != none)
    {
        c_EquipForm[int(m_eEquippedInHand)].EndDevicePuttingDown();
    }
    m_eEquippedInHand = r_eDesiredInHand;
    // End:0xB0
    if(c_EquipForm[int(m_eEquippedInHand)] != none)
    {
        c_EquipForm[int(m_eEquippedInHand)].BeginDeviceTakingOut(!SkipPlayAnim);
    }
    //return;    
}

function OnDeviceFormEnteredTargetingMode(TgDeviceForm form)
{
    //return;    
}

function OnDeviceFormExitedTargetingMode(TgDeviceForm form)
{
    //return;    
}

exec function UIH()
{
    DeviceFormChanged();
    //return;    
}

simulated event AnimSwapDevice()
{
    // End:0x46
    if(c_EquipForm[int(m_eEquippedInHand)] != none)
    {
        c_EquipForm[int(m_eEquippedInHand)].DeviceAnimNotify();
    }
    //return;    
}

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp = true)
{
    local TgDevice altFireInhandDev;
    local bool bSuccess;
    local TgClientSettings Settings;
    local TgPlayerController TgPC;

    // End:0x17
    if(Dev == none)
    {
        return false;
    }
    bSuccess = false;
    TgPC = TgPlayerController(Controller);
    // End:0x1B3
    if(int(Dev.r_eEquippedAt) == int(16))
    {
        altFireInhandDev = m_EquippedDevices[1];
        // End:0x1B0
        if((altFireInhandDev != none) && altFireInhandDev.m_bAltFireEnabled)
        {
            switch(altFireInhandDev.m_AltFireType)
            {
                // End:0x129
                case 3:
                    bSuccess = Dev.Use();
                    altFireInhandDev.Use();
                    // End:0x1B0
                    break;
                // End:0x15B
                case 2:
                    bSuccess = Dev.Use();
                    // End:0x1B0
                    break;
                // End:0x160
                case 1:
                // End:0xFFFF
                default:
                    altFireInhandDev.AltUse(true);
                    bSuccess = altFireInhandDev.IsFiring();
                    // End:0x1B0
                    break;
                    break;
            }
        }        
    }
    else
    {
        bSuccess = Dev.Use();
    }
    // End:0x245
    if(((TgPC != none) && bSuccess) && int(Dev.r_eEquippedAt) == int(5))
    {
        TgPC.PlayEventFX();
    }
    c_CurrentStartActionDevice = none;
    // End:0x40F
    if(!bSuccess && int(Dev.m_eCachedDeviceFailType) != int(0))
    {
        failType = Dev.m_eCachedDeviceFailType;
        // End:0x40F
        if(TgPC != none)
        {
            Settings = TgPC.GetClientSettings();
            // End:0x40F
            if(((Settings != none) && int(Settings.GetCastMode(r_nProfileId, c_CurrentTargetingDevice.r_eEquippedAt)) != int(0)) && Settings.bUseCastQueueing)
            {
                // End:0x40F
                if((int(failType) == int(10)) && int(Dev.r_eEquippedAt) != int(1))
                {
                    c_CurrentStartActionDevice = Dev;
                    failType = 0;
                    bSuccess = true;
                    // End:0x40F
                    if(bUpdateTimeStamp)
                    {
                        c_fShouldStartActionTimeStamp = WorldInfo.TimeSeconds;
                    }
                }
            }
        }
    }
    // End:0x4BA
    if(!bSuccess)
    {
        // End:0x4BA
        if(Dev.IsAbility() && Dev.IsDeviceCoolingDown())
        {
            // End:0x4BA
            if((Dev.m_EndOfLastFireTimeStamp + 3.0000000) <= WorldInfo.TimeSeconds)
            {
                PlayEmoteSelfOnly(38);
            }
        }
    }
    return bSuccess;
    //return ReturnValue;    
}

simulated event StopAction(TgDevice Dev)
{
    local TgDevice altFireInhandDev;
    local TgPlayerController TgPC;
    local TgControlModule_StunTaunted StunTauntControlModule;

    // End:0x11
    if(Dev == none)
    {
        return;
    }
    // End:0x2B
    if(TgDevice_HitPulse(Dev) != none)
    {
        return;
    }
    TgPC = TgPlayerController(Controller);
    // End:0xE0
    if(TgPC != none)
    {
        StunTauntControlModule = TgControlModule_StunTaunted(TgPC.ControlModule);
        // End:0xE0
        if(((StunTauntControlModule != none) && StunTauntControlModule.m_bIsActive) && Dev.m_bHandDevice)
        {
            return;
        }
    }
    // End:0x29E
    if(int(Dev.r_eEquippedAt) == int(16))
    {
        altFireInhandDev = m_EquippedDevices[1];
        // End:0x29B
        if((altFireInhandDev != none) && altFireInhandDev.m_bAltFireEnabled)
        {
            switch(altFireInhandDev.m_AltFireType)
            {
                // End:0x17E
                case 3:
                // End:0x270
                case 2:
                    // End:0x208
                    if(Dev.IsFunctionallyToggleDevice())
                    {
                        // End:0x205
                        if(Dev.CanBeCanceled())
                        {
                            Dev.OnCanceled();
                            Dev.StopFire();
                        }                        
                    }
                    else
                    {
                        // End:0x26D
                        if(Dev.IsFiring() && Dev.bPendingFire)
                        {
                            Dev.StopFire();
                        }
                    }
                    // End:0x29B
                    break;
                // End:0x275
                case 1:
                // End:0xFFFF
                default:
                    altFireInhandDev.AltUse(false);
                    // End:0x29B
                    break;
                    break;
            }
        }        
    }
    else
    {
        Dev.StopFire();
    }
    //return;    
}

simulated event StopFiringAllDevices(optional bool bClearEquipEffectFlag, optional bool bResetCooldowns, optional bool bKeepFiringMount, optional bool bServerDeviceLockout = false)
{
    local int I;
    local TgDevice Dev;
    local bool bWasActive;

    I = 1;
    J0x13:

    // End:0x1A0 [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0x192
        if(Dev != none)
        {
            // End:0xCF
            if((I != 23) || !bKeepFiringMount)
            {
                Dev.DeviceShutDown(bClearEquipEffectFlag, bResetCooldowns);
                // End:0xCF
                if(bServerDeviceLockout)
                {
                    Dev.StopFiringServerDeviceLockout();
                }
            }
            // End:0x192
            if(bClearEquipEffectFlag)
            {
                bWasActive = Dev.IsActive();
                Dev.m_bEquipEffectsApplied = false;
                // End:0x192
                if((bWasActive && int(Role) == int(ROLE_Authority)) && !Dev.IsCard())
                {
                    Dev.CeaseActive(true);
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x13;
    }
    // End:0x1D1
    if((int(RemoteRole) == int(ROLE_AutonomousProxy)) && bServerDeviceLockout)
    {
        ClientStopFiringAllDevices(true, true, true, true);
    }
    //return;    
}

function PutAllCardsOnCooldown()
{
    local int I;
    local TgDevice Dev;

    // End:0x9E
    if(false)
    {
        I = 1;
        J0x0F:

        // End:0x9E [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0x90
            if((Dev != none) && Dev.IsCard())
            {
                Dev.StartCooldown();
            }
            I++;
            // [Loop Continue]
            goto J0x0F;
        }
    }
    //return;    
}

reliable client simulated function ClientStopFiringAllDevices(optional bool bClearEquipEffectFlag, optional bool bResetCooldowns, optional bool bKeepFiringMount, optional bool bServerDeviceLockout = false)
{
    StopFiringAllDevices(bClearEquipEffectFlag, bResetCooldowns, bKeepFiringMount, bServerDeviceLockout);
    //return;    
}

simulated event RestartAllDevices()
{
    local TgDevice Dev;
    local int I;

    I = 1;
    J0x0B:

    // End:0x74 [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0x66
        if(Dev != none)
        {
            Dev.DeviceRestart();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

// Export UTgPawn::execSwapEquippedDevices(FFrame&, void* const)
native function SwapEquippedDevices(TgDevice newDev, int nEqpSlot);

// Export UTgPawn::execSyncDeviceTimers(FFrame&, void* const)
native function SyncDeviceTimers(TgDevice SourceDevice, TgDevice DestinationDevice);

simulated function OnDeviceFormBuildup(int nEquipSlot, float fBuildupTime)
{
    local TgAnimBlendByFire IteratorA;
    local TgDeviceForm form;

    form = c_EquipForm[nEquipSlot];
    // End:0x80
    if(form != none)
    {
        // End:0x7F
        foreach m_FireBlendNodes(IteratorA)
        {
            IteratorA.OnDeviceFormBuildup(c_EquipForm[nEquipSlot], fBuildupTime);            
        }        
    }
    // End:0xB7
    if(m_WeaponMesh != none)
    {
        m_WeaponMesh.PlayBuildupEffects(nEquipSlot);
    }
    //return;    
}

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining)
{
    local TgAnimBlendByFire IteratorC;
    local TgAnimNodeBlendByCombatWariness IteratorD;
    local TgAnimBlendByFireMode IteratorE;
    local TgDemoRecSpectator DemoController;
    local TgDeviceForm form;
    local TgDevice Device;

    form = c_EquipForm[nEquipSlot];
    // End:0x2A0
    if(form != none)
    {
        switch(nEquipSlot)
        {
            // End:0x163
            case 1:
                Device = GetDeviceByEqPoint(nEquipSlot);
                // End:0x160
                if((Device != none) && Device.r_nMaxAmmoClipCount > 0)
                {
                    SetRTPCValue('AmmoAmountPercentage', FClamp((float(nAmmoRemaining) / float(Device.r_nMaxAmmoClipCount)) * 100.0000000, 0.0000000, 100.0000000));
                    // End:0x160
                    if(m_WeaponMesh != none)
                    {
                        m_WeaponMesh.SetRTPCValue('AmmoAmountPercentage', FClamp((float(nAmmoRemaining) / float(Device.r_nMaxAmmoClipCount)) * 100.0000000, 0.0000000, 100.0000000));
                    }
                }
                // End:0x1A5
                break;
            // End:0x1A2
            case 17:
                // End:0x19F
                if(m_FireAnimNode != none)
                {
                    m_FireAnimNode.PlayFireAnim('melee');
                }
                // End:0x1A5
                break;
            // End:0xFFFF
            default:
                break;
        }
        // End:0x213
        foreach m_DeviceModeBlendNodes(IteratorE)
        {
            // End:0x212
            if(int(IteratorE.m_EquipPoint) == nEquipSlot)
            {
                IteratorE.SelectFireMode(nFireMode);
            }            
        }        
        // End:0x267
        foreach m_FireBlendNodes(IteratorC)
        {
            IteratorC.OnDeviceFormStartFire(c_EquipForm[nEquipSlot], FireDuration);            
        }        
        // End:0x29F
        foreach m_CombatWarinessBlendNodes(IteratorD)
        {
            IteratorD.BecomeWary();            
        }        
    }
    // End:0x43A
    if(WorldInfo.IsPlayingDemo())
    {
        DemoController = TgDemoRecSpectator(GetALocalPlayerController());
        // End:0x43A
        if(DemoController != none)
        {
            // End:0x43A
            if(((DemoController != none) && DemoController.m_ActionListener != none) && VSizeSq(DemoController.m_ActionListener.Location - Location) < (DemoController.m_ActionListener.m_CollisionCylinder.CollisionRadius * DemoController.m_ActionListener.m_CollisionCylinder.CollisionRadius))
            {
                DemoController.m_ActionListener.ForwardDeviceOnStartFire(self, nEquipSlot);
            }
        }
    }
    // End:0x483
    if(m_WeaponMesh != none)
    {
        m_WeaponMesh.PlayFireEffects(nEquipSlot, FireDuration, nFireMode);
    }
    //return;    
}

simulated function OnDeviceFormFire(int nEquipSlot, float fRefireTime, int nFireMode)
{
    // End:0x58
    if(nEquipSlot == 6)
    {
        // End:0x58
        if((Controller != none) && Controller.IsLocalPlayerController())
        {
            TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_LocalPlayerRecalled', self);
        }
    }
    // End:0xA1
    if(m_WeaponMesh != none)
    {
        m_WeaponMesh.PlayDeviceFiredEffects(nEquipSlot, fRefireTime, nFireMode);
    }
    //return;    
}

simulated function OnDeviceFormHit(int nEquipSlot, Actor Target, float DamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    //return;    
}

simulated function PostRecallTimerToKillParticles()
{
    local editinline ParticleSystemComponent PSC;

    // End:0xBE
    foreach Mesh.AttachedComponents(Class'Engine.ParticleSystemComponent', PSC)
    {
        switch(PSC.Template.Name)
        {
            // End:0x7D
            case 'FX_XBAL_ABILITY04_ENEMY_FOG':
            // End:0x89
            case 'FX_XBAL_ABILITY04_FOG':
            // End:0x98
            case 'FX_XBAL_ABILITY04_FOG_END':
                // End:0xBD
                break;
            // End:0xFFFF
            default:
                PSC.KillParticlesForced();
                // End:0xBD
                break;
                break;
        }        
    }    
    //return;    
}

simulated function OnDeviceFormStopFire(int nEquipSlot)
{
    local TgAnimBlendByFire IteratorA;
    local TgDeviceForm DeviceForm;

    DeviceForm = c_EquipForm[nEquipSlot];
    // End:0x77
    if(DeviceForm != none)
    {
        // End:0x76
        foreach m_FireBlendNodes(IteratorA)
        {
            IteratorA.OnDeviceFormStopFire(c_EquipForm[nEquipSlot]);            
        }        
    }
    // End:0x9A
    if(nEquipSlot == 6)
    {
        SetTimer(0.1000000, false, 'PostRecallTimerToKillParticles');
    }
    // End:0xE7
    if(ShouldStopWeaponMeshFireEffectsOnDeviceFormStopFire(nEquipSlot))
    {
        // End:0xE7
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.StopFireEffects(nEquipSlot);
        }
    }
    //return;    
}

simulated function bool ShouldStopWeaponMeshFireEffectsOnDeviceFormStopFire(int nEquipSlot)
{
    return true;
    //return ReturnValue;    
}

simulated function OnDeviceFormInterruptFire(int nEquipSlot)
{
    local TgAnimBlendByFire IteratorA;
    local TgDeviceForm form;

    form = c_EquipForm[nEquipSlot];
    // End:0x77
    if(form != none)
    {
        // End:0x76
        foreach m_FireBlendNodes(IteratorA)
        {
            IteratorA.OnDeviceFormInterruptFire(c_EquipForm[nEquipSlot]);            
        }        
    }
    //return;    
}

event bool CanApplyEffects()
{
    local TgGame TgG;

    TgG = TgGame(WorldInfo.Game);
    // End:0x6D
    if((TgG != none) && int(TgG.m_GameWinState) != int(0))
    {
        return false;
    }
    return s_bCanApplyEffects;
    //return ReturnValue;    
}

simulated function ForceUpdate1PMeshes()
{
    local int I;

    // End:0x2A0
    if(m_WeaponMesh != none)
    {
        // End:0xEA
        if(m_WeaponMesh.m_HandsMesh != none)
        {
            I = 0;
            J0x3E:

            // End:0xEA [Loop If]
            if(I < m_OverlayInfosBody.Length)
            {
                // End:0xDC
                if(m_OverlayInfosBody[I].ParentMesh == m_WeaponMesh.m_HandsMesh)
                {
                    m_OverlayInfosBody[I].OverlayMesh.ForceUpdate(true);
                }
                I++;
                // [Loop Continue]
                goto J0x3E;
            }
        }
        // End:0x1C5
        if(m_WeaponMesh.m_WeaponMesh1P != none)
        {
            I = 0;
            J0x119:

            // End:0x1C5 [Loop If]
            if(I < m_OverlayInfosWeapon.Length)
            {
                // End:0x1B7
                if(m_OverlayInfosWeapon[I].ParentMesh == m_WeaponMesh.m_WeaponMesh1P)
                {
                    m_OverlayInfosWeapon[I].OverlayMesh.ForceUpdate(true);
                }
                I++;
                // [Loop Continue]
                goto J0x119;
            }
        }
        // End:0x2A0
        if(m_WeaponMesh.m_HeadMesh1P != none)
        {
            I = 0;
            J0x1F4:

            // End:0x2A0 [Loop If]
            if(I < m_OverlayInfosBody.Length)
            {
                // End:0x292
                if(m_OverlayInfosBody[I].ParentMesh == m_WeaponMesh.m_HeadMesh1P)
                {
                    m_OverlayInfosBody[I].OverlayMesh.ForceUpdate(true);
                }
                I++;
                // [Loop Continue]
                goto J0x1F4;
            }
        }
    }
    //return;    
}

simulated function IncrementFlashCount(Weapon Who, byte FireModeNum)
{
    //return;    
}

simulated function ClearFlashCount(Weapon Who)
{
    //return;    
}

function ClearFlashLocation(Weapon Who)
{
    //return;    
}

simulated function StopPlayFiring()
{
    //return;    
}

function RememberPlayerAttackerExpired()
{
    //return;    
}

simulated event PlayHeal3P()
{
    // End:0x43
    if(m_HealFX3P != none)
    {
        m_HealFX3P.Activate();
        SetTimer(1.0000000, false, 'EndHeal3P');
    }
    //return;    
}

simulated function EndHeal3P()
{
    // End:0x2F
    if(m_HealFX3P != none)
    {
        m_HealFX3P.Deactivate(true);
    }
    //return;    
}

simulated event PlayHitReactionMaterialPulse()
{
    // End:0x22
    if(!IsFirstPerson())
    {
        m_fRemainingHitReactionPulseTime = m_fHitReactionPulseTime;
    }
    //return;    
}

simulated function PlayTakeHit(Vector Direction, int Damage, Class<DamageType> dmgType, const out ExtraDamageInfo ExtraInfo, TgPawn.EHitAudioCue eCue)
{
    local TgPlayerController TgPC;
    local Class<TgDamageType> TgDmgType;
    local TgAkActor TakeHitSoundActor;
    local Vector Dir;
    local TgPawn.EEmote eHitCue;

    m_fLastPainSound = WorldInfo.TimeSeconds;
    // End:0x456
    if(Damage > 0)
    {
        Dir = Normal(Direction);
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x456
        if((((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && IsLocallyControlled()) && TgPC != none) && TgPC.GetViewTarget() == self)
        {
            TakeHitSoundActor = Spawn(Class'TgGame.TgAkActor', TgPC,, TgPC.PlayerCamera.CameraCache.POV.Location + (Dir * 16.0000000));
            TakeHitSoundActor.SetRTPCValue('DamageTaken', m_fDamageTakenRTPC);
            TakeHitSoundActor.SetBase(self);
            TakeHitSoundActor.bIgnoreBaseRotation = true;
            TakeHitSoundActor.m_bCanCheckOcclusion = false;
            TgDmgType = Class<TgDamageType>(dmgType);
            eHitCue = 44;
            switch(eCue)
            {
                // End:0x24C
                case 0:
                    eHitCue = 0;
                    // End:0x29F
                    break;
                // End:0x260
                case 1:
                    eHitCue = 44;
                    // End:0x29F
                    break;
                // End:0x274
                case 2:
                    eHitCue = 47;
                    // End:0x29F
                    break;
                // End:0x288
                case 3:
                    eHitCue = 46;
                    // End:0x29F
                    break;
                // End:0x29C
                case 4:
                    eHitCue = 48;
                    // End:0x29F
                    break;
                // End:0xFFFF
                default:
                    break;
            }
            // End:0x42E
            if(int(eHitCue) == int(44))
            {
                // End:0x382
                if(ExtraInfo.bHeadShot)
                {
                    // End:0x348
                    if((TgDmgType != none) && TgDmgType.default.m_TakeHeadShotAkEvent != none)
                    {
                        TakeHitSoundActor.PostAkEvent(TgDmgType.default.m_TakeHeadShotAkEvent);                        
                    }
                    else
                    {
                        // End:0x37F
                        if(m_TakeHeadShotAkEvent != none)
                        {
                            TakeHitSoundActor.PostAkEvent(m_TakeHeadShotAkEvent);
                        }
                    }                    
                }
                else
                {
                    // End:0x3F7
                    if((TgDmgType != none) && TgDmgType.default.m_TakeHitAkEvent != none)
                    {
                        TakeHitSoundActor.PostAkEvent(TgDmgType.default.m_TakeHitAkEvent);                        
                    }
                    else
                    {
                        // End:0x42E
                        if(m_TakeHitAkEvent != none)
                        {
                            TakeHitSoundActor.PostAkEvent(m_TakeHitAkEvent);
                        }
                    }
                }
            }
            // End:0x456
            if(int(eHitCue) != int(0))
            {
                PlayEmoteAtWorldLocation(eHitCue);
            }
        }
    }
    //return;    
}

event SendNotifyTakeHit(Controller InstigatedBy, Vector HitLocation, int Damage, Class<DamageType> DamageType, Vector Momentum)
{
    NotifyTakeHit(InstigatedBy, HitLocation, Damage, DamageType, Momentum, none);
    //return;    
}

function NotifyTakeHit(Controller InstigatedBy, Vector HitLocation, int Damage, Class<DamageType> DamageType, Vector Momentum, Actor DamageCauser)
{
    super(Pawn).NotifyTakeHit(InstigatedBy, HitLocation, Damage, DamageType, Momentum, DamageCauser);
    //return;    
}

simulated event DrawAIDebug(Canvas Canvas, Vector ScreenLoc)
{
    local string sGoalString;
    local float XD, YD;

    sGoalString = ("Pawn:        " $ r_sDebugName) $ "\n";    
    sGoalString $= (("Type:        " $ PlayerReplicationInfo.PlayerName) $ "\n");    
    sGoalString $= (("Nav. Action:   " $ r_sDebugAction) $ "\n");
    // End:0x15B
    if((Pawn(r_aDebugTarget) != none) && Pawn(r_aDebugTarget).PlayerReplicationInfo != none)
    {        
        sGoalString $= (("Target(1):     " $ Pawn(r_aDebugTarget).PlayerReplicationInfo.PlayerName) $ "\n");        
    }
    else
    {        
        sGoalString $= (("Target(2):     " $ string(r_aDebugTarget)) $ "\n");
    }    
    sGoalString $= (("Destination: " $ string(r_aDebugDestination)) $ "\n");
    // End:0x276
    if(r_aDebugNextNav == none)
    {        
        sGoalString $= (((((("Next Point:  (" $ string(int(r_vDebugNextNavMeshPoint.X))) $ ",") $ string(int(r_vDebugNextNavMeshPoint.Y))) $ ",") $ string(int(r_vDebugNextNavMeshPoint.Z))) $ ")\n");        
    }
    else
    {        
        sGoalString $= (("Next Path:   " $ string(r_aDebugNextNav)) $ "\n");
    }
    Canvas.Font = Class'Engine.Engine'.static.GetSmallFont();
    Canvas.SetDrawColor(255, 0, 0, 255);
    Canvas.StrLen(sGoalString, XD, YD);
    DrawMultiLineText(Canvas, sGoalString, int(ScreenLoc.X - (0.4000000 * XD)), int((ScreenLoc.Y - (1.2000000 * YD)) - float(2 * 20)), 16);
    DrawClientDebug();
    //return;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local TgAIController aic;
    local TgDevice_Mount MountDevice;
    local int nPreviousHealth, nActualDamage;
    local Class<TgDamageType> TgDamage;

    HitDamageType = DamageType;
    nPreviousHealth = Health;
    TgDamage = Class<TgDamageType>(DamageType);
    // End:0x114
    if(TgDamage != none)
    {
        Momentum = RandRange(TgDamage.default.m_bMinImpulse, TgDamage.default.m_bMaxImpulse) * Normal(Momentum);
        Momentum.Z += RandRange(TgDamage.default.m_bMinUpKick, TgDamage.default.m_bMaxUpKick);
    }
    // End:0x151
    if(Damage >= Health)
    {
        r_DeathInfo.Momentum = Momentum;
    }
    super(Pawn).TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo);
    // End:0x1E1
    if(Health <= 0)
    {
        NotifyTakeHit(InstigatedBy, HitLocation, Damage, DamageType, Momentum, DamageCauser);
    }
    // End:0x2E5
    if(Controller != none)
    {
        // End:0x258
        if(!Controller.bGodMode)
        {
            nActualDamage = nPreviousHealth - Health;
            Health = nPreviousHealth;
            ModifyHealthProp(nActualDamage);
        }
        // End:0x2CE
        if(float(Damage) >= m_fDamageTakenMax)
        {
            m_fDamageTakenMax = float(Damage);
            m_fDamageTakenRTPC = float(Damage);
            SetRTPCValue('DamageTaken', m_fDamageTakenRTPC);
            SetTimer(m_fDamageTakenMaxSustainDuration, false, 'DamageTakenMaxReset');
        }
        SetTimer(m_fDamageTakenRTPCSustainDuration, false, 'DamageTakenRTPCReset');
    }
    // End:0x31A
    if(Health <= 0)
    {
        r_DeathInfo.Momentum = Momentum;
    }
    // End:0x344
    if((r_EffectManager != none) && Health > 0)
    {
        PulseStealth();
    }
    aic = TgAIController(Controller);
    // End:0x3E5
    if((aic != none) && aic.m_pFactory != none)
    {
        aic.m_pFactory.OnBotDamaged(self, InstigatedBy, DamageType, Damage);
    }
    // End:0x409
    if(!ClassIsChildOf(DamageType, Class'TgGame.TgDamageType_AbilityCost'))
    {
        InterruptUse();
    }
    // End:0x4B0
    if((nPreviousHealth != Health) && int(Role) == int(ROLE_Authority))
    {
        MountDevice = TgDevice_Mount(GetDeviceByEqPoint(23));
        // End:0x4B0
        if((MountDevice != none) && MountDevice.IsFiring())
        {
            MountDevice.DismountOnDamage(Damage);
        }
    }
    //return;    
}

event int TakeShieldDamage(int fDamage, Class<DamageType> DamageType)
{
    local TgDevice_Mount MountDevice;
    local float fPostShieldDamage;

    // End:0x159
    if((r_EffectManager != none) && (Class<TgDamageType>(DamageType) == none) || !Class<TgDamageType>(DamageType).default.m_bIgnorePersonalShields)
    {
        fPostShieldDamage = float(r_EffectManager.ShieldTakeDamage(fDamage));
        // End:0x144
        if((fPostShieldDamage < float(fDamage)) && int(Role) == int(ROLE_Authority))
        {
            MountDevice = TgDevice_Mount(GetDeviceByEqPoint(23));
            // End:0x144
            if((MountDevice != none) && MountDevice.IsFiring())
            {
                MountDevice.DismountOnDamage(int(float(fDamage) - fPostShieldDamage));
            }
        }
        fDamage = int(fPostShieldDamage);
    }
    return fDamage;
    //return ReturnValue;    
}

event TakeHealing(float fHealAmount)
{
    local float fHealCap, fNewHealth;

    // End:0x97
    if((GetHealth()) < (GetMaxHealth()))
    {
        fNewHealth = (GetHealth()) + fHealAmount;
        fHealCap = FMax((GetMaxHealth()) - (GetHealBlock()), 0.0000000);
        fNewHealth = FClamp(fNewHealth, 0.0000000, fHealCap);
        SetProperty(19, fNewHealth);
    }
    //return;    
}

function PulseStealth()
{
    //return;    
}

singular event EndPulseStealth()
{
    // End:0x53
    if((r_EffectManager != none) && m_StealthPulseEffectGroup != none)
    {
        r_EffectManager.RemoveProperty(m_StealthPulseEffectGroup);
        m_StealthPulseEffectGroup = none;
    }
    //return;    
}

function AdjustDamage(out int InDamage, out Vector Momentum, Controller InstigatedBy, Vector HitLocation, Class<DamageType> DamageType, TraceHitInfo HitInfo, Actor DamageCauser)
{
    super(Pawn).AdjustDamage(InDamage, Momentum, InstigatedBy, HitLocation, DamageType, HitInfo, DamageCauser);
    // End:0x85
    if(ClassIsChildOf(DamageType, Class'TgGame.TgDamageType_AbilityCost'))
    {
        InDamage = Max(Min(InDamage, Health - 1), 0);
    }
    // End:0x15D
    if(int(TgRepInfo_Game(WorldInfo.GRI).r_GameType) == int(12))
    {
        // End:0x15D
        if(r_nPawnId == GetLocalPlayerPawn().r_nPawnId)
        {
            InDamage -= int(float(InDamage) * (float(Health / HealthMax) / 100.0000000));
            // End:0x15D
            if(InDamage >= Health)
            {
                InDamage = Health - 1;
            }
        }
    }
    //return;    
}

function SetHealth(int NewHealth)
{
    local TgRepInfo_Player TgPRI;

    SetProperty(19, float(Min(NewHealth, int(GetMaxHealth()))));
    TgPRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x84
    if(TgPRI != none)
    {
        TgPRI.UpdateHealth(NewHealth, int(GetMaxHealth()));
    }
    //return;    
}

event ModifyHealthProp(int nDamage)
{
    local TgRepInfo_Player TgPRI;

    SetProperty(19, (GetHealth()) - float(nDamage));
    TgPRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x85
    if(TgPRI != none)
    {
        TgPRI.UpdateHealth(int(GetHealth()), int(GetMaxHealth()));
    }
    //return;    
}

simulated event DrawMultiLineText(Canvas Canvas, string Text, int X, int Y, int LineHeight)
{
    local string RemainingText;
    local int StringLength, LineLength, LineNum;
    local FontRenderInfo FontInfo;

    RemainingText = Text;
    StringLength = Len(Text);
    LineNum = 0;
    J0x33:

    // End:0x175 [Loop If]
    if(StringLength > 0)
    {
        LineNum++;
        LineLength = InStr(RemainingText, "\n");
        // End:0x8E
        if(LineLength == -1)
        {
            LineLength = StringLength;
        }
        Canvas.SetPos(float(X), float(Y + (LineHeight * LineNum)));
        FontInfo.bClipText = true;
        Canvas.DrawText(Left(RemainingText, LineLength), false,,, FontInfo);
        RemainingText = Mid(RemainingText, LineLength + 1);
        StringLength -= (LineLength + 1);
        // [Loop Continue]
        goto J0x33;
    }
    //return;    
}

simulated function bool LoadPlayerIcons()
{
    return true;
    //return ReturnValue;    
}

function DamageTakenMaxReset()
{
    m_fDamageTakenMax = 0.0000000;
    //return;    
}

function DamageTakenRTPCReset()
{
    m_fDamageTakenRTPC = 0.0000000;
    SetRTPCValue('DamageTaken', m_fDamageTakenRTPC);
    //return;    
}

simulated function TgPawn GetLocalPlayerPawn()
{
    local TgPlayerController PC;

    // End:0x23
    foreach LocalPlayerControllers(Class'TgGame.TgPlayerController', PC)
    {
        // End:0x23
        break;        
    }    
    // End:0x53
    if(PC != none)
    {
        return PC.GetTgPawn();
    }
    return none;
    //return ReturnValue;    
}

simulated function int GetX1CoordBasedOnIndex(int nIndex)
{
    return (GetX2CoordBasedOnIndex(nIndex)) - 50;
    //return ReturnValue;    
}

simulated function int GetY1CoordBasedOnIndex(int nIndex)
{
    return (GetY2CoordBasedOnIndex(nIndex)) - 50;
    //return ReturnValue;    
}

simulated function int GetX2CoordBasedOnIndex(int nIndex)
{
    return (GetColumnBasedOnIndex(nIndex)) * 51;
    //return ReturnValue;    
}

simulated function int GetY2CoordBasedOnIndex(int nIndex)
{
    return ((GetRowBasedOnIndex(nIndex)) * 51) - 1;
    //return ReturnValue;    
}

simulated function int GetRowBasedOnIndex(int nIndex)
{
    return ((nIndex - 1) / 5) + 1;
    //return ReturnValue;    
}

simulated function int GetColumnBasedOnIndex(int nIndex)
{
    return nIndex - (((GetRowBasedOnIndex(nIndex)) - 1) * 5);
    //return ReturnValue;    
}

simulated function NotifyTeamChanged()
{
    OnGroupChange();
    super(Pawn).NotifyTeamChanged();
    //return;    
}

simulated function NotifyLocalPlayerTeamReceived()
{
    RecalculateMaterial(IsFriendlyWithLocalPawn());
    TriggerKismetPlayerInitialized();
    //return;    
}

simulated event OnGroupChange()
{
    local TgPawn LocalPawn;
    local TgRepInfo_Player TgPRI;
    local TgPlayerController TgPC;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x62
    if(PlayerReplicationInfo != none)
    {
        TgRepInfo_Player(PlayerReplicationInfo).CheckMembership();
    }
    LocalPawn = GetLocalPlayerPawn();
    // End:0x1A1
    if((LocalPawn == self) && LocalPawn != none)
    {
        TgPRI = TgRepInfo_Player(LocalPawn.PlayerReplicationInfo);
        // End:0xF5
        if(TgPRI != none)
        {
            TgPRI.RecalculateTeamColor();
        }
        TgPC = TgPlayerController(Controller);
        // End:0x19E
        if((TgPC != none) && TgPC.m_OverlayPathMaterial != none)
        {
            TgPC.m_OverlayPathMaterial.SetScalarParameterValue('Team', float(((int(GetTaskForceNumber()) == int(1)) ? 0 : 1)));
        }        
    }
    else
    {
        NotifyLocalPlayerTeamReceived();
        // End:0x1D9
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.NotifyLocalPlayerTeamReceived();
        }
    }
    //return;    
}

simulated function Color GetTargetBoxColor(TgPawn LocalPlayerPawn)
{
    local Color TargetColor;

    // End:0x76
    if(IsEnemy(LocalPlayerPawn))
    {
        TargetColor.R = 255;
        TargetColor.G = 0;
        TargetColor.B = 0;        
    }
    else
    {
        TargetColor.R = 0;
        TargetColor.G = 255;
        TargetColor.B = 0;
    }
    TargetColor.A = 255;
    return TargetColor;
    //return ReturnValue;    
}

simulated event string GetPlayerNameForRender()
{
    local TgRepInfo_Player myInfo;

    // End:0x4C
    if(PlayerReplicationInfo != none)
    {
        myInfo = TgRepInfo_Player(PlayerReplicationInfo);
        return myInfo.GetPlayerNameForMsgDisplay();
    }
    return "";
    //return ReturnValue;    
}

simulated event string GetPlayerTagForRender()
{
    local string toReturn;

    toReturn = "";
    return toReturn;
    //return ReturnValue;    
}

simulated event float GetPlayerHealthForRender()
{
    return float(Health);
    //return ReturnValue;    
}

simulated event BecomeViewTarget(PlayerController PC)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera PlayerCamera;

    TgPC = TgPlayerController(PC);
    PlayerCamera = ((TgPC != none) ? TgPlayerCamera(TgPC.PlayerCamera) : none);
    // End:0xA7
    if((TgPC != none) && PlayerCamera != none)
    {
        PlayerCamera.BecomeViewTarget(TgPC);
    }
    super(Pawn).BecomeViewTarget(PC);
    // End:0x101
    if((TgPC != none) && s_Viewers.Find(TgPC) == -1)
    {
        s_Viewers.AddItem(TgPC);
    }
    SetRTPCValue('IsPosition3D', 0.0000000);
    // End:0x272
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && PlayerCamera != none)
    {
        PlayBleedEffects(r_bIsBleeding);
        PlayDazeEffects(r_bIsDazed);
        PlayCCImmuneEffects(r_bIsCCImmune);
        PlayOnFireEffects(r_bIsOnFire);
        PlayFreezeEffects(r_bIsFrozen);
        PlayKnockbackEffects(r_bIsKnockedBack);
        PlayMarkEffects(r_bIsMarked);
        PlayRootEffects(r_bIsRooted);
        PlayPoisonedEffects(r_bIsPoisoned);
        PlayCrippledEffects(r_bCrippled);
        PlaySlowEffects(r_bIsSlowed);
        PlayFlashBangEffects(r_bIsFlashBang);
        // End:0x272
        if(Controller != PC)
        {
            ClientPlayGrassEffects(false);
            ClientPlayHiddenEffects(false);
        }
    }
    //return;    
}

simulated event EndViewTarget(PlayerController PC)
{
    local TgPlayerController TgPC;
    local int Idx;

    TgPC = TgPlayerController(PC);
    // End:0xA0
    if((TgPC != none) && TgPlayerCamera(TgPC.PlayerCamera) != none)
    {
        TgPlayerCamera(TgPC.PlayerCamera).EndViewTarget(TgPC);
    }
    Idx = 0;
    J0xAB:

    // End:0x114 [Loop If]
    if(Idx < 33)
    {
        // End:0x106
        if(c_EquipForm[Idx] != none)
        {
            c_EquipForm[Idx].OnEndViewTarget(PC);
        }
        Idx++;
        // [Loop Continue]
        goto J0xAB;
    }
    CleanUpScreenCapturePostProcess();
    super(Actor).EndViewTarget(PC);
    SetRTPCValue('IsPosition3D', 1.0000000);
    // End:0x16E
    if(TgPC != none)
    {
        s_Viewers.RemoveItem(TgPC);
    }
    //return;    
}

simulated function bool CalcCamera(float fDeltaTime, out Vector out_CamLoc, out Rotator out_CamRot, out float out_FOV)
{
    return false;
    //return ReturnValue;    
}

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration)
{
    // End:0x1C
    if(ShouldBeFirstPersonThisTick())
    {
        fZoom = 0.0000000;
    }
    //return;    
}

simulated function bool IgnoreFaceRotationWithInterp()
{
    return false;
    //return ReturnValue;    
}

simulated function InterceptInputDeltaRotation(out Rotator rDeltaRotation)
{
    // End:0x27D
    if(m_bUsesRecoil)
    {
        // End:0x145
        if((m_rCurrentRecoil.Pitch * rDeltaRotation.Pitch) < 0)
        {
            // End:0xED
            if(Abs(float(m_rCurrentRecoil.Pitch)) > Abs(float(rDeltaRotation.Pitch)))
            {
                m_rCurrentRecoil.Pitch += rDeltaRotation.Pitch;
                rDeltaRotation.Pitch = 0;                
            }
            else
            {
                rDeltaRotation.Pitch += m_rCurrentRecoil.Pitch;
                m_rCurrentRecoil.Pitch = 0;
            }
        }
        // End:0x27D
        if((m_rCurrentRecoil.Yaw * rDeltaRotation.Yaw) < 0)
        {
            // End:0x225
            if(Abs(float(m_rCurrentRecoil.Yaw)) > Abs(float(rDeltaRotation.Yaw)))
            {
                m_rCurrentRecoil.Yaw += rDeltaRotation.Yaw;
                rDeltaRotation.Yaw = 0;                
            }
            else
            {
                rDeltaRotation.Yaw += m_rCurrentRecoil.Yaw;
                m_rCurrentRecoil.Yaw = 0;
            }
        }
    }
    //return;    
}

simulated function FaceRotation(Rotator NewRotation, float DeltaTime)
{
    local Rotator RotationDelta;

    // End:0x23
    if(IgnoreFaceRotationWithInterp())
    {
        m_fRemainingFaceRotationInterpTime = m_fFaceRotationInterpTime;        
    }
    else
    {
        // End:0x85
        if(m_fRemainingFaceRotationInterpTime > 0.0000000)
        {
            NewRotation = RLerp(NewRotation, Rotation, m_fRemainingFaceRotationInterpTime / m_fFaceRotationInterpTime, true);
            m_fRemainingFaceRotationInterpTime -= DeltaTime;
        }
        // End:0x215
        if(int(Physics) == int(16))
        {
            // End:0xD9
            if((int(r_eChargeState) == int(1)) || int(r_eChargeState) == int(3))
            {
                NewRotation = Rotation;                
            }
            else
            {
                // End:0x215
                if(int(r_eChargeState) == int(4))
                {
                    NewRotation.Pitch = 0;
                    NewRotation = Normalize(NewRotation);
                    RotationDelta = NewRotation - Rotation;
                    RotationDelta = Normalize(RotationDelta);
                    RotationDelta.Yaw = Clamp(RotationDelta.Yaw, int(-GetChargeTurnRate() * DeltaTime), int((GetChargeTurnRate()) * DeltaTime));
                    RotationDelta = Normalize(RotationDelta);
                    NewRotation = Normalize(Rotation + RotationDelta);
                }
            }
        }
        NewRotation.Pitch = 0;
        // End:0x256
        if(Rotation != NewRotation)
        {
            SetRotation(NewRotation);
        }
    }
    ForceUpdateUncompressedRemoteYaw();
    //return;    
}

simulated event PostureTransitionEnded(TgPawn.TG_POSTURE PostureThatEnded)
{
    //return;    
}

function string GetDebugName()
{
    // End:0x12
    if(PlayerReplicationInfo != none)
    {
        return "";
    }
    return GetItemName(string(self));
    //return ReturnValue;    
}

simulated event PlayJumpSound()
{
    local array<Object> JumpFxList;
    local TgSpecialFx JumpFx;
    local int I;

    // End:0x11
    if(Mesh == none)
    {
        return;
    }
    JumpFxList = Mesh.FxGetAll('Jump', 0);
    I = 0;
    J0x52:

    // End:0xEC [Loop If]
    if(I < JumpFxList.Length)
    {
        JumpFx = TgSpecialFx(JumpFxList[I]);
        // End:0xDE
        if(JumpFx != none)
        {
            JumpFx.c_Owner = self;
            JumpFx.PlaySound();
        }
        I++;
        // [Loop Continue]
        goto J0x52;
    }
    PlayEmoteAtWorldLocation(45);
    //return;    
}

simulated event PlayPreTeleportEffects()
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0xA4
    if((TgPC != none) && Controller == TgPC)
    {
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xA4
        if(TgCamera != none)
        {
            TgCamera.PlayPreTeleportFX();
        }
    }
    //return;    
}

simulated event PlayTeleportEffects(Vector OriginLocation)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;
    local TgSpecialFx TeleportFX1p, TeleportFX3p;
    local Vector SocketLocation;
    local Rotator SocketRotation;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x10B
    if((TgPC != none) && Controller == TgPC)
    {
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xA4
        if(TgCamera != none)
        {
            TgCamera.PlayTeleportFx();
        }
        TeleportFX1p = GetSpecialFx(6407);
        // End:0x10B
        if(TeleportFX1p != none)
        {
            TeleportFX1p.c_Owner = self;
            TeleportFX1p.PlaySound();
        }
    }
    // End:0x27B
    if(Mesh != none)
    {
        Mesh.GetSocketWorldLocationAndRotation('CSO_COG', SocketLocation, SocketRotation);
        TeleportFX3p = GetSpecialFx(6693);
        // End:0x27B
        if((TeleportFX3p != none) && !IsFirstPerson())
        {
            TeleportFX3p.c_Owner = self;
            TeleportFX3p.SpawnEmitter(SocketLocation, vect(0.0000000, 0.0000000, 1.0000000));
            TeleportFX3p.SpawnEmitter(OriginLocation, vect(0.0000000, 0.0000000, 1.0000000));
            // End:0x253
            if(!IsLocallyControlled())
            {
                TeleportFX3p.PlaySoundAt(Location);
            }
            TeleportFX3p.PlaySoundAt(OriginLocation);
        }
    }
    //return;    
}

simulated event PlayJumpFx()
{
    // End:0x65
    if((Mesh != none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        FxActivateGroupSelf('Jump', 0);
        SetTimer(0.5000000, false, 'StopJumpFx');
    }
    //return;    
}

simulated event StopJumpFx()
{
    // End:0x50
    if((Mesh != none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        FxDeactivateGroupSelf('Jump', 0);
    }
    //return;    
}

simulated event PlaySpecialJumpFx()
{
    // End:0x65
    if((Mesh != none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        FxActivateGroupSelf('Jump_Special', 0);
        SetTimer(0.5000000, false, 'StopSpecialJumpFx');
    }
    //return;    
}

simulated event StopSpecialJumpFx()
{
    // End:0x50
    if((Mesh != none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        FxDeactivateGroupSelf('Jump_Special', 0);
    }
    //return;    
}

simulated function CalculateMaterialSwitch(Vector TraceStart, Vector TraceEnd)
{
    local Vector HitLocation;
    local PhysicalMaterial TracedMaterial;
    local name TracedMaterialType;
    local TgPlayerController TgPC;

    TracedMaterialType = 'Default';
    TracedMaterial = TraceWorldPhysicalGeometry(TraceStart, TraceEnd, HitLocation);
    // End:0xBA
    if((!IsZero(HitLocation) && TracedMaterial != none) && TracedMaterial.MaterialTypeName != 'None')
    {
        TracedMaterialType = TracedMaterial.MaterialTypeName;
    }
    SetSwitch('MaterialType', TracedMaterialType);
    TgPC = TgPlayerController(Controller);
    // End:0x125
    if((TgPC != none) && TgPC.c_bShowFootstepInfoDebug)
    {
    }
    //return;    
}

simulated event PlayLandingSound(Vector LandingVelocity)
{
    local array<Object> LandFxList;
    local TgSpecialFx LandFx;
    local int I;
    local TgPlayerController LocalTgPC;

    // End:0x3C
    if((Mesh == none) || int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    CalculateMaterialSwitch(Location + ((GetCollisionHeight()) * vect(0.0000000, 0.0000000, -0.5000000)), Location + ((GetCollisionHeight()) * vect(0.0000000, 0.0000000, -1.5000000)));
    LandFxList = Mesh.FxGetAll('Land', 0);
    I = 0;
    J0xCF:

    // End:0x169 [Loop If]
    if(I < LandFxList.Length)
    {
        LandFx = TgSpecialFx(LandFxList[I]);
        // End:0x15B
        if(LandFx != none)
        {
            LandFx.c_Owner = self;
            LandFx.PlaySound();
        }
        I++;
        // [Loop Continue]
        goto J0xCF;
    }
    LocalTgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x255
    if((LocalTgPC != none) && LocalTgPC.GetTgPawn() == self)
    {
        m_LandCameraShake.m_fShakeScale = FClamp(FPctByRange(Abs(LandingVelocity.Z), 0.0000000, Abs(m_fHardLandVelocityCutoff)), 0.1000000, 1.0000000);
        LocalTgPC.PlayTgCameraShake(m_LandCameraShake, vect(0.0000000, 0.0000000, 0.0000000), self);
    }
    //return;    
}

simulated event PlayFootStepSound(int FootDown, Pawn.EFootstepTypes FootStepType)
{
    local array<Object> FootstepFxList;
    local TgSpecialFx FootstepFx;
    local int I, J;
    local name DisplayGroupName, DisplayGroupOverride;

    DisplayGroupName = 'FootstepDefault';
    DisplayGroupOverride = GetFootStepOverride();
    // End:0x51
    if(DisplayGroupOverride != 'None')
    {
        DisplayGroupName = DisplayGroupOverride;
    }
    // End:0xA3
    if(((Mesh == none) || int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || int(r_CurrentPolymorph) != int(0))
    {
        return;
    }
    CalculateMaterialSwitch(Location + ((GetCollisionHeight()) * vect(0.0000000, 0.0000000, -0.5000000)), Location + ((GetCollisionHeight()) * vect(0.0000000, 0.0000000, -1.5000000)));
    FootstepFxList = Mesh.FxGetAll(DisplayGroupName, 0);
    I = 0;
    J0x136:

    // End:0x475 [Loop If]
    if(I < FootstepFxList.Length)
    {
        FootstepFx = TgSpecialFx(FootstepFxList[I]);
        // End:0x467
        if(FootstepFx != none)
        {
            // End:0x308
            if(IsFirstPerson())
            {
                J = 0;
                J0x19B:

                // End:0x305 [Loop If]
                if(J < FootstepFx.c_SoundList.Length)
                {
                    // End:0x256
                    if(FootstepFx.c_SoundList[J].c_AkEvent != none)
                    {
                        PlayAkEvent(FootstepFx.c_SoundList[J].c_AkEvent);                        
                    }
                    else
                    {
                        // End:0x2F7
                        if(FootstepFx.c_SoundList[J].c_SoundObject != none)
                        {
                            GetALocalPlayerController().PlaySoundBase(FootstepFx.c_SoundList[J].c_SoundObject);
                        }
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x19B;
                }                
            }
            else
            {
                J = 0;
                J0x313:

                // End:0x467 [Loop If]
                if(J < FootstepFx.c_SoundList.Length)
                {
                    // End:0x3CE
                    if(FootstepFx.c_SoundList[J].c_AkEvent != none)
                    {
                        PlayAkEvent(FootstepFx.c_SoundList[J].c_AkEvent);                        
                    }
                    else
                    {
                        // End:0x459
                        if(FootstepFx.c_SoundList[J].c_SoundObject != none)
                        {
                            PlaySoundBase(FootstepFx.c_SoundList[J].c_SoundObject);
                        }
                    }
                    J++;
                    // [Loop Continue]
                    goto J0x313;
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x136;
    }
    //return;    
}

simulated function name GetFootStepOverride()
{
    return 'None';
    //return ReturnValue;    
}

reliable client simulated event ClientTriggerGlobalEventClass(Class<SequenceEvent> InEventClass, Actor InInstigator, optional int ActivateIndex = -1)
{
    TriggerGlobalEventClass(InEventClass, InInstigator, ActivateIndex);
    //return;    
}

simulated function bool IsFiringMelee()
{
    local TgDevice MeleeDevice;

    MeleeDevice = GetDeviceByEqPoint(17);
    // End:0x45
    if(MeleeDevice != none)
    {
        return MeleeDevice.IsFiring();
    }
    return false;
    //return ReturnValue;    
}

simulated function PlayDying(Class<DamageType> dmgType, Vector HitLoc)
{
    local int I;
    local TgDevice Dev;
    local TgPlayerController TgPC;

    EndPhysTween(true);
    EndPhysGrab(true);
    PlayPolymorphEffects(true);
    ToggleSilhouetteVisibility(false, true);
    m_DeathDamageType = Class<TgDamageType>(dmgType);
    m_DeathHitLocation = HitLoc;
    // End:0x94
    if((int(r_eIsStealthed) != int(0)) && int(Role) == int(ROLE_Authority))
    {
        ApplyStealthServer(ROLE_None);
    }
    // End:0xC8
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        ApplyStealthClient();
    }
    StopFiringAllDevices(true, false);
    PutAllCardsOnCooldown();
    KillDeployables(false);
    KillOwnedBots();
    // End:0x162
    if(Mesh != none)
    {
        Mesh.FxDeactivateGroup('Phase', -1);
        Mesh.FxDeactivateGroup('Posture', -1);
    }
    // End:0x20E
    if(int(Role) < int(ROLE_Authority))
    {
        I = 0;
        J0x181:

        // End:0x20E [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0x200
            if((Dev != none) && Dev.r_bConsumedOnDeath)
            {
                Dev.ConsumeDevice();
            }
            I++;
            // [Loop Continue]
            goto J0x181;
        }
    }
    // End:0x2D4
    if(int(Role) == int(ROLE_Authority))
    {
        r_DeathInfo.bDead = true;
        r_DeathInfo.dmgType = dmgType;
        r_DeathInfo.HitLoc = HitLoc;
        r_nResetCharacter = 0;
        // End:0x2C8
        if(PlayerReplicationInfo != none)
        {
            PlayerReplicationInfo.Deaths += 1;
        }
        bReplicateMovement = false;
    }
    PlayDyingEffects();
    // End:0x351
    if(((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Controller != none) && Controller.IsLocalPlayerController())
    {
        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_LocalPlayerDied', self);
    }
    bPlayedDeath = true;
    HitDamageType = dmgType;
    TakeHitLocation = HitLoc;
    GotoState(DyingStateName);
    ExitCombat();
    // End:0x459
    if((((int(Role) == int(ROLE_Authority)) && int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Controller != none) && Controller.IsLocalPlayerController())
    {
        TgPC = TgPlayerController(Controller);
        // End:0x459
        if(TgPC != none)
        {
            TgPC.UpdatePlayerVitalsUI();
        }
    }
    //return;    
}

simulated function FindNewTargetTimer()
{
    local TgDemoRecSpectator DemoPC;

    DemoPC = TgDemoRecSpectator(GetALocalPlayerController());
    // End:0x72
    if((DemoPC != none) && DemoPC.GetViewTarget() == self)
    {
        DemoPC.FindNextClosestAssistedViewTarget();
    }
    //return;    
}

simulated function PlayDyingEffects()
{
    local Vector FXLocation;
    local Rotator FXRotation;
    local TgSpecialFx DyingSpecialFX;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    SetTimer(2.0000000, false, 'FindNewTargetTimer');
    // End:0x3F7
    if(Mesh != none)
    {
        Mesh.FxDeactivateGroup('WhileAlive', 0);
        // End:0x1A4
        if(int(r_eDeathReason) == int(1))
        {
            DyingSpecialFX = TgSpecialFx(Mesh.FxGet('Despawned', 0));
            // End:0x196
            if(DyingSpecialFX != none)
            {
                // End:0x155
                if(!Mesh.GetSocketWorldLocationAndRotation(DyingSpecialFX.c_nmSocket, FXLocation, FXRotation))
                {
                    FXLocation = Location;
                    FXRotation = Rotation;
                }
                Mesh.FxActivateIndependant('Despawned', 0, FXLocation, Vector(FXRotation));
            }
            SetMeshVisibility(false);            
        }
        else
        {
            // End:0x1C6
            if(int(r_eDeathReason) == int(2))
            {
                SetMeshVisibility(false);                
            }
            else
            {
                // End:0x251
                if(int(r_eDeathReason) == int(3))
                {
                    SetMeshVisibility(false);
                    c_bMeshHiddenDueToDeath = true;
                    DyingSpecialFX = GetSpecialFx(6283);
                    // End:0x24E
                    if(DyingSpecialFX != none)
                    {
                        DyingSpecialFX.SpawnEmitter(Location, Vector(Rotation));
                    }                    
                }
                else
                {
                    // End:0x2D9
                    if(int(r_eDeathReason) == int(4))
                    {
                        Mesh.bNoSkeletonUpdate = true;
                        AttachDeathAnimationFX(m_DeathDamageType.default.m_nDeathSpecialFXId, m_DeathDamageType.default.m_nmDeathSpecialFXSocket);
                        PlayDeathAnimation();                        
                    }
                    else
                    {
                        PlayHitReactionMaterialPulse();
                        PlayDeathAnimation();
                        DyingSpecialFX = TgSpecialFx(Mesh.FxGet('PawnDied', 0));
                        // End:0x3F7
                        if(DyingSpecialFX != none)
                        {
                            // End:0x3B6
                            if(!Mesh.GetSocketWorldLocationAndRotation(DyingSpecialFX.c_nmSocket, FXLocation, FXRotation))
                            {
                                FXLocation = Location;
                                FXRotation = Rotation;
                            }
                            Mesh.FxActivateIndependant('PawnDied', 0, FXLocation, Vector(FXRotation));
                        }
                    }
                }
            }
        }
    }
    // End:0x440
    if(TgPlayerController(Controller) != none)
    {
        TgPlayerController(Controller).SetSoundMode('GA_Death');
    }
    // End:0x457
    if(IsLocallyControlled())
    {
        BeginLocalDeathRTPC();
    }
    //return;    
}

simulated function bool AllowRagdoll()
{
    return false;
    //return ReturnValue;    
}

simulated event PlayDeathAnimation()
{
    local Vector AngVelocity, TraceEnd;
    local int I;
    local MaterialInstanceConstant OverrideMaterial, OldMaterial;
    local Texture Diffuse, Normal, Specular, Mask;
    local LinearColor DIF_Color1, DIF_Color2, SPC_Multiplier, SPC_Power, DIF_Power;

    local bool bHarvestMaterials, bForceAnimation;
    local SkelControlBase SkelControl;
    local name AnimName;

    // End:0x0F
    if(m_bHasPlayedDeathAnimation)
    {
        return;
    }
    m_bHasPlayedDeathAnimation = true;
    TraceEnd = Location;
    TraceEnd.Z -= ((GetCollisionHeight()) + 8.0000000);
    // End:0xC84
    if(Mesh != none)
    {
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        Mesh.MinDistFactorForKinematicUpdate = 0.0000000;
        // End:0xCC
        if(int(r_eDeathReason) == int(1))
        {
            c_bMeshHiddenDueToDeath = true;
            return;            
        }
        else
        {
            bForceAnimation = AllowRagdoll();
            // End:0x22B
            if((HasDeathPostureAnimation()) && int(r_eDeathReason) == int(0))
            {
                // End:0x153
                if((!m_bForceDeathAnim && int(Physics) == int(2)) && FastTrace(TraceEnd, Location))
                {
                    m_bHasPlayedDeathAnimation = false;
                    return;
                }
                PlayFullBodyAnim(GetDeathAnimName(), 1.0000000, 0.0000000, -1.0000000, false, true);
                // End:0x21D
                if(((m_DeathDamageType != none) && m_DeathDamageType.default.m_bCanPlayDeathSpecialFXOnDefaultDeath) && m_DeathDamageType.default.m_nDeathSpecialFXId != -1)
                {
                    AttachDeathAnimationFX(m_DeathDamageType.default.m_nDeathSpecialFXId, m_DeathDamageType.default.m_nmDeathSpecialFXSocket);
                }
                ToggleSkelControlLocks(true);                
            }
            else
            {
                // End:0xB5A
                if((m_bUseDamageTypeForDeathAnim && m_DeathDamageType != none) && Mesh.FindAnimSequence('Death_Generic_01') != none)
                {
                    // End:0x39D
                    if(m_DeathDamageType.default.m_bImpulseMesh && !bForceAnimation)
                    {
                        InitRagdoll();
                        AngVelocity = Vector(Rotation) * RandRange(m_DeathDamageType.default.m_fMinAngularVelocity, m_DeathDamageType.default.m_fMaxAngularVelocity);
                        Mesh.SetRBAngularVelocity(AngVelocity, true);
                        Mesh.AddImpulse(r_DeathInfo.Momentum);
                        Mesh.SetNotifyRigidBodyCollision(true);                        
                    }
                    else
                    {
                        // End:0x3EC
                        if((!m_bForceDeathAnim && int(Physics) == int(2)) && FastTrace(TraceEnd, Location))
                        {
                            m_bHasPlayedDeathAnimation = false;
                            return;
                        }
                        Mesh.PhysicsWeight = 0.0000000;
                        SetPhysics(0);
                        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
                        PlayFullBodyAnim(m_DeathDamageType.static.GetRandomDeathAnimName(), 1.0000000, 0.0000000, -1.0000000, false, true);
                        I = 0;
                        J0x473:

                        // End:0x537 [Loop If]
                        if(I < m_DeathDamageType.default.ActivateSkelControlListOnDeath.Length)
                        {
                            SkelControl = Mesh.FindSkelControl(m_DeathDamageType.default.ActivateSkelControlListOnDeath[I]);
                            // End:0x529
                            if(SkelControl != none)
                            {
                                SkelControl.SetSkelControlStrength(1.0000000, 0.0000000);
                            }
                            I++;
                            // [Loop Continue]
                            goto J0x473;
                        }
                    }
                    // End:0x5A5
                    if(m_DeathDamageType.default.m_nDeathSpecialFXId != -1)
                    {
                        AttachDeathAnimationFX(m_DeathDamageType.default.m_nDeathSpecialFXId, m_DeathDamageType.default.m_nmDeathSpecialFXSocket);
                    }
                    // End:0xA98
                    if(m_DeathDamageType.default.m_OverrideMaterial != none)
                    {
                        I = 0;
                        J0x5D4:

                        // End:0xA98 [Loop If]
                        if(I < Mesh.GetNumElements())
                        {
                            OldMaterial = MaterialInstanceConstant(Mesh.GetMaterial(I));
                            bHarvestMaterials = m_DeathDamageType.default.m_bHarvestMaterialParameters && OldMaterial != none;
                            // End:0x83D
                            if(bHarvestMaterials)
                            {
                                OldMaterial.GetTextureParameterValue('Diffuse', Diffuse);
                                OldMaterial.GetTextureParameterValue('Normal', Normal);
                                OldMaterial.GetTextureParameterValue('Specular', Specular);
                                OldMaterial.GetTextureParameterValue('Mask', Mask);
                                OldMaterial.GetVectorParameterValue('DIF_Color1', DIF_Color1);
                                OldMaterial.GetVectorParameterValue('DIF_Color2', DIF_Color2);
                                OldMaterial.GetVectorParameterValue('SPC_Multiplier', SPC_Multiplier);
                                OldMaterial.GetVectorParameterValue('SPC_Power', SPC_Power);
                                OldMaterial.GetVectorParameterValue('DIF_Power', DIF_Power);
                            }
                            Mesh.SetMaterial(I, m_DeathDamageType.default.m_OverrideMaterial);
                            OverrideMaterial = Mesh.CreateAndSetMaterialInstanceConstant(I);
                            // End:0xA8A
                            if(bHarvestMaterials)
                            {
                                // End:0xA8A
                                if(OverrideMaterial != none)
                                {
                                    OverrideMaterial.SetTextureParameterValue('Diffuse', Diffuse);
                                    OverrideMaterial.SetTextureParameterValue('Normal', Normal);
                                    OverrideMaterial.SetTextureParameterValue('Specular', Specular);
                                    OverrideMaterial.SetTextureParameterValue('Mask', Mask);
                                    OverrideMaterial.SetVectorParameterValue('DIF_Color1', DIF_Color1);
                                    OverrideMaterial.SetVectorParameterValue('DIF_Color2', DIF_Color2);
                                    OverrideMaterial.SetVectorParameterValue('SPC_Multiplier', SPC_Multiplier);
                                    OverrideMaterial.SetVectorParameterValue('SPC_Power', SPC_Power);
                                    OverrideMaterial.SetVectorParameterValue('DIF_Power', DIF_Power);
                                }
                            }
                            I++;
                            // [Loop Continue]
                            goto J0x5D4;
                        }
                    }
                    // End:0xADB
                    if(m_DeathDamageType.default.m_bFreezeAnimsOnDeath)
                    {
                        Mesh.bNoSkeletonUpdate = true;
                    }
                    // End:0xB57
                    if(m_DeathDamageType.default.m_fLifeAfterDeathSeconds > 0.0000000)
                    {
                        m_fLifeAfterDeathSecs = m_DeathDamageType.default.m_fLifeAfterDeathSeconds;
                        SetTimer(m_DeathDamageType.default.m_fLifeAfterDeathSeconds, false, 'OnLifeAfterDeathTimerExpired');
                    }                    
                }
                else
                {
                    // End:0xB74
                    if(m_bHasDestroyedMesh)
                    {
                        OnSwapToDestroyedMesh();                        
                    }
                    else
                    {
                        // End:0xC64
                        if(bForceAnimation)
                        {
                            // End:0xBD0
                            if((!m_bForceDeathAnim && int(Physics) == int(2)) && FastTrace(TraceEnd, Location))
                            {
                                m_bHasPlayedDeathAnimation = false;
                                return;
                            }
                            Mesh.PhysicsWeight = 0.0000000;
                            SetPhysics(0);
                            Velocity = vect(0.0000000, 0.0000000, 0.0000000);
                            AnimName = GetDeathAnimName();
                            // End:0xC61
                            if(AnimName != 'None')
                            {
                                PlayFullBodyAnim(AnimName, 1.0000000, 0.0000000, -1.0000000, false, true);
                            }                            
                        }
                        else
                        {
                            // End:0xC84
                            if((GetPropCurrentValue(145)) <= 0.0000000)
                            {
                                RagdollPawn();
                            }
                        }
                    }
                }
            }
        }
    }
    //return;    
}

simulated function RagdollPawn()
{
    Mesh.MinDistFactorForKinematicUpdate = 0.0000000;
    InitRagdoll();
    Mesh.AddImpulse(r_DeathInfo.Momentum, Location);
    //return;    
}

simulated event name GetDeathAnimName()
{
    return 'Death';
    //return ReturnValue;    
}

// Export UTgPawn::execAttachDeathAnimationFX(FFrame&, void* const)
native function AttachDeathAnimationFX(int SpecialFXId, name SocketName);

simulated function OnSwapToDestroyedMesh()
{
    // End:0xAC
    if(TgPlayerController(GetALocalPlayerController()).AllowRagdoll())
    {
        Mesh.MinDistFactorForKinematicUpdate = 0.0000000;
        SwapToDestroyedMesh();
        Mesh.MinDistFactorForKinematicUpdate = 0.0000000;
        Mesh.UpdateRBBonesFromSpaceBases(true, true);
        InitRagdoll();        
    }
    else
    {
        c_bMeshHiddenDueToDeath = true;
    }
    //return;    
}

simulated function CleanUpDyingEffects()
{
    //return;    
}

reliable server function RemoveAllEffectsOnDeath()
{
    // End:0x2E
    if(r_EffectManager != none)
    {
        r_EffectManager.RemoveAllEffectsOnDeath();
    }
    //return;    
}

simulated event Vector GetPhysTweenTargetLocation()
{
    return r_vPhysTweenTarget;
    //return ReturnValue;    
}

simulated event StartPhysTween(Vector Target, float fTime, TgPawn.ETweenState tweenState, optional bool bCollideWithWorld = false, optional bool bRotateTowardsTarget = false)
{
    // End:0x20
    if((GetHealth()) <= 0.0000000)
    {
        return;
    }
    // End:0x3F
    if(int(m_eLocalTweenState) != int(0))
    {
        EndPhysTween(true);
    }
    // End:0x5E
    if(int(m_eLocalGrabState) != int(0))
    {
        EndPhysGrab(true);
    }
    // End:0x98
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_vPhysTweenTarget = Target;
        r_fPhysTweenDuration = fTime;
    }
    m_fPhysTweenDist = VSize((GetPhysTweenTargetLocation()) - Location);
    BeginTween(tweenState, bCollideWithWorld);
    m_eLocalTweenState = tweenState;
    // End:0x168
    if(int(Role) == int(ROLE_Authority))
    {
        r_eTweenState = tweenState;
        r_nPhysTweenFlags = 0;
        r_nPhysTweenFlags = r_nPhysTweenFlags | ((bCollideWithWorld) ? 1 : 0);
        r_nPhysTweenFlags = r_nPhysTweenFlags | ((bRotateTowardsTarget) ? 2 : 0);
    }
    // End:0x193
    if(r_fPhysTweenDuration > float(0))
    {
        SetTimer(r_fPhysTweenDuration, false, 'EndPhysTween');        
    }
    else
    {
        EndPhysTween();
    }
    //return;    
}

final simulated event UpdatePhysTweenTargetLocation(Vector NewTarget, float updatedTime)
{
    // End:0x3A
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_vPhysTweenTarget = NewTarget;
        r_fPhysTweenDuration = updatedTime;
    }
    m_fPhysTweenDist = VSize((GetPhysTweenTargetLocation()) - Location);
    //return;    
}

final simulated event EndPhysTween(optional bool bInterrupted = false)
{
    local TgPawn.ETweenState oldTweenState;

    ClearTimer('EndPhysTween');
    // End:0xBD
    if(int(m_eLocalTweenState) != int(0))
    {
        oldTweenState = m_eLocalTweenState;
        r_vPhysTweenTarget = GetPhysTweenTargetLocation();
        m_eLocalTweenState = 0;
        r_bPhysTweenInterrupted = bInterrupted;
        // End:0xA0
        if(int(Role) == int(ROLE_Authority))
        {
            r_eTweenState = 0;
            r_nPhysTweenFlags = 0;
        }
        EndTween(oldTweenState, bInterrupted);
    }
    //return;    
}

protected simulated function BeginTween(TgPawn.ETweenState newTweenState, optional bool bCollideWithWorld = false)
{
    switch(newTweenState)
    {
        // End:0x42
        case 2:
            s_bCanApplyEffects = false;
            DefaultTweenStart(true,, bCollideWithWorld);
            // End:0x14E
            break;
        // End:0x60
        case 1:
            DefaultTweenStart(,,, bCollideWithWorld);
            // End:0x14E
            break;
        // End:0x12D
        case 3:
            m_bIsInvisibleToAI = true;
            InterruptUse();
            InterruptAllDevices();
            DefaultTweenStart(,,, bCollideWithWorld);
            m_nPhysTweenPostureId = PushPosture(11);
            Velocity.X = 0.0000000;
            Velocity.Y = 0.0000000;
            Velocity.Z = -GetGravityZ() * r_fPhysTweenDuration;
            // End:0x14E
            break;
        // End:0x14B
        case 4:
            DefaultTweenStart(true, true, bCollideWithWorld);
            // End:0x14E
            break;
        // End:0xFFFF
        default:
            break;
    }
    switch(newTweenState)
    {
        // End:0xFFFF
        default:
            ForceAllGrabTargetsDetach();
            TeleportNotify();
            // End:0x17C
            break;
            break;
    }
    //return;    
}

final simulated function DefaultTweenStart(optional bool bCanBeHit = false, optional bool bRemoveRoots = false, optional bool bCollideWithWorld = false)
{
    SetCollision(bCanBeHit, bCanBeHit, !bCanBeHit);
    bCollideWorld = bCollideWithWorld;
    // End:0x65
    if(int(Physics) == int(10))
    {
        TermRagdoll();
    }
    SetPhysics(15);
    bIgnoreForces = true;
    // End:0xA9
    if(bRemoveRoots)
    {
        r_EffectManager.RemoveEffectGroupsByCategory(10050);
    }
    //return;    
}

event SendHitReaction(byte HitDirection)
{
    local byte Counter;

    Counter = byte(int(s_BitPackedHitReaction) & int(15));
    Counter++;
    // End:0x48
    if(int(Counter) > int(15))
    {
        Counter = 0;
    }
    s_BitPackedHitReaction = 0;
    s_BitPackedHitReaction = byte(int(s_BitPackedHitReaction) << int(6));
    HitDirection = byte(int(HitDirection) << int(4));
    s_BitPackedHitReaction = byte(int(s_BitPackedHitReaction) | int(HitDirection));
    s_BitPackedHitReaction = byte(int(s_BitPackedHitReaction) | int(Counter));
    // End:0x114
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PlayHitReaction(int(s_BitPackedHitReaction));
    }
    FlashHitReaction();
    //return;    
}

simulated event PlayHitReaction(int BitPackedHitReaction)
{
    local byte Dir;
    local bool bMoving;
    local name HitReactionAnimName;
    local int I;
    local TgObject.RecoilHitDir RecoilDir;
    local Vector CamLoc;
    local Rotator CamRot;
    local PlayerController PC;

    return;
    // End:0x18
    if((GetHealth()) <= 0.0000000)
    {
        return;
    }
    Dir = byte((BitPackedHitReaction & 48) >> 4);
    // End:0x2A7
    if(int(m_HitReactionType) == int(1))
    {
        PC = GetALocalPlayerController();
        // End:0x2A4
        if(PC != none)
        {
            PC.GetPlayerViewPoint(CamLoc, CamRot);
            // End:0x2A4
            if(VSizeSq(CamLoc - Location) < float(4000000))
            {
                // End:0xE2
                if(int(Dir) == int(0))
                {
                    RecoilDir = 0;                    
                }
                else
                {
                    // End:0x105
                    if(int(Dir) == int(1))
                    {
                        RecoilDir = 1;                        
                    }
                    else
                    {
                        // End:0x128
                        if(int(Dir) == int(2))
                        {
                            RecoilDir = 2;                            
                        }
                        else
                        {
                            RecoilDir = 3;
                        }
                    }
                }
                bMoving = VSizeSq2D(Velocity) > 0.0000000;
                I = 0;
                J0x164:

                // End:0x2A4 [Loop If]
                if(I < m_HitReactionSkelControls.Length)
                {
                    // End:0x296
                    if(((int(m_HitReactionSkelControls[I].m_MoveType) == int(0)) || (int(m_HitReactionSkelControls[I].m_MoveType) == int(1)) && !bMoving) || (int(m_HitReactionSkelControls[I].m_MoveType) == int(2)) && bMoving)
                    {
                        m_HitReactionSkelControls[I].SetRecoilDir(RecoilDir);
                        m_HitReactionSkelControls[I].bPlayRecoil = true;
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x164;
                }
            }
        }        
    }
    else
    {
        // End:0x2E8
        if(int(Dir) == int(0))
        {
            HitReactionAnimName = ((FRand() > 0.5000000) ? 'HitReaction_FromFront_Ranged' : 'HitReaction_FromFront_Ranged_02');            
        }
        else
        {
            // End:0x312
            if(int(Dir) == int(1))
            {
                HitReactionAnimName = 'HitReaction_FromFront_Ranged';                
            }
            else
            {
                // End:0x33C
                if(int(Dir) == int(2))
                {
                    HitReactionAnimName = 'HitReaction_FromFront_Ranged';                    
                }
                else
                {
                    HitReactionAnimName = 'HitReaction_FromFront_Ranged';
                }
            }
        }
        PlayFullBodyAnim(HitReactionAnimName, 1.0000000, 0.0000000, m_fHitReactionBlendOutTime, false, true);
    }
    //return;    
}

protected simulated function EndTween(TgPawn.ETweenState endingTweenState, bool bInterrupted)
{
    switch(endingTweenState)
    {
        // End:0x3B
        case 2:
            s_bCanApplyEffects = true;
            DefaultTweenEnd(bInterrupted);
            // End:0x122
            break;
        // End:0x57
        case 1:
            DefaultTweenEnd(bInterrupted);
            // End:0x122
            break;
        // End:0x103
        case 3:
            m_bIsInvisibleToAI = false;
            DefaultTweenEnd(bInterrupted);
            PopPosture(m_nPhysTweenPostureId);
            m_nPhysTweenPostureId = 0;
            // End:0x103
            if(DynamicLightEnvironmentComponent(LightEnvironment) != none)
            {
                DynamicLightEnvironmentComponent(LightEnvironment).bDynamic = DynamicLightEnvironmentComponent(default.LightEnvironment).bDynamic;
            }
        // End:0x11F
        case 4:
            DefaultTweenEnd(bInterrupted);
            // End:0x122
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

final simulated function DefaultTweenEnd(bool bInterrupted)
{
    local Vector Destination;

    bCollideWorld = true;
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    bIgnoreForces = default.bIgnoreForces;
    // End:0x8B
    if(!bInterrupted)
    {
        SetLocation(GetPhysTweenTargetLocation());
        SetPhysics(1);
        Landed(vect(0.0000000, 0.0000000, 1.0000000), none);        
    }
    else
    {
        Destination = Location;
        // End:0xE9
        if(FindSpot(GetCollisionExtent(), Destination))
        {
            // End:0xE1
            if(Destination != Location)
            {
                SetLocation(Destination);
            }
            SetPhysics(2);            
        }
        else
        {
            SetLocation(GetPhysTweenTargetLocation());
            SetPhysics(1);
            Landed(vect(0.0000000, 0.0000000, 1.0000000), none);
        }
    }
    // End:0x14B
    if(IsAliveAndWell())
    {
        SetCollisionType(CollisionType);
        SetCollision(bCollideActors, bBlockActors, false);
    }
    //return;    
}

final simulated event StartPhysGrab(TgPawn Source, float fTime, TgPawn.EGrabState grabState, optional name grabSocket, optional Vector grabLocOffset, optional Rotator grabRotOffset)
{
    // End:0x1C
    if((GetHealth()) <= 0.0000000)
    {
        return;        
    }
    else
    {
        // End:0x4E
        if((int(Role) >= int(ROLE_AutonomousProxy)) && !IsGrabSourceValid(Source))
        {
            return;
        }
    }
    // End:0x6D
    if(int(m_eLocalTweenState) != int(0))
    {
        EndPhysTween(true);
    }
    // End:0x8C
    if(int(m_eLocalGrabState) != int(0))
    {
        EndPhysGrab(true);
    }
    // End:0xFF
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_GrabSource = Source;
        r_fGrabDuration = fTime;
        r_GrabAttachSocket = grabSocket;
        r_vGrabLocationOffset = grabLocOffset;
        r_rGrabRotationOffset = grabRotOffset;
    }
    // End:0x137
    if(r_GrabSource != none)
    {
        r_GrabSource.OnGrabTargetAttach(grabState, self);
    }
    BeginGrab(grabState);
    m_eLocalGrabState = grabState;
    // End:0x184
    if(int(Role) == int(ROLE_Authority))
    {
        r_eGrabState = grabState;
    }
    // End:0x1B1
    if(r_fGrabDuration > 0.0000000)
    {
        SetTimer(r_fGrabDuration, false, 'EndPhysGrab');        
    }
    else
    {
        // End:0x1CF
        if(r_fGrabDuration == 0.0000000)
        {
            EndPhysGrab();
        }
    }
    //return;    
}

final simulated event EndPhysGrab(optional bool bInterrupted = false)
{
    local TgPawn.EGrabState oldGrabState;

    ClearTimer('EndPhysGrab');
    // End:0xE0
    if(int(m_eLocalGrabState) != int(0))
    {
        oldGrabState = m_eLocalGrabState;
        m_eLocalGrabState = 0;
        r_bGrabInterrupted = bInterrupted;
        // End:0x81
        if(int(Role) == int(ROLE_Authority))
        {
            r_eGrabState = 0;
        }
        // End:0xC3
        if(r_GrabSource != none)
        {
            r_GrabSource.OnGrabTargetDetach(oldGrabState, self, bInterrupted);
        }
        EndGrab(oldGrabState, bInterrupted);
    }
    //return;    
}

final event ForceAllGrabTargetsDetach(optional TgPawn.EGrabState State)
{
    local int I;
    local TgPawn AttachedPawn;
    local bool bShouldDetachThisState;

    // End:0x26C
    if(int(Role) == int(ROLE_Authority))
    {
        I = Attached.Length - 1;
        J0x2C:

        // End:0x145 [Loop If]
        if(I >= 0)
        {
            AttachedPawn = TgPawn(Attached[I]);
            // End:0x137
            if(AttachedPawn != none)
            {
                bShouldDetachThisState = ((int(State) == int(0)) ? int(AttachedPawn.m_eLocalGrabState) > int(0) : int(State) == int(AttachedPawn.m_eLocalGrabState));
                // End:0x137
                if(bShouldDetachThisState && AttachedPawn.r_GrabSource == self)
                {
                    AttachedPawn.EndPhysGrab(true);
                }
            }
            I--;
            // [Loop Continue]
            goto J0x2C;
        }
        I = s_GrabbedTargets.Length - 1;
        J0x15C:

        // End:0x26C [Loop If]
        if(I >= 0)
        {
            AttachedPawn = s_GrabbedTargets[I];
            // End:0x25E
            if(AttachedPawn != none)
            {
                bShouldDetachThisState = ((int(State) == int(0)) ? int(AttachedPawn.m_eLocalGrabState) > int(0) : int(State) == int(AttachedPawn.m_eLocalGrabState));
                // End:0x25E
                if(bShouldDetachThisState && AttachedPawn.r_GrabSource == self)
                {
                    AttachedPawn.EndPhysGrab(true);
                }
            }
            I--;
            // [Loop Continue]
            goto J0x15C;
        }
    }
    //return;    
}

protected simulated function OnGrabTargetAttach(TgPawn.EGrabState newGrabState, TgPawn Target)
{
    //return;    
}

protected simulated function OnGrabTargetDetach(TgPawn.EGrabState endingGrabState, TgPawn Target, bool bInterrupted)
{
    //return;    
}

final simulated event bool ShouldGrabBreakStealth(TgPawn.EGrabState grabState)
{
    return false;
    //return ReturnValue;    
}

final simulated event bool IsBaselessGrab(TgPawn.EGrabState grabState)
{
    return false;
    //return ReturnValue;    
}

protected simulated function BeginGrab(TgPawn.EGrabState newGrabState)
{
    switch(newGrabState)
    {
        // End:0x7E
        case 1:
            InterruptUse();
            InterruptAllDevices();
            DefaultGrabStart(true);
            // End:0x5D
            if(m_nPhysGrabPostureId < 0)
            {
                m_nPhysGrabPostureId = PushPosture(18);
            }
            SetCollision(false, false);
            bCollideWorld = false;
            bCollideComplex = false;
            // End:0xEC
            break;
        // End:0xE9
        case 2:
            InterruptUse();
            InterruptAllDevices();
            DefaultGrabStart(true);
            // End:0xC8
            if(m_nPhysGrabPostureId < 0)
            {
                m_nPhysGrabPostureId = PushPosture(18);
            }
            SetCollision(false, false);
            bCollideWorld = false;
            bCollideComplex = false;
            // End:0xEC
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0x132
    if(ShouldGrabBreakStealth(newGrabState) && r_EffectManager != none)
    {
        r_EffectManager.RemoveAllStealthEffects();
    }
    //return;    
}

protected simulated function EndGrab(TgPawn.EGrabState endingGrabState, bool bInterrupted)
{
    switch(endingGrabState)
    {
        // End:0x8B
        case 1:
            DefaultGrabEnd(bInterrupted);
            // End:0x5D
            if(m_nPhysGrabPostureId >= 0)
            {
                PopPosture(m_nPhysGrabPostureId);
                m_nPhysGrabPostureId = -1;
            }
            // End:0x70
            if(IsAliveAndWell())
            {
                SetCollision(true, true);
            }
            bCollideWorld = true;
            bCollideComplex = false;
            // End:0x106
            break;
        // End:0x103
        case 2:
            DefaultGrabEnd(bInterrupted);
            // End:0xD5
            if(m_nPhysGrabPostureId >= 0)
            {
                PopPosture(m_nPhysGrabPostureId);
                m_nPhysGrabPostureId = -1;
            }
            // End:0xE8
            if(IsAliveAndWell())
            {
                SetCollision(true, true);
            }
            bCollideWorld = true;
            bCollideComplex = false;
            // End:0x106
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

final simulated function DefaultGrabStart(optional bool bRemoveRoots = false)
{
    local SkeletalMeshSocket Socket;
    local Vector WorldLoc;
    local Rotator WorldRot;

    m_PreGrabCollideActors = bCollideActors;
    m_PreGrabBlockActors = bBlockActors;
    m_PreGrabCollideWorld = bCollideWorld;
    m_PreGrabCollideComplex = bCollideComplex;
    // End:0x89
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        // End:0x89
        if(r_GrabSource == none)
        {
            EndPhysGrab();
            return;
        }
    }
    m_bCausesPushblock = false;
    bIgnoreForces = true;
    m_bCanBeKnockedBack = false;
    SetCollision(false, false, false);
    WorldLoc = r_GrabSource.Location + r_vGrabLocationOffset;
    WorldRot = r_GrabSource.Rotation + r_rGrabRotationOffset;
    SetLocation(WorldLoc);
    SetRotation(WorldRot);
    // End:0x143
    if(r_GrabSource == none)
    {
        return;
    }
    SetPhysics(0);
    SetHardAttach(true);
    // End:0x2AD
    if(r_GrabSource.Mesh != none)
    {
        Socket = r_GrabSource.Mesh.GetSocketByName(r_GrabAttachSocket);
        // End:0x275
        if(Socket != none)
        {
            m_vGrabDestRelLocation = Socket.RelativeLocation;
            m_rGrabDestRelRotation = Socket.RelativeRotation;
            SetBase(r_GrabSource, vect(0.0000000, 0.0000000, 1.0000000), r_GrabSource.Mesh, Socket.BoneName);            
        }
        else
        {
            SetBase(r_GrabSource);
            m_vGrabDestRelLocation = RelativeLocation;
            m_rGrabDestRelRotation = RelativeRotation;
        }        
    }
    else
    {
        SetBase(r_GrabSource);
        m_vGrabDestRelLocation = RelativeLocation;
        m_rGrabDestRelRotation = RelativeRotation;
    }
    SetPhysics(0);
    SetCollision(m_PreGrabCollideActors, m_PreGrabBlockActors);
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    // End:0x360
    if(bRemoveRoots)
    {
        r_EffectManager.RemoveEffectGroupsByCategory(10050);
    }
    //return;    
}

final simulated function DefaultGrabEnd(bool bInterrupted)
{
    local Vector dismountAdjust;

    SetBase(none);
    SetHardAttach(false);
    // End:0x128
    if((int(Role) == int(ROLE_Authority)) && SetLocation(r_GrabSource.Location + r_vGrabLocationOffset))
    {
        SetRotation(r_GrabSource.Rotation + r_rGrabRotationOffset);
        // End:0x128
        if(!IsLocallyControlled() && PlayerController(Controller) != none)
        {
            PlayerController(Controller).ClientSetLocation(r_GrabSource.Location + r_vGrabLocationOffset, r_GrabSource.Rotation + r_rGrabRotationOffset);
        }
    }
    dismountAdjust = -Vector(Rotation);
    dismountAdjust.Z = 1.0000000;
    m_bCausesPushblock = true;
    bIgnoreForces = default.bIgnoreForces;
    m_bCanBeKnockedBack = default.m_bCanBeKnockedBack;
    // End:0x1B0
    if(int(Physics) == int(0))
    {
        SetPhysics(2);
    }
    AddVelocity(dismountAdjust * float(200), Location, none);
    // End:0x1F3
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_GrabSource = none;
    }
    //return;    
}

final simulated function BaselessGrabStart(optional bool bRemoveRoots = false)
{
    // End:0x35
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        // End:0x35
        if(r_GrabSource == none)
        {
            EndPhysGrab();
            return;
        }
    }
    // End:0x81
    if(int(r_GrabSource.Role) == int(ROLE_Authority))
    {
        r_GrabSource.s_GrabbedTargets.AddItem(self);
    }
    // End:0xB4
    if(bRemoveRoots)
    {
        r_EffectManager.RemoveEffectGroupsByCategory(10050);
    }
    //return;    
}

final simulated function BaselessGrabEnd(bool bInterrupted)
{
    // End:0x4C
    if(int(r_GrabSource.Role) == int(ROLE_Authority))
    {
        r_GrabSource.s_GrabbedTargets.RemoveItem(self);
    }
    // End:0x6B
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_GrabSource = none;
    }
    //return;    
}

event AddVelocity(Vector NewVelocity, Vector HitLocation, Class<DamageType> DamageType, optional TraceHitInfo HitInfo)
{
    // End:0x3A
    if((int(Physics) == int(2)) && r_bIsJumping)
    {
        r_bIsJumping = false;
        ClientCancelJump();
    }
    super(Pawn).AddVelocity(NewVelocity, HitLocation, DamageType, HitInfo);
    //return;    
}

simulated function bool CanBeBaseForPawn(Pawn aPawn)
{
    local TgPawn TgPawn;

    TgPawn = TgPawn(aPawn);
    return super(Pawn).CanBeBaseForPawn(aPawn) || (TgPawn != none) && TgPawn.r_GrabSource == self;
    //return ReturnValue;    
}

function SetMovementPhysics()
{
    // End:0x2C
    if((int(m_eLocalGrabState) > int(0)) && int(Physics) == int(0))
    {
        return;
    }
    super(Pawn).SetMovementPhysics();
    //return;    
}

simulated function TickGrab(float DeltaSeconds)
{
    local Vector tweenLoc;
    local Rotator tweenRot;

    // End:0x41
    if((int(Physics) != int(0)) && !IsBaselessGrab(m_eLocalGrabState))
    {
        BeginGrab(m_eLocalGrabState);
    }
    // End:0x7E
    if((int(Role) >= int(ROLE_AutonomousProxy)) && !IsGrabSourceValid(r_GrabSource))
    {
        EndPhysGrab(true);
        return;
    }
    // End:0x11F
    if(!IsBaselessGrab(m_eLocalGrabState))
    {
        tweenLoc = VInterpTo(RelativeLocation, m_vGrabDestRelLocation, DeltaSeconds, 20.0000000);
        tweenRot = TweenRelRotation(DeltaSeconds, RelativeRotation, m_rGrabDestRelRotation);
        SetRelativeLocation(tweenLoc);
        SetRelativeRotation(tweenRot);
    }
    //return;    
}

event IncrementCannotBeGrabSource(optional bool bBreakGrabs = true)
{
    // End:0x4D
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x42
        if((r_nCannotBeGrabSource == 0) && bBreakGrabs)
        {
            ForceAllGrabTargetsDetach();
        }
        r_nCannotBeGrabSource++;
    }
    //return;    
}

event DecrementCannotBeGrabSource()
{
    // End:0x2D
    if(int(Role) == int(ROLE_Authority))
    {
        r_nCannotBeGrabSource = Max(r_nCannotBeGrabSource - 1, 0);
    }
    //return;    
}

simulated event bool IsGrabSourceValid(TgPawn Target, optional bool bAllowTurrets = false, optional bool bAllowStealthed = false)
{
    // End:0x1E
    if(Target == none)
    {
        return false;        
    }
    else
    {
        // End:0x47
        if(!Target.IsAliveAndWell())
        {
            return false;            
        }
        else
        {
            // End:0x75
            if(int(Target.m_eLocalGrabState) != int(0))
            {
                return false;                
            }
            else
            {
                // End:0xB7
                if(Target.IsStealthed(GetPRI()) && !bAllowStealthed)
                {
                    return false;                    
                }
                else
                {
                    // End:0xC8
                    if(r_nCannotBeGrabSource > 0)
                    {
                        return false;
                    }
                }
            }
        }
    }
    switch(Target.m_eLocalTweenState)
    {
        // End:0xFA
        case 0:
            return true;
            // End:0x102
            break;
        // End:0xFFFF
        default:
            return false;
            break;
    }    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x102
    //return ReturnValue;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x102    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x102
    // Failed to format remaining nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x102
}

simulated function float GetChargeTurnRate()
{
    return 16383.0000000;
    //return ReturnValue;    
}

final simulated event StartPhysCharge(TgPawn.EChargeState newChargeType, Rotator InitialDirection, optional Vector InitialLocation, optional float fChargeSpeed = 0.0000000, optional float fChargeRange = 0.0000000, optional bool bIngoreHumanoidBlocking = false, optional bool bUsePhysFlyingForCharge)
{
    // End:0x2F
    if((GetHealth()) <= 0.0000000)
    {
        return;
    }
    // End:0x160
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_eChargeState = newChargeType;
        r_fChargeInitialYaw = float(InitialDirection.Yaw);
        r_fChargeInitialPitch = float(InitialDirection.Pitch);
        r_bUsePhysFlyingForCharge = bUsePhysFlyingForCharge;
        // End:0xE2
        if(!IsZero(InitialLocation))
        {
            r_vChargeInitialLocation = InitialLocation;            
        }
        else
        {
            r_vChargeInitialLocation = Location;
        }
        r_fChargeSpeed = fChargeSpeed;
        r_fChargeRange = fChargeRange;
        r_bChargeIgnoreHumanoidBlocking = bIngoreHumanoidBlocking;
        // End:0x160
        if((int(Role) == int(ROLE_Authority)) && r_bIsKnockedBack)
        {
            Knock(false);
        }
    }
    // End:0x18F
    if((int(Physics) == int(WalkingPhysics)) || m_bCanChargeInAir)
    {
        SetPhysics(16);
    }
    m_bWantsCharge = true;
    //return;    
}

final simulated event EndPhysCharge(bool bInterrupted)
{
    // End:0x73
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_eChargeState = 0;
        r_fChargeInitialYaw = 0.0000000;
        r_fChargeInitialPitch = 0.0000000;
        r_vChargeInitialLocation = vect(0.0000000, 0.0000000, 0.0000000);
        r_fChargeSpeed = 0.0000000;
        r_fChargeRange = 0.0000000;
    }
    // End:0x88
    if(m_bEndChargeInFalling)
    {
        SetPhysics(2);        
    }
    else
    {
        // End:0xA1
        if(int(Physics) == int(16))
        {
            SetPhysics(1);
        }
    }
    m_bWantsCharge = false;
    //return;    
}

simulated function GetHitLocationForProximityTouch(Actor Target, out Vector HitLocation, out Vector HitNormal)
{
    local Vector accHitLocation, accHitNormal;

    // End:0xB7
    if(TraceComponent(accHitLocation, accHitNormal, Target.CollisionComponent, Target.Location, HitLocation, vect(0.0000000, 0.0000000, 0.0000000),, Target.bCollideComplex))
    {
        HitLocation = accHitLocation;
        HitNormal = accHitNormal;
    }
    //return;    
}

simulated event bool PredictChargeHit(Vector ChargeDir, Vector ChargeStart, float fChargeRange, Vector HitLocation, Vector HitNormal, Vector TargetLocation, Actor Other)
{
    local Vector accHitLocation, accHitNormal;

    accHitLocation = HitLocation;
    accHitNormal = HitNormal;
    GetHitLocationForProximityTouch(Other, accHitLocation, accHitNormal);
    // End:0x78
    if((Normal2D(TargetLocation - HitLocation) Dot ChargeDir) <= -0.2000000)
    {
        return false;
    }
    // End:0xB9
    if((fChargeRange > float(0)) && VSize2D(accHitLocation - ChargeStart) > fChargeRange)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated event bool VerifyChargeHit(Vector HitLocation, Vector HitNormal, Vector TargetLocation, Actor Other)
{
    local TgPawn pTgPawn;
    local Rotator chargeForward;
    local Vector accHitLocation, accHitNormal;

    // End:0x1E0
    if(int(r_eChargeState) != int(0))
    {
        accHitLocation = HitLocation;
        accHitNormal = HitNormal;
        GetHitLocationForProximityTouch(Other, accHitLocation, accHitNormal);
        chargeForward = Rotation;
        // End:0xEC
        if((int(r_eChargeState) == int(1)) || int(r_eChargeState) == int(2))
        {
            chargeForward.Yaw = int(r_fChargeInitialYaw);
            chargeForward.Pitch = int(r_fChargeInitialPitch);
        }
        // End:0x11B
        if((Normal2D(TargetLocation - Location) Dot Vector(chargeForward)) <= -0.2000000)
        {
            return false;
        }
        // End:0x186
        if((int(r_eChargeState) == int(1)) || int(r_eChargeState) == int(2))
        {
            // End:0x186
            if((r_fChargeRange > float(0)) && VSize2D(accHitLocation - r_vChargeInitialLocation) > r_fChargeRange)
            {
                return false;
            }
        }
        pTgPawn = TgPawn(Other);
        // End:0x1DE
        if((pTgPawn != none) && pTgPawn.GetPropCurrentValue(132) > float(0))
        {
            return false;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function StopAllAnimations()
{
    local AnimNodeSequence SeqNode;

    // End:0x56
    foreach Mesh.AllAnimNodes(Class'Engine.AnimNodeSequence', SeqNode)
    {
        SeqNode.bPlaying = false;        
    }    
    //return;    
}

simulated function TimerDestroy()
{
    //return;    
}

event EquipBestInHandDevice(optional bool bForceFastClear)
{
    local TgDevice TgD;

    // End:0x27
    if(m_EquippedDevices[1] != none)
    {
        TgD = m_EquippedDevices[1];
    }
    SetActiveWeapon(TgD, bForceFastClear);
    //return;    
}

singular simulated function OnRespawn()
{
    local TgPlayerController localPC;
    local int I;
    local TgDevice TgD;

    // End:0x4C
    if(Mesh != none)
    {
        Mesh.SetAnimTreeTemplate(Mesh.AnimTreeTemplate);
    }
    // End:0xF7
    if((IsLocallyControlled() && m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh1P != none)
    {
        m_WeaponMesh.m_WeaponMesh1P.SetAnimTreeTemplate(m_WeaponMesh.m_WeaponMesh1P.AnimTreeTemplate);
    }
    TermRagdoll();
    // End:0x174
    if(TgPlayerController(Controller) != none)
    {
        TgPlayerController(Controller).bDuck = 0;
        TgPlayerController(Controller).SetSoundMode('Default');
    }
    SwapToLiveMesh();
    ToggleSkelControlLocks(false);
    localPC = TgPlayerController(GetALocalPlayerController());
    // End:0x20D
    if(WorldInfo.IsPlayingDemo() || (localPC != none) && !localPC.AllowRagdoll())
    {
        SetUsePhysicsWithAnimation(false);        
    }
    else
    {
        SetUsePhysicsWithAnimation(true);
    }
    FxActivateGroupSelf('WhileAlive', 0);
    GotoState('Auto');
    m_PostureStack.Postures.Remove(0, m_PostureStack.Postures.Length);
    m_PostureStack.GUIDs.Remove(0, m_PostureStack.GUIDs.Length);
    // End:0x2EC
    if(TgPlayerController(Controller) != none)
    {
        c_StunnedPostureID = -1;
        c_FearedPostureID = -1;
    }
    m_ePosture = 0;
    bPlayedDeath = false;
    OnPostureChange();
    m_RecentHealList.Remove(0, m_RecentHealList.Length);
    EquipBestInHandDevice(true);
    TgD = GetDeviceByEqPoint(4);
    // End:0x398
    if(TgD != none)
    {
        TgD.ResetCooldown(int(TgD.CurrentFireMode), 0.0000000);
    }
    BlendToAnimTreeDeviceType();
    RemoveDeathEffects();
    c_bMeshHiddenDueToDeath = false;
    r_eDeathReason = 0;
    m_bHasPlayedDeathAnimation = false;
    m_bForceDeathAnim = false;
    m_ExecutionMaterialFadeOutTimer = m_ExecutionMaterialFadeOutDuration;
    ClearReplacementMaterial();
    ApplyPawnShadows(true);
    r_bJustJumped = false;
    I = 0;
    J0x41B:

    // End:0x484 [Loop If]
    if(I < 33)
    {
        TgD = GetDeviceByEqPoint(I);
        // End:0x476
        if(TgD != none)
        {
            TgD.OnOwnerRespawn();
        }
        I++;
        // [Loop Continue]
        goto J0x41B;
    }
    // End:0x4B8
    if(int(Role) == int(ROLE_Authority))
    {
        m_bWasKilledByEnvironment = false;
        SyncClientEnergy(GetEnergy());
    }
    // End:0x5D2
    if(m_WeaponMesh != none)
    {
        // End:0x520
        if(m_WeaponMesh.m_WeaponMesh1P != none)
        {
            m_WeaponMesh.m_WeaponMesh1P.SetHidden(false);
        }
        // End:0x579
        if(m_WeaponMesh.m_HandsMesh != none)
        {
            m_WeaponMesh.m_HandsMesh.SetHidden(false);
        }
        // End:0x5D2
        if(m_WeaponMesh.m_HeadMesh1P != none)
        {
            m_WeaponMesh.m_HeadMesh1P.SetHidden(false);
        }
    }
    // End:0x5F7
    if(r_bIsMounted)
    {
        PlayMountingEffects(false, r_bUseMountPosture);        
    }
    else
    {
        // End:0x61B
        if(m_MountMesh != none)
        {
            StopMountingEffects(false, r_bUseMountPosture);
        }
    }
    PlayPolymorphEffects();
    SetMountOnRespawn();
    PawnOnRevive();
    // End:0x651
    if(IsLocallyControlled())
    {
        EndLocalDeathRTPC();
    }
    //return;    
}

simulated function OnLiveRespawn()
{
    local int I;
    local TgDevice TgD;

    // End:0x4C
    if(Mesh != none)
    {
        Mesh.SetAnimTreeTemplate(Mesh.AnimTreeTemplate);
    }
    // End:0xF7
    if((IsLocallyControlled() && m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh1P != none)
    {
        m_WeaponMesh.m_WeaponMesh1P.SetAnimTreeTemplate(m_WeaponMesh.m_WeaponMesh1P.AnimTreeTemplate);
    }
    TermRagdoll();
    // End:0x121
    if(int(Role) == int(ROLE_Authority))
    {
        m_bWasKilledByEnvironment = false;
    }
    I = 0;
    J0x12C:

    // End:0x1EB [Loop If]
    if(I < 33)
    {
        TgD = GetDeviceByEqPoint(I);
        // End:0x1DD
        if(TgD != none)
        {
            // End:0x1A9
            if(TgD.m_bHandDevice)
            {
                TgD.ReloadAmmoWithSynchronization();
            }
            // End:0x1DD
            if(int(Role) == int(ROLE_Authority))
            {
                TgD.r_nProjectiles = 0;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x12C;
    }
    SetMountOnRespawn();
    //return;    
}

simulated function SetMountOnRespawn()
{
    local Class<TgGame_Paladins> GameClass;
    local TgRepInfo_Game GRI;
    local TgPlayerController TgPC;

    // End:0x37
    if((WorldInfo == none) || WorldInfo.GRI == none)
    {
        return;
    }
    // End:0x8D
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x8D
        if(TgPC != none)
        {
            return;
        }
    }
    // End:0xB1
    if(WorldInfo.IsPlayingTimelapse())
    {
        return;
    }
    GameClass = Class<TgGame_Paladins>(WorldInfo.GRI.GameClass);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x14A
    if((GameClass == none) || GRI == none)
    {
        return;
    }
    AutoMount((GameClass.default.m_bAutoMountOnRespawn && MySpawnGatesAreOpen()) && !GRI.r_bRoundEnding);
    //return;    
}

simulated event AutoMount(bool bShouldBeMounted, optional bool bToggleMount = false)
{
    local TgDevice_Mount MountDevice;

    MountDevice = TgDevice_Mount(GetDeviceByEqPoint(23));
    // End:0x170
    if(MountDevice != none)
    {
        // End:0x6F
        if(bToggleMount)
        {
            bShouldBeMounted = !MountDevice.IsFiring();            
        }
        else
        {
            // End:0x9F
            if(MountDevice.IsFiring() == bShouldBeMounted)
            {
                return;
            }
        }
        // End:0x151
        if(bShouldBeMounted)
        {
            // End:0xED
            if(MountDevice.IsDeviceCoolingDown())
            {
                MountDevice.EndCooldown();
            }
            MountDevice.m_bForceFireDueToRespawn = true;
            MountDevice.Use();
            MountDevice.m_bForceFireDueToRespawn = false;            
        }
        else
        {
            MountDevice.AutoDismount();
        }
    }
    //return;    
}

function LiveRespawn(bool bResetHealth, bool bResetDevices)
{
    // End:0x16
    if(int(Role) < int(ROLE_Authority))
    {
        return;
    }
    // End:0x2D
    if(r_bInCombatFlag)
    {
        ExitCombat();
    }
    // End:0x53
    if(bResetDevices)
    {
        StopFiringAllDevices(true, true, true, true);
        ReapplyLoadoutEffects(true);
    }
    // End:0x74
    if(bResetHealth)
    {
        SetSpawnHealth();
        SetSpawnMana();
    }
    m_LastDamager = none;
    s_Damagers.Remove(0, s_Damagers.Length);
    r_nLiveRespawn++;
    bNetDirty = true;
    OnLiveRespawn();
    //return;    
}

reliable client simulated function SyncClientEnergy(float energy)
{
    SetProperty(2, energy);
    //return;    
}

simulated function RemoveDeathEffects()
{
    // End:0x18
    if(m_bInitialized)
    {
        SetMeshVisibility(true);
    }
    //return;    
}

simulated function SetPawnState(name NewState)
{
    GotoState(NewState);
    //return;    
}

simulated event bool IsInItemShop()
{
    local TgItemShopVolume ItemShop;

    // End:0x1C
    foreach TouchingActors(Class'TgGame.TgItemShopVolume', ItemShop)
    {        
        return true;        
    }    
    return false;
    //return ReturnValue;    
}

simulated event bool IsInFriendlyItemShop()
{
    local TgItemShopVolume ItemShop;

    // End:0x4B
    foreach TouchingActors(Class'TgGame.TgItemShopVolume', ItemShop)
    {
        // End:0x4A
        if(ItemShop.TaskforceIndex == int(GetTaskForceNumber()))
        {            
            return true;
        }        
    }    
    return false;
    //return ReturnValue;    
}

simulated event bool SetActiveWeapon(Weapon NewWeapon, optional bool bForceFastClear = false)
{
    local TgDevice Dev;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x8E
    if(InvManager != none)
    {
        Dev = TgDevice(NewWeapon);
        // End:0x8E
        if(Dev != none)
        {
            TgInventoryManager(InvManager).SetPendingWeapon(Dev);
            SetTargetingDevice(Dev, SwapStrategy);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy)
{
    local TgDevice PreviousTargetingDevice;
    local TgObject.TG_EQUIP_POINT eqp;

    PreviousTargetingDevice = c_CurrentTargetingDevice;
    // End:0x95
    if(((Dev != none) && c_nLockInHandToTargetingDevice > 0) && int(Dev.r_eEquippedAt) != int(1))
    {
        // End:0x80
        if(Dev.LogDebugInfo())
        {
        }
        Dev = GetDeviceByEqPoint(1);
    }
    // End:0xFD
    if(((PreviousTargetingDevice != none) && PreviousTargetingDevice.LogDebugInfo()) || (Dev != none) && Dev.LogDebugInfo())
    {
    }
    // End:0x25C
    if(c_CurrentTargetingDevice != Dev)
    {
        // End:0x1AC
        if(c_CurrentTargetingDevice != none)
        {
            // End:0x18D
            if(!c_CurrentTargetingDevice.IsFunctionallyToggleDevice() && !c_CurrentTargetingDevice.IsA('TgDevice_HitPulse'))
            {
                c_CurrentTargetingDevice.StopFire();
            }
            c_CurrentTargetingDevice.ExitTargetingMode();
        }
        c_CurrentTargetingDevice = Dev;
        // End:0x25C
        if(c_CurrentTargetingDevice != none)
        {
            c_CurrentTargetingDevice.EnterTargetingMode();
            // End:0x25C
            if(m_WeaponMesh != none)
            {
                eqp = GetEquipSlotOfDevice(Dev);
                m_WeaponMesh.PlayMeshTransitionAnimation(SwapStrategy, eqp, PreviousTargetingDevice, Dev);
            }
        }
    }
    //return;    
}

simulated function TgObject.TG_EQUIP_POINT GetEquipSlotOfDevice(TgDevice Dev)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x56 [Loop If]
    if(I < 33)
    {
        // End:0x48
        if(m_EquippedDevices[I] == Dev)
        {
            return byte(I);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return 0;
    //return ReturnValue;    
}

event LockTargetingDeviceToInHand(bool bEnable)
{
    local WeaponMeshSwapStrategy SwapStrategy;

    c_nLockInHandToTargetingDevice += ((bEnable) ? 1 : -1);
    c_nLockInHandToTargetingDevice = Max(c_nLockInHandToTargetingDevice, 0);
    // End:0x63
    if(c_nLockInHandToTargetingDevice > 0)
    {
        SetTargetingDevice(GetDeviceByEqPoint(1), SwapStrategy);
    }
    //return;    
}

simulated function name GetDefaultCameraMode(PlayerController RequestedBy)
{
    // End:0x82
    if(((RequestedBy != none) && RequestedBy.PlayerCamera != none) && RequestedBy.PlayerCamera.CameraStyle == 'Fixed')
    {
        return 'Fixed';
    }
    return 'ThirdPerson';
    //return ReturnValue;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local int I, J;
    local editinline PrimitiveComponent P;
    local string S;
    local float XL, YL;
    local ReverbVolume ReverbVolume;

    super(Pawn).DisplayDebug(HUD, out_YL, out_YPos);
    // End:0x19F
    if(HUD.ShouldDisplayDebug('Speed'))
    {
        HUD.Canvas.DrawText("Speed:" @ string(VSize(Velocity)));
        out_YPos += out_YL;
        HUD.Canvas.SetPos(4.0000000, out_YPos);
        HUD.Canvas.DrawText("Velocity:" @ string(Velocity));
        out_YPos += out_YL;
        HUD.Canvas.SetPos(4.0000000, out_YPos);
    }
    // End:0x1CA
    if(HUD.ShouldDisplayDebug('footsteps'))
    {
    }
    // End:0x384
    if(HUD.ShouldDisplayDebug('Reverb'))
    {
        ReverbVolume = GetCurrentReverbVolume();
        // End:0x329
        if(ReverbVolume != none)
        {
            HUD.Canvas.DrawText("Reverb Volume:" @ string(ReverbVolume));
            out_YPos += out_YL;
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            HUD.Canvas.DrawText("AUX:" @ string(ReverbVolume.AuxBusName));            
        }
        else
        {
            HUD.Canvas.DrawText("Not currently in a reverb volume");
        }
    }
    // End:0xAA1
    if(HUD.ShouldDisplayDebug('PawnComponent'))
    {
        HUD.Canvas.SetDrawColor(255, 255, 128, 255);
        I = 0;
        J0x3F6:

        // End:0xA30 [Loop If]
        if(I < Mesh.Attachments.Length)
        {
            HUD.Canvas.SetPos(4.0000000, out_YPos);
            S = "" $ string(Mesh.Attachments[I].Component);
            HUD.Canvas.StrLen(S, XL, YL);
            J = Len(S);
            J0x515:

            // End:0x5EA [Loop If]
            if((XL > (HUD.Canvas.ClipX * 0.5000000)) && J > 10)
            {
                J--;
                S = Right(S, J);
                HUD.Canvas.StrLen(S, XL, YL);
                // [Loop Continue]
                goto J0x515;
            }
            HUD.Canvas.DrawText(((("Attachment" @ string(I)) @ " = ") @ string(Mesh.Attachments[I].BoneName)) @ S);
            out_YPos += out_YL;
            P = PrimitiveComponent(Mesh.Attachments[I].Component);
            // End:0xA22
            if(P != none)
            {
                HUD.Canvas.SetPos(24.0000000, out_YPos);
                HUD.Canvas.DrawText(((("Component = " @ string(P.Owner)) @ string(P.HiddenGame)) @ string(P.bOnlyOwnerSee)) @ string(P.bOwnerNoSee));
                out_YPos += out_YL;
                S = "" $ string(P);
                HUD.Canvas.StrLen(S, XL, YL);
                J = Len(S);
                J0x8A4:

                // End:0x979 [Loop If]
                if((XL > (HUD.Canvas.ClipX * 0.5000000)) && J > 10)
                {
                    J--;
                    S = Right(S, J);
                    HUD.Canvas.StrLen(S, XL, YL);
                    // [Loop Continue]
                    goto J0x8A4;
                }
                HUD.Canvas.SetPos(24.0000000, out_YPos);
                HUD.Canvas.DrawText("Component = " @ S);
                out_YPos += out_YL;
            }
            I++;
            // [Loop Continue]
            goto J0x3F6;
        }
        out_YPos += (out_YL * float(2));
        HUD.Canvas.SetPos(24.0000000, out_YPos);
        out_YPos += out_YL;
    }
    //return;    
}

simulated function TgPawnControllerSet()
{
    local TgPlayerController TgPC;

    UpdatePlayerStatUI();
    TgPC = TgPlayerController(Controller);
    // End:0x54
    if(TgPC != none)
    {
        TgPC.UpdatePlayerVitalsUI();
    }
    //return;    
}

simulated event UpdateWeaponMesh()
{
    local int DeviceID;
    local Class<TgDevice> WeaponClass;
    local WeaponMeshSwapStrategy SwapStrategy;
    local TgDeviceForm_Inhand InhandForm;

    // End:0x248
    if(((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && c_bUpdatesWeaponMesh) && c_EquipForm[1] != none)
    {
        // End:0x9D
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.SetHidden(true);
            m_WeaponMesh.Destroy();
            m_WeaponMesh = none;
        }
        DeviceID = c_EquipForm[1].c_EquipDeviceInfo.nDeviceId;
        // End:0x1B1
        if((m_WeaponMesh == none) && DeviceID > 0)
        {
            WeaponClass = Class<TgDevice>(DynamicLoadObject(Class'TgGame.TgWeaponMeshActor'.static.GetWeaponClassById(DeviceID), Class'Core.Class'));
            m_WeaponMesh = Spawn(WeaponClass.default.m_WeaponMeshActorClass, self,, Location, Rotation,, true);
            m_WeaponMesh.m_OwningPawn = self;
        }
        // End:0x1FC
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.SetActiveWeapon(1, DeviceID, WeaponClass, SwapStrategy);
        }
        InhandForm = TgDeviceForm_Inhand(c_EquipForm[1]);
        // End:0x248
        if(InhandForm != none)
        {
            InhandForm.OnWeaponMeshUpdated();
        }
    }
    //return;    
}

simulated event UpdateFirstValidFlashEventIdx()
{
    c_nLastProcessedFlashEventIdx = r_nFirstValidFlashEventIdx - 1;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x18
    if(NativeReplicatedEvent(VarName))
    {
        return;
    }
    // End:0x5A
    if(VarName == 'r_ReplicatedDeviceState')
    {
        // End:0x55
        if(c_bJustStartedTimelapsePlayback || c_bJustEndedTimelapsePlayback)
        {
            OnStartTimelapseNewDeviceState();
        }
        return;        
    }
    else
    {
        // End:0x118
        if(VarName == 'r_bIsMounted')
        {
            // End:0x115
            if(((!IsLocallyControlled() || c_bJustStartedTimelapsePlayback) || c_bJustEndedTimelapsePlayback) || WorldInfo.IsPlayingTimelapse())
            {
                ((r_bIsMounted) ? PlayMountingEffects(false, r_bUseMountPosture) : StopMountingEffects(!c_bJustStartedTimelapsePlayback || c_bJustEndedTimelapsePlayback, r_bUseMountPosture));
            }            
        }
        else
        {
            // End:0x1D1
            if(VarName == 'r_eTweenState')
            {
                // End:0x1A7
                if((int(r_eTweenState) != int(0)) && r_vPhysTweenTarget != vect(0.0000000, 0.0000000, 0.0000000))
                {
                    StartPhysTween(r_vPhysTweenTarget, r_fPhysTweenDuration, r_eTweenState, (r_nPhysTweenFlags & 1) != 0, (r_nPhysTweenFlags & 2) != 0);                    
                }
                else
                {
                    // End:0x1CF
                    if(int(r_eTweenState) == int(0))
                    {
                        EndPhysTween(r_bPhysTweenInterrupted);
                    }
                }
                return;
            }
        }
    }
    // End:0x278
    if(VarName == 'r_eGrabState')
    {
        // End:0x250
        if((int(r_eGrabState) != int(0)) && r_GrabSource != none)
        {
            StartPhysGrab(r_GrabSource, r_fGrabDuration, r_eGrabState, r_GrabAttachSocket, r_vGrabLocationOffset, r_rGrabRotationOffset);            
        }
        else
        {
            // End:0x278
            if(int(r_eGrabState) == int(0))
            {
                EndPhysGrab(r_bGrabInterrupted);
            }
        }
    }
    // End:0x29B
    if(VarName == 'r_nBigTeleportCount')
    {
        PostBigTeleport();
        return;
    }
    // End:0x2E4
    if(VarName == 'r_nPhase')
    {
        OnPhaseEnded(c_PreviousPhase);
        OnPhaseChange();
        c_PreviousPhase = r_nPhase;
        return;
    }
    // End:0x311
    if(VarName == 'r_bIsMarked')
    {
        PlayMarkEffects(r_bIsMarked);
        return;
    }
    // End:0x33E
    if(VarName == 'r_bIsDazed')
    {
        PlayDazeEffects(r_bIsDazed);
        return;
    }
    // End:0x36B
    if(VarName == 'r_bIsCCImmune')
    {
        PlayCCImmuneEffects(r_bIsCCImmune);
        return;
    }
    // End:0x398
    if(VarName == 'r_bIsBleeding')
    {
        PlayBleedEffects(r_bIsBleeding);
        return;
    }
    // End:0x3C5
    if(VarName == 'r_bIsOnFire')
    {
        PlayOnFireEffects(r_bIsOnFire);
        return;
    }
    // End:0x3F2
    if(VarName == 'r_bIsFrozen')
    {
        PlayFreezeEffects(r_bIsFrozen);
        return;
    }
    // End:0x41F
    if(VarName == 'r_bIsRooted')
    {
        PlayRootEffects(r_bIsRooted);
        return;
    }
    // End:0x44C
    if(VarName == 'r_bIsKnockedBack')
    {
        PlayKnockbackEffects(r_bIsKnockedBack);
        return;
    }
    // End:0x479
    if(VarName == 'r_bIsPoisoned')
    {
        PlayPoisonedEffects(r_bIsPoisoned);
        return;
    }
    // End:0x4A9
    if(VarName == 'r_bCrippled')
    {
        PlayCrippledEffects(r_bCrippled);
        return;        
    }
    else
    {
        // End:0x4D6
        if(VarName == 'r_bIsFlashBang')
        {
            PlayFlashBangEffects(r_bIsFlashBang);
            return;
        }
    }
    // End:0x503
    if(VarName == 'r_bIsSlowed')
    {
        PlaySlowEffects(r_bIsSlowed);
        return;
    }
    // End:0x540
    if(VarName == 'r_bDisarmed')
    {
        // End:0x534
        if(r_bDisarmed)
        {
            PlayDisarmFX();            
        }
        else
        {
            StopDisarmFX();
        }
        return;
    }
    // End:0x56D
    if(VarName == 'r_bHasRespawnBeacon')
    {
        UpdateHasRespawnBeacon(r_bHasRespawnBeacon);
        return;
    }
    // End:0x590
    if(VarName == 'r_eCurrentStunType')
    {
        ClientSetStun();
        return;
    }
    // End:0x5C0
    if(VarName == 'r_nFlashQueIndex')
    {
        // End:0x5C0
        if(m_bInitialized)
        {
            FlashEventUpdate();
            return;
        }
    }
    // End:0x609
    if(VarName == 'r_eDesiredInHand')
    {
        // End:0x607
        if((int(Role) == int(ROLE_SimulatedProxy)) && m_bInitialized == true)
        {
            UpdateWeaponMesh();
        }
        return;
    }
    // End:0x65F
    if(((VarName == 'r_eIsStealthed') || VarName == 'r_bIsVolumeStealthed') || VarName == 'r_bIsVolumeStealthFading')
    {
        ApplyStealthClient();
        return;
    }
    // End:0x69A
    if(VarName == 'r_bDisableVolumeStealth')
    {
        // End:0x690
        if(r_bDisableVolumeStealth)
        {
            DisableVolumeStealth();            
        }
        else
        {
            EnableVolumeStealth();
        }
    }
    // End:0x755
    if(VarName == 'r_DeathInfo')
    {
        // End:0x713
        if(r_DeathInfo.bDead)
        {
            PlayDying(r_DeathInfo.dmgType, r_DeathInfo.HitLoc);
        }
        // End:0x753
        if(TgPlayerController(Controller) != none)
        {
            TgPlayerController(Controller).UpdatePlayerVitalsUI();
        }
        return;
    }
    // End:0x78B
    if(VarName == 'r_nResetCharacter')
    {
        // End:0x789
        if(r_nResetCharacter > 0)
        {
            GotoState('Auto');
        }
        return;
    }
    // End:0x7BD
    if(VarName == 'r_nLiveRespawn')
    {
        // End:0x7BB
        if(r_nLiveRespawn > 0)
        {
            OnLiveRespawn();
        }
        return;
    }
    // End:0x7D6
    if(VarName == 'r_TargetActor')
    {
        return;
    }
    // End:0x7FA
    if(VarName == 'Controller')
    {
        TgPawnControllerSet();        
    }
    else
    {
        // End:0x81E
        if(VarName == 'r_CurrentPropValues')
        {
            ReceivedPropValues();            
        }
        else
        {
            // End:0x842
            if(VarName == 'r_fCachedMaxHealth')
            {
                ReceivedCachedMaxHealth();                
            }
            else
            {
                // End:0x87C
                if(VarName == 'r_ReplicatedState')
                {
                    // End:0x879
                    if(!IsInState('Dying'))
                    {
                        GotoState(r_ReplicatedState);
                    }                    
                }
                else
                {
                    // End:0x8C3
                    if((VarName == 'r_fIntroOffset') || VarName == 'r_fIntroTime')
                    {
                        SetupIntroAnimNodesAndTimers();
                        SetWhiteOutStartTimer();                        
                    }
                    else
                    {
                        // End:0x8E8
                        if(VarName == 'r_CurrentPolymorph')
                        {
                            PlayPolymorphEffects();                            
                        }
                        else
                        {
                            // End:0x92C
                            if(VarName == 'r_PolymorphInstigator')
                            {
                                ReloadMeshAssemblies();
                                SwapToLiveMesh();
                                OnPolymorphChanged(!IsAliveAndWell());                                
                            }
                            else
                            {
                                // End:0x950
                                if(VarName == 'r_ObscuringDeployables')
                                {
                                    UpdateObscuringDeployableState();                                    
                                }
                                else
                                {
                                    // End:0x974
                                    if(VarName == 'r_BlindingDeployables')
                                    {
                                        UpdateBlindingDeployableState();                                        
                                    }
                                    else
                                    {
                                        // End:0x9A2
                                        if(VarName == 'r_nBodyMeshOverride')
                                        {
                                            ReloadMeshAssemblies();
                                            SwapToLiveMesh();                                            
                                        }
                                        else
                                        {
                                            // End:0x9D8
                                            if(VarName == 'r_bInCombatFlag')
                                            {
                                                SetRTPCValue('InCombatState', float(r_bInCombatFlag));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    super(Pawn).ReplicatedEvent(VarName);
    //return;    
}

simulated event ReceivedPropValues()
{
    //return;    
}

simulated event ReceivedCachedMaxHealth()
{
    //return;    
}

event ApplyStealthServer(TgPawn.STEALTH_TYPE eStealthed, optional float fRate = 9999.0000000, optional bool bForce = false)
{
    local TgRepInfo_TaskForce tfri;

    // End:0x1CB
    if(int(r_eIsStealthed) != int(eStealthed))
    {
        r_eIsStealthed = eStealthed;
        TgRepInfo_Player(PlayerReplicationInfo).r_bIsStealthed = int(eStealthed) > int(1);
        fRate = ((fRate >= 0.0000000) ? fRate : 9999.0000000);
        r_fStealthFadeRate = ((int(eStealthed) == int(0)) ? 0.0000000 : FMax(fRate, r_fStealthFadeRate));
        // End:0x105
        if(int(eStealthed) != int(0))
        {
            ForceAllGrabTargetsDetach();
            TeleportNotify();
        }
        // End:0x196
        foreach WorldInfo.DynamicActors(Class'TgGame.TgRepInfo_TaskForce', tfri)
        {
            // End:0x195
            if(tfri.s_MinimapManager != none)
            {
                tfri.s_MinimapManager.ForceUpdate(GetPRI());
            }            
        }        
        // End:0x1CB
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            ApplyStealthClient();
        }
    }
    //return;    
}

event InterruptStealth(optional TgDevice OriginatingDevice)
{
    local TgDevice stealthDevice;

    // End:0x17
    if((GetPropCurrentValue(24)) > float(0))
    {
        return;
    }
    // End:0x45
    if(r_EffectManager != none)
    {
        r_EffectManager.RemoveAllStealthEffects();
    }
    stealthDevice = GetDeviceByClass(Class'TgGame.TgDevice_Stealth');
    // End:0x90
    if(stealthDevice != none)
    {
        stealthDevice.InterruptFiring();
    }
    s_fDamageTakenDuringStealth = 0.0000000;
    ClearTimer('ClearStealthDamage');
    DisableVolumeStealth();
    //return;    
}

event InterruptLift(optional TgDevice OriginatingDevice)
{
    // End:0x36
    if(r_EffectManager != none)
    {
        r_EffectManager.RemoveEffectGroupsByCategory(16657);
    }
    //return;    
}

simulated function bool ShouldShowAsStealthed(bool bDetected)
{
    local PlayerController PC;
    local bool bShowAsStealthed;

    PC = GetALocalPlayerController();
    // End:0x25
    if(PC == none)
    {
        return false;
    }
    // End:0x181
    if(!IsFriendlyWithLocalPawn() && !PC.IsSpectating())
    {
        // End:0x87
        if((IsHardStealthed()) && !bDetected)
        {
            bShowAsStealthed = true;            
        }
        else
        {
            // End:0xD0
            if(((int(r_eIsStealthed) == int(2)) && !bDetected) && c_fStealthFadeValue >= 1.0000000)
            {
                bShowAsStealthed = true;                
            }
            else
            {
                // End:0x10E
                if((r_bIsVolumeStealthed && r_bIsVolumeStealthFading) && c_fVolumeFadeValue >= float(1))
                {
                    bShowAsStealthed = true;                    
                }
                else
                {
                    // End:0x12E
                    if(c_fDistanceFadeValue == float(1))
                    {
                        bShowAsStealthed = true;                        
                    }
                    else
                    {
                        // End:0x150
                        if(c_fObscuringDeployableFadeValue >= 1.0000000)
                        {
                            bShowAsStealthed = true;                            
                        }
                        else
                        {
                            // End:0x172
                            if(c_fBlindingDeployableFadeValue >= 1.0000000)
                            {
                                bShowAsStealthed = true;                                
                            }
                            else
                            {
                                bShowAsStealthed = false;
                            }
                        }
                    }
                }
            }
        }        
    }
    else
    {
        // End:0x1C9
        if(!PC.IsSpectating() && c_fBlindingDeployableFadeValue >= 1.0000000)
        {
            bShowAsStealthed = true;            
        }
        else
        {
            bShowAsStealthed = false;
        }
    }
    return bShowAsStealthed;
    //return ReturnValue;    
}

simulated event ApplyStealthClient(optional bool bForce = false)
{
    local bool bShowStealthed, bStealthed, bDetected, bIsHardRevealed;
    local TgRepInfo_Player localpri;
    local TgPlayerController localPC;
    local name stealthGroup;

    localPC = TgPlayerController(GetALocalPlayerController());
    localpri = ((localPC != none) ? localPC.CachedPRI : none);
    bStealthed = ((((int(r_eIsStealthed) > int(1)) || r_bIsVolumeStealthed) || c_fDistanceFadeValue == float(1)) || c_fObscuringDeployableFadeValue == float(1)) || c_fBlindingDeployableFadeValue == float(1);
    bDetected = bStealthed && !IsStealthed(localpri);
    bShowStealthed = bStealthed && ShouldShowAsStealthed(bDetected);
    bIsHardRevealed = IsHardRevealed(localpri);
    // End:0x1E9
    if(m_bPlayingStealth != bShowStealthed)
    {
        c_bHiddenDueToStealth = bShowStealthed;
        ApplyPawnShadows(c_bHiddenDueToStealth);
        // End:0x1AB
        if(r_EffectManager != none)
        {
            r_EffectManager.UpdateEffectFormVisibility();
        }
        SetHidden(c_bHiddenDueToStealth);
        RecalculateMaterial(IsFriendlyWithLocalPawn());
        m_bPlayingStealth = bShowStealthed;
    }
    // End:0x313
    if(!bIsHardRevealed && int(r_eIsStealthed) != int(0))
    {
        // End:0x259
        if((localPC != none) && localPC.Pawn == self)
        {
            stealthGroup = 'StealthLocal';            
        }
        else
        {
            // End:0x292
            if(localPC.IsEnemy(self))
            {
                stealthGroup = 'StealthEnemy';                
            }
            else
            {
                stealthGroup = 'Stealth';
            }
        }
        FxActivateGroupAllMesh(stealthGroup, 0);
        // End:0x2FA
        if(m_MountMesh != none)
        {
            m_MountMesh.FxActivateGroup(stealthGroup, 0);
        }
        c_bIsStealthMaterialOn = true;
        UpdateStealthMaterialBasedOnNearbyEnemies();        
    }
    else
    {
        // End:0x35E
        if((localPC != none) && localPC.Pawn == self)
        {
            stealthGroup = 'StealthLocal';            
        }
        else
        {
            // End:0x397
            if(localPC.IsEnemy(self))
            {
                stealthGroup = 'StealthEnemy';                
            }
            else
            {
                stealthGroup = 'Stealth';
            }
        }
        FxDeactivateGroupAllMesh(stealthGroup, 0);
        // End:0x3FB
        if(m_MountMesh != none)
        {
            m_MountMesh.FxDeactivateGroup(stealthGroup, 0);
        }
        // End:0x470
        if((m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh1P != none)
        {
            m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup(stealthGroup, 0);
        }
        c_bIsStealthMaterialOn = false;
    }
    // End:0x67A
    if(Mesh != none)
    {
        // End:0x584
        if((int(c_eIsStealthed) == int(0)) && int(r_eIsStealthed) != int(0))
        {
            Mesh.FxActivateIndependant('Stealth_Start', 0, Location, Vector(Rotation));
            // End:0x581
            if((m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_WeaponMesh.m_WeaponMesh1P.FxActivateIndependant('Stealth_Start', 0, Location, Vector(Rotation));
            }            
        }
        else
        {
            // End:0x67A
            if((int(c_eIsStealthed) != int(0)) && int(r_eIsStealthed) == int(0))
            {
                Mesh.FxActivateIndependant('Stealth_End', 0, Location, Vector(Rotation));
                // End:0x67A
                if((m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh1P != none)
                {
                    m_WeaponMesh.m_WeaponMesh1P.FxActivateIndependant('Stealth_End', 0, Location, Vector(Rotation));
                }
            }
        }
    }
    // End:0x6DB
    if((bDetected != m_bPlayingDetected) && IsLocallyControlled())
    {
        // End:0x6BC
        if(bDetected)
        {
            PlayDetectedFx();            
        }
        else
        {
            RemoveDetectedFx();
        }
        m_bPlayingDetected = bDetected;
    }
    c_eIsStealthed = r_eIsStealthed;
    //return;    
}

event FixUpVisibilityVolumes()
{
    local int I;
    local TgVisibilityVolume Vol;

    I = 0;
    J0x0B:

    // End:0x3E [Loop If]
    if(I < 2)
    {
        r_CurrentVisibilityVolumes[I] = none;
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    r_bIsVolumeStealthed = false;
    r_bIsVolumeStealthFading = false;
    VolumeStealthOff();
    GrassOff();
    // End:0x96
    foreach TouchingActors(Class'TgGame.TgVisibilityVolume', Vol)
    {
        AddVisibilityVolume(Vol);        
    }    
    UpdateObscuringDeployableState();
    //return;    
}

function AddVisibilityVolume(TgVisibilityVolume Vol)
{
    local int I;
    local bool bSuccessfulAdd;

    // End:0x0F
    if(m_bCannotBeVolumeStealthed)
    {
        return;
    }
    // End:0xFF
    if(((Vol != none) && (NumVisibilityVolumesTouching()) < 2) && (FindVisibilityVolume(Vol)) == -1)
    {
        I = 0;
        J0x5B:

        // End:0xBE [Loop If]
        if(I < 2)
        {
            // End:0xB0
            if(r_CurrentVisibilityVolumes[I] == none)
            {
                r_CurrentVisibilityVolumes[I] = Vol;
                bSuccessfulAdd = true;
                // [Explicit Break]
                goto J0xBE;
            }
            I++;
            // [Loop Continue]
            goto J0x5B;
        }
        J0xBE:

        // End:0xFF
        if(bSuccessfulAdd)
        {
            // End:0xFF
            if(!r_bIsVolumeStealthFading && !m_bDisableVolumeStealth)
            {
                VolumeStealthOn(Vol, true);
            }
        }
    }
    //return;    
}

function RemoveVisibilityVolume(TgVisibilityVolume Vol)
{
    local int VolumeIndex;

    // End:0x0F
    if(m_bCannotBeVolumeStealthed)
    {
        return;
    }
    // End:0x87
    if(Vol != none)
    {
        VolumeIndex = FindVisibilityVolume(Vol);
        // End:0x87
        if(VolumeIndex != -1)
        {
            r_CurrentVisibilityVolumes[VolumeIndex] = none;
            // End:0x87
            if((NumVisibilityVolumesTouching()) == 0)
            {
                VolumeStealthOff();
                GrassOff();
            }
        }
    }
    //return;    
}

function VolumeStealthFadeComplete()
{
    r_bIsVolumeStealthed = (NumVisibilityVolumesTouching()) > 0;
    r_bIsVolumeStealthFading = r_bIsVolumeStealthed;
    GetPRI().r_bIsVolumeStealthed = r_bIsVolumeStealthed;
    // End:0x8C
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        ApplyStealthClient();
    }
    //return;    
}

function VolumeStealthOn(TgVisibilityVolume Vol, optional bool bFull)
{
    ClearTimer('ClearStealthDamage');
    r_bIsVolumeStealthFading = true;
    GrassOn(Vol);
    // End:0x59
    if(!bFull)
    {
        SetTimer(1.0000000, false, 'VolumeStealthFadeComplete');        
    }
    else
    {
        VolumeStealthFadeComplete();
    }
    // End:0x12B
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !WorldInfo.IsPlayingTimelapse())
    {
        ApplyStealthClient();
        // End:0x12B
        if((Controller != none) && Controller.IsLocalPlayerController())
        {
            ClientPlayHiddenEffects(true, ((Vol != none) ? Vol.m_PlayerCameraInvisibleParticleSystem : none));
        }
    }
    //return;    
}

function VolumeStealthOff()
{
    ClearTimer('VolumeStealthFadeComplete');
    r_bIsVolumeStealthed = false;
    r_bIsVolumeStealthFading = false;
    GrassOff();
    // End:0x68
    if((GetPRI()) != none)
    {
        GetPRI().r_bIsVolumeStealthed = false;
    }
    // End:0xA4
    if((int(Role) == int(ROLE_Authority)) && s_fDamageTakenDuringStealth > 0.0000000)
    {
        SetTimer(1.0000000, false, 'ClearStealthDamage');
    }
    // End:0x150
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && (m_bDisableVolumeStealth || !IsInFriendlyObscuringDeployable()) || WorldInfo.IsPlayingTimelapse())
    {
        // End:0x150
        if((Controller != none) && Controller.IsLocalPlayerController())
        {
            ClientPlayHiddenEffects(false);
        }
    }
    //return;    
}

function ClearStealthDamage()
{
    s_fDamageTakenDuringStealth = 0.0000000;
    //return;    
}

function GrassOn(TgVisibilityVolume Vol)
{
    // End:0xBD
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !WorldInfo.IsPlayingTimelapse())
    {
        // End:0xBD
        if((Controller != none) && Controller.IsLocalPlayerController())
        {
            ClientPlayGrassEffects(true, ((Vol != none) ? Vol.m_PlayerCameraParticleSystem : none));
        }
    }
    // End:0xDD
    if(int(Role) == int(ROLE_Authority))
    {
        s_bIsInGrass = true;
    }
    //return;    
}

function GrassOff()
{
    // End:0x68
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x68
        if((Controller != none) && Controller.IsLocalPlayerController())
        {
            ClientPlayGrassEffects(false);
        }
    }
    // End:0x88
    if(int(Role) == int(ROLE_Authority))
    {
        s_bIsInGrass = false;
    }
    //return;    
}

function DisableVolumeStealth()
{
    // End:0x20
    if(int(Role) == int(ROLE_Authority))
    {
        r_bDisableVolumeStealth = true;
    }
    // End:0x4F
    if(!m_bDisableVolumeStealth)
    {
        m_bDisableVolumeStealth = true;
        VolumeStealthOff();
        UpdateObscuringDeployableState();
    }
    // End:0x7C
    if(m_fVolumeStealthDisableTime > 0.0000000)
    {
        SetTimer(m_fVolumeStealthDisableTime, false, 'EnableVolumeStealth');        
    }
    else
    {
        EnableVolumeStealth();
    }
    //return;    
}

function EnableVolumeStealth()
{
    ClearTimer('EnableVolumeStealth');
    // End:0x34
    if(int(Role) == int(ROLE_Authority))
    {
        r_bDisableVolumeStealth = false;
    }
    m_bDisableVolumeStealth = false;
    // End:0x76
    if(((NumVisibilityVolumesTouching()) > 0) && !r_bDisableVolumeStealth)
    {
        VolumeStealthOn(GetATouchingVisibilityVolume(), true);
    }
    UpdateObscuringDeployableState();
    //return;    
}

function UpdateObscuringDeployableState()
{
    local bool bShouldPlayFxs;

    // End:0x75
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !r_bIsVolumeStealthFading)
    {
        bShouldPlayFxs = IsInFriendlyObscuringDeployable() && !m_bDisableVolumeStealth;
        ClientPlayHiddenEffects(bShouldPlayFxs);
    }
    //return;    
}

function UpdateBlindingDeployableState()
{
    //return;    
}

unreliable client simulated event ClientEnterCombat(Actor aInstigator, Actor ATarget, optional float fLength)
{
    EnterCombat(aInstigator, ATarget, fLength);
    //return;    
}

event BeginMoving()
{
    // End:0x23
    if(s_bIsStill)
    {
        s_bIsStill = false;
        PawnOnEndStill();
    }
    ClearTimer('IsStillTimer');
    // End:0x5C
    if(5.0000000 > 0.0000000)
    {
        SetTimer(5.0000000, false, 'IsStillTimer');        
    }
    else
    {
        IsStillTimer();
    }
    //return;    
}

function IsStillTimer()
{
    // End:0x25
    if(!s_bIsStill)
    {
        s_bIsStill = true;
        PawnOnBecomeStill();
    }
    //return;    
}

simulated event EnterCombat(Actor aInstigator, Actor ATarget, optional float fLength)
{
    local bool bWasInCombat;
    local TgPlayerController TgPC;
    local float combatDurationReduction;

    // End:0x38
    if((r_EffectManager != none) && r_EffectManager.s_nForceOutOfCombatCount > 0)
    {
        return;
    }
    bWasInCombat = r_bInCombatFlag;
    // End:0x60
    if(true)
    {
        fLength = 5.0000000;
    }
    combatDurationReduction = FClamp((GetCombatDurationReduction()) / 100.0000000, 0.0000000, 1.0000000);
    fLength -= (fLength * combatDurationReduction);
    TgPC = TgPlayerController(Controller);
    // End:0xEF
    if((TgPC != none) && !IsTimerActive('InCombatTimer'))
    {        
    }
    else
    {
        // End:0x14B
        if((Controller != none) && Controller.IsA('TgAIController'))
        {
            TgAIController(Controller).OnEnterCombat();
        }
    }
    r_bInCombatFlag = true;
    m_LastHomeguardTime = 0.0000000;
    // End:0x18B
    if(ATarget == self)
    {
        s_LastAttacker = aInstigator;        
    }
    else
    {
        s_LastAttacked = ATarget;
    }
    Combat(true);
    // End:0x1C2
    if(!bWasInCombat)
    {
        PawnOnEnterCombat();
    }
    m_fInCombatTime = fLength;
    ClearTimer('InCombatTimer');
    // End:0x216
    if(m_fInCombatTime > 0.0000000)
    {
        SetTimer(m_fInCombatTime, false, 'InCombatTimer');        
    }
    else
    {
        InCombatTimer();
    }
    r_nInCombatNonce += 1;
    bNetDirty = true;
    //return;    
}

simulated event ExitCombat()
{
    // End:0x2B
    if(r_bInCombatFlag)
    {
        ClearTimer('InCombatTimer');
        InCombatTimer();
    }
    //return;    
}

simulated function InCombatTimer()
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(Controller);
    r_bInCombatFlag = false;
    m_fInCombatTime = 0.0000000;
    r_nInCombatNonce += 1;
    s_LastAttacker = none;
    s_LastAttacked = none;
    Combat(false);
    PawnOnExitCombat();
    // End:0x81
    if(TgPC != none)
    {        
    }
    else
    {
        // End:0xDD
        if((Controller != none) && Controller.IsA('TgAIController'))
        {
            TgAIController(Controller).OnExitCombat();
        }
    }
    bNetDirty = true;
    //return;    
}

simulated event Combat(bool bInCombat)
{
    //return;    
}

event bool InCombat()
{
    return r_bInCombatFlag;
    //return ReturnValue;    
}

simulated event float GetEnergyPercent()
{
    return ((((GetEnergy()) > float(0)) && (GetMaxEnergy()) > 0.0000000) ? (GetEnergy()) / (GetMaxEnergy()) : 0.0000000);
    //return ReturnValue;    
}

simulated function ApplyPawnShadows(bool bOn)
{
    // End:0x39
    if(Mesh != none)
    {
        Mesh.CastShadow = bOn;
    }
    //return;    
}

simulated event bool IsDying()
{
    return IsInState('Dying') || !Health > 0;
    //return ReturnValue;    
}

event Landed(Vector HitNormal, Actor FloorActor)
{
    local TgPlayerController TgPC;
    local TgCameraModule_ThirdPerson CamMod;
    local Vector landingFXLocation, LandingVelocity;

    LandingVelocity = Velocity;
    // End:0x13D
    if(Mesh != none)
    {
        landingFXLocation = Location;
        landingFXLocation.Z -= ((GetCollisionHeight()) / 2.0000000);
        // End:0xD2
        if(Velocity.Z <= m_fHardLandVelocityCutoff)
        {
            Mesh.FxActivateIndependant('Landing_Hard', 0, landingFXLocation, Vector(Rotation));            
        }
        else
        {
            // End:0x13D
            if(Velocity.Z <= m_fSoftLandVelocityCutoff)
            {
                Mesh.FxActivateIndependant('Landing_Soft', 0, landingFXLocation, Vector(Rotation));
            }
        }
    }
    TgPC = TgPlayerController(Controller);
    // End:0x21C
    if(((TgPC != none) && TgPC.m_bBehindView) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        CamMod = TgCameraModule_ThirdPerson(TgPC.GetCurrentCameraModule());
        // End:0x21C
        if(CamMod != none)
        {
            CamMod.f3pViewPaddingRemainingTime = 0.1000000;
        }
    }
    // End:0x261
    if(((int(Role) == int(ROLE_Authority)) && r_bIsKnockedBack) && r_fKnockedBackFrictionOverride < 0.0000000)
    {
        Knock(false);
    }
    super(Pawn).Landed(HitNormal, FloorActor);
    PawnOnLand();
    // End:0x2D2
    if(r_bIsJumping)
    {
        r_bIsJumping = false;
        m_fJumpLandingTime = WorldInfo.TimeSeconds;
        PawnOnLandAfterJump();
    }
    // End:0x33E
    if((r_bJustJumped && IsAliveAndWell()) && (GetPropCurrentValue(63)) <= float(0))
    {
        r_bJustJumped = false;
        // End:0x33E
        if(!m_bAllowHigherWallJumping)
        {
            m_bIsLanding = true;
            SetTimer(0.8000000, false, 'OnJumpPenaltyEnded');
        }
    }
    // End:0x38B
    if(!r_bIsMounted)
    {
        PlayLandingSound(LandingVelocity);
        // End:0x38B
        if(int(Role) == int(ROLE_Authority))
        {
            FlashPlaySpecialEffect(8, LandingVelocity);
        }
    }
    // End:0x3C4
    if(m_bIsLeaping || (GetPropCurrentValue(135)) > float(0))
    {
        m_bIsLeaping = false;
        PawnOnLandAfterLeap();
    }
    // End:0x3F2
    if(r_EffectManager != none)
    {
        r_EffectManager.HandleOnLandedIntercepts();
    }
    // End:0x45B
    if((Velocity.Z < float(-200)) && m_bUpdateEyeHeight)
    {
        m_fOldZ = Location.Z;
        m_bJustLanded = true;
    }
    //return;    
}

function OnJumpPenaltyEnded()
{
    ClearTimer('OnJumpPenaltyEnded');
    m_bIsLanding = false;
    //return;    
}

function PlayHit(float Damage, Controller InstigatedBy, Vector HitLocation, Class<DamageType> dmgType, Vector Momentum, TraceHitInfo HitInfo)
{
    local Class<TgDamageType> dmgClass;

    dmgClass = Class<TgDamageType>(dmgType);
    // End:0x47
    if((dmgClass == none) || ClassIsChildOf(dmgClass, Class'TgGame.TgDamageType_AbilityCost'))
    {
        return;
    }
    super(Pawn).PlayHit(Damage, InstigatedBy, HitLocation, dmgClass, Momentum, HitInfo);
    // End:0xD1
    if((Damage <= float(0)) && (Controller == none) || !Controller.bGodMode)
    {
        return;
    }
    // End:0xF2
    if(!EffectIsRelevant(HitLocation, true, 0.0000000))
    {
        return;
    }
    CheckHitInfo(HitInfo, Mesh, Normal(Momentum), HitLocation);
    //return;    
}

exec function FlushDebug()
{
    FlushPersistentDebugLines();
    //return;    
}

simulated event FellOutOfWorld(Class<DamageType> dmgType)
{
    // End:0x2A
    if(dmgType == Class'Engine.KillZDamageType')
    {
        dmgType = Class'TgGame.TgDamageType_FallOutOfWorld';
    }
    // End:0xAC
    if(int(Role) == int(ROLE_Authority))
    {
        Health = -1;
        m_bWasKilledByEnvironment = true;
        Died(Controller, dmgType, Location);
        // End:0xAC
        if(dmgType == none)
        {
            SetPhysics(0);
            LifeSpan = FMin(LifeSpan, 1.0000000);
        }
    }
    //return;    
}

singular simulated event OutsideWorldBounds()
{
    // End:0x2B
    if(int(Role) == int(ROLE_Authority))
    {
        m_bWasKilledByEnvironment = true;
        KilledBy(self);
    }
    SetPhysics(0);
    LifeSpan = FMin(LifeSpan, 1.0000000);
    //return;    
}

event KilledBy(Pawn EventInstigator)
{
    ModifyHealthProp(Health);
    super(Pawn).KilledBy(EventInstigator);
    //return;    
}

simulated function TurnOff()
{
    SetCollision(true, false);
    bNoWeaponFiring = true;
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    SetPhysics(0);
    bIgnoreForces = true;
    // End:0x68
    if(Weapon != none)
    {
        Weapon.StopFire();
    }
    //return;    
}

// Export UTgPawn::execInitRagdoll(FFrame&, void* const)
native simulated function bool InitRagdoll();

// Export UTgPawn::execDelayedRagdollConstraintBreak(FFrame&, void* const)
native function DelayedRagdollConstraintBreak();

simulated event HoldFlag(TgCarriedFlag NewFlag)
{
    m_CurrentFlag = NewFlag;
    m_CurrentFlag.SetHardAttach(true);
    m_CurrentFlag.SetBase(self);
    //return;    
}

event DropFlag(optional Controller C)
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x54
    if((PRI == none) || !PRI.r_bHasFlag)
    {
        return;
    }
    PRI.s_CarriedFlag.Drop(C);
    //return;    
}

simulated function BeginFadeOut()
{
    local TgSpecialFx FadeOutSpecialFX;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x9F
    if(Mesh != none)
    {
        Mesh.PutRigidBodyToSleep();
        Mesh.bNoSkeletonUpdate = true;
        Mesh.PhysicsWeight = 0.0000000;
    }
    m_bIsFadingOut = true;
    LifeSpan = m_fFadeOutTime;
    // End:0x19F
    if((m_bUseDamageTypeForDeathAnim && m_DeathDamageType != none) && m_DeathDamageType.default.m_nFadeOutSpecialFXId != -1)
    {
        FadeOutSpecialFX = GetSpecialFx(m_DeathDamageType.default.m_nFadeOutSpecialFXId);
        // End:0x19F
        if(FadeOutSpecialFX != none)
        {
            FadeOutSpecialFX.c_Owner = self;
            FadeOutSpecialFX.SpawnEmitter(Location, Vector(Rotation));
            Destroy();
        }
    }
    //return;    
}

simulated function OnLifeAfterDeathTimerExpired()
{
    //return;    
}

simulated function UpdateHealingBeamEffects()
{
    local TgSpecialFx HealingFX;
    local int I;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x25F
    if(r_HealTarget != none)
    {
        // End:0x137
        if(c_HealingBeamPSC == none)
        {
            HealingFX = TgSpecialFx(Mesh.FxGet('Healing Beam', 0));
            // End:0x99
            if(HealingFX == none)
            {
                return;
            }
            c_HealingBeamPSC = new Class'TgGame.TgParticleSystemComponent';
            c_HealingBeamPSC.SetTickGroup(5);
            c_HealingBeamPSC.SetTemplate(HealingFX.c_PSCList[0].c_PSCTemplate);
            AttachComponent(c_HealingBeamPSC);
        }
        // End:0x25C
        if(c_HealingBeamPSC != none)
        {
            // End:0x18A
            if(!c_HealingBeamPSC.bIsActive)
            {
                c_HealingBeamPSC.ActivateSystem();
            }
            c_HealingBeamPSC.SetVectorParameter('beamEnd', r_HealTarget.Location);
            I = 0;
            J0x1DB:

            // End:0x25C [Loop If]
            if(I < c_HealingBeamPSC.EmitterInstances.Length)
            {
                c_HealingBeamPSC.SetBeamEndPoint(I, r_HealTarget.Location);
                I++;
                // [Loop Continue]
                goto J0x1DB;
            }
        }        
    }
    else
    {
        // End:0x28D
        if(c_HealingBeamPSC != none)
        {
            c_HealingBeamPSC.DeactivateSystem();
        }
    }
    //return;    
}

simulated event DetachDevice()
{
    //return;    
}

simulated event AttachDevice()
{
    //return;    
}

simulated event PropertySet(int nPropertyId, float fPreviousValue, float fNewValue)
{
    //return;    
}

simulated event HandleClientPostPawnSetup()
{
    PostPawnSetup();
    m_bInitialized = true;
    OnPawnInitialized();
    OnWaitingForPawnDone();
    //return;    
}

simulated event WaitForInventoryThenDoPostPawnSetup()
{
    local bool bHasBotData, bAlive, bHasInvData, bHasEffectManager;

    ClearTimer('WaitForInventoryThenDoPostPawnSetup');
    // End:0x150
    if(!m_bInitialized)
    {
        bHasBotData = ((((r_nProfileId > 0) && r_nSkinId >= 0) && r_nWeaponSkinId >= 0) && r_nMountSkinId >= 0) && Mesh != none;
        bAlive = !IsInState('Dying') && Health > 0;
        bHasInvData = ((InvManager != none) || !bNetOwner) || WorldInfo.IsPlayingDemo();
        bHasEffectManager = r_EffectManager != none;
        // End:0x150
        if(((bHasBotData && bAlive) && bHasInvData) && bHasEffectManager)
        {
            HandleClientPostPawnSetup();
        }
    }
    // End:0x172
    if(!m_bInitialized)
    {
        SetTimer(0.1000000, false, 'WaitForInventoryThenDoPostPawnSetup');
    }
    //return;    
}

simulated function OnWaitingForPawnDone()
{
    // End:0x4D
    if(r_EffectManager != none)
    {
        r_EffectManager.UpdateEffectForms();
        r_EffectManager.UpdateEffectFormVisibility();
    }
    RecalculateMaterial(IsFriendlyWithLocalPawn());
    DeviceFormChanged(false);
    CalcDistanceFadeValue(10.0000000);
    c_fCurrentFadeValue = FMax(c_fDistanceFadeValue, FMax(c_fVolumeFadeValue, c_fStealthFadeValue));
    c_fCurrentFadeValue = FMax(c_fCurrentFadeValue, c_fObscuringDeployableFadeValue);
    // End:0xF7
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        ApplyStealthClient();
    }
    //return;    
}

simulated event OnPawnInitialized()
{
    // End:0x69
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x5E
        if(r_bNeedPlaySpawnFx)
        {
            // End:0x5B
            if(!c_bSpawnFxPlayed)
            {
                PlayInitialSpawnFX();
                c_bSpawnFxPlayed = true;
            }            
        }
        else
        {
            SetMeshVisibility(true);
        }
    }
    SetRTPCValue('InCombatState', float(r_bInCombatFlag));
    TriggerKismetPlayerInitialized();
    //return;    
}

simulated function TriggerKismetPlayerInitialized()
{
    local int Idx;
    local TgSeqEvent_PlayerInitialized InitializedEvent;
    local array<SequenceObject> Events;
    local bool bHumanControlled;
    local TgPlayerController TgPC;

    // End:0x42
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        bHumanControlled = IsHumanControlled();        
    }
    else
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        bHumanControlled = ((TgPC != none) ? TgPC.GetTgPawn() == self : IsHumanControlled());
    }
    // End:0x1F7
    if(WorldInfo.GetGameSequence() != none)
    {
        WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_PlayerInitialized', true, Events);
        Idx = 0;
        J0x120:

        // End:0x1F7 [Loop If]
        if(Idx < Events.Length)
        {
            InitializedEvent = TgSeqEvent_PlayerInitialized(Events[Idx]);
            // End:0x1E9
            if((InitializedEvent != none) && (InitializedEvent.bLocalPlayerOnly == false) || bHumanControlled)
            {
                // End:0x1E9
                if(InitializedEvent.CheckActivate(self, self))
                {
                    InitializedEvent.PopulateLinkedVariableValues();
                }
            }
            Idx++;
            // [Loop Continue]
            goto J0x120;
        }
    }
    //return;    
}

simulated function PlayInitialSpawnFX()
{
    FxActivateGroupSelf('Spawned', 0, 0, 0, true);
    //return;    
}

simulated function DrawConeComponent AttachConeComponent(DrawConeComponent ConeComponent, float fRadius, float fAngle)
{
    // End:0x16C
    if(ConeComponent == none)
    {
        ConeComponent = new Class'Engine.DrawConeComponent';
        ConeComponent.SetHidden(false);
        ConeComponent.ConeColor.R = 200;
        ConeComponent.ConeColor.G = 0;
        ConeComponent.ConeColor.B = 0;
        ConeComponent.ConeColor.A = 255;
        ConeComponent.ConeSides = 16;
        ConeComponent.SetTranslation((GetPawnViewLocation()) - Location);
    }
    ConeComponent.ConeRadius = fRadius;
    ConeComponent.ConeAngle = fAngle;
    // End:0x1F3
    if(!ConeComponent.bAttached)
    {
        AttachComponent(ConeComponent);
    }
    return ConeComponent;
    //return ReturnValue;    
}

simulated function DetachConeComponent(DrawConeComponent ConeComponent)
{
    // End:0x46
    if((ConeComponent != none) && ConeComponent.bAttached)
    {
        DetachComponent(ConeComponent);
    }
    //return;    
}

function gibbedBy(Actor Other)
{
    return;
    //return;    
}

simulated event OnAnimPlay(AnimNodeSequence SeqNode)
{
    //return;    
}

simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
    // End:0x49
    if((SeqNode != none) && SeqNode.NodeName == 'FullBodyCustomAnimSeqNode')
    {
        c_bDeviceHiddenDueToFullBodyAnim = false;
    }
    //return;    
}

simulated function StopFullBodyAnimation(optional float BlendOutTime = 0.1500000)
{
    // End:0x64
    if((m_FullBodyAnimNode != none) && m_FullBodyAnimNode.bIsPlayingCustomAnim)
    {
        m_FullBodyAnimNode.StopCustomAnim(BlendOutTime);
    }
    //return;    
}

simulated function ClientSetStun()
{
    local bool bDead, bChangePhysics;
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    bDead = IsInState('Dying') || bPlayedDeath;
    bChangePhysics = (!bDead && int(r_eCurrentStunType) != int(0)) && int(r_eCurrentStunType) != int(5);
    TgPC = TgPlayerController(Controller);
    // End:0xCE
    if((TgPC != none) && bChangePhysics)
    {
        bChangePhysics = TgPC.ShouldStunChangePhysics();
    }
    // End:0x109
    if(bChangePhysics)
    {
        Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    }
    // End:0x129
    if(!bDead)
    {
        PlayCustomAnimation(0, false, 0.0000000);
    }
    // End:0x1D8
    if((Controller != none) && !Controller.IsInState('Dead'))
    {
        // End:0x1AF
        if((int(r_eCurrentStunType) == int(0)) || int(r_eCurrentStunType) == int(5))
        {
            Controller.Stun(false);            
        }
        else
        {
            Controller.Stun(true, r_eCurrentStunType);
        }
    }
    // End:0x218
    if(int(r_eCurrentStunType) == int(6))
    {
        // End:0x215
        if(c_StunnedPostureID == -1)
        {
            c_StunnedPostureID = PushPosture(18);
        }        
    }
    else
    {
        // End:0x258
        if(int(r_eCurrentStunType) == int(4))
        {
            // End:0x255
            if(c_StunnedPostureID == -1)
            {
                c_StunnedPostureID = PushPosture(13);
            }            
        }
        else
        {
            // End:0x298
            if(int(r_eCurrentStunType) == int(9))
            {
                // End:0x295
                if(c_FearedPostureID == -1)
                {
                    c_FearedPostureID = PushPosture(17);
                }                
            }
            else
            {
                PopPosture(c_StunnedPostureID);
                c_StunnedPostureID = -1;
                PopPosture(c_FearedPostureID);
                c_FearedPostureID = -1;
            }
        }
    }
    // End:0x398
    if((TgPC != none) && TgPC.GetViewTarget() == self)
    {
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0x398
        if(TgCamera != none)
        {
            TgCamera.PlayStun((int(r_eCurrentStunType) != int(0)) && int(r_eCurrentStunType) != int(5));
        }
    }
    //return;    
}

function ResetStunnedBehavior(TgPlayerController PC, TgAIController aic)
{
    // End:0x201
    if((PC != none) && int(PC.m_eCurrentStunType) != int(TgPawn(PC.Pawn).r_eCurrentStunType))
    {
        // End:0x149
        if((int(TgPawn(PC.Pawn).r_eCurrentStunType) == int(0)) || int(TgPawn(PC.Pawn).r_eCurrentStunType) == int(5))
        {
            PC.Stun(false);
            PC.ClientResetStunnedBehavior(false);            
        }
        else
        {
            PC.Stun(true, TgPawn(PC.Pawn).r_eCurrentStunType);
            PC.ClientResetStunnedBehavior(true, TgPawn(PC.Pawn).r_eCurrentStunType);
        }
    }
    // End:0x385
    if((aic != none) && int(aic.m_eCurrentStunType) != int(TgPawn(aic.Pawn).r_eCurrentStunType))
    {
        // End:0x329
        if((int(TgPawn(aic.Pawn).r_eCurrentStunType) == int(0)) || int(TgPawn(PC.Pawn).r_eCurrentStunType) == int(5))
        {
            aic.Stun(false);            
        }
        else
        {
            aic.Stun(true, TgPawn(aic.Pawn).r_eCurrentStunType);
        }
    }
    //return;    
}

event Silence(bool bSilenced)
{
    local TgDevice Dev;
    local int I;

    r_bSilenced = bSilenced;
    // End:0x12B
    if(r_bSilenced)
    {
        Dev = none;
        I = 0;
        J0x38:

        // End:0xE9 [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0xDB
            if(((Dev != none) && Dev.CanBeSilenced()) && Dev.CanBeInterrupted())
            {
                Dev.InterruptFiring();
            }
            I++;
            // [Loop Continue]
            goto J0x38;
        }
        // End:0x12B
        if(int(r_eIsStealthed) != int(0))
        {
            // End:0x12B
            if(r_EffectManager != none)
            {
                r_EffectManager.RemoveAllStealthEffects();
            }
        }
    }
    //return;    
}

event Disarm(bool bDisarmed)
{
    local TgDevice Dev;
    local int I;

    r_bDisarmed = bDisarmed;
    // End:0x10A
    if(r_bDisarmed)
    {
        Dev = none;
        I = 0;
        J0x38:

        // End:0xE9 [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0xDB
            if(((Dev != none) && Dev.CanBeDisarmed()) && Dev.CanBeInterrupted())
            {
                Dev.InterruptFiring();
            }
            I++;
            // [Loop Continue]
            goto J0x38;
        }
        // End:0x107
        if(int(Role) == int(ROLE_Authority))
        {
            PlayDisarmFX();
        }        
    }
    else
    {
        // End:0x128
        if(int(Role) == int(ROLE_Authority))
        {
            StopDisarmFX();
        }
    }
    //return;    
}

simulated function PlayDisarmFX()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x74
    if(!c_bShowingDisarm)
    {
        FxActivateGroupSelf('Disarmed', 0);
        c_bShowingDisarm = true;
        c_DisarmedPostureID = PushPosture(16);
    }
    //return;    
}

simulated function StopDisarmFX()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x7A
    if(c_bShowingDisarm)
    {
        FxDeactivateGroupSelf('Disarmed', 0);
        c_bShowingDisarm = false;
        self.PopPosture(c_DisarmedPostureID);
    }
    //return;    
}

event Knock(bool bKnocked, optional float fKnockbackFrictionOverride = -1.0000000, optional Vector vKnockbackVelocityOverride = vect(0.0000000, 0.0000000, 0.0000000))
{
    local TgDevice Dev;
    local int I;

    r_bIsKnockedBack = bKnocked && !IsCrowdControlImmune();
    r_fKnockedBackFrictionOverride = fKnockbackFrictionOverride;
    r_vKnockedBackVelocityOverride = vKnockbackVelocityOverride;
    // End:0xF2
    if(r_bIsKnockedBack)
    {
        Dev = none;
        I = 0;
        J0x89:

        // End:0xF2 [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0xE4
            if(Dev != none)
            {
                Dev.OnKnock();
            }
            I++;
            // [Loop Continue]
            goto J0x89;
        }
    }
    //return;    
}

event Cripple(bool bCrippled)
{
    local TgDevice Dev;
    local int I;

    s_bHasCrippleEffect = bCrippled;
    r_bCrippled = (bCrippled && !IsCrowdControlImmune()) && (GetProtectionCC()) < 100.0000000;
    // End:0xDD
    if(r_bCrippled)
    {
        Dev = none;
        I = 0;
        J0x74:

        // End:0xDD [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0xCF
            if(Dev != none)
            {
                Dev.OnCripple();
            }
            I++;
            // [Loop Continue]
            goto J0x74;
        }
    }
    //return;    
}

event FlashBang(bool bIsFlashBang)
{
    r_bIsFlashBang = (bIsFlashBang && !IsCrowdControlImmune()) && (GetProtectionCC()) < 100.0000000;
    bNetDirty = true;
    PlayFlashBangEffects(r_bIsFlashBang);
    //return;    
}

event Stasis(bool bStasised)
{
    local TgDevice Dev;
    local int I;

    // End:0x5A
    if(bStasised)
    {
        EndPhysTween(false);
        // End:0x5A
        if(int(r_eIsStealthed) != int(0))
        {
            // End:0x5A
            if(r_EffectManager != none)
            {
                r_EffectManager.RemoveAllStealthEffects();
            }
        }
    }
    r_bIsInStasis = bStasised;
    // End:0x11D
    if(r_bIsInStasis)
    {
        Dev = none;
        I = 0;
        J0x92:

        // End:0x11D [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0x10F
            if(Dev != none)
            {
                // End:0x10F
                if(Dev.CanBeInterrupted())
                {
                    Dev.InterruptFiring();
                }
            }
            I++;
            // [Loop Continue]
            goto J0x92;
        }
    }
    //return;    
}

event Daze(bool bDazed, optional float Duration = 8.0000000, optional int FxId = 2430)
{
    // End:0xCB
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsDazed = bDazed;
        // End:0x5D
        if(Duration <= 0.0000000)
        {
            Duration = 8.0000000;
        }
        ClientDaze(bDazed, Duration, FxId);
        // End:0xCB
        if(r_bIsDazed)
        {
            m_fDazedStartTime = WorldInfo.TimeSeconds;
            m_fDazedDuration = Duration;
        }
    }
    //return;    
}

reliable client simulated function ClientDaze(bool bDazed, optional float Duration = 8.0000000, optional int FxId = 2430)
{
    r_bIsDazed = bDazed;
    m_fDazedDuration = Duration;
    // End:0x82
    if(r_bIsDazed)
    {
        m_fDazedStartTime = WorldInfo.TimeSeconds;
        LoadDazedMIC(FxId);
    }
    //return;    
}

simulated function DrawHUD(HUD H)
{
    local float U;

    super(Pawn).DrawHUD(H);
    // End:0x158
    if(r_bIsDazed && m_DazedWineMIC != none)
    {
        U = (WorldInfo.TimeSeconds - m_fDazedStartTime) / m_fDazedDuration;
        m_DazedWineMIC.SetScalarParameterValue('WineFlow', U);
        H.Canvas.DrawMaterialTile(m_DazedWineMIC, H.Canvas.ClipX, H.Canvas.ClipY, 0.0000000, 0.0000000, 1.0000000, 1.0000000);
    }
    //return;    
}

event bool CanBePulled()
{
    return r_bCanBePulled && !IsCrowdControlImmune();
    //return ReturnValue;    
}

event bool CanBeGrabbed()
{
    return ((GetPropCurrentValue(116)) == float(0)) && !IsCrowdControlImmune();
    //return ReturnValue;    
}

event HitWall(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    m_bHitWallThisTick = true;
    super(Actor).HitWall(HitNormal, Wall, WallComp);
    //return;    
}

simulated event EnableFootControls(int foot, bool bDisable)
{
    //return;    
}

simulated event InterruptUse()
{
    m_bUseInterrupted = true;
    //return;    
}

simulated event bool IsUseInterrupted()
{
    return m_bUseInterrupted;
    //return ReturnValue;    
}

simulated event InterruptAllDevices(optional bool bForceInterrupt = false)
{
    local TgDevice Dev;
    local int I;

    Dev = none;
    I = 0;
    J0x1B:

    // End:0xB5 [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0xA7
        if(Dev != none)
        {
            // End:0xA7
            if(bForceInterrupt || Dev.CanBeInterrupted())
            {
                Dev.InterruptFiring();
            }
        }
        I++;
        // [Loop Continue]
        goto J0x1B;
    }
    //return;    
}

simulated function SetTriggerToUse(TgTrigger_Use Trigger, bool bEnable)
{
    // End:0x23
    if(bEnable)
    {
        m_CurrentUseActor = Trigger;        
    }
    else
    {
        // End:0x45
        if(m_CurrentUseActor == Trigger)
        {
            m_CurrentUseActor = none;
        }
    }
    m_bUseInterrupted = false;
    // End:0xE6
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0xBC
        if(bEnable)
        {
            ClientSetTriggerMessage(Trigger, Trigger.GetMsgIdToDisplay());            
        }
        else
        {
            ClientSetTriggerMessage(none, Trigger.GetMsgIdToDisplay());
        }
    }
    //return;    
}

simulated function ClientSetTriggerMessage(TgTrigger_Use newTrigger, int msgId)
{
    //return;    
}

event CheckUseDuration(out float fDuration)
{
    //return;    
}

simulated function DisplayWeaponSwitchProgressBar(float Duration)
{
    //return;    
}

simulated function HideWeaponSwitchProgressBar()
{
    //return;    
}

simulated event Vector GetWeaponStartTraceLocation(TgDevice Dev)
{
    return (GetPawnViewLocation()) + (Dev.GetProjectileSpawnOffset() >> (GetBaseAimRotation(Dev)));
    //return ReturnValue;    
}

simulated event Vector GetWeaponStartTraceLocationAlt(Vector Offset)
{
    return (GetPawnViewLocation()) + (Offset >> (GetBaseAimRotation(none)));
    //return ReturnValue;    
}

simulated event GetBaseAimRotationNative(Weapon W, bool bIgnoreAutoLock, out Rotator Rot)
{
    Rot = GetBaseAimRotation(W, bIgnoreAutoLock);
    //return;    
}

simulated event GetAdjustedAimNative(Weapon W, Vector StartFireLoc, out Rotator Rot)
{
    local TgPlayerController TgPlayerController;

    Rot = GetAdjustedAimFor(W, StartFireLoc);
    TgPlayerController = TgPlayerController(Controller);
    // End:0x98
    if(TgPlayerController != none)
    {
        Rot = TgPlayerController.ApplyAimVectorModification(TgDevice(W), Rot);        
    }
    else
    {
        Rot.Pitch = int(m_fAimPitch);
    }
    //return;    
}

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock)
{
    local Vector POVLoc;
    local Rotator POVRot;
    local TgPlayerController PC;

    PC = TgPlayerController(Controller);
    // End:0xA6
    if((PC != none) && PC.ControlModule != none)
    {
        POVRot = PC.ControlModule.GetBaseAimRotation(W, bIgnoreAutoLock);        
    }
    else
    {
        // End:0xFA
        if((Controller != none) && !InFreeCam())
        {
            Controller.GetPlayerViewPoint(POVLoc, POVRot);            
        }
        else
        {
            POVRot = Rotation;
            // End:0x155
            if(POVRot.Pitch == 0)
            {
                POVRot.Pitch = m_nSmoothedRemoteViewPitch;
            }
        }
    }
    // End:0x179
    if(m_bUsesRecoil)
    {
        return ApplyRecoilToRotation(POVRot);        
    }
    else
    {
        return POVRot;
    }
    //return ReturnValue;    
}

simulated function float ApplyPitchLimit(float fPitch)
{
    return FClamp(fPitch, -16000.0000000, 16000.0000000);
    //return ReturnValue;    
}

simulated event EndCrouch(float HeightAdjust)
{
    super(Pawn).EndCrouch(HeightAdjust);
    AdjustMeshTranslation();
    //return;    
}

simulated event StartCrouch(float HeightAdjust)
{
    super(Pawn).StartCrouch(HeightAdjust);
    AdjustMeshTranslation();
    //return;    
}

simulated event TriggerJump()
{
    DoJump(true);
    //return;    
}

reliable server function ServerCancelJump()
{
    r_bIsJumping = false;
    ClientCancelJump();
    Velocity.Z = 0.0000000;
    //return;    
}

unreliable client simulated event ClientCancelJump()
{
    r_bIsJumping = false;
    //return;    
}

function bool DoJump(bool bUpdating, optional float JumpZSpeed = 0.0000000)
{
    local TgPlayerController TgPC;
    local bool bWasWalking;
    local float fHeightIncrease;

    TgPC = TgPlayerController(Controller);
    // End:0x5A
    if((TgPC != none) && TgPC.IsDeviceLockingInput())
    {
        return false;
    }
    // End:0x69
    if(r_bIsRooted)
    {
        return false;
    }
    // End:0x8F
    if(JumpZSpeed == 0.0000000)
    {
        JumpZSpeed = JumpZ;
    }
    // End:0xCC
    if(!r_bIsMounted && m_bIsLanding)
    {
        JumpZSpeed *= 0.6000000;
        r_bIsShortJump = true;        
    }
    else
    {
        r_bIsShortJump = false;
    }
    // End:0x35E
    if(bJumpCapable && m_bIgnorePhysCheckForJump || CheckPhysicsStateForJumping())
    {
        bWasWalking = int(Physics) == int(WalkingPhysics);
        JumpZSpeed *= (GetJumpSpeedMultiplier());
        fHeightIncrease = GetJumpHeightMultiplier();
        // End:0x178
        if(fHeightIncrease > 0.0000000)
        {
            JumpZSpeed *= Sqrt(fHeightIncrease);
        }
        // End:0x1AD
        if(int(Physics) == int(8))
        {
            Velocity = JumpZSpeed * Floor;            
        }
        else
        {
            // End:0x1E6
            if(int(Physics) == int(9))
            {
                Velocity.Z = 0.0000000;                
            }
            else
            {
                // End:0x21C
                if(bIsWalking)
                {
                    Velocity.Z = JumpZSpeed;                    
                }
                else
                {
                    Velocity.Z = JumpZSpeed;
                }
            }
        }
        // End:0x303
        if(((Base != none) && !Base.bWorldGeometry) && Base.Velocity.Z > 0.0000000)
        {
            Velocity.Z += Base.Velocity.Z;
        }
        SetPhysics(2);
        // End:0x337
        if(bWasWalking && int(Physics) == int(2))
        {
            r_bIsJumping = true;
        }
        r_bJustJumped = true;
        // End:0x35C
        if(!r_bIsMounted)
        {
            FlashJumpEffects();
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function FlashJumpEffects()
{
    FlashPlaySpecialEffect(6);
    //return;    
}

simulated function float GetJumpHeightMultiplier()
{
    local float fHeightIncrease;

    fHeightIncrease = 1.0000000;
    // End:0x33
    if(r_bIsMounted)
    {
        fHeightIncrease += m_fHorseJumpHeightIncrease;        
    }
    else
    {
        fHeightIncrease *= (GetPropCurrentValue(11));
    }
    // End:0x6E
    if(AllowBoostedJump())
    {
        fHeightIncrease += (GetPropCurrentValue(4));
    }
    return fHeightIncrease;
    //return ReturnValue;    
}

simulated function float GetJumpSpeedMultiplier()
{
    return 1.0000000;
    //return ReturnValue;    
}

simulated function OnTeleport(SeqAct_Teleport Action)
{
    local Vector StartLocation;
    local TgPlayerController TgPC;

    StartLocation = Location;
    TgPC = TgPlayerController(Controller);
    // End:0x5F
    if(TgPC != none)
    {
        TgPC.SetNoSmoothedMovementCorrection(true, false);
    }
    super(Pawn).OnTeleport(Action);
    // End:0xAB
    if(Action.bResetVelocity)
    {
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    }
    ApplyTeleportEffects(StartLocation);
    //return;    
}

simulated event ApplyTeleportEffects(Vector StartLocation)
{
    local TgDevice_PortalMod modPortal;
    local int I;

    FlashPlaySpecialEffect(9, StartLocation);
    // End:0x118
    if(int(Role) == int(ROLE_Authority))
    {
        I = 0;
        J0x36:

        // End:0x118 [Loop If]
        if(I < 33)
        {
            // End:0x10A
            if((self.m_EquippedDevices[I] != none) && self.m_EquippedDevices[I].IsActive())
            {
                modPortal = TgDevice_PortalMod(self.m_EquippedDevices[I]);
                // End:0x10A
                if(modPortal != none)
                {
                    modPortal.ApplyEffect();
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}

reliable server function ServerSetVar(int varId)
{
    local Vector V;

    V = vect(10.0000000, 10.0000000, 10.0000000);
    V.X = float(varId);
    AddVelocity(V, vect(0.0000000, 0.0000000, 0.0000000), none);
    //return;    
}

exec function SetVar(int varId)
{
    ServerSetVar(varId);
    //return;    
}

simulated function BlendToAnimTreeDeviceType()
{
    // End:0x24
    if(TgDevice(Weapon) != none)
    {
        r_bIsAnimInStrafeMode = true;
    }
    //return;    
}

simulated function TgPawn FindLocalPlayerPawn()
{
    local PlayerController PC;

    PC = GetALocalPlayerController();
    // End:0x4B
    if(PC != none)
    {
        return TgPawn(PC.Pawn);
    }
    return none;
    //return ReturnValue;    
}

simulated exec event SetUsePhysicsWithAnimation(bool Enable)
{
    local RB_BodySetup RigidBodySetupIterator;
    local bool NeedsPhysicsAssetInstance;

    // End:0x11
    if(Mesh == none)
    {
        return;
    }
    Mesh.SetHasPhysicsAssetInstance(false);
    // End:0x94
    if(Mesh.PhysicsAssetInstance != none)
    {
        Mesh.PhysicsAssetInstance.SetFullAnimWeightBonesFixed(true, Mesh);
    }
    return;
    NeedsPhysicsAssetInstance = false;
    // End:0x2B1
    if(Mesh != none)
    {
        Mesh.bEnableFullAnimWeightBodies = Enable;
        // End:0x136
        if(Enable && Mesh.MinDistFactorForKinematicUpdate == 0.0000000)
        {
            Mesh.MinDistFactorForKinematicUpdate = 0.1400000;
        }
        // End:0x2B1
        if(Mesh.PhysicsAsset != none)
        {
            // End:0x1F2
            if(Mesh.PhysicsAssetInstance == none)
            {
                // End:0x1F1
                foreach Mesh.PhysicsAsset.BodySetup(RigidBodySetupIterator)
                {
                    // End:0x1F0
                    if(RigidBodySetupIterator.bAlwaysFullAnimWeight)
                    {
                        NeedsPhysicsAssetInstance = true;                        
                    }
                    else
                    {                        
                    }
                }                
            }
            // End:0x244
            if(NeedsPhysicsAssetInstance)
            {
                // End:0x244
                if(!Mesh.bHasPhysicsAssetInstance)
                {
                    Mesh.SetHasPhysicsAssetInstance(true);
                }
            }
            // End:0x2B1
            if(Mesh.PhysicsAssetInstance != none)
            {
                Mesh.PhysicsAssetInstance.SetFullAnimWeightBonesFixed(!Enable, Mesh);
            }
        }
    }
    //return;    
}

simulated event OnRigidBodySpringOverextension(RB_BodyInstance BodyInstance)
{
    super(Actor).OnRigidBodySpringOverextension(BodyInstance);
    //return;    
}

event ModifyPawnPropertiesVolumeChanged()
{
    local TgModifyPawnPropertiesVolume Vol;
    local bool bNewDisableAllDevices;

    bNewDisableAllDevices = false;
    s_vOneWayMovement = vect(0.0000000, 0.0000000, 0.0000000);
    // End:0xC1
    foreach TouchingActors(Class'TgGame.TgModifyPawnPropertiesVolume', Vol)
    {
        bNewDisableAllDevices = bNewDisableAllDevices || Vol.m_bDisableAllDevices;
        // End:0xC0
        if(Vol.m_bOneWayMovement)
        {
            s_vOneWayMovement = Vector(Vol.m_vOnewWay);
        }        
    }    
    //return;    
}

simulated function DisplayMessage(string sMessage)
{
    // End:0x5A
    if(Controller != none)
    {
        // End:0x5A
        if(TgPlayerController(Controller) != none)
        {
            TgPlayerController(Controller).ClientMessage(sMessage);
        }
    }
    //return;    
}

event bool ShouldRecharge()
{
    // End:0x21
    if(IsInState('Dying') || m_bStunEnergyRegen)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

simulated function TickFriendlyPush()
{
    local TgPawn buddy;
    local Vector Dir;
    local int I;

    I = 0;
    J0x0B:

    // End:0xD0 [Loop If]
    if(I < Touching.Length)
    {
        buddy = TgPawn(Touching[I]);
        // End:0xC2
        if(buddy != none)
        {
            Dir = Location - buddy.Location;
            Dir = Normal(Dir);
            AddVelocity(Dir, vect(0.0000000, 0.0000000, 0.0000000), none);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function DoubleCheckSimulatedProxy()
{
    local bool bWrong;

    bWrong = false;
    // End:0x33
    if(int(r_eDesiredInHand) != int(m_eEquippedInHand))
    {
        bWrong = true;
    }
    // End:0x70
    if((c_EquipForm[int(m_eEquippedInHand)] == none) && int(m_eEquippedInHand) != int(0))
    {
        bWrong = true;
    }
    // End:0x101
    if(c_EquipForm[int(m_eEquippedInHand)] != none)
    {
        // End:0x101
        if(c_EquipForm[int(m_eEquippedInHand)].c_EquipDeviceInfo.nDeviceInstanceId != r_EquipDeviceInfo[int(m_eEquippedInHand)].nDeviceInstanceId)
        {
            bWrong = true;
        }
    }
    // End:0x158
    if((c_EquipForm[int(m_eEquippedInHand)] == none) && r_EquipDeviceInfo[int(m_eEquippedInHand)].nDeviceInstanceId != 0)
    {
        bWrong = true;
    }
    // End:0x1AF
    if(bWrong == true)
    {
        // End:0x186
        if(c_EquipForm[int(m_eEquippedInHand)] != none)
        {            
        }
        DeviceFormChanged();
        // End:0x1AF
        if(c_EquipForm[int(m_eEquippedInHand)] != none)
        {            
        }
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local TgDevice Dev;
    local bool bShouldBeFirstPersonThisFrame;

    // End:0x12
    if(c_nTickCheckingState == 2)
    {
        return;
    }
    // End:0x2B
    if(m_bHitWallThisTick)
    {
        m_bHitWallThisTick = false;
    }
    super(Actor).Tick(DeltaSeconds);
    // End:0x65
    if(int(Role) == int(ROLE_Authority))
    {
        RegainPools(DeltaSeconds);
    }
    // End:0x8C
    if(int(m_eLocalGrabState) > int(0))
    {
        TickGrab(DeltaSeconds);
    }
    // End:0x143
    if((int(Role) == int(ROLE_Authority)) && int(r_eCurrentStunType) == int(7))
    {
        Dev = GetDeviceByEqPoint(1);
        // End:0x143
        if(((Dev != none) && Dev.m_bHandDevice) && !Dev.IsFiring())
        {
            Dev.StartFire();
        }
    }
    UpdateHealingBeamEffects();
    bShouldBeFirstPersonThisFrame = ShouldBeFirstPersonThisTick();
    // End:0x1A8
    if(bShouldBeFirstPersonThisFrame != m_bShouldBeFirstPersonLastFrame)
    {
        // End:0x19E
        if(bShouldBeFirstPersonThisFrame)
        {
            m_f1PTransitionFireDelayRemaining = m_f1PTransitionFireDelay;            
        }
        else
        {
            Invoke3pTransitionDelegates();
        }
    }
    m_bShouldBeFirstPersonLastFrame = bShouldBeFirstPersonThisFrame;
    // End:0x1E2
    if(m_f1PTransitionFireDelayRemaining > float(0))
    {
        m_f1PTransitionFireDelayRemaining -= DeltaSeconds;
    }
    TickScale(DeltaSeconds);
    // End:0x21D
    if(int(Role) != int(ROLE_Authority))
    {
        c_fServerTimeStamp += DeltaSeconds;
    }
    UpdateStealthMaterialBasedOnNearbyEnemies();
    // End:0x247
    if(m_bUsesRecoil)
    {
        UpdateRecoil(DeltaSeconds);
    }
    //return;    
}

simulated event UpdateRecoil(float DeltaTime)
{
    local Rotator m_rNewRecoil;

    // End:0x22
    if(!m_bUsesRecoil || Weapon == none)
    {
        return;
    }
    m_fSettleDelay -= DeltaTime;
    // End:0x11D
    if(m_fSettleDelay < float(0))
    {
        // End:0x10E
        if(m_rCurrentRecoil != MakeRotator(0, 0, 0))
        {
            m_rNewRecoil = RInterpTo(m_rCurrentRecoil, MakeRotator(0, 0, 0), -m_fSettleDelay + m_fRecoilSettleDeltaTimeOverflow, m_fSettleSpeed, true);
            // End:0xDA
            if(m_rNewRecoil == m_rCurrentRecoil)
            {
                m_fRecoilSettleDeltaTimeOverflow += DeltaTime;                
            }
            else
            {
                m_fRecoilSettleDeltaTimeOverflow = 0.0000000;
                m_rCurrentRecoil = m_rNewRecoil;
            }
            m_fSettleDelay = 0.0000000;            
        }
        else
        {
            m_fRecoilSettleDeltaTimeOverflow = 0.0000000;
        }
    }
    // End:0x1CB
    if(m_rSmoothedRecoil != m_rCurrentRecoil)
    {
        m_rNewRecoil = RInterpTo(m_rSmoothedRecoil, m_rCurrentRecoil, DeltaTime + m_fRecoilSmoothDeltaTimeOverflow, m_fRecoilSmoothRate);
        // End:0x1A6
        if(m_rNewRecoil == m_rSmoothedRecoil)
        {
            m_fRecoilSmoothDeltaTimeOverflow += DeltaTime;            
        }
        else
        {
            m_fRecoilSmoothDeltaTimeOverflow = 0.0000000;
            m_rSmoothedRecoil = m_rNewRecoil;
        }        
    }
    else
    {
        m_fRecoilSmoothDeltaTimeOverflow = 0.0000000;
    }
    //return;    
}

function AddRecoil(Rotator rNewRecoil, float fRecoilSmoothRate, float fSettleDelay, float fSettleSpeed)
{
    // End:0x11
    if(!m_bUsesRecoil)
    {
        return;
    }
    m_rCurrentRecoil = Normalize(m_rCurrentRecoil + rNewRecoil);
    m_fRecoilSmoothRate = fRecoilSmoothRate;
    m_fSettleDelay = fSettleDelay;
    m_fSettleSpeed = fSettleSpeed * 182.0444000;
    //return;    
}

simulated function float TickScaleVariable(float fDesiredValue, float fOldValue, float fScaleChangePerSecond, float DeltaSeconds)
{
    local float fNewValue;

    fNewValue = fOldValue;
    // End:0xE1
    if(fDesiredValue > 0.0000000)
    {
        // End:0xE1
        if(fOldValue != fDesiredValue)
        {
            // End:0x5F
            if(fScaleChangePerSecond < 0.0000000)
            {
                fScaleChangePerSecond = 1.0000000;
            }
            // End:0xAD
            if(fOldValue > fDesiredValue)
            {
                fNewValue = FMax(fOldValue - (fScaleChangePerSecond * DeltaSeconds), fDesiredValue);                
            }
            else
            {
                fNewValue = FMin(fOldValue + (fScaleChangePerSecond * DeltaSeconds), fDesiredValue);
            }
        }
    }
    return fNewValue;
    //return ReturnValue;    
}

simulated function TickScale(float DeltaSeconds)
{
    local float fNewScale, fOldScaleCollisionHeight, fOldScaleCollisionRadius, fCurrentScaleCollisionHeightDifference, fCurrentScaleCollisionRadiusDifference;

    // End:0xC5
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        fNewScale = GetPropCurrentValue(118);
        // End:0xC5
        if(fNewScale != m_fScaleMesh)
        {
            m_fScaleMesh = TickScaleVariable(fNewScale, m_fScaleMesh, m_fScaleMeshChangePerSecond, DeltaSeconds);
            // End:0xC5
            if(Mesh != none)
            {
                Mesh.SetScale(m_fScaleMesh);
            }
        }
    }
    fNewScale = GetPropCurrentValue(119);
    fOldScaleCollisionHeight = m_fScaleCollisionHeight;
    // End:0x13D
    if(fNewScale != m_fScaleCollisionHeight)
    {
        m_fScaleCollisionHeight = TickScaleVariable(fNewScale, m_fScaleCollisionHeight, m_fScaleCollisionHeightChangePerSecond, DeltaSeconds);
    }
    fNewScale = GetPropCurrentValue(120);
    fOldScaleCollisionRadius = m_fScaleCollisionRadius;
    // End:0x1B5
    if(fNewScale != m_fScaleCollisionRadius)
    {
        m_fScaleCollisionRadius = TickScaleVariable(fNewScale, m_fScaleCollisionRadius, m_fScaleCollisionRadiusChangePerSecond, DeltaSeconds);
    }
    fCurrentScaleCollisionHeightDifference = 1.0000000;
    fCurrentScaleCollisionRadiusDifference = 1.0000000;
    // End:0x204
    if(fOldScaleCollisionHeight > 0.0000000)
    {
        fCurrentScaleCollisionHeightDifference = m_fScaleCollisionHeight / fOldScaleCollisionHeight;
    }
    // End:0x235
    if(fOldScaleCollisionRadius > 0.0000000)
    {
        fCurrentScaleCollisionRadiusDifference = m_fScaleCollisionRadius / fOldScaleCollisionRadius;
    }
    // End:0x2CE
    if((fCurrentScaleCollisionHeightDifference != 1.0000000) || fCurrentScaleCollisionRadiusDifference != 1.0000000)
    {
        CylinderComponent.SetCylinderSize(CylinderComponent.CollisionRadius * fCurrentScaleCollisionRadiusDifference, CylinderComponent.CollisionHeight * fCurrentScaleCollisionHeightDifference);
    }
    //return;    
}

simulated function UpdateBob(float DeltaSeconds)
{
    local Vector X, Y, Z;
    local float Speed2D, Alpha, OldBobTime;
    local TgPlayerController TgPC;
    local TgPlayerCamera PlayerCamera;
    local TgCameraModule_ThirdPerson CamMod;
    local int M, N;

    Alpha = 1.0000000;
    TgPC = TgPlayerController(Controller);
    // End:0x133
    if(TgPC != none)
    {
        PlayerCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0x133
        if(PlayerCamera != none)
        {
            CamMod = TgCameraModule_ThirdPerson(PlayerCamera.CurrentCameraMod);
            // End:0x133
            if((CamMod != none) && CamMod.fZoomMax > 0.0000000)
            {
                Alpha = 1.0000000 - (CamMod.fZoomFactorInterp / CamMod.fZoomMax);
            }
        }
    }
    OldBobTime = BobTime;
    // End:0x414
    if(int(Physics) == int(1))
    {
        GetAxes(Controller.Rotation, X, Y, Z);
        Speed2D = VSize(Velocity);
        // End:0x1ED
        if((Speed2D < float(10)) || GroundSpeed < float(1))
        {
            BobTime += (0.2000000 * DeltaSeconds);            
        }
        else
        {
            BobTime += (DeltaSeconds * (0.3000000 + ((0.7000000 * Speed2D) / GroundSpeed)));
        }
        WalkBob = ((vect(0.0000000, 1.0000000, 0.0000000) * Bob) * Speed2D) * Sin(8.0000000 * BobTime);
        AppliedBob = AppliedBob * (float(1) - FMin(1.0000000, 16.0000000 * DeltaSeconds));
        WalkBob.Z = AppliedBob;
        // End:0x33A
        if(Speed2D > 10.0000000)
        {
            WalkBob.Z = WalkBob.Z + (((0.7500000 * Bob) * Speed2D) * Sin(16.0000000 * BobTime));
        }
        WalkBob *= Alpha;
        // End:0x414
        if(((int(Physics) == int(1)) && IsFirstPerson()) && Speed2D > 10.0000000)
        {
            M = int((0.5000000 * 3.1415930) + ((m_BobFootstepFactor * OldBobTime) / 3.1415930));
            N = int((0.5000000 * 3.1415930) + ((m_BobFootstepFactor * BobTime) / 3.1415930));
            // End:0x414
            if(M != N)
            {
                PlayFootStepSound(0, 0);
            }
        }
    }
    //return;    
}

simulated event TickTargeting(float DeltaSeconds)
{
    local bool bTickedTargeting, bDead, bCinematic;
    local TgPlayerController TgPC;
    local TgClientSettings Settings;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x48
    if(WorldInfo.IsPlayingDemo() || WorldInfo.IsPlayingTimelapse())
    {
        return;
    }
    bTickedTargeting = false;
    bDead = IsInState('Dying');
    bCinematic = IsCinematicMode();
    TgPC = TgPlayerController(Controller);
    // End:0x2F6
    if(TgPC != none)
    {
        // End:0x160
        if((c_CurrentStartActionDevice == none) || int(c_CurrentStartActionDevice.r_eEquippedAt) == int(0))
        {
            c_CurrentStartActionDevice = none;
            // End:0x15D
            if(((c_CurrentTargetingDevice != none) && TgPC.bPressingLeftMouseButton) && c_CurrentTargetingDevice.CanFireIfLeftMouseDown())
            {
                StartAction(c_CurrentTargetingDevice);
            }            
        }
        else
        {
            // End:0x2F6
            if((c_CurrentStartActionDevice != none) && !c_CurrentStartActionDevice.IsFiring())
            {
                Settings = TgPC.GetClientSettings();
                // End:0x2F6
                if(((Settings != none) && int(Settings.GetCastMode(r_nProfileId, c_CurrentStartActionDevice.r_eEquippedAt)) != int(0)) && Settings.bUseCastQueueing)
                {
                    StartAction(c_CurrentStartActionDevice,, false);
                    // End:0x2F6
                    if((Settings.CastQueueTime > float(0)) && (c_fShouldStartActionTimeStamp + Settings.CastQueueTime) <= WorldInfo.TimeSeconds)
                    {
                        SetTargetingDevice(GetDeviceByEqPoint(1), SwapStrategy);
                        c_CurrentStartActionDevice = none;
                    }
                }
            }
        }
    }
    // End:0x3E1
    if((c_CurrentTargetingDevice != none) && !c_CurrentTargetingDevice.m_bHandDevice)
    {
        // End:0x38B
        if(bDead || bCinematic)
        {
            // End:0x388
            if(c_CurrentTargetingDevice.IsInTargetingMode())
            {
                c_CurrentTargetingDevice.ExitTargetingMode();
            }            
        }
        else
        {
            // End:0x3E1
            if(c_CurrentTargetingDevice.UsesTargetingMode())
            {
                c_CurrentTargetingDevice.TickTargetingMode(DeltaSeconds);
                bTickedTargeting = true;
            }
        }
    }
    // End:0x420
    if(!bTickedTargeting && TgPC != none)
    {
        TgPC.ClearTargetingList();
    }
    //return;    
}

simulated event bool IsTargetWithInCone(Actor Target)
{
    local Vector vTargetDir, vPawnFacingDir;
    local bool bTargetInFrontOfMe;
    local float fOrientation, fAngle;

    vPawnFacingDir = Vector(Rotation);
    vTargetDir = Normal(Target.Location - Location);
    bTargetInFrontOfMe = (((vPawnFacingDir Dot vTargetDir) > float(0)) ? true : false);
    // End:0xE3
    if(bTargetInFrontOfMe)
    {
        fOrientation = vPawnFacingDir Dot vTargetDir;
        fAngle = Acos(fOrientation);
        fAngle *= (float(180) / 3.1415930);
        return fAngle <= float(45);
    }
    return false;
    //return ReturnValue;    
}

// Export UTgPawn::execIsTalentEquipped(FFrame&, void* const)
native function bool IsTalentEquipped(int nTalentDeviceId);

// Export UTgPawn::execWasPlayerSpawned(FFrame&, void* const)
native function bool WasPlayerSpawned();

// Export UTgPawn::execGetCurrentOwnerPawn(FFrame&, void* const)
native function TgPawn GetCurrentOwnerPawn();

// Export UTgPawn::execTeleportTraceCheck(FFrame&, void* const)
native function bool TeleportTraceCheck(Vector vTestLoc, Vector vDestLoc);

// Export UTgPawn::execIsAboveNonbaseableSurface(FFrame&, void* const)
native function bool IsAboveNonbaseableSurface(Vector vTestLoc, float fTestDist, out Actor HitActor, out Vector HitNormal);

simulated event bool Teleport(Vector vDest, Rotator rDest, bool bPlayFx, optional int TeleportEnterState, optional int TeleportExitState, optional bool bFailOnNoSafeSpot, optional out Vector vTeleportLocation, optional bool bFakeTeleport = false)
{
    local Vector Extent, Loc, NewLocation;
    local Rotator NewRotation;
    local TgPlayerController TgPC;
    local Actor NonBaseableHitActor;
    local Vector NonBaseableHitNormal;
    local bool bFoundSafeSpot;

    Extent.X = GetCollisionRadius();
    Extent.Y = Extent.X;
    Extent.Z = GetCollisionHeight();
    Loc = vDest;
    NewLocation = vDest;
    // End:0x118
    if(FindSpot(Extent, Loc) && TeleportTraceCheck(Loc, vDest))
    {
        NewLocation = Loc;
        bFoundSafeSpot = true;        
    }
    else
    {
        bFoundSafeSpot = false;
        // End:0x13C
        if(bFailOnNoSafeSpot)
        {
            return bFoundSafeSpot;
        }
    }
    // End:0x19D
    if(!bFakeTeleport)
    {
        PreTeleport(none);
        PlayTeleportEffect(false, true);
        // End:0x19D
        if(bPlayFx)
        {
            FlashTeleportFx(((TeleportEnterState == 0) ? 1 : TeleportEnterState), Location);
        }
    }
    vTeleportLocation = NewLocation;
    // End:0x2D6
    if(!bFakeTeleport && SetLocation(NewLocation))
    {
        NewRotation = rDest;
        NewRotation.Pitch = 0;
        NewRotation.Roll = 0;
        SetRotation(NewRotation);
        // End:0x2D3
        if(Controller != none)
        {
            TgPC = TgPlayerController(Controller);
            // End:0x286
            if(TgPC != none)
            {
                TgPC.SetNoSmoothedMovementCorrection(true, false);
            }
            // End:0x2D3
            if(IsAboveNonbaseableSurface(NewLocation + vect(0.0000000, 0.0000000, 30.0000000), 2.0000000 * (NativeGetCollisionHeight()), NonBaseableHitActor, NonBaseableHitNormal))
            {
                SetPhysics(2);
            }
        }        
    }
    else
    {
        // End:0x2F7
        if(bFakeTeleport && bFoundSafeSpot)
        {
            return true;            
        }
        else
        {
            // End:0x306
            if(!bFakeTeleport)
            {
            }
            bFoundSafeSpot = false;
            // End:0x32A
            if(bFailOnNoSafeSpot)
            {
                return bFoundSafeSpot;
            }
        }
    }
    // End:0x38C
    if(!bFakeTeleport)
    {
        PostTeleport(none);
        PlayTeleportEffect(true, true);
        // End:0x38C
        if(bPlayFx)
        {
            FlashTeleportFx(((TeleportExitState == 0) ? 2 : TeleportExitState), Location);
        }
    }
    return bFoundSafeSpot;
    //return ReturnValue;    
}

simulated function bool CanApplyAimAssist(TgPlayerController LocalPlayerController, TgPawn LocalPawn)
{
    local bool bCanApplyAimAssist, bInSameVolume;
    local TgRepInfo_Player TgRepInfo_Player;

    bInSameVolume = false;
    bCanApplyAimAssist = true;
    TgRepInfo_Player = GetPRI();
    bCanApplyAimAssist = (TgRepInfo_Player != none) && IsAliveAndWell();
    // End:0xC0
    if((bCanApplyAimAssist && (NumVisibilityVolumesTouching()) > 0) && r_bIsVolumeStealthed)
    {
        bInSameVolume = LocalPawn.IsInSameVisibilityVolume(self);
        bCanApplyAimAssist = bInSameVolume;
    }
    // End:0x177
    if(bCanApplyAimAssist)
    {
        // End:0xF0
        if(int(r_eIsStealthed) == int(1))
        {
            bCanApplyAimAssist = true;            
        }
        else
        {
            // End:0x16B
            if(!TgRepInfo_Player.IsStealthedClient() || (!TgRepInfo_Player.IsHardStealthedClient() && bInSameVolume) && c_fCurrentFadeValue < float(1))
            {
                bCanApplyAimAssist = true;                
            }
            else
            {
                bCanApplyAimAssist = false;
            }
        }
    }
    return bCanApplyAimAssist;
    //return ReturnValue;    
}

simulated event Stun(bool bStunController, optional Controller.EStunType eType)
{
    local TgDevice Dev;
    local int I;
    local Controller.EStunType OldStunType;

    OldStunType = r_eCurrentStunType;
    r_eCurrentStunType = eType;
    // End:0x123
    if((int(r_eCurrentStunType) != int(0)) && int(r_eCurrentStunType) != int(5))
    {
        EndPhysTween(false);
        Dev = none;
        I = 0;
        J0x72:

        // End:0x123 [Loop If]
        if(I < 33)
        {
            Dev = GetDeviceByEqPoint(I);
            // End:0x115
            if(((Dev != none) && Dev.CanBeStunned()) && Dev.CanBeInterrupted())
            {
                Dev.InterruptFiring();
            }
            I++;
            // [Loop Continue]
            goto J0x72;
        }
    }
    // End:0x164
    if(Controller != none)
    {
        Controller.Stun(bStunController, eType);
    }
    // End:0x1E2
    if(int(r_eCurrentStunType) == int(7))
    {
        Dev = GetDeviceByEqPoint(1);
        // End:0x1DF
        if((Dev != none) && Dev.m_bHandDevice)
        {
            Dev.StartFire();
        }        
    }
    else
    {
        // End:0x25D
        if(int(OldStunType) == int(7))
        {
            Dev = GetDeviceByEqPoint(1);
            // End:0x25D
            if((Dev != none) && Dev.m_bHandDevice)
            {
                Dev.StopFire();
            }
        }
    }
    // End:0x290
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        ClientSetStun();
    }
    //return;    
}

event UpdateCooldownsOnDevices()
{
    local int I;

    // End:0x90
    if((int(Role) == int(ROLE_Authority)) && InvManager != none)
    {
        I = 1;
        J0x30:

        // End:0x90 [Loop If]
        if(I < 33)
        {
            // End:0x82
            if(m_EquippedDevices[I] != none)
            {
                m_EquippedDevices[I].CheckAndUpdateCooldown();
            }
            I++;
            // [Loop Continue]
            goto J0x30;
        }
    }
    //return;    
}

event SaveDeathInfoForZoomCam(TgPawn KillerOwner, TgPawn Killer, int DeviceID, bool bPetKill)
{
    local TgPlayerController PC;
    local TgRepInfo_Player KillerPRI, OwnerPRI;
    local int nKillerHealthPct;
    local float killerMaxHealth;

    PC = TgPlayerController(Controller);
    // End:0x1A9
    if(PC != none)
    {
        // End:0xA6
        if((Killer != none) && Killer.r_Owner != none)
        {
            OwnerPRI = TgRepInfo_Player(Killer.r_Owner.PlayerReplicationInfo);
        }
        // End:0xDE
        if(Killer != none)
        {
            KillerPRI = Killer.GetPRI();
        }
        // End:0x163
        if((Killer != none) && KillerPRI != none)
        {
            killerMaxHealth = Killer.GetMaxHealth();
            nKillerHealthPct = (100 * Killer.Health) / int(killerMaxHealth);            
        }
        else
        {
            nKillerHealthPct = -1;
        }
        SetDeathZoomInfo(Killer, KillerPRI, nKillerHealthPct, DeviceID, OwnerPRI);
    }
    return;
    //return;    
}

simulated function bool IsValidMeleeTarget(TgPawn ProspectiveMeleeTarget)
{
    local bool bIsValidTarget;

    bIsValidTarget = true;
    // End:0x2A
    if(ProspectiveMeleeTarget == none)
    {
        bIsValidTarget = false;        
    }
    else
    {
        // End:0x54
        if(!IsEnemy(ProspectiveMeleeTarget) == true)
        {
            bIsValidTarget = false;            
        }
        else
        {
            // End:0x73
            if(IsInState('Dying'))
            {
                bIsValidTarget = false;                
            }
            else
            {
                // End:0xD6
                if((int(Controller.m_eCurrentStunType) != int(0)) || int(Controller.m_eCurrentStunType) != int(0))
                {
                    bIsValidTarget = false;                    
                }
                else
                {
                    // End:0x12E
                    if(ProspectiveMeleeTarget.IsInState('Dying') || ProspectiveMeleeTarget.IsInState('KnockedDown'))
                    {
                        bIsValidTarget = false;
                    }
                }
            }
        }
    }
    return bIsValidTarget;
    //return ReturnValue;    
}

simulated function bool CanPickupDroppedItem()
{
    // End:0x12
    if(IsInState('Dying'))
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

event BaseChange()
{
    local SpeedTreeActor SpeedTree;

    super(Pawn).BaseChange();
    SpeedTree = SpeedTreeActor(Base);
    // End:0x3F
    if(SpeedTree != none)
    {
        JumpOffPawn();
    }
    //return;    
}

simulated event OnPhaseEnded(int nPhaseThatEnded)
{
    //return;    
}

simulated event OnPhaseChange()
{
    ClearTimer('OnPhaseTransitionComplete');
    SetTimer(m_fPhaseChangeTime, false, 'OnPhaseTransitionComplete');
    FxDeactivateGroupSelf('Phase', -1);
    FxActivateGroupSelf('Phase', r_nPhase);
    //return;    
}

simulated function OnPhaseTransitionComplete()
{
    //return;    
}

exec function Perf2(bool bEnabled)
{
    local TgPawn P;

    // End:0x7D
    foreach AllActors(Class'TgGame.TgPawn', P)
    {
        // End:0x7C
        if(P.Mesh != none)
        {
            P.Mesh.bUpdateSkelWhenNotRendered = bEnabled;
        }        
    }    
    //return;    
}

exec function ChangePhase(int NewPhase)
{
    SetPhase(NewPhase);
    ServerChangePhase(NewPhase);
    //return;    
}

reliable server function ServerChangePhase(int NewPhase)
{
    SetPhase(NewPhase);
    //return;    
}

event AddToTeleportNotify(Actor ToBeNotified)
{
    // End:0x2A
    if(int(Role) == int(ROLE_Authority))
    {
        m_TeleportNotifyList.AddItem(ToBeNotified);
    }
    //return;    
}

event RemoveFromTeleportNotify(Actor RemoveActor)
{
    // End:0x2A
    if(int(Role) == int(ROLE_Authority))
    {
        m_TeleportNotifyList.RemoveItem(RemoveActor);
    }
    //return;    
}

final event TeleportNotify()
{
    local int I;
    local TgPawn NotifyPawn;
    local TgDevice NotifyDevice;

    I = m_TeleportNotifyList.Length - 1;
    J0x17:

    // End:0xE1 [Loop If]
    if(I >= 0)
    {
        NotifyPawn = TgPawn(m_TeleportNotifyList[I]);
        NotifyDevice = TgDevice(m_TeleportNotifyList[I]);
        // End:0xA4
        if(NotifyPawn != none)
        {
            NotifyPawn.OnTeleportNotify(self);            
        }
        else
        {
            // End:0xD3
            if(NotifyDevice != none)
            {
                NotifyDevice.OnTeleportNotify(self);
            }
        }
        I--;
        // [Loop Continue]
        goto J0x17;
    }
    //return;    
}

function OnTeleportNotify(Actor TeleportingActor)
{
    //return;    
}

function bool PreTeleport(Teleporter InTeleporter)
{
    local bool bFail;

    bFail = super(Actor).PreTeleport(InTeleporter);
    // End:0x77
    if(!bFail)
    {
        // End:0x62
        if(int(Role) == int(ROLE_Authority))
        {
            EndPhysTween(true);
            EndPhysGrab(true);
            EndPhysCharge(true);
        }
        ForceAllGrabTargetsDetach();
        TeleportNotify();
    }
    // End:0xAA
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        HaltFXForTeleport();
    }
    return bFail;
    //return ReturnValue;    
}

simulated function HaltFXForTeleport()
{
    local editinline TgParticleSystemComponent PSC;

    // End:0x12F
    if(Mesh != none)
    {
        // End:0x12E
        foreach Mesh.AttachedComponents(Class'TgGame.TgParticleSystemComponent', PSC)
        {
            // End:0x12D
            if((PSC != none) && PSC.Template != none)
            {
                switch(PSC.Template.Name)
                {
                    // End:0x12A
                    case 'FX_Gen_Stat_Zombie_Loop_3P':
                        // End:0x127
                        if(!PSC.bWasDeactivated)
                        {
                            PSC.m_bReenableAfterTeleport = true;
                            PSC.SetActive(false);
                        }
                        // End:0x12D
                        break;
                    // End:0xFFFF
                    default:
                        break;
                }
            }
            else
            {                
            }/* !MISMATCHING REMOVE, tried ForEach got Type:Else Position:0x12D! */            
        }/* !MISMATCHING REMOVE, tried If got Type:ForEach Position:0x00F! */
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:If Position:0x000! */
}

simulated function ResumeFXFromTeleport()
{
    local editinline TgParticleSystemComponent PSC;

    // End:0x12D
    if(Mesh != none)
    {
        // End:0x12C
        foreach Mesh.AttachedComponents(Class'TgGame.TgParticleSystemComponent', PSC)
        {
            // End:0x12B
            if((PSC != none) && PSC.Template != none)
            {
                switch(PSC.Template.Name)
                {
                    // End:0x128
                    case 'FX_Gen_Stat_Zombie_Loop_3P':
                        // End:0x125
                        if(PSC.m_bReenableAfterTeleport)
                        {
                            PSC.SetActive(true);
                            PSC.m_bReenableAfterTeleport = false;
                        }
                        // End:0x12B
                        break;
                    // End:0xFFFF
                    default:
                        break;
                }
            }
            else
            {                
            }/* !MISMATCHING REMOVE, tried ForEach got Type:Else Position:0x12B! */            
        }/* !MISMATCHING REMOVE, tried If got Type:ForEach Position:0x00F! */
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:If Position:0x000! */
}

simulated function PostTeleport(Teleporter OutTeleporter)
{
    super(Actor).PostTeleport(OutTeleporter);
    r_nBigTeleportCount++;
    PostBigTeleport();
    // End:0x5B
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        ResumeFXFromTeleport();
    }
    //return;    
}

simulated function PostBigTeleport()
{
    HaltFXForTeleport();
    ForceUpdateComponents();
    // End:0x46
    if(Mesh != none)
    {
        Mesh.UpdateRBBonesFromSpaceBases(true, true);
    }
    ResumeFXFromTeleport();
    //return;    
}

// Export UTgPawn::execGetPerCharacterAltEquipPoint(FFrame&, void* const)
native simulated function TgObject.TG_EQUIP_POINT GetPerCharacterAltEquipPoint();

// Export UTgPawn::execGetBotId(FFrame&, void* const)
native function int GetBotId();

// Export UTgPawn::execGetBotName(FFrame&, void* const)
native function string GetBotName();

// Export UTgPawn::execGetEmoteSoundCue(FFrame&, void* const)
native final function SoundCue GetEmoteSoundCue(int BotId, TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execGetEmoteAkEvent(FFrame&, void* const)
native final function AkEvent GetEmoteAkEvent(int BotId, TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execGetVoxKillAkEvent(FFrame&, void* const)
native final function AkEvent GetVoxKillAkEvent(int BotId, TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execGetEmoteSuffix(FFrame&, void* const)
native static final function string GetEmoteSuffix(TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execGetEmoteCustomSuffix(FFrame&, void* const)
native function string GetEmoteCustomSuffix(TgPawn.EEmote Emote, int ExtraInfo);

// Export UTgPawn::execGetVGSCustomSuffix(FFrame&, void* const)
native function string GetVGSCustomSuffix();

function TgPawn.EEmote GetDeviceEmoteType(TgDevice Dev)
{
    // End:0x62
    if(Dev != none)
    {
        switch(Dev.r_eEquippedAt)
        {
            // End:0x3F
            case 2:
                return 16;
            // End:0x47
            case 3:
                return 14;
            // End:0x4F
            case 4:
                return 15;
            // End:0x57
            case 16:
                return 13;
            // End:0x5F
            case 23:
                return 17;
            // End:0xFFFF
            default:
                break;
            }
    }
    else
    {
        return 0;
        //return ReturnValue;        
    }
}

event PlayDeviceEmoteAll(TgDevice Dev, optional bool bCallOnOwner = false)
{
    local TgPawn.EEmote DeviceEmote;

    // End:0x125
    if(((Dev != none) && PlayerReplicationInfo != none) && !PlayerReplicationInfo.IsBot())
    {
        DeviceEmote = GetDeviceEmoteType(Dev);
        // End:0x125
        if(int(DeviceEmote) != int(0))
        {
            // End:0xC8
            if(int(Role) == int(ROLE_Authority))
            {
                // End:0xB4
                if(bCallOnOwner)
                {
                    FlashPlayEmote(DeviceEmote, 0);                    
                }
                else
                {
                    FlashPlayEmoteExcludeOwner(DeviceEmote, 0);
                }
            }
            // End:0x125
            if((!bCallOnOwner && int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && IsLocallyControlled())
            {
                ClientPlayEmote(DeviceEmote);
            }
        }
    }
    //return;    
}

event PlayEmote(TgPawn.EEmote Emote, optional int nExtraInfo)
{
    // End:0x54
    if(((!IsAliveAndWell() && int(Emote) != int(7)) && int(Emote) != int(8)) && int(Emote) != int(9))
    {
        return;
    }
    FlashPlayEmote(Emote, nExtraInfo);
    //return;    
}

unreliable server function ServerPlayEmote(TgPawn.EEmote Emote, optional int nExtraInfo)
{
    PlayEmote(Emote, nExtraInfo);
    //return;    
}

exec event PlayEmoteAtWorldLocation(TgPawn.EEmote Emote, optional int nExtraInfo)
{
    ServerPlayEmote(Emote, nExtraInfo);
    //return;    
}

unreliable client simulated event PlayEmoteSelfOnly(TgPawn.EEmote Emote, optional int nExtraInfo)
{
    // End:0x3A
    if(IsLocallyControlled() && IsHumanControlled())
    {
        ClientPlayEmote(Emote, nExtraInfo);
    }
    //return;    
}

simulated event ClientPlayEmote(TgPawn.EEmote Emote, optional int nExtraInfo)
{
    local TgAnimNodeEmoteSwitch AnimNodeIterator;
    local TgAnimBlendByEmote EmoteBlendIterator;
    local bool bEmoteSuccessful;
    local AkEvent EmoteAkEvent, VoxKillAkEvent;
    local SoundCue EmoteSoundCue;

    // End:0x413
    if((((!IsEmoteOnInternalCooldown(Emote) && !RespectsEmoteGlobalCooldown(Emote) || !AreEmotesOnGlobalCooldown()) && !RespectsEmoteGlobalCooldown(Emote) || !IsEmoteOnNonLocalCooldown(Emote)) && !WorldInfo.IsPlayingTimelapse() || CanEmoteDuringTimelapse(Emote)) && EmoteDiceRoll(Emote))
    {
        // End:0x413
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            // End:0x124
            if(int(Emote) == int(7))
            {
                // End:0x124
                if(AreEmotesOnGlobalCooldown())
                {
                    Emote = 8;
                }
            }
            EmoteAkEvent = GetEmoteAkEvent(GetBotId(), Emote, nExtraInfo);
            // End:0x1E4
            if(EmoteShouldKillAllOtherVox(Emote))
            {
                VoxKillAkEvent = GetVoxKillAkEvent(GetBotId(), Emote, nExtraInfo);
                PostAkEvent(VoxKillAkEvent);
                // End:0x1E4
                if(m_AkActorUnoccluded != none)
                {
                    m_AkActorUnoccluded.PostAkEvent(VoxKillAkEvent);
                }
            }
            // End:0x212
            if(EmoteAkEvent != none)
            {
                PostEmoteAkEvent(EmoteAkEvent, Emote);                
            }
            else
            {
                EmoteSoundCue = GetEmoteSoundCue(GetBotId(), Emote, nExtraInfo);
                // End:0x2B6
                if(EmoteSoundCue != none)
                {
                    // End:0x29E
                    if(IsLocallyControlled() && IsHumanControlled())
                    {
                        Controller.PlaySound(EmoteSoundCue);                        
                    }
                    else
                    {
                        PlaySound(EmoteSoundCue);
                    }
                }
            }
            // End:0x2F6
            foreach m_AnimNodeEmoteSwitches(AnimNodeIterator)
            {
                AnimNodeIterator.PlayEmote(Emote);                
            }            
            // End:0x358
            foreach m_EmoteBlendNodes(EmoteBlendIterator)
            {
                bEmoteSuccessful = (EmoteBlendIterator.PlayEmote(Emote) > 0.0000000) || bEmoteSuccessful;                
            }            
            // End:0x3AF
            if(!bEmoteSuccessful)
            {
                // End:0x3A0
                foreach m_EmoteBlendNodes(EmoteBlendIterator)
                {
                    EmoteBlendIterator.CancelEmote(true);                    
                }                
                SetEmote3PCamera(false);                
            }
            else
            {
                // End:0x3D0
                if(EmoteShouldForce3P(Emote))
                {
                    SetEmote3PCamera(true);
                }
            }
            PlayEmoteSilhouetteEffect(Emote, nExtraInfo);
            RecordInternalEmoteTime(Emote);
            RecordGlobalEmoteTime();
            RecordNonLocalEmoteTime();
        }
    }
    //return;    
}

simulated event PlayEmoteSilhouetteEffect(TgPawn.EEmote Emote, optional int nExtraInfo)
{
    //return;    
}

simulated event bool CanEmoteDuringTimelapse(TgPawn.EEmote Emote)
{
    local TgPlayerController PC;
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0x3A
        case 8:
            return true;
            // End:0x40
            break;
        // End:0xFFFF
        default:
            // End:0x40
            break;
            break;
    }
    PC = TgPlayerController(GetALocalPlayerController());
    // End:0xC0
    if(PC != none)
    {
        // End:0x9A
        if(PC.m_nKillCamTargetId == r_nPawnId)
        {
            return true;
        }
        // End:0xC0
        if(PC.Pawn == self)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event TgPawn.EEmoteCategory GetEmoteCategory(TgPawn.EEmote Emote)
{
    switch(Emote)
    {
        // End:0x1E
        case 38:
            return 2;
            // End:0x14D
            break;
        // End:0x23
        case 1:
        // End:0x28
        case 2:
        // End:0x33
        case 3:
            return 1;
            // End:0x14D
            break;
        // End:0x38
        case 44:
        // End:0x43
        case 34:
            return 3;
            // End:0x14D
            break;
        // End:0x48
        case 11:
        // End:0x4D
        case 12:
        // End:0x52
        case 13:
        // End:0x57
        case 14:
        // End:0x5C
        case 15:
        // End:0x61
        case 17:
        // End:0x66
        case 26:
        // End:0x6B
        case 27:
        // End:0x70
        case 28:
        // End:0x7B
        case 30:
            return 6;
            // End:0x14D
            break;
        // End:0x80
        case 5:
        // End:0x85
        case 10:
        // End:0x8A
        case 21:
        // End:0x8F
        case 22:
        // End:0x94
        case 23:
        // End:0x99
        case 29:
        // End:0xA4
        case 33:
            return 4;
            // End:0x14D
            break;
        // End:0xA9
        case 20:
        // End:0xAE
        case 31:
        // End:0xB9
        case 32:
            return 5;
            // End:0x14D
            break;
        // End:0xBE
        case 18:
        // End:0xC3
        case 19:
        // End:0xC8
        case 35:
        // End:0xCD
        case 36:
        // End:0xD2
        case 4:
        // End:0xD7
        case 48:
        // End:0xDC
        case 47:
        // End:0xE1
        case 46:
        // End:0xEC
        case 37:
            return 7;
            // End:0x14D
            break;
        // End:0xF7
        case 16:
            return 8;
            // End:0x14D
            break;
        // End:0xFC
        case 6:
        // End:0x101
        case 7:
        // End:0x106
        case 8:
        // End:0x10B
        case 9:
        // End:0x110
        case 24:
        // End:0x11B
        case 25:
            return 9;
            // End:0x14D
            break;
        // End:0x126
        case 45:
            return 10;
            // End:0x14D
            break;
        // End:0x12B
        case 0:
        // End:0x130
        case 39:
        // End:0x135
        case 40:
        // End:0x13A
        case 41:
        // End:0x13F
        case 42:
        // End:0x144
        case 43:
        // End:0xFFFF
        default:
            return 0;
            break;
    }    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x14D
    //return ReturnValue;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x14D    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x14D
    // Failed to format remaining nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x14D
}

simulated event int GetEmotePriority(TgPawn.EEmote Emote)
{
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0x35
        case 1:
        // End:0x3F
        case 2:
            return 0;
            // End:0x83
            break;
        // End:0x44
        case 3:
        // End:0x49
        case 4:
        // End:0x4E
        case 5:
        // End:0x53
        case 6:
        // End:0x5D
        case 7:
            return 1;
            // End:0x83
            break;
        // End:0x62
        case 8:
        // End:0x6D
        case 9:
            return 2;
            // End:0x83
            break;
        // End:0x72
        case 10:
        // End:0x77
        case 0:
        // End:0xFFFF
        default:
            return -1;
            break;
    }    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x083
    //return ReturnValue;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x083    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x083
    // Failed to format remaining nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x083
}

simulated event float GetAbilityEmoteChance(TgPawn.EEmote Emote)
{
    switch(Emote)
    {
        // End:0x38
        case 13:
            return m_EmoteChancesAbility.fAbility1;
            // End:0xAA
            break;
        // End:0x5D
        case 14:
            return m_EmoteChancesAbility.fAbility2;
            // End:0xAA
            break;
        // End:0x82
        case 15:
            return m_EmoteChancesAbility.fAbility3;
            // End:0xAA
            break;
        // End:0xA7
        case 17:
            return m_EmoteChancesAbility.fMount;
            // End:0xAA
            break;
        // End:0xFFFF
        default:
            break;
    }
    return m_EmoteChancesAbility.fDefault;
    //return ReturnValue;    
}

simulated event float GetEmoteChance(TgPawn.EEmote Emote)
{
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0x55
        case 1:
            return m_EmoteChances.fPlayerVGS;
            // End:0x22C
            break;
        // End:0x7A
        case 2:
            return m_EmoteChances.fAbilityOnCooldown;
            // End:0x22C
            break;
        // End:0x9F
        case 3:
            return m_EmoteChances.fTakingDamage;
            // End:0x22C
            break;
        // End:0xE1
        case 4:
            // End:0xC1
            if(int(Emote) == int(29))
            {
                return 0.3300000;
                // [Explicit Continue]
                goto J0x22C;
            }
            return m_EmoteChances.fCelebration;
            // End:0x22C
            break;
        // End:0x106
        case 5:
            return m_EmoteChances.fKills;
            // End:0x22C
            break;
        // End:0x195
        case 6:
            // End:0x175
            if((((int(Emote) == int(13)) || int(Emote) == int(14)) || int(Emote) == int(15)) || int(Emote) == int(17))
            {
                return GetAbilityEmoteChance(Emote);
            }
            return m_EmoteChances.fAction;
            // End:0x22C
            break;
        // End:0x1BA
        case 7:
            return m_EmoteChances.fContext;
            // End:0x22C
            break;
        // End:0x1DF
        case 8:
            return m_EmoteChances.fUltimate;
            // End:0x22C
            break;
        // End:0x204
        case 9:
            return m_EmoteChances.fOverride;
            // End:0x22C
            break;
        // End:0x229
        case 10:
            return m_EmoteChances.fMovement;
            // End:0x22C
            break;
        // End:0xFFFF
        default:
            break;
    }
    J0x22C:

    return m_EmoteChances.fDefault;
    //return ReturnValue;    
}

simulated event bool EmoteDiceRoll(TgPawn.EEmote Emote)
{
    return RandRange(0.0000000, 1.0000000) <= (GetEmoteChance(Emote));
    //return ReturnValue;    
}

simulated event bool TriggersEmoteGlobalCooldown(TgPawn.EEmote Emote)
{
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0x35
        case 3:
        // End:0x3A
        case 4:
        // End:0x3F
        case 5:
        // End:0x44
        case 6:
        // End:0x49
        case 7:
        // End:0x4E
        case 8:
        // End:0x58
        case 9:
            return true;
            // End:0x74
            break;
        // End:0x5D
        case 1:
        // End:0x62
        case 2:
        // End:0x67
        case 10:
        // End:0x6C
        case 0:
        // End:0xFFFF
        default:
            return false;
            break;
    }    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074
    //return ReturnValue;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074
    // Failed to format remaining nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074
}

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote)
{
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0x35
        case 8:
        // End:0x3A
        case 9:
        // End:0x44
        case 10:
            return false;
            // End:0x74
            break;
        // End:0x49
        case 1:
        // End:0x4E
        case 3:
        // End:0x53
        case 2:
        // End:0x58
        case 4:
        // End:0x5D
        case 5:
        // End:0x62
        case 6:
        // End:0x67
        case 7:
        // End:0x6C
        case 0:
        // End:0xFFFF
        default:
            return true;
            break;
    }    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074
    //return ReturnValue;
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074    
    // Failed to format nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074
    // Failed to format remaining nests!:System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
   at System.ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
   at UELib.Core.UStruct.UByteCodeDecompiler.DecompileNests(Boolean outputAllRemainingNests)
   at UELib.Core.UStruct.UByteCodeDecompiler.Decompile()
    // 1 & Type:Switch Position:0x074
}

simulated event float GetEmoteInternalCooldown(TgPawn.EEmote Emote)
{
    local TgPlayerController PC;
    local TgPawn.EEmoteCategory EmoteCat;
    local float fInternalCooldown;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0x47
        case 1:
            fInternalCooldown = 10.0000000;
            // End:0xD6
            break;
        // End:0x5E
        case 2:
            fInternalCooldown = 3.0000000;
            // End:0xD6
            break;
        // End:0x75
        case 3:
            fInternalCooldown = 45.0000000;
            // End:0xD6
            break;
        // End:0x7A
        case 4:
        // End:0x7F
        case 5:
        // End:0x84
        case 6:
        // End:0x9B
        case 7:
            fInternalCooldown = 30.0000000;
            // End:0xD6
            break;
        // End:0xB2
        case 10:
            fInternalCooldown = 5.0000000;
            // End:0xD6
            break;
        // End:0xB7
        case 8:
        // End:0xBC
        case 9:
        // End:0xC1
        case 0:
        // End:0xFFFF
        default:
            fInternalCooldown = 0.0000000;
            // End:0xD6
            break;
            break;
    }
    PC = TgPlayerController(GetALocalPlayerController());
    // End:0x138
    if((PC != none) && PC.Pawn != self)
    {
        fInternalCooldown *= 2.0000000;
    }
    return fInternalCooldown;
    //return ReturnValue;    
}

simulated event RecordInternalEmoteTime(TgPawn.EEmote Emote)
{
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    // End:0x3F
    if(m_fLastEmoteCatTimes.Length < int(11))
    {
        m_fLastEmoteCatTimes.Length = int(11);
    }
    switch(EmoteCat)
    {
        // End:0x93
        case 1:
            m_fLastPlayerVGSEmoteTimes.InsertItem(0, WorldInfo.TimeSeconds);
            m_fLastPlayerVGSEmoteTimes.Length = 3;
            // End:0x96
            break;
        // End:0xFFFF
        default:
            break;
    }
    m_fLastEmoteCatTimes[int(EmoteCat)] = WorldInfo.TimeSeconds;
    //return;    
}

simulated event RecordGlobalEmoteTime()
{
    m_fLastEmoteTime = WorldInfo.TimeSeconds;
    //return;    
}

simulated event RecordNonLocalEmoteTime()
{
    local TgPlayerController localPC;
    local TgPawn LocalPawn;

    localPC = TgPlayerController(GetALocalPlayerController());
    // End:0xB8
    if(localPC != none)
    {
        LocalPawn = TgPawn(localPC.Pawn);
        // End:0xB8
        if(LocalPawn != none)
        {
            // End:0xB8
            if(LocalPawn != self)
            {
                LocalPawn.m_fLastNonLocalEmoteTime = WorldInfo.TimeSeconds;
            }
        }
    }
    //return;    
}

simulated event float GetLastEmoteTime(TgPawn.EEmote Emote)
{
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    // End:0x3F
    if(m_fLastEmoteCatTimes.Length < int(11))
    {
        m_fLastEmoteCatTimes.Length = int(11);
    }
    switch(EmoteCat)
    {
        // End:0x74
        case 1:
            m_fLastPlayerVGSEmoteTimes.Length = 3;
            return m_fLastPlayerVGSEmoteTimes[2];
            // End:0x77
            break;
        // End:0xFFFF
        default:
            break;
    }
    return m_fLastEmoteCatTimes[int(EmoteCat)];
    //return ReturnValue;    
}

simulated event bool IsEmoteOnInternalCooldown(TgPawn.EEmote Emote)
{
    local float fLastEmoteTime, fInternalCooldownTime;

    fLastEmoteTime = GetLastEmoteTime(Emote);
    fInternalCooldownTime = GetEmoteInternalCooldown(Emote);
    return (fLastEmoteTime + fInternalCooldownTime) >= WorldInfo.TimeSeconds;
    //return ReturnValue;    
}

simulated event bool AreEmotesOnGlobalCooldown()
{
    local bool bGlobalCooldown;

    bGlobalCooldown = (m_fLastEmoteTime + m_fEmoteGlobalCooldown) >= WorldInfo.TimeSeconds;
    return bGlobalCooldown;
    //return ReturnValue;    
}

simulated event bool IsEmoteOnNonLocalCooldown(TgPawn.EEmote Emote)
{
    local TgPlayerController localPC;
    local TgPawn LocalPawn;

    localPC = TgPlayerController(GetALocalPlayerController());
    // End:0xC5
    if(localPC != none)
    {
        LocalPawn = TgPawn(localPC.Pawn);
        // End:0xC5
        if(LocalPawn != none)
        {
            // End:0xC5
            if(LocalPawn != self)
            {
                return (LocalPawn.m_fLastNonLocalEmoteTime + m_fEmoteNonLocalCooldown) >= WorldInfo.TimeSeconds;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event bool EmoteShouldKillAllOtherVox(TgPawn.EEmote Emote)
{
    local TgDevice dev_ult;
    local TgPawn.EEmoteCategory EmoteCat;

    EmoteCat = GetEmoteCategory(Emote);
    switch(EmoteCat)
    {
        // End:0xE7
        case 9:
            switch(GetBotId())
            {
                // End:0x51
                case 2094:
                // End:0x59
                case 2056:
                // End:0x61
                case 2057:
                // End:0xDF
                case 2267:
                    dev_ult = GetDeviceByEqPoint(2);
                    // End:0xDC
                    if((dev_ult != none) && (dev_ult.r_Deployable != none) || dev_ult.r_nProjectiles > 0)
                    {
                        return false;
                    }
                    // End:0xE2
                    break;
                // End:0xFFFF
                default:
                    break;
            }
            return true;
            // End:0xEA
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
    //return ReturnValue;    
}

function bool EmoteShouldForce3P(TgPawn.EEmote Emote)
{
    switch(Emote)
    {
        // End:0x18
        case 1:
        // End:0x1D
        case 2:
        // End:0x22
        case 3:
        // End:0x27
        case 39:
        // End:0x2C
        case 40:
        // End:0x31
        case 41:
        // End:0x36
        case 42:
        // End:0x40
        case 43:
            return true;
            // End:0x43
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
    //return ReturnValue;    
}

event SetEmote3PCamera(bool bOn)
{
    local TgPlayerController PC;

    PC = TgPlayerController(Controller);
    // End:0x53
    if((PC == none) || !PC.IsLocalPlayerController())
    {
        return;
    }
    // End:0x74
    if((c_nEmoteCameraStackId != -1) == bOn)
    {
        return;
    }
    // End:0xAF
    if(bOn)
    {
        c_nEmoteCameraStackId = PC.PushCameraPosture(1);        
    }
    else
    {
        // End:0xE9
        if(PC.PopCameraPosture(c_nEmoteCameraStackId))
        {
            c_nEmoteCameraStackId = -1;
        }
    }
    //return;    
}

simulated event bool AnimNotifySound(SoundCue Cue)
{
    return false;
    //return ReturnValue;    
}

simulated event PreDemoRewind()
{
    // End:0x2E
    if(r_EffectManager != none)
    {
        r_EffectManager.ClearAllClientEffectForms();
    }
    //return;    
}

simulated event PostDemoRewind()
{
    local editinline SkeletalMeshComponent SkelComp;
    local int I;

    // End:0x4D
    if(r_EffectManager != none)
    {
        r_EffectManager.UpdateEffectForms();
        r_EffectManager.UpdateEffectFormVisibility();
    }
    // End:0x114
    if(Mesh != none)
    {
        // End:0x114
        if((GetHealth()) > 0.0000000)
        {
            Mesh.bNoSkeletonUpdate = false;
            Mesh.bPauseAnims = false;
            // End:0x114
            if((m_FullBodyAnimNode != none) && m_FullBodyAnimNode.GetPlayedAnimation() == 'Death')
            {
                m_FullBodyAnimNode.StopCustomAnim(0.0000000);
            }
        }
    }
    // End:0x147
    foreach ComponentList(Class'Engine.SkeletalMeshComponent', SkelComp)
    {
        ResetSkelControls(SkelComp);        
    }    
    I = 1;
    J0x153:

    // End:0x3BA [Loop If]
    if(I < 33)
    {
        // End:0x3AC
        if((c_EquipForm[I] != none) && c_EquipForm[I].FormState != c_EquipFormState[I])
        {
            switch(c_EquipFormState[I])
            {
                // End:0x1E7
                case 'None':
                // End:0x2B8
                case 'Active':
                    // End:0x256
                    if(c_EquipForm[I].FormState == 'DeviceFiring')
                    {
                        c_EquipForm[I].StopFire(0);                        
                    }
                    else
                    {
                        // End:0x2B5
                        if(c_EquipForm[I].FormState != 'Active')
                        {
                            c_EquipForm[I].BeginActive();
                        }
                    }
                    // End:0x3AC
                    break;
                // End:0x2F0
                case 'DeviceOutOfHand':
                    c_EquipForm[I].EndDevicePuttingDown();
                    // End:0x3AC
                    break;
                // End:0x334
                case 'DeviceBuildup':
                    c_EquipForm[I].BuildUp(0, I, 0);
                    // End:0x3AC
                    break;
                // End:0x370
                case 'DeviceFiring':
                    c_EquipForm[I].StartFire(0);
                    // End:0x3AC
                    break;
                // End:0x3A9
                case 'DeviceCoolDown':
                    c_EquipForm[I].Cooldown(0);
                    // End:0x3AC
                    break;
                // End:0xFFFF
                default:
                    break;
            }
        }
        else
        {
            I++;
            // [Loop Continue]
            goto J0x153;
        }/* !MISMATCHING REMOVE, tried Loop got Type:Else Position:0x3AC! */
        ReinitializeOverlays();
        //return;        
    }/* !MISMATCHING REMOVE, tried Else got Type:Loop Position:0x153! */
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x77
    if((Other != none) && Other.IsA('TgPlayerBlockingVolume'))
    {
        ForceAllGrabTargetsDetach();
        TeleportNotify();
    }
    //return;    
}

function AdjustDevicesForNewDilation(float fPrevDilation, float fNewDilation)
{
    local int I;
    local TgDevice Dev;

    I = 1;
    J0x0B:

    // End:0x86 [Loop If]
    if(I < 33)
    {
        Dev = m_EquippedDevices[I];
        // End:0x78
        if(Dev != none)
        {
            Dev.AdjustForNewDilation(fPrevDilation, fNewDilation);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated event bool CanFlyWithoutHover()
{
    return false;
    //return ReturnValue;    
}

function bool CheckPhysicsStateForJumping()
{
    return (((int(Physics) == int(1)) || int(Physics) == int(9)) || int(Physics) == int(8)) || (int(Physics) == int(16)) && m_bCanJumpWhileCharging;
    //return ReturnValue;    
}

function bool IsFiringAny()
{
    local int I;
    local TgDevice Dev;

    I = 1;
    J0x0B:

    // End:0x7B [Loop If]
    if(I < 33)
    {
        Dev = m_EquippedDevices[I];
        // End:0x6D
        if((Dev != none) && Dev.IsFiring())
        {
            return true;
        }
        ++I;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

function bool CannotJumpNow()
{
    local TgDevice Dev;
    local int I;

    // End:0x0F
    if(IsJumpDisabled())
    {
        return true;
    }
    I = 1;
    J0x1A:

    // End:0xB0 [Loop If]
    if(I < 33)
    {
        Dev = m_EquippedDevices[I];
        // End:0xA2
        if(((Dev != none) && Dev.IsFiring()) && !Dev.CanJumpWhileFiring())
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x1A;
    }
    // End:0xCE
    if(r_bIsLifted && m_bIgnorePhysCheckForJump)
    {
        return false;
    }
    // End:0xFA
    if((int(r_eCurrentStunType) != int(0)) && int(r_eCurrentStunType) != int(5))
    {
        return true;
    }
    // End:0x10D
    if(GroundSpeed == float(0))
    {
        return true;
    }
    // End:0x12F
    if(!m_bIgnorePhysCheckForJump && !CheckPhysicsStateForJumping())
    {
        return true;
    }
    // End:0x15F
    if(((GetPropCurrentValue(32)) > 0.0000000) || (GetPropCurrentValue(33)) > 0.0000000)
    {
        return true;
    }
    // End:0x16E
    if(r_bIsRooted)
    {
        return true;
    }
    // End:0x17D
    if(m_bIsLeaping)
    {
        return true;
    }
    return super(Pawn).CannotJumpNow();
    //return ReturnValue;    
}

simulated event bool IsInJumpLanding()
{
    // End:0x66
    if((Controller != none) && !Controller.IsLocalPlayerController())
    {
        return WorldInfo.TimeSeconds < (m_fJumpLandingTime + 0.1500000);
    }
    return WorldInfo.TimeSeconds < (m_fJumpLandingTime + 0.3000000);
    //return ReturnValue;    
}

function InterruptInhand()
{
    local TgDevice inhand;

    inhand = GetDeviceByEqPoint(1);
    // End:0xA1
    if((((int(Role) == int(ROLE_Authority)) && inhand != none) && inhand.IsFiring()) && inhand.CanBeInterrupted())
    {
        inhand.InterruptFiring();
    }
    //return;    
}

function TgObject.TG_EQUIP_POINT OverrideOffhandSlot(TgObject.TG_EQUIP_POINT eqp)
{
    return eqp;
    //return ReturnValue;    
}

simulated function SetMeshDepthPriority(Scene.ESceneDepthPriorityGroup NewDepth)
{
    Mesh.SetDepthPriorityGroup(NewDepth);
    //return;    
}

event bool CanPlayHitReaction()
{
    return m_bAcceptsHitReactions && !IsImmuneToDamage();
    //return ReturnValue;    
}

function KillCloneTimer()
{
    // End:0x1A
    if(Health > 0)
    {
        KilledBy(self);
    }
    //return;    
}

simulated event OnCameraCutAnimNotify(TgAnimNotify_CameraCut CameraCutNotify)
{
    //return;    
}

simulated function bool IsInputLocked()
{
    return r_bIsInStasis;
    //return ReturnValue;    
}

simulated function bool InputLockedDueToFiring()
{
    local TgPlayerController PC;
    local TgAIController_Behavior AI;

    PC = TgPlayerController(Controller);
    // End:0x4B
    if(PC != none)
    {
        return PC.IsDeviceLockingInput();
    }
    AI = TgAIController_Behavior(Controller);
    // End:0x96
    if(AI != none)
    {
        return AI.bIsRotationLocked;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool IsRotationLocked()
{
    local TgPlayerController PC;

    PC = TgPlayerController(Controller);
    // End:0x4B
    if(PC != none)
    {
        return PC.IsDeviceLockingRotation();
    }
    return false;
    //return ReturnValue;    
}

simulated function bool IsCameraLocked()
{
    return false;
    //return ReturnValue;    
}

event bool CanApplyShield()
{
    return true;
    //return ReturnValue;    
}

function bool OnMountCancelOffhandSlotPressed(TgDevice newDev)
{
    local TgDevice Mount;

    // End:0x10E
    if((newDev == none) || newDev.ShouldInterruptMount())
    {
        Mount = GetDeviceByEqPoint(23);
        // End:0x10E
        if((Mount != none) && Mount.CanBeCanceled())
        {
            Mount.InterruptFiring();
            Mount.ClientInterrupt();
            Mount.OnCanceled();
            // End:0x10C
            if((newDev != none) && newDev.LogDebugInfo())
            {
            }
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function PlayMountingEffects(bool bPlayMountAnim, bool bPostureChange)
{
    local TgAnimNodeSlot MountFullBodyAnimNode;
    local int MeshId1P, MeshId3P;
    local float SummonAnimTime;
    local TgDeviceForm_Mount MountDeviceForm;
    local TgPlayerController localPC;
    local name stealthGroup;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x4F
    if(m_MountMesh != none)
    {
        StopMountingEffects(false, r_bUseMountPosture);
    }
    Class'TgGame.TgWeaponMeshActor'.static.GetMeshAsmIds(r_EquipDeviceInfo[23].nDeviceId, MeshId1P, MeshId3P);
    // End:0x32E
    if(MeshId3P > 0)
    {
        m_MountMesh = TgSkeletalMeshComponent(CreateMeshComponent(MeshId3P));
        UpdateMountScale(true);
        AttachComponent(m_MountMesh);
        m_MountMesh.SetLightEnvironment(LightEnvironment);
        m_MountMesh.SetShadowParent(Mesh);
        m_MountMesh.SetTranslation(Mesh.Translation);
        InitializeSilhouetteComponent(m_MountMesh);
        // End:0x203
        if(!TgRepInfo_Game(WorldInfo.GRI).AllowPlayerMounting())
        {
            m_MountMesh.FxActivateGroup('Mount', 0);
        }
        // End:0x32E
        if(bPlayMountAnim)
        {
            MountFullBodyAnimNode = TgAnimNodeSlot(m_MountMesh.Animations.FindAnimNode('FullBody'));
            // End:0x32E
            if(MountFullBodyAnimNode != none)
            {
                SummonAnimTime = MountFullBodyAnimNode.PlayCustomAnim('Summon', 1.0000000 / (GetPropCurrentValue(13)), 0.0000000, 0.2000000, false, true);
                MountDeviceForm = TgDeviceForm_Mount(c_EquipForm[23]);
                // End:0x32E
                if((SummonAnimTime > 0.0000000) && MountDeviceForm != none)
                {
                    MountDeviceForm.PlaySummonEffects(SummonAnimTime, false);
                }
            }
        }
    }
    // End:0x395
    if((m_FullBodyAnimNode != none) && bPlayMountAnim)
    {
        m_FullBodyAnimNode.PlayCustomAnim('MountSummon', 1.0000000 / (GetPropCurrentValue(13)), 0.0000000, 0.2000000, false, true);
    }
    // End:0x3B8
    if(bPostureChange)
    {
        m_nMountPostureId = PushPosture(12);
    }
    FxActivateGroupSelf('Mount', 1);
    // End:0x4D6
    if((m_MountMesh != none) && int(r_eIsStealthed) != int(0))
    {
        localPC = TgPlayerController(GetALocalPlayerController());
        // End:0x45D
        if((localPC != none) && localPC.Pawn == self)
        {
            stealthGroup = 'StealthLocal';            
        }
        else
        {
            // End:0x496
            if(localPC.IsEnemy(self))
            {
                stealthGroup = 'StealthEnemy';                
            }
            else
            {
                stealthGroup = 'Stealth';
            }
        }
        m_MountMesh.FxActivateGroup(stealthGroup, 0);
    }
    //return;    
}

simulated function StopMountingEffects(bool bPlayDismount, bool bPostureChange)
{
    local TgAnimNodeSlot MountFullBodyAnimNode;
    local float MountDismountTime;
    local TgDeviceForm_Mount MountDeviceForm;
    local bool bPlayedDismount;
    local Vector MeshTranslation;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    UpdateMountScale(false);
    ClearTimer('DetachMountMesh');
    // End:0x2E8
    if(!r_bIsMounted && r_bMorphMounted)
    {
        // End:0x270
        if(m_MountMesh != none)
        {
            // End:0x270
            if(bPlayDismount)
            {
                MountFullBodyAnimNode = TgAnimNodeSlot(m_MountMesh.Animations.FindAnimNode('FullBody'));
                // End:0x270
                if(MountFullBodyAnimNode != none)
                {
                    MountDismountTime = MountFullBodyAnimNode.PlayCustomAnim('Dismount', 1.0000000 / (GetPropCurrentValue(13)), 0.1000000, 0.0000000, false, true);
                    // End:0x270
                    if(MountDismountTime > 0.0000000)
                    {
                        bPlayedDismount = true;
                        SetTimer(MountDismountTime, false, 'DetachMountMesh');
                        m_MountMesh.SetAbsolute(true, true);
                        MeshTranslation = Location;
                        MeshTranslation.Z -= (GetCollisionHeight());
                        m_MountMesh.SetTranslation(MeshTranslation);
                        m_MountMesh.SetRotation(Rotation);
                        MountDeviceForm = TgDeviceForm_Mount(c_EquipForm[23]);
                        // End:0x270
                        if(MountDeviceForm != none)
                        {
                            MountDeviceForm.PlaySummonEffects(MountDismountTime, true);
                        }
                    }
                }
            }
        }
        // End:0x2E8
        if((bPlayDismount && m_FullBodyAnimNode != none) && !IsDying())
        {
            m_FullBodyAnimNode.PlayCustomAnim('MountDismount', 1.0000000 / (GetPropCurrentValue(13)), 0.0000000, 0.2000000, false, true);
        }
    }
    // End:0x301
    if(!bPlayedDismount)
    {
        DetachMountMesh();
    }
    // End:0x321
    if(bPostureChange)
    {
        PopPosture(m_nMountPostureId);
    }
    //return;    
}

simulated function DetachMountMesh()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x6B
    if(m_MountMesh != none)
    {
        RemoveSilhouetteInfo(m_MountMesh);
        DetachComponent(m_MountMesh);
        m_MountMesh = none;
    }
    // End:0xA5
    if(Mesh != none)
    {
        Mesh.FxDeactivateGroup('Mount', 0);
    }
    //return;    
}

simulated function OnMountBegin(bool bForceFireDueToRespawn, bool bPostureChange)
{
    local TgAIController TgAIC;
    local TgPlayerController TgPC;

    PlayMountingEffects(!bForceFireDueToRespawn, bPostureChange);
    m_bIsEnteringMount = true;
    TgAIC = TgAIController(Controller);
    // End:0x63
    if(TgAIC != none)
    {
        r_bIsMounted = true;
    }
    TgPC = TgPlayerController(Controller);
    // End:0x10E
    if(TgPC != none)
    {
        TgPC.bRun = 1;
        // End:0x10E
        if(TgPC.IsLocalPlayerController() && c_CurrentTargetingDevice != none)
        {
            // End:0x10E
            if(c_CurrentTargetingDevice.m_bRemoveTargetingOnMount)
            {
                SwitchBackToInhandInstantly();
            }
        }
    }
    //return;    
}

simulated function SwitchBackToInhandInstantly()
{
    local TgDevice inhand;
    local WeaponMeshSwapStrategy SwapStrategy;

    inhand = GetDeviceByEqPoint(1);
    // End:0x48
    if(inhand != c_CurrentTargetingDevice)
    {
        SetTargetingDevice(inhand, SwapStrategy);
    }
    //return;    
}

simulated event bool IsFirstPerson()
{
    local TgPlayerController TgPC;
    local TgSpectatorController SpecPC;

    TgPC = TgPlayerController(Controller);
    // End:0x50
    if(TgPC != none)
    {
        return !TgPC.m_bBehindView;        
    }
    else
    {
        SpecPC = TgSpectatorController(GetALocalPlayerController());
        // End:0xF0
        if(SpecPC != none)
        {
            return (SpecPC.GetViewTarget() == self) && (int(SpecPC.m_CameraMode) == int(3)) || !SpecPC.m_bBehindView;
        }
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x165
        if(TgPC != none)
        {
            return (TgPC.GetViewTarget() == self) && !TgPC.m_bBehindView;
        }
    }
    return false;
    //return ReturnValue;    
}

function RemoveStealthEffects()
{
    local TgDevice_Stealth Dev;
    local int I;

    I = 0;
    J0x0B:

    // End:0x7D [Loop If]
    if(I < 33)
    {
        Dev = TgDevice_Stealth(GetDeviceByEqPoint(I));
        // End:0x6F
        if(Dev != none)
        {
            Dev.InterruptFiring();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    // End:0xAB
    if(r_EffectManager != none)
    {
        r_EffectManager.RemoveAllStealthEffects();
    }
    //return;    
}

simulated event PlayBleedEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsBleeding = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayBleed(r_bIsBleeding);
    }
    //return;    
}

simulated event PlayDazeEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsDazed = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayDaze(r_bIsDazed);
    }
    //return;    
}

simulated event PlayCCImmuneEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsCCImmune = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayCCImmuneEffects(r_bIsCCImmune);
    }
    //return;    
}

simulated event PlayOnFireEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsOnFire = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayOnFire(r_bIsOnFire);
    }
    //return;    
}

simulated event PlayFreezeEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsFrozen = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayFreeze(r_bIsFrozen);
    }
    //return;    
}

simulated event PlayKnockbackEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0xE8
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x7D
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xBF
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayKnockback(r_bIsKnockedBack);
    }
    //return;    
}

simulated event PlayMarkEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsMarked = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayMark(r_bIsMarked);
    }
    //return;    
}

function ClientPlayGrassEffects(bool bEnabled, optional ParticleSystem Template)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0xF2
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x7E
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xC0
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayGrass(bEnabled, Template);
    }
    //return;    
}

function ClientPlayHiddenEffects(bool bEnabled, optional ParticleSystem Template)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0xF2
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x7E
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xC0
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayHidden(bEnabled, Template);
    }
    //return;    
}

simulated event PlayRootEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsRooted = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayRoot(r_bIsRooted);
    }
    //return;    
}

simulated event PlayPoisonedEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsPoisoned = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayPoisoned(r_bIsPoisoned);
    }
    //return;    
}

simulated event PlayCrippledEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0xE8
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x7D
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xBF
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayCrippled(bEnabled);
    }
    //return;    
}

simulated event PlayFlashBangEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local LocalPlayer LP;
    local TgScreenCapturePostEffect TgScreenCapturePostEffect;
    local MaterialInstanceTimeVarying NewMaterial;
    local PostProcessEffect CurrentEffect;
    local bool bFoundPostProcess;

    // End:0x48E
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x7D
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        LP = LocalPlayer(TgPC.Player);
        // End:0x48E
        if((LP != none) && LP.PlayerPostProcess != none)
        {
            // End:0x2E7
            foreach LP.PlayerPostProcess.Effects(CurrentEffect)
            {
                TgScreenCapturePostEffect = TgScreenCapturePostEffect(CurrentEffect);
                // End:0x2E6
                if(TgScreenCapturePostEffect != none)
                {
                    NewMaterial = MaterialInstanceTimeVarying(TgScreenCapturePostEffect.Material);
                    // End:0x2E6
                    if(NewMaterial != none)
                    {
                        bFoundPostProcess = true;
                        // End:0x25F
                        if(bEnabled)
                        {
                            NewMaterial.SetTextureParameterValue('OldFrame', TgScreenCapturePostEffect.ScreenCapture);
                            NewMaterial.SetScalarStartTime('FadeAmount', 100.0000000);
                            NewMaterial.SetScalarStartTime('WhiteFade', 100.0000000);
                            ClearTimer('CleanUpScreenCapturePostProcess');                            
                        }
                        else
                        {
                            NewMaterial.SetScalarStartTime('WhiteFade', 0.0000000);
                            NewMaterial.SetScalarStartTime('FadeAmount', 0.0000000);
                            SetTimer(NewMaterial.GetMaxDurationFromAllParameters(), false, 'CleanUpScreenCapturePostProcess');
                        }
                    }
                }                
            }            
            // End:0x48E
            if(!bFoundPostProcess && bEnabled)
            {
                TgScreenCapturePostEffect = new Class'TgGame.TgScreenCapturePostEffect';
                TgScreenCapturePostEffect.InitializeRenderTarget(TgPC);
                NewMaterial = new Class'Engine.MaterialInstanceTimeVarying';
                NewMaterial.SetParent(MaterialInstanceTimeVarying'TgPostProcess.MIC_FadeOldFrame');
                NewMaterial.SetTextureParameterValue('OldFrame', TgScreenCapturePostEffect.ScreenCapture);
                NewMaterial.SetScalarStartTime('FadeAmount', 100.0000000);
                NewMaterial.SetScalarStartTime('WhiteFade', 100.0000000);
                TgScreenCapturePostEffect.Material = NewMaterial;
                LP.PlayerPostProcess.Effects.AddItem(TgScreenCapturePostEffect);
            }
        }
    }
    //return;    
}

simulated function CleanUpScreenCapturePostProcess()
{
    local PlayerController PC;
    local LocalPlayer LP;
    local TgScreenCapturePostEffect TgScreenCapturePostEffect;
    local PostProcessEffect CurrentEffect;

    PC = GetALocalPlayerController();
    // End:0x25
    if(PC == none)
    {
        return;
    }
    LP = LocalPlayer(PC.Player);
    // End:0x139
    if((LP != none) && LP.PlayerPostProcess != none)
    {
        // End:0x138
        foreach LP.PlayerPostProcess.Effects(CurrentEffect)
        {
            TgScreenCapturePostEffect = TgScreenCapturePostEffect(CurrentEffect);
            // End:0x137
            if(TgScreenCapturePostEffect != none)
            {
                TgScreenCapturePostEffect.Cleanup(LP.PlayerPostProcess);                
            }
            else
            {                
            }
        }        
    }
    //return;    
}

simulated event PlaySlowEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsSlowed = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlaySlow(r_bIsSlowed);
    }
    //return;    
}

simulated event PlayRevealedEffects(bool bEnabled)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera TgCamera;

    // End:0x29
    if(int(Role) == int(ROLE_Authority))
    {
        r_bIsRevealed = bEnabled;
    }
    // End:0x111
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgPC = TgPlayerController(Controller);
        // End:0xA6
        if((TgPC == none) || TgPC.GetViewTarget() != self)
        {
            return;
        }
        TgCamera = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xE8
        if(TgCamera == none)
        {
            return;
        }
        TgCamera.PlayRevealed(r_bIsRevealed);
    }
    //return;    
}

simulated function InterruptAllReloads()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x6B [Loop If]
    if(I < 33)
    {
        // End:0x5D
        if(m_EquippedDevices[I] != none)
        {
            m_EquippedDevices[I].InterruptReload();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated event InterruptInhandReload()
{
    // End:0x58
    if((m_EquippedDevices[1] != none) && m_EquippedDevices[1].m_bCanReloadEarly)
    {
        m_EquippedDevices[1].InterruptReload();
    }
    //return;    
}

event bool HasDeviceByID(int DeviceID)
{
    local TgDevice Dev;
    local int I;

    I = 1;
    J0x0B:

    // End:0x83 [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0x75
        if(Dev != none)
        {
            // End:0x75
            if(Dev.r_nDeviceId == DeviceID)
            {
                return true;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

event bool HasActiveDeviceByID(int DeviceID)
{
    local TgDevice Dev;
    local int I;

    I = 1;
    J0x0B:

    // End:0xAB [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0x9D
        if(((Dev != none) && Dev.r_nDeviceId == DeviceID) && Dev.IsActive())
        {
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

event bool HasDeviceByClass(Class DeviceClass)
{
    return GetDeviceByClass(DeviceClass) != none;
    //return ReturnValue;    
}

event bool HasActiveDeviceByClass(name DeviceClassName)
{
    return (GetActiveDeviceByClass(DeviceClassName)) != none;
    //return ReturnValue;    
}

// Export UTgPawn::execGetDeviceByClass(FFrame&, void* const)
native final event TgDevice GetDeviceByClass(Class DeviceClass);

event TgDevice GetActiveDeviceByClass(name DeviceClassName)
{
    local TgDevice Dev;
    local int I;

    I = 1;
    J0x0B:

    // End:0xAA [Loop If]
    if(I < 33)
    {
        Dev = GetDeviceByEqPoint(I);
        // End:0x9C
        if(((Dev != none) && Dev.IsA(DeviceClassName)) && Dev.IsActive())
        {
            return Dev;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return none;
    //return ReturnValue;    
}

event InterruptDeviceFiringByClass(Class DeviceClass, optional bool bForce)
{
    local TgDevice Dev;

    Dev = GetDeviceByClass(DeviceClass);
    // End:0x7F
    if((Dev != none) && bForce || Dev.CanBeInterrupted())
    {
        Dev.InterruptFiring();
    }
    //return;    
}

event InterruptAllMovementDevices()
{
    local TgDevice Device;

    Device = GetDeviceByEqPoint(16);
    // End:0x8C
    if(((Device != none) && Device.IsMovementAbility()) && Device.CanBeInterrupted())
    {
        Device.InterruptFiring();
    }
    Device = GetDeviceByEqPoint(3);
    // End:0x118
    if(((Device != none) && Device.IsMovementAbility()) && Device.CanBeInterrupted())
    {
        Device.InterruptFiring();
    }
    Device = GetDeviceByEqPoint(4);
    // End:0x1A4
    if(((Device != none) && Device.IsMovementAbility()) && Device.CanBeInterrupted())
    {
        Device.InterruptFiring();
    }
    //return;    
}

event float GetDistanceToNearestCapturePoint()
{
    local float shortestDistance, Distance;
    local TgChaosCapturePoint capturePoint;

    shortestDistance = -1.0000000;
    // End:0xB2
    foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
    {
        Distance = VSize(capturePoint.Location - Location);
        // End:0xB1
        if((shortestDistance < 0.0000000) || Distance < shortestDistance)
        {
            shortestDistance = Distance;
        }        
    }    
    return shortestDistance;
    //return ReturnValue;    
}

simulated event SetUITargetingType(TgObject.EUITargetingType NewTargetingType, optional bool bForceRequiredToSet, optional TgObject.EUITargetingType RequiredToSet)
{
    // End:0x41
    if(!bForceRequiredToSet || int(RequiredToSet) == int(c_UITargetingType))
    {
        c_UITargetingType = NewTargetingType;
    }
    //return;    
}

simulated function AddIncomingImpact(int bNumToAdd)
{
    r_nIncomingImpactCount += bNumToAdd;
    //return;    
}

reliable client simulated function ClientSetActiveWeapon(Weapon NewWeapon)
{
    local WeaponMeshSwapStrategy SwapStrategy;

    SetActiveWeapon(NewWeapon);
    SetTargetingDevice(TgDevice(NewWeapon), SwapStrategy);
    //return;    
}

function UpdateMetaGameState(TgPawn.EMetaGameState NewState)
{
    m_eMetaGameState = NewState;
    //return;    
}

function TgPawn.EMetaGameState GetMetaGameState()
{
    return m_eMetaGameState;
    //return ReturnValue;    
}

function UpdateBotBehaviorState(TgPawn.EBotBehaviorState NewState)
{
    m_eBotBehaviorState = NewState;
    //return;    
}

function TgPawn.EBotBehaviorState GetBotBehaviorState()
{
    return m_eBotBehaviorState;
    //return ReturnValue;    
}

// Export UTgPawn::execTestFx(FFrame&, void* const)
native exec function TestFx(float Pct);

exec function TgSpecialFx TestFx2(int Id)
{
    local TgSpecialFx Fx;
    local int I;

    Fx = Class'TgGame.TgPawn'.static.GetSpecialFx(Id);
    // End:0x15A
    if(Fx != none)
    {
        I = 0;
        J0x4C:

        // End:0x123 [Loop If]
        if(I < Fx.c_PSCList.Length)
        {
            Fx.c_ParticleChannelOverride.bInitialized = true;
            Fx.c_ParticleChannelOverride.Friendly = true;
            Fx.c_ParticleChannelOverride.Enemy = false;
            I++;
            // [Loop Continue]
            goto J0x4C;
        }
        Fx.SpawnEmitter(Location, vect(1.0000000, 0.0000000, 0.0000000));
    }
    return Fx;
    //return ReturnValue;    
}

function UpdateLastPlayerStart(PlayerStart NewLastPlayerStart)
{
    m_LastPlayerStart = NewLastPlayerStart;
    //return;    
}

simulated function string GetAnimSetString(TgObject.EMountType MountType)
{
    return "";
    //return ReturnValue;    
}

event AddInstigatorWallReveal(Actor Viewer)
{
    local int I;

    // End:0x96
    if(Viewer != none)
    {
        I = 0;
        J0x1A:

        // End:0x96 [Loop If]
        if(I < 12)
        {
            // End:0x50
            if(r_VisibleThroughWallsInstigators[I] == Viewer)
            {
                return;                
            }
            else
            {
                // End:0x88
                if(r_VisibleThroughWallsInstigators[I] == none)
                {
                    r_VisibleThroughWallsInstigators[I] = Viewer;
                    return;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

event RemoveInstigatorWallReveal(Actor Viewer)
{
    local int I, J;

    // End:0xCC
    if(Viewer != none)
    {
        I = 0;
        J0x1A:

        // End:0xCC [Loop If]
        if(I < 12)
        {
            // End:0xBE
            if(r_VisibleThroughWallsInstigators[I] == Viewer)
            {
                r_VisibleThroughWallsInstigators[I] = none;
                J = I + 1;
                J0x76:

                // End:0xBE [Loop If]
                if(J < 12)
                {
                    r_VisibleThroughWallsInstigators[J - 1] = r_VisibleThroughWallsInstigators[J];
                    J++;
                    // [Loop Continue]
                    goto J0x76;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

simulated event bool IsInstigatorWallRevealed(Actor Viewer)
{
    local int I;

    // End:0x5B
    if(Viewer != none)
    {
        I = 0;
        J0x1A:

        // End:0x5B [Loop If]
        if(I < 12)
        {
            // End:0x4D
            if(r_VisibleThroughWallsInstigators[I] == Viewer)
            {
                return true;
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    return false;
    //return ReturnValue;    
}

event AddInstigatorStealthReveal(Actor Viewer)
{
    local int I;

    // End:0x96
    if(Viewer != none)
    {
        I = 0;
        J0x1A:

        // End:0x96 [Loop If]
        if(I < 12)
        {
            // End:0x50
            if(r_VisibleThroughStealthInstigators[I] == Viewer)
            {
                return;                
            }
            else
            {
                // End:0x88
                if(r_VisibleThroughStealthInstigators[I] == none)
                {
                    r_VisibleThroughStealthInstigators[I] = Viewer;
                    return;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

event RemoveInstigatorStealthReveal(Actor Viewer)
{
    local int I, J;

    // End:0xCC
    if(Viewer != none)
    {
        I = 0;
        J0x1A:

        // End:0xCC [Loop If]
        if(I < 12)
        {
            // End:0xBE
            if(r_VisibleThroughStealthInstigators[I] == Viewer)
            {
                r_VisibleThroughStealthInstigators[I] = none;
                J = I + 1;
                J0x76:

                // End:0xBE [Loop If]
                if(J < 12)
                {
                    r_VisibleThroughStealthInstigators[J - 1] = r_VisibleThroughStealthInstigators[J];
                    J++;
                    // [Loop Continue]
                    goto J0x76;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

// Export UTgPawn::execIsInstigatorStealthRevealed(FFrame&, void* const)
native final simulated function bool IsInstigatorStealthRevealed(Actor Viewer);

event AddObscuringDeployable(TgDeployable deployable)
{
    local int I;

    // End:0x0F
    if(m_bCannotBeVolumeStealthed)
    {
        return;
    }
    // End:0x89
    if(deployable != none)
    {
        I = 0;
        J0x29:

        // End:0x89 [Loop If]
        if(I < 10)
        {
            // End:0x7B
            if(r_ObscuringDeployables[I] == none)
            {
                r_ObscuringDeployables[I] = deployable;
                UpdateObscuringDeployableState();
                return;
            }
            I++;
            // [Loop Continue]
            goto J0x29;
        }
    }
    //return;    
}

event RemoveObscuringDeployable(TgDeployable deployable)
{
    local int I;

    // End:0x0F
    if(m_bCannotBeVolumeStealthed)
    {
        return;
    }
    // End:0x87
    if(deployable != none)
    {
        I = 0;
        J0x29:

        // End:0x7D [Loop If]
        if(I < 10)
        {
            // End:0x6F
            if(r_ObscuringDeployables[I] == deployable)
            {
                r_ObscuringDeployables[I] = none;
            }
            I++;
            // [Loop Continue]
            goto J0x29;
        }
        UpdateObscuringDeployableState();
    }
    //return;    
}

event AddBlindingDeployable(TgDeployable deployable)
{
    local int I;

    // End:0x0F
    if(m_bCannotBeVolumeStealthed)
    {
        return;
    }
    // End:0x89
    if(deployable != none)
    {
        I = 0;
        J0x29:

        // End:0x89 [Loop If]
        if(I < 10)
        {
            // End:0x7B
            if(r_BlindingDeployables[I] == none)
            {
                r_BlindingDeployables[I] = deployable;
                UpdateBlindingDeployableState();
                return;
            }
            I++;
            // [Loop Continue]
            goto J0x29;
        }
    }
    //return;    
}

event RemoveBlindingDeployable(TgDeployable deployable)
{
    local int I;

    // End:0x0F
    if(m_bCannotBeVolumeStealthed)
    {
        return;
    }
    // End:0x87
    if(deployable != none)
    {
        I = 0;
        J0x29:

        // End:0x7D [Loop If]
        if(I < 10)
        {
            // End:0x6F
            if(r_BlindingDeployables[I] == deployable)
            {
                r_BlindingDeployables[I] = none;
            }
            I++;
            // [Loop Continue]
            goto J0x29;
        }
        UpdateBlindingDeployableState();
    }
    //return;    
}

// Export UTgPawn::execUpdateWhiteOut(FFrame&, void* const)
native function UpdateWhiteOut();

// Export UTgPawn::execEndWhiteOut(FFrame&, void* const)
native function EndWhiteOut();

function IntroTimer()
{
    //return;    
}

simulated function SetWhiteOutStartTimer()
{
    //return;    
}

simulated function BeginWhiteOutScaleUp()
{
    ClearTimer('BeginWhiteOutScaleUp');
    m_bIntroWhiteOutActive = true;
    //return;    
}

simulated event bool IsPlayingIntro()
{
    return false;
    //return ReturnValue;    
}

event DoIntroduction(bool bUseInitialIntro)
{
    s_fIntroStartTime = WorldInfo.TimeSeconds;
    GotoState(((r_bFirstSpawnWave || bUseInitialIntro) ? m_IntialIntroState : 'Intro'));
    // End:0xA9
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && IsPlayingIntro())
    {
        SetupIntroAnimNodesAndTimers();
        SetWhiteOutStartTimer();
    }
    //return;    
}

simulated function SetupIntroAnimNodesAndTimers()
{
    local AnimNodeSequence SeqNode;
    local TgAnimBlendByBuffMonsterIntro BuffCampIntro;
    local float fIntroOffset;

    // End:0x2A
    if(int(Role) < int(ROLE_Authority))
    {
        fIntroOffset = r_fIntroOffset;        
    }
    else
    {
        fIntroOffset = WorldInfo.TimeSeconds - s_fIntroStartTime;
    }
    // End:0x155
    if((fIntroOffset >= 0.0000000) && r_fIntroTime > 0.0000000)
    {
        m_fIntroProgress = fIntroOffset;
        // End:0xF5
        if(m_BuffCampIntroNodes.Length > 0)
        {
            // End:0xF1
            foreach m_BuffCampIntroNodes(BuffCampIntro)
            {
                BuffCampIntro.SetupIntro(r_fIntroTime, fIntroOffset);                
            }                        
        }
        else
        {
            // End:0x154
            foreach m_RespawnNodes(SeqNode)
            {
                SeqNode.PlayAnim(false, SeqNode.Rate, fIntroOffset);                
            }            
        }
    }
    //return;    
}

simulated function EnterIntroPosture()
{
    local TgAnimBlendByPosture postureNode;

    // End:0x112
    if(m_IntroPostureID == -1)
    {
        m_IntroPostureID = PushPosture(3);
        // End:0xC2
        foreach m_PostureBlendNodes(postureNode)
        {
            postureNode.ForcePostureChange(false);
            postureNode.SetActiveChild(postureNode.ActiveChildIndex, 0.0000000);
            postureNode.ReplayAnim();            
        }        
        // End:0x112
        if(Mesh != none)
        {
            Mesh.ForceSkelUpdate();
            Mesh.bUpdateSkelWhenNotRendered = true;
        }
    }
    //return;    
}

simulated function ExitIntroPosture(optional bool bForceAnimTreeOut)
{
    local TgAnimBlendByPosture postureNode;

    // End:0x14B
    if(m_IntroPostureID != -1)
    {
        PopPosture(m_IntroPostureID);
        m_IntroPostureID = -1;
        // End:0x14B
        if(Mesh != none)
        {
            // End:0xEC
            if(bForceAnimTreeOut)
            {
                // End:0xEB
                foreach m_PostureBlendNodes(postureNode)
                {
                    postureNode.ForcePostureChange(false);
                    postureNode.SetActiveChild(postureNode.ActiveChildIndex, 0.0000000);
                    postureNode.ReplayAnim();                    
                }                
            }
            Mesh.ForceSkelUpdate();
            Mesh.bUpdateSkelWhenNotRendered = (int(Role) == int(ROLE_AutonomousProxy)) || c_bUpdateSkelMeshWhenNotRendered;
        }
    }
    //return;    
}

simulated event FinishedIntroAnim(AnimNode IntroAnimNode)
{
    //return;    
}

event SetInitialHUDOverlayInfo()
{
    SetHUDOverlayIcon(m_InitHUDOverlayIcon);
    SetHUDOverlayDisplayMask(m_nInitHUDOverlayDisplayMask);
    SetHUDOverlayState(m_InitHUDOverlayState);
    SetHUDOverlayEnemyViewDist(m_InitHUDOverlayEnemyViewDist);
    //return;    
}

simulated function TgRespawnBeaconExit GetTouchingRespawnBeacon()
{
    // End:0x12
    if(m_LocalTouchingRespawnBeacons.Length <= 0)
    {
        return none;
    }
    return m_LocalTouchingRespawnBeacons[0];
    //return ReturnValue;    
}

function TouchingRespawnBeaconExit(TgRespawnBeaconExit RespawnBeacon, bool IsTouching)
{
    // End:0x28
    if(!IsTouching)
    {
        m_LocalTouchingRespawnBeacons.RemoveItem(RespawnBeacon);        
    }
    else
    {
        // End:0x5E
        if(m_LocalTouchingRespawnBeacons.Find(RespawnBeacon) == -1)
        {
            m_LocalTouchingRespawnBeacons.AddItem(RespawnBeacon);
        }
    }
    UpdateRespawnBeaconReticule();
    //return;    
}

singular simulated function UpdateHasRespawnBeacon(bool bHasRespawnBeacon)
{
    // End:0x3D
    if(int(Role) >= int(ROLE_AutonomousProxy))
    {
        r_bHasRespawnBeacon = bHasRespawnBeacon;
        ClientUpdateHasRespawnBeacon(bHasRespawnBeacon);
    }
    // End:0xBD
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PlayFXHoldsBeacon(bHasRespawnBeacon);
        UpdateRespawnBeaconReticule();
        // End:0xBD
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.ToggleHoldingBeacon(bHasRespawnBeacon);
        }
    }
    //return;    
}

reliable client simulated function ClientUpdateHasRespawnBeacon(bool bHasRespawnBeacon)
{
    UpdateHasRespawnBeacon(bHasRespawnBeacon);
    //return;    
}

simulated function PlayFXHoldsBeacon(bool bShouldPlay)
{
    // End:0x28
    if(bShouldPlay)
    {
        FxActivateGroupSelf('BeaconCarrier', 0);        
    }
    else
    {
        FxDeactivateGroupSelf('BeaconCarrier', 0);
    }
    //return;    
}

final simulated function PlayGenericTakeHit(Vector HitLocation, Vector HitNormal, TgPawn HitInstigator, float fDamageAmount, const out ExtraDamageInfo ExtraInfo)
{
    local TgPlayerController PC;
    local bool bDisplayHit;

    // End:0x1F2
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PC = TgPlayerController(GetALocalPlayerController());
        // End:0x1F2
        if((PC != none) && PC.CachedPRI != none)
        {
            bDisplayHit = false;
            // End:0x14C
            if(WorldInfo.TimeSeconds >= c_fNextTakeHitDisplayGroupTimestamp)
            {
                bDisplayHit = true;
                // End:0x119
                if(HitInstigator != none)
                {
                    c_fNextTakeHitDisplayGroupTimestamp = WorldInfo.TimeSeconds + HitInstigator.c_fNextTakeHitDisplayDelay;                    
                }
                else
                {
                    c_fNextTakeHitDisplayGroupTimestamp = WorldInfo.TimeSeconds + c_fNextTakeHitDisplayDelay;
                }
            }
            // End:0x1F2
            if(((bDisplayHit && Mesh != none) && PC.GetTgPawn() != self) && !IsEnemy(PC) || !IsStealthed(PC.CachedPRI))
            {
                FxReactivateGroupSelf('TakeHit', 0);
            }
        }
    }
    //return;    
}

simulated function OnStartTimelapseNewDeviceState()
{
    local int I;

    I = 1;
    J0x0B:

    // End:0x7E [Loop If]
    if(I < 33)
    {
        // End:0x70
        if(c_EquipForm[I] != none)
        {
            c_EquipForm[I].RecoverDeviceState(r_ReplicatedDeviceState[I]);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function Vector GetCameraOffsetOverride(Vector originalOffset)
{
    local TgDeviceForm_Mount MountDeviceForm;

    // End:0x5A
    if(r_bIsMounted)
    {
        MountDeviceForm = TgDeviceForm_Mount(c_EquipForm[23]);
        // End:0x5A
        if(MountDeviceForm != none)
        {
            return MountDeviceForm.m_CameraOffset;
        }
    }
    return originalOffset;
    //return ReturnValue;    
}

exec function Polymorph(TgObject.EPolymorphType NewPolymorph)
{
    SetPolymorph(NewPolymorph, none);
    //return;    
}

// Export UTgPawn::execSetPolymorph(FFrame&, void* const)
native final function SetPolymorph(TgObject.EPolymorphType NewPolymorph, Actor instigatingActor);

// Export UTgPawn::execGetPolymorphMeshID(FFrame&, void* const)
native final function int GetPolymorphMeshID();

// Export UTgPawn::execPlayPolymorphEffects(FFrame&, void* const)
native function PlayPolymorphEffects(optional bool bForceOff);

// Export UTgPawn::execSetAux(FFrame&, void* const)
native function SetAux(name AuxBusName, float Level);

simulated event PreTimeLapse(bool bPlayOfTheGame)
{
    PrepTrackedProjectileRecreation(0.2500000);
    // End:0x35
    if(int(c_LocalPolymorph) != int(r_CurrentPolymorph))
    {
        PlayPolymorphEffects();
    }
    UpdateFirstValidFlashEventIdx();
    super(Actor).PreTimeLapse(bPlayOfTheGame);
    ApplyStealthClient();
    //return;    
}

simulated event PostTimeLapse(bool bPlayOfTheGame)
{
    PrepTrackedProjectileRecreation(1.0000000);
    // End:0x35
    if(int(c_LocalPolymorph) != int(r_CurrentPolymorph))
    {
        PlayPolymorphEffects();
    }
    super(Actor).PostTimeLapse(bPlayOfTheGame);
    UpdateFirstValidFlashEventIdx();
    ApplyStealthClient();
    //return;    
}

simulated function PrepTrackedProjectileRecreation(float recreateTimeOut)
{
    local int I;
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x47
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        return;
    }
    c_fRecreateTrackedProjectilesTimer = recreateTimeOut;
    // End:0xE1
    if(PRI != none)
    {
        PRI.c_bTrackedProjectileIdsJustChanged = false;
        I = 0;
        J0x95:

        // End:0xE1 [Loop If]
        if(I < 15)
        {
            PRI.r_TrackedProjectileIds[I] = -1;
            I++;
            // [Loop Continue]
            goto J0x95;
        }
    }
    //return;    
}

simulated event RecreateTrackedProjectiles()
{
    local TgRepInfo_Game GRI;
    local int I;
    local TgRepInfo_Player PRI;
    local TgProj_Simulated Proj;
    local bool bExists;

    // End:0x2B
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        return;
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x646
    if((GRI != none) && PRI != none)
    {
        I = 0;
        J0xA3:

        // End:0x646 [Loop If]
        if(I < 15)
        {
            // End:0x638
            if(PRI.r_TrackedProjectileIds[I] > -1)
            {
                Proj = GRI.GetSimulatedProjectile(PRI.r_TrackedProjectileIds[I]);
                // End:0x259
                if(Proj == none)
                {
                    bExists = false;
                    Proj = GRI.SpawnSimulatedProjectile(PRI.r_TrackedProjectileIds[I], PRI.r_TrackedProjectilesInitData[I].FireModeID, self, PRI.r_TrackedProjectilesInitData[I].SpawnLocation, PRI.r_TrackedProjectilesInitData[I].SpawnRotation);                    
                }
                else
                {
                    bExists = true;
                }
                // End:0x638
                if(Proj != none)
                {
                    Proj.Velocity = PRI.r_TrackedProjectilesInitData[I].SpawnVelocity;
                    Proj.m_vSpawnVelocity = PRI.r_TrackedProjectilesInitData[I].SpawnVelocity;
                    // End:0x3E0
                    if(bExists)
                    {
                        Proj.SetLocation(PRI.r_TrackedProjectilesInitData[I].SpawnLocation);
                        Proj.SetRotation(Rotator(PRI.r_TrackedProjectilesInitData[I].SpawnRotation));                        
                    }
                    else
                    {
                        Proj.CompleteInitialization();
                    }
                    // End:0x5D3
                    if(Proj.m_fTrackingUpdateRate > 0.0000000)
                    {
                        Proj.TickAhead(PRI.r_TrackedProjectilesUpdateData[I].UpdateServerTime - PRI.r_TrackedProjectilesInitData[I].SpawnServerTime);
                        Proj.SetLocation(PRI.r_TrackedProjectilesUpdateData[I].Location);
                        Proj.Velocity = PRI.r_TrackedProjectilesUpdateData[I].Velocity;
                        Proj.TickAhead(c_fServerTimeStamp - PRI.r_TrackedProjectilesUpdateData[I].UpdateServerTime);                        
                    }
                    else
                    {
                        Proj.TickAhead(c_fServerTimeStamp - PRI.r_TrackedProjectilesInitData[I].SpawnServerTime);
                    }
                }
            }
            I++;
            // [Loop Continue]
            goto J0xA3;
        }
    }
    //return;    
}

simulated event OnPolymorphChanged(bool bDead)
{
    // End:0x27
    if(!bDead)
    {
        FxActivateGroupSelf('WhileAlive', 0);
    }
    PlayFXHoldsBeacon(r_bHasRespawnBeacon);
    // End:0x7B
    if(m_HeadMesh != none)
    {
        m_HeadMesh.m_bForceHideComponent = int(c_LocalPolymorph) > int(0);
    }
    // End:0xB3
    if(m_WeaponMesh != none)
    {
        m_WeaponMesh.OnPolymorphChanged(bDead);
    }
    //return;    
}

simulated function Rotator ApplyCameraRotationModifier(Rotator rCameraRot)
{
    // End:0x24
    if(m_bUsesRecoil)
    {
        return ApplyRecoilToRotation(rCameraRot);        
    }
    else
    {
        return rCameraRot;
    }
    //return ReturnValue;    
}

simulated function Rotator ApplyRecoilToRotation(Rotator rRot)
{
    // End:0x71
    if(m_bUsesRecoil)
    {
        rRot += m_rSmoothedRecoil;
        rRot.Pitch = Clamp(NormalizeRotAxis(rRot.Pitch), -16383, 16383);
    }
    return rRot;
    //return ReturnValue;    
}

simulated function AllowDeviceToModifyInput(TgPlayerInput tgInput)
{
    //return;    
}

simulated event ForceUpdateAmmoAnim()
{
    //return;    
}

simulated event OnBecameSpectatorViewTarget()
{
    //return;    
}

simulated event OnCeaseSpectatorViewTarget()
{
    //return;    
}

// Export UTgPawn::execSetThreatLevel(FFrame&, void* const)
native function SetThreatLevel(TgObject.EThreatLevel NewThreatLevel);

// Export UTgPawn::execCheckOcclusion(FFrame&, void* const)
native function float CheckOcclusion();

event SetHUDOverlayDisplayMask(int dodm)
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x2D
    if(PRI == none)
    {
        return;
    }
    PRI.SetHUDOverlayDisplayMask(dodm);
    //return;    
}

event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi)
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x2D
    if(PRI == none)
    {
        return;
    }
    PRI.SetHUDOverlayIcon(doi);
    //return;    
}

event SetHUDOverlayState(TgObject.DeployableOverlayState dos)
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x2D
    if(PRI == none)
    {
        return;
    }
    PRI.SetHUDOverlayState(dos);
    //return;    
}

event SetHUDOverlayEnemyViewDist(float enemyViewDist)
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x2D
    if(PRI == none)
    {
        return;
    }
    PRI.SetHUDOverlayEnemyViewDist(enemyViewDist);
    //return;    
}

event UpdateHUDHealthPercent(float fPercent)
{
    local float fDeltaThreshold;

    fDeltaThreshold = 0.0100000;
    // End:0x79
    if(!c_bHealAkEventPlaying)
    {
        // End:0x76
        if(((fPercent > c_fHUDHealthPercent) && Abs((GetHealthPercent()) - fPercent) >= fDeltaThreshold) && IsAliveAndWell())
        {
            ToggleHealAkEvent(true);
        }        
    }
    else
    {
        // End:0xD3
        if(((fPercent < c_fHUDHealthPercent) || Abs((GetHealthPercent()) - fPercent) < fDeltaThreshold) || !IsAliveAndWell())
        {
            ToggleHealAkEvent(false);
        }
    }
    SetAkPlayerHealthPercent(fPercent);
    c_fHUDHealthPercent = fPercent;
    //return;    
}

event ToggleHealAkEvent(bool bEnable)
{
    // End:0x64
    if(bEnable != c_bHealAkEventPlaying)
    {
        // End:0x3C
        if(bEnable)
        {
            PostAkEvent(c_HealPlayAkEvent);            
        }
        else
        {
            PostAkEvent(c_HealStopAkEvent);
        }
        c_bHealAkEventPlaying = bEnable;
    }
    //return;    
}

function SetFaceRotationToController()
{
    local Rotator NewPawnRotation;

    // End:0x88
    if(m_fRemainingFaceRotationInterpTime > 0.0000000)
    {
        m_fRemainingFaceRotationInterpTime = 0.0000000;
        NewPawnRotation.Yaw = Controller.Rotation.Yaw;
        FaceRotation(NewPawnRotation, 0.0000000);
    }
    //return;    
}

simulated function ForwardEffects(ImpactInfo Impact, TgEffectGroup EffectGroup, TgDevice SourceDevice, optional bool bRemove, optional int StackCount = 1)
{
    //return;    
}

simulated function bool CanBeNudged()
{
    return (m_EquippedDevices[7] == none) || !m_EquippedDevices[7].IsFiring();
    //return ReturnValue;    
}

simulated function bool ShouldNudgePlayer(TgPawn PlayerPawn)
{
    return int(GetTaskForceNumber()) == int(PlayerPawn.GetTaskForceNumber());
    //return ReturnValue;    
}

simulated function float GetReloadScale()
{
    return FMax(r_fReloadScale, 0.4000000);
    //return ReturnValue;    
}

// Export UTgPawn::execGetEnergyChargeModifier(FFrame&, void* const)
native function float GetEnergyChargeModifier();

// Export UTgPawn::execResetUlt(FFrame&, void* const)
native function ResetUlt();

simulated function TgDevice GetDeviceForAimAssist()
{
    local int X, nSelectedPriority, nCurrentPriority;
    local TgDevice SelectedDevice;

    X = 0;
    J0x0B:

    // End:0xBC [Loop If]
    if(X < 33)
    {
        // End:0xAE
        if(m_EquippedDevices[X] != none)
        {
            nCurrentPriority = m_EquippedDevices[X].GetAimAssistPriority();
            // End:0xAE
            if(nCurrentPriority > nSelectedPriority)
            {
                nSelectedPriority = nCurrentPriority;
                SelectedDevice = m_EquippedDevices[X];
            }
        }
        ++X;
        // [Loop Continue]
        goto J0x0B;
    }
    return SelectedDevice;
    //return ReturnValue;    
}

simulated function float GetMaxAimAssistStacks()
{
    return m_fMaxAimAssistStacks;
    //return ReturnValue;    
}

reliable server function ServerStartFlourish()
{
    StartFlourish();
    //return;    
}

simulated function FlourishTimeoutFinished()
{
    //return;    
}

simulated event StartFlourish()
{
    // End:0xB0
    if(!IsTimerActive('FlourishTimeoutFinished'))
    {
        SetTimer(m_fFlourishTimeout + ((int(Role) < int(ROLE_Authority)) ? 0.2000000 : 0.0000000), false, 'FlourishTimeoutFinished');
        // End:0x80
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.PlayFlourish();
        }
        // End:0xA1
        if(int(Role) < int(ROLE_Authority))
        {
            ServerStartFlourish();            
        }
        else
        {
            FlashPlaySpecialEffect(11);
        }
    }
    //return;    
}

simulated event AppliedEffectRemoved(TgEffect RemovedEffect)
{
    //return;    
}

simulated event RegisterFor3pTransitionCB(delegate<On3pTransitionEvent> EventDelegate)
{
    // End:0x36
    if(m_SingleUseOn3pTransitionDelegates.Find(EventDelegate) == -1)
    {
        m_SingleUseOn3pTransitionDelegates.AddItem(EventDelegate);
    }
    //return;    
}

simulated function Invoke3pTransitionDelegates()
{
    local delegate<On3pTransitionEvent> onEventDelegate;

    // End:0x3A
    foreach m_SingleUseOn3pTransitionDelegates(onEventDelegate)
    {
        // End:0x39
        if(onEventDelegate != none)
        {
            On3pTransitionEvent();
        }        
    }    
    m_SingleUseOn3pTransitionDelegates.Remove(0, m_SingleUseOn3pTransitionDelegates.Length);
    //return;    
}

simulated event DisableMovementCorrection(float fDisableTime)
{
    local TgPlayerController pController;

    ClearTimer('EnableMovementCorrection');
    pController = TgPlayerController(Controller);
    // End:0x77
    if(pController != none)
    {
        pController.bAcceptSendCorrections = false;
        SetTimer(fDisableTime, false, 'EnableMovementCorrection');
    }
    //return;    
}

simulated event EnableMovementCorrection()
{
    local TgPlayerController pController;

    ClearTimer('EnableMovementCorrection');
    pController = TgPlayerController(Controller);
    // End:0x60
    if(pController != none)
    {
        pController.bAcceptSendCorrections = true;
    }
    //return;    
}

simulated function bool ShouldUseScopeSensitivity()
{
    return false;
    //return ReturnValue;    
}

simulated event OnVGSSoundPlayed(int nVgsId)
{
    c_nCurrentVGSPlaying = nVgsId;
    //return;    
}

simulated event OnVGSSoundFinished()
{
    c_nCurrentVGSPlaying = 0;
    //return;    
}

simulated event OnEmoteSoundPlayed(TgPawn.EEmote Emote)
{
    c_eCurrentAudioEmotePlaying = Emote;
    //return;    
}

simulated event OnEmoteSoundFinished()
{
    c_eCurrentAudioEmotePlaying = 0;
    //return;    
}

simulated state Dying
{
    ignores StopPlayFiring, TakeDamage, StopAction, BreathTimer, Falling, PhysicsVolumeChange, 
	    HeadVolumeChange;

    simulated event Landed(Vector HitNormal, Actor FloorActor)
    {
        // End:0x25
        if(!m_bHasPlayedDeathAnimation)
        {
            m_bForceDeathAnim = true;
            PlayDeathAnimation();
        }
        //return;        
    }

    simulated function OnLifeAfterDeathTimerExpired()
    {
        // End:0x2F
        if(m_DeathAnimFX != none)
        {
            m_DeathAnimFX.Deactivate(true);
        }
        // End:0x20F
        if(Controller != none)
        {
            // End:0x1A3
            if(Controller.IsA('AIController') && !Controller.IsA('TgAIController_BehaviorGod'))
            {
                Controller.Destroy();
                bTearOff = true;
                bReplicateMovement = false;
                // End:0x19D
                if(((((WorldInfo.IsPlayingDemo() && Mesh != none) && !self.IsA('TgPawn_Character')) || !Controller.IsA('TgAIController_BehaviorGod') || Controller.IsA('TgPlayerController')) && int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && m_bFadeOutOnLifeAfterDeathTimerExpired)
                {
                    BeginFadeOut();                    
                }
                else
                {
                    Destroy();
                }                
            }
            else
            {
                // End:0x200
                if((Controller.IsA('TgAIController_BehaviorGod') || Controller.IsA('TgPlayerController')) && bTearOff)
                {
                    Destroy();                    
                }
                else
                {
                    c_bMeshHiddenDueToDeath = true;
                }
            }            
        }
        else
        {
            // End:0x23A
            if((Mesh != none) && m_bFadeOutOnLifeAfterDeathTimerExpired)
            {
                BeginFadeOut();                
            }
            else
            {
                Destroy();
            }
        }
        //return;        
    }

    singular simulated event OutsideWorldBounds()
    {
        SetPhysics(0);
        LifeSpan = FMin(LifeSpan, 1.0000000);
        //return;        
    }

    simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
    {
        local editinline TgSkeletalMeshComponent ActualMesh;

        // End:0x182
        if((SeqNode != none) && SeqNode.AnimSeqName == 'Death')
        {
            ActualMesh = TgSkeletalMeshComponent(Mesh);
            // End:0xAF
            if((ActualMesh == none) || ActualMesh.m_nAssemblyId == m_nBodyMeshAsmId)
            {
                // End:0xAF
                if(m_bHasDestroyedMesh)
                {
                    m_SwapToDestroyedMeshOnTick = true;
                }
            }
            // End:0x182
            if(((m_bUseDamageTypeForDeathAnim && m_DeathDamageType != none) && m_DeathDamageType.default.m_bShouldRagdollAfterDeathAnim) && m_DeathDamageType.default.m_nmDeathAnimNames.Find(SeqNode.AnimSeqName) != -1)
            {
                // End:0x176
                if(TgPlayerController(GetALocalPlayerController()).AllowRagdoll())
                {
                    InitRagdoll();                    
                }
                else
                {
                    c_bMeshHiddenDueToDeath = true;
                }
            }
        }
        //return;        
    }

    simulated event PreDemoRewind()
    {
        CleanUpDyingEffects();
        //return;        
    }

    simulated function Tick(float DeltaTime)
    {
        global.Tick(DeltaTime);
        // End:0x36
        if(m_SwapToDestroyedMeshOnTick)
        {
            OnSwapToDestroyedMesh();
            m_SwapToDestroyedMeshOnTick = false;
        }
        m_bShouldBeFirstPersonLastFrame = true;
        m_f1PTransitionFireDelayRemaining = -1.0000000;
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        local Class<TgGame_Paladins> ChaosGameClass;
        local bool bCanGameModeSpawnHealthNugget;
        local TgPlayerController TgPC;
        local TgPlayerCamera PlayerCamera;

        // End:0xE2
        if(WorldInfo.IsPlayingTimelapse() && r_DeathInfo.dmgType == Class'TgGame.TgDamageType_FallOutOfWorld')
        {
            TgPC = TgPlayerController(Controller);
            // End:0xE2
            if(TgPC != none)
            {
                PlayerCamera = TgPlayerCamera(TgPC.PlayerCamera);
                // End:0xE2
                if(PlayerCamera != none)
                {
                    PlayerCamera.SwitchCameras(Class'TgGame.TgCameraModule_FallOutOfWorld');
                }
            }
        }
        m_SwapToDestroyedMeshOnTick = false;
        DropFlag();
        // End:0x123
        if(m_fLifeAfterDeathSecs > 0.0000000)
        {
            SetTimer(m_fLifeAfterDeathSecs, false, 'OnLifeAfterDeathTimerExpired');
        }
        // End:0x13E
        if(Weapon != none)
        {
            SetActiveWeapon(none, true);
        }
        // End:0x15C
        if(int(Role) == int(ROLE_Authority))
        {
            RemoveAllEffectsOnDeath();
        }
        // End:0x1B3
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            // End:0x1B3
            if(r_EffectManager != none)
            {
                r_EffectManager.UpdateEffectFormVisibility();
            }
        }
        // End:0x1EE
        if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && m_bInitialized)
        {            
        }
        else
        {
            // End:0x208
            if(!m_bInitialized)
            {
                SetMeshVisibility(false);
            }
        }
        bCanClimbLadders = false;
        // End:0x265
        if(Controller != none)
        {
            // End:0x265
            if(Controller.bIsPlayer)
            {
                Controller.PawnDied(self);
            }
        }
        // End:0x2DF
        if((GetPRI()) != none)
        {
            GetPRI().r_nHealthCurrent = 0;
            // End:0x2DF
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                GetPRI().UpdatedHealthCurrent();
            }
        }
        OnPawnDied();
        SetCollision(false, false, false);
        bCanGameModeSpawnHealthNugget = true;
        // End:0x3AF
        if((WorldInfo != none) && WorldInfo.GRI != none)
        {
            ChaosGameClass = Class<TgGame_Paladins>(WorldInfo.GRI.GameClass);
            // End:0x3AF
            if(ChaosGameClass != none)
            {
                bCanGameModeSpawnHealthNugget = ChaosGameClass.default.m_bDropHealthNuggetOnDeath;
            }
        }
        // End:0x3D8
        if(m_bCanSpawnHealthNuggetsOnDeath && bCanGameModeSpawnHealthNugget)
        {
            DropHealthNugget();
        }
        PlayDyingSound();
        // End:0x456
        if(Mesh != none)
        {
            Mesh.SetRBChannel(16);
            Mesh.SetRBCollidesWithChannel(2, false);
            Mesh.SetRBCollidesWithChannel(16, false);
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x22
        if(bPendingDelete)
        {
            super(Object).EndState(NextStateName);
            return;
        }
        SetTimer(0.0000000, false, 'OnLifeAfterDeathTimerExpired');
        super(Object).EndState(NextStateName);
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        m_bIsFadingOut = false;
        // End:0x9B
        if(Mesh != none)
        {
            Mesh.bNoSkeletonUpdate = false;
        }
        // End:0xB9
        if(int(Role) != int(ROLE_Authority))
        {
            OnRespawn();
        }
        bCanClimbLadders = true;
        s_vOneWayMovement = vect(0.0000000, 0.0000000, 0.0000000);
        SetCollision(true, true, false);
        // End:0x156
        if(Mesh != none)
        {
            Mesh.SetRBChannel(2);
            Mesh.SetRBCollidesWithChannel(2, true);
            Mesh.SetRBCollidesWithChannel(16, false);
        }
        // End:0x175
        if(int(Role) == int(ROLE_Authority))
        {
            ReapplyLoadoutEffects();
        }
        // End:0x1CC
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            // End:0x1CC
            if(r_EffectManager != none)
            {
                r_EffectManager.UpdateEffectFormVisibility();
            }
        }
        // End:0x1FF
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            CleanUpDyingEffects();
        }
        //return;        
    }
Begin:

    bBlockActors = false;
    stop;                
}

state Intro
{
    simulated function BeginState(name PreviousStateName)
    {
        m_nIsInIntroState++;
        // End:0x2C
        if(int(Role) == int(ROLE_Authority))
        {
            r_ReplicatedState = GetStateName();
        }
        // End:0x4E
        if(m_fIntroProgress < 0.0000000)
        {
            m_fIntroProgress = 0.0000000;
        }
        FxActivateGroupAllMesh('Intro', 0);
        EnterIntroPosture();
        // End:0xC6
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0xB2
            if(r_fIntroTime > 0.0000000)
            {
                SetTimer(r_fIntroTime, false, 'IntroTimer');                
            }
            else
            {
                IntroTimer();
            }
            SetInitialHUDOverlayInfo();
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local bool bRecentlyRendered;

        ClearTimer('IntroTimer');
        // End:0x3B
        if(int(Role) == int(ROLE_Authority))
        {
            r_ReplicatedState = 'None';
        }
        // End:0xAF
        if(m_bAllowIntroWhiteOut)
        {
            // End:0x68
            if(m_fIntroWhiteOutDownTime <= 0.0000000)
            {
                EndWhiteOut();                
            }
            else
            {
                // End:0xAF
                if((m_fIntroWhiteOutScale <= 0.0000000) || !m_bIntroWhiteOutActive)
                {
                    BeginWhiteOutScaleUp();
                    m_fIntroWhiteOutScale = 1.0000000;
                    UpdateWhiteOut();
                }
            }
        }
        FxDeactivateGroupAllMesh('Intro', 0);
        bRecentlyRendered = (Mesh != none) && Mesh.bRecentlyRendered;
        m_nIsInIntroState--;
        // End:0x195
        if((((!m_bWaitForIntroAnimToEnd || m_bIntroAnimFinished) || NextStateName != 'Idle') || int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || !bRecentlyRendered)
        {
            ExitIntroPosture(!bRecentlyRendered);
        }
        // End:0x28A
        if((((int(Role) == int(ROLE_Authority)) && TgAIController(Controller) != none) && TgAIController(Controller).m_pFactory != none) && TgAIController(Controller).m_pFactory.m_FRI != none)
        {
            TgAIController(Controller).m_pFactory.m_FRI.s_FactoryState = 2;
        }
        //return;        
    }

    simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
    {
        global.OnAnimEnd(SeqNode, PlayedTime, ExcessTime);
        // End:0x6E
        if((SeqNode != none) && SeqNode.NodeName == 'Intro')
        {
            m_bIntroAnimFinished = true;
        }
        //return;        
    }

    simulated event FinishedIntroAnim(AnimNode IntroAnimNode)
    {
        m_bIntroAnimFinished = true;
        //return;        
    }

    simulated event bool IsPlayingIntro()
    {
        return true;
        //return ReturnValue;        
    }

    function IntroTimer()
    {
        GotoState('Idle');
        //return;        
    }

    simulated function SetWhiteOutStartTimer()
    {
        local float fScaleUpDelay;

        // End:0xD3
        if((m_bAllowIntroWhiteOut && r_fIntroTime > 0.0000000) && m_fIntroWhiteOutUpTime > 0.0000000)
        {
            fScaleUpDelay = r_fIntroTime - r_fIntroOffset;
            // End:0x91
            if(fScaleUpDelay > m_fIntroWhiteOutUpTime)
            {
                SetTimer(fScaleUpDelay - m_fIntroWhiteOutUpTime, false, 'BeginWhiteOutScaleUp');                
            }
            else
            {
                // End:0xC4
                if(fScaleUpDelay > 0.0000000)
                {
                    m_fIntroWhiteOutUpTime = fScaleUpDelay;
                    BeginWhiteOutScaleUp();                    
                }
                else
                {
                    m_fIntroWhiteOutUpTime = 0.0000000;
                }
            }
        }
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        super(TgPawn).Tick(DeltaSeconds);
        m_fIntroProgress += DeltaSeconds;
        m_bShouldBeFirstPersonLastFrame = true;
        m_f1PTransitionFireDelayRemaining = -1.0000000;
        //return;        
    }
    stop;    
}

state Idle
{
    simulated function BeginState(name PreviousStateName)
    {
        GotoState('Auto');
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        m_bIntroAnimFinished = true;
        ExitIntroPosture();
        //return;        
    }

    simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
    {
        global.OnAnimEnd(SeqNode, PlayedTime, ExcessTime);
        // End:0x79
        if((SeqNode != none) && SeqNode.NodeName == 'Intro')
        {
            m_bIntroAnimFinished = true;
            ExitIntroPosture();
        }
        //return;        
    }

    simulated event FinishedIntroAnim(AnimNode IntroAnimNode)
    {
        m_bIntroAnimFinished = true;
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_eCharacterCustom1OverlayDepthGroup=ESceneDepthPriorityGroup.SDPG_World
    s_LoadMeshServerSide=true
    m_bApplyDistanceFade=true
    r_bIsBot=true
    s_bCanSeePets=true
    s_bCanApplyEffects=true
    c_bCanDoTurnInPlaceAnim=true
    m_bShouldApplyCCImmuneOverlay=true
    m_bCanBeKnockedBack=true
    m_bCausesPushblock=true
    m_bPushblockAffectsFriendlies=true
    m_bUseSmoothNetReceiveRotation=true
    r_bHasAccurateRotation=true
    r_bCanBePulled=true
    m_bAllowHigherWallJumping=true
    c_bApplyDropShadow=true
    m_bShowNameplate=true
    m_bCanSpawnHealthNuggetsOnDeath=true
    m_bCanAutoMountOnRespawn=true
    m_bAirAccuracyPenalty=true
    m_bCanBeHeadShot=true
    m_bFadeOutOnLifeAfterDeathTimerExpired=true
    m_bShouldSmoothEyeHeight=true
    m_nPhysGrabPostureId=-1
    m_n1PHeadMeshId=-1
    s_PropValuesRepResolution[2]=1.0000000
    m_EmoteChances=(fDefault=1.4000000,fPlayerVGS=1.0000000,fAbilityOnCooldown=1.0000000,fTakingDamage=1.0000000,fCelebration=1.0000000,fKills=0.3300000,fAction=1.0000000,fContext=1.0000000,fUltimate=1.0000000,fOverride=1.0000000,fMovement=1.0000000)
    m_EmoteChancesAbility=(fDefault=0.3300000,fAbility1=0.3300000,fAbility2=0.3300000,fAbility3=0.3300000,fMount=0.3300000)
    c_nEmoteCameraStackId=-1
    m_fEmoteGlobalCooldown=4.0000000
    m_fEmoteNonLocalCooldown=5.0000000
    m_fSoftLandVelocityCutoff=-500.0000000
    m_fHardLandVelocityCutoff=-2000.0000000
    c_nLastProcessedFlashEventIdx=-1
    r_nFlashQueIndex=-1
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        bSynthesizeSHLight=true
        bIsCharacterLightEnvironment=true
    end object
    LightEnvironment=MyLightEnvironment
    m_fMaxAimAssistStacks=1.0000000
    m_fVolumeStealthDisableTime=2.0000000
    c_fFxScaleSize=1.0000000
    r_vDown=(X=0.0000000,Y=0.0000000,Z=-1.0000000)
    m_fExhaustedPercent=20.0000000
    m_fExhaustedPropModifier=1.0000000
    m_fExhaustedMinPropModifier=0.1000000
    m_fMountFrictionMultiplier=1.0000000
    m_fBackpedalPct=1.0000000
    m_fMountBackpedalPct=0.2160000
    r_nResetCharacter=1
    DyingStateName="Dying"
    m_fCrouchTranslationOffset=-32.0000000
    m_InitHUDOverlayEnemyViewDist=1600.0000000
    m_SkelControlLockNames[0]="Prop_Lock"
    m_SkelControlLockNames[1]="Prop1_Lock"
    m_SkelControlLockNames[2]="Prop2_Lock"
    m_SkelControlLockNames[3]="Prop01_Lock"
    m_SkelControlLockNames[4]="Prop02_Lock"
    m_fKnockbackMultiplier=1.0000000
    m_fRBPushStrengthMultiplier=0.2500000
    m_fRBPushStrengthRange=(X=20.0000000,Y=200.0000000)
    m_RotationInterpRate=15.0000000
    m_PitchInterpRate=15.0000000
    m_fSmoothCorrectionRate=25000.0000000
    m_fHorseJumpHeightIncrease=0.2500000
    m_fDazedDuration=8.0000000
    m_fDazedInterval=0.5000000
    m_iDazedOrder=4
    m_iDazedNumControlPoints=8
    m_vDazedMaxRotator=(X=12288.0000000,Y=8192.0000000)
    m_vDazedMinMaxStrafeDuration=(X=1.0000000,Y=2.5000000)
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    begin object name="ShadowDecal" class=TgGame.TgDropShadowDecalComponent
        StaticMesh=StaticMesh'GOD_CommonAssets.Meshes.FX_Player_ground_shadow'
        ReplacementPrimitive=none
        TranslucencySortPriority=1
    end object
    c_PlayerDropShadow=ShadowDecal
    c_PlayerDropShadowTemplate=Material'GOD_CommonAssets.Materials.FX_Player_MeshShadow'
    c_PlayerDropShadowSocketName="CSO_FX_Origin_01"
    m_fFaceRotationInterpTime=1.5000000
    // Reference: TgManifestGroup'TgGame.Default__TgPawn.TgManifestGroup0'
    begin object name="TgManifestGroup0" class=TgGame.TgManifestGroup
    end object
    c_AssetManifestGroup=TgManifestGroup0
    c_nLevelUpFxId=1714
    r_nProfileId=2092
    r_nSkinId=-1
    r_nHeadSkinId=-1
    r_nWeaponSkinId=-1
    r_nMountSkinId=-1
    c_StunnedPostureID=-1
    c_FearedPostureID=-1
    m_fDamageTakenMaxSustainDuration=0.1000000
    m_fDamageTakenRTPCSustainDuration=0.7500000
    m_ExecuteOverlayMaterialFriend=MaterialInstanceConstant'FX_WEP_Lawman.Materials.MIC_ULT_Death_Overlay_A'
    m_ExecuteOverlayMaterialEnemy=MaterialInstanceConstant'FX_WEP_Lawman.Materials.MIC_ULT_Death_Overlay_B'
    m_ShieldOverlayMaterialFriend=MaterialInstanceConstant'fx_generic_status.Materials.MIC_Shield_Overlay_A'
    m_ShieldOverlayMaterialEnemy=MaterialInstanceConstant'fx_generic_status.Materials.MIC_Shield_Overlay_A_Enemy'
    m_ImmortalOverlayMaterialFriend=MaterialInstanceConstant'fx_generic_status.Materials.MIC_Shield_Overlay_Immortal_A'
    m_ImmortalOverlayMaterialEnemy=MaterialInstanceConstant'fx_generic_status.Materials.MIC_Shield_Overlay_Immortal_A_Enemy'
    m_FreezeOverlayMaterial=MaterialInstanceConstant'fx_generic_status.MICs.MIC_Ice_Overlay_A'
    m_SilhouetteClass=Class'TgGame.TgSilhouetteComponentPaladinsPawn'
    m_fHitReactionAIPauseTime=0.6000000
    m_fHitReactionBlendOutTime=0.3000000
    m_fHitReactionTweenTime=0.5000000
    m_fFadeOutTime=8.0000000
    m_fFadeOutSpeed=40.0000000
    m_fHitReactionPulseTime=0.2500000
    m_fDisorientSpinRate=3000.0000000
    m_fMaxSmoothNetUpdateDist=84.0000000
    m_fNoSmoothNetUpdateDist=256.0000000
    m_fSmoothNetUpdateTime=0.1250000
    m_fInitialHealthPercent=1.0000000
    m_fDamageDealtPercentAI=1.0000000
    m_fDamageTakenPercentAI=1.0000000
    m_fRecentHealExpireTime=10.0000000
    m_HeadSilhouetteIndex=-1
    m_HeadOverlayIndex=-1
    m_BobFootstepFactor=8.0000000
    Bob=0.0100000
    // Reference: AudioComponent'TgGame.Default__TgPawn.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    begin object name="TakeHitAC" class=Engine.AudioComponent
        bAllowSpatialization=false
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    begin object name="PainAC" class=Engine.AudioComponent
        bAllowSpatialization=false
    end object
    m_PainAudioComponent=PainAC
    c_HealPlayAkEvent=AkEvent'WW_PC_Shared.PC_Shared_HealingReceived_1P_Play'
    c_HealStopAkEvent=AkEvent'WW_PC_Shared.PC_Shared_HealingReceived_1P_Stop'
    m_fPainEventCooldown=3.0000000
    m_fStealthPulseTime=1.0000000
    r_fKnockedBackFrictionOverride=-1.0000000
    r_fReloadScale=1.0000000
    r_fRefireSpeed=100.0000000
    m_OutlineMaterial=MaterialInstanceConstant'FX_Gen_Outline.Materials.MIC_Outline'
    r_fLeapAirControl=0.2000000
    m_fBaseLeapAirControl=0.2000000
    m_fKnockAirControl=0.0350000
    s_fEndStealthDamage=500.0000000
    m_fScaleMesh=1.0000000
    m_fScaleMeshChangePerSecond=1.0000000
    m_fScaleCollisionHeight=1.0000000
    m_fScaleCollisionHeightChangePerSecond=1.0000000
    m_fScaleCollisionRadius=1.0000000
    m_fScaleCollisionRadiusChangePerSecond=1.0000000
    m_IntroPostureID=-1
    r_fIntroOffset=-1.0000000
    s_fIntroStartTime=-1.0000000
    m_fIntroProgress=-1.0000000
    m_IntialIntroState="Intro"
    c_fNextTakeHitDisplayDelay=0.2500000
    m_PolymorphMaxHealth=1500
    m_GameplayCurves=TgGameplayCurves'GP_BasePawn.BasePawn'
    LLegBoneNames[0]="L_Thigh"
    LLegBoneNames[1]="L_Calf"
    LLegBoneNames[2]="L_Foot"
    RLegBoneNames[0]="R_Thigh"
    RLegBoneNames[1]="R_Calf"
    RLegBoneNames[2]="R_Foot"
    LArmBoneNames[0]="L_UpperArm"
    LArmBoneNames[1]="L_Forearm"
    RArmBoneNames[0]="R_UpperArm"
    RArmBoneNames[1]="R_Forearm"
    HeadBoneNames[0]="Neck1"
    HeadBoneNames[1]="head"
    m_HeadShotComponentBoneName="head"
    m_fMountScaleOverride=1.0000000
    m_LandCameraShake=TgCameraShake'FX_Gen_Camera.CamShake_Land'
    m_JumpCameraShake=TgCameraShake'FX_Gen_Camera.CamShake_Jump'
    m_f1PTransitionFireDelay=0.2000000
    m_fEnergyChargeMultiplier=1.0000000
    m_fNonBaseableSurfaceAirControlDuration=1.0000000
    m_fNonBaseableSurfaceLerpTime=1.0000000
    m_fNonBaseableSurfaceRampUpMult=6.0000000
    m_fNonBaseableSurfaceMaxMoveAmount=12.5000000
    m_fNonBaseableSurfaceGraceTime=0.1000000
    m_fNonBaseableSurfaceExitMaxVelocity=350.0000000
    m_fNonBaseableSurfaceControlPercent=0.4000000
    m_fEyeHeightSmoothFactor=1.0000000
    m_ExecutionMaterialFadeOutTimer=1.5000000
    m_ExecutionMaterialFadeOutDuration=1.5000000
    m_DeathFFWaveform=ForceFeedbackWaveform'gp_forcefeedback.DeathForceFeedback'
    m_fFlourishTimeout=0.5000000
    MaxStepHeight=26.0000000
    MaxJumpHeight=49.0000000
    bCanCrouch=true
    bCanSwim=true
    bCanClimbLadders=true
    bCanStrafe=true
    bCanWalkOffLedges=true
    bCanPickupInventory=true
    bMuffledHearing=true
    bReplicateHealthToAll=true
    m_bPhysVolumesOnlyAffectDownwardVelocities=true
    CrouchHeight=32.0000000
    CrouchRadius=21.0000000
    SightRadius=1600.0000000
    PeripheralVision=-1.0000000
    Buoyancy=0.9900000
    MeleeRange=20.0000000
    WaterSpeed=220.0000000
    AirSpeed=1000.0000000
    AccelRate=8192.0000000
    JumpZ=425.0000000
    AirControl=0.3500000
    WalkingPct=1.0000000
    CrouchedPct=1.0000000
    BaseEyeHeight=40.0000000
    EyeHeight=40.0000000
    UnderWaterTime=20.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__GamePawn.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=46.0000000
        CollisionRadius=25.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    RBPushRadius=5.0000000
    AlwaysRelevantDistanceSquared=2560000.0000000
    ViewPitchMin=-15800.0000000
    ViewPitchMax=16000.0000000
    InventoryManagerClass=Class'TgGame.TgInventoryManager'
    m_TerrainWalkableFloorZ=0.1000000
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn.PositionHistoryComponent'
    begin object name="PositionHistoryComponent" class=PlatformCommon.PComPositionHistoryComponent
    end object
    Components[6]=PositionHistoryComponent
    TickGroup=ETickingGroup.TG_PostAsyncWork
    bReplicateRigidBodyLocation=true
    NetPriority=4.0000000
    CollisionComponent=CollisionCylinder
    RotationRate=(Pitch=0,Yaw=20000,Roll=2048)
    m_fOcclusionCheckInterval=1.0000000
    m_fMaxDistForOcclusionPathfinding=5000.0000000
}