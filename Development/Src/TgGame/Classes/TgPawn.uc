class TgPawn extends GamePawn
    abstract
    native(Pawns)
    nativereplication
    config(Game)
    hidecategories(Navigation)
    implements(TgSkinnableInterface,TgCombatActor,TgObserver_ViewTargetChanged,TgInteractiveAudio)
    dependson(TgCombatActor, TgObject);

const TG_PAWN_PROPERTIES = 8;

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

enum ETweenState {
    TWEEN_None,  // 0
    TWEEN_Default,  // 1
    TWEEN_DefaultImmune,  // 2
    TWEEN_TimedKnockup,  // 3
    TWEEN_Damagable,  // 4
};

enum EGrabState {
    GRAB_None,  // 0
    GRAB_ShellSpin,  // 1
    GRAB_LazarusRush,  // 2
};

enum EChargeState {
    CHARGE_None,  // 0
    CHARGE_NoTurn,  // 1
    CHARGE_NoTurn_RotPawn,  // 2
    CHARGE_NoTurnBackwards,  // 3
    CHARGE_Turn,  // 4
    CHARGE_Fairy,  // 5
};

enum EEmote {
    EMOTE_None,  // 0
    EMOTE_Taunt,  // 1
    EMOTE_Joke,  // 2
    EMOTE_Laugh,  // 3
    EMOTE_Health_Low,  // 4
    EMOTE_Kill_Streak,  // 5
    EMOTE_Intro,  // 6
    EMOTE_Death,  // 7
    EMOTE_DeathGrunt,  // 8
    EMOTE_DeathFall,  // 9
    EMOTE_FirstBlood,  // 10
    EMOTE_Weapon_1,  // 11
    EMOTE_Weapon_2,  // 12
    EMOTE_Ability1,  // 13
    EMOTE_Ability2,  // 14
    EMOTE_Ability3,  // 15
    EMOTE_AbilityUltimate,  // 16
    EMOTE_Mount,  // 17
    EMOTE_SetOnFire,  // 18
    EMOTE_StunnedOrFrozen,  // 19
    EMOTE_Kill,  // 20
    EMOTE_KillSiegeEngine,  // 21
    EMOTE_KillGate,  // 22
    EMOTE_LevelUp,  // 23
    EMOTE_Victory,  // 24
    EMOTE_Defeat,  // 25
    EMOTE_PickWeaponCard,  // 26
    EMOTE_PickArmorCard,  // 27
    EMOTE_PickAbilityCard,  // 28
    EMOTE_KillAssist,  // 29
    EMOTE_UniqueCombat,  // 30
    EMOTE_KillAbility1,  // 31
    EMOTE_KillAbility2,  // 32
    EMOTE_CapturePoint,  // 33
    EMOTE_TakingDamage,  // 34
    EMOTE_EnemyCapturingPoint,  // 35
    EMOTE_OnPointAndFiring,  // 36
    EMOTE_HealedByTeammate,  // 37
    EMOTE_AbilityOnCooldown,  // 38
    EMOTE_Mastery1,  // 39
    EMOTE_Mastery9,  // 40
    EMOTE_Mastery12,  // 41
    EMOTE_Mastery15,  // 42
    EMOTE_Train,  // 43
    EMOTE_GruntHit,  // 44
    EMOTE_GruntJump,  // 45
    EMOTE_BehindUs,  // 46
    EMOTE_AboveUs,  // 47
    EMOTE_Sniper,  // 48
};

enum EEmoteCategory {
    EMOTECAT_None,  // 0
    EMOTECAT_PlayerVGS,  // 1
    EMOTECAT_AbilityOnCooldown,  // 2
    EMOTECAT_TakingDamage,  // 3
    EMOTECAT_Celebration,  // 4
    EMOTECAT_Kills,  // 5
    EMOTECAT_Action,  // 6
    EMOTECAT_Context,  // 7
    EMOTECAT_Ultimate,  // 8
    EMOTECAT_Override,  // 9
    EMOTECAT_Movement,  // 10
};

enum EHitAudioCue {
    CUEHIT_None,  // 0
    CUEHIT_Pain,  // 1
    CUEHIT_FromAbove,  // 2
    CUEHIT_FromBehind,  // 3
    CUEHIT_Sniper,  // 4
};

enum TG_DEATH_REASON {
    DR_NORMAL,  // 0
    DR_DESPAWN,  // 1
    DR_RECONNECT,  // 2
    DR_FREEZE_GIB,  // 3
    DR_LEX_EXECUTE,  // 4
};

enum TG_REP_DEVICE_STATE {
    RDS_INACTIVE,  // 0
    RDS_FIRING,  // 1
    RDS_GENERIC1,  // 2
    RDS_GENERIC2,  // 3
};

enum STEALTH_TYPE {
    STEALTH_TYPE_NONE,  // 0
    STEALTH_TYPE_PULSED,  // 1
    STEALTH_TYPE_FADING,  // 2
    STEALTH_TYPE_INSTANT,  // 3
    STEALTH_TYPE_NO_REVEAL,  // 4
};

enum TG_POSTURE {
    TG_POSTURE_DEFAULT,  // 0
    TG_POSTURE_REST,  // 1
    TG_POSTURE_FUSSY,  // 2
    TG_POSTURE_INTRO,  // 3
    TG_POSTURE_ENRAGED,  // 4
    TG_POSTURE_PATROL,  // 5
    TG_POSTURE_GENERICFIRE1,  // 6
    TG_POSTURE_GENERICFIRE2,  // 7
    TG_POSTURE_GENERICFIRE3,  // 8
    TG_POSTURE_DEAD,  // 9
    TG_POSTURE_SEARCHING,  // 10
    TG_POSTURE_FALLING,  // 11
    TG_POSTURE_MOUNT,  // 12
    TG_POSTURE_STASIS,  // 13
    TG_POSTURE_KNOCKBACK,  // 14
    TG_POSTURE_MESMERIZE,  // 15
    TG_POSTURE_DISARMED,  // 16
    TG_POSTURE_SCARED,  // 17
    TG_POSTURE_STUNNED,  // 18
    TG_POSTURE_PULLED,  // 19
    TG_POSTURE_NONE,  // 20
};

enum TG_PlaySpecialEffect {
    PLAYFX_Heal,  // 0
    PLAYFX_RUberLaser,  // 1
    PLAYFX_LUberLaser,  // 2
    PLAYFX_SiegeWallImpact,  // 3
    PLAYFX_GAMMARAY_BUILDUP,  // 4
    PLAYFX_GAMMARAY_FIRE,  // 5
    PLAYFX_Jump,  // 6
    PLAYFX_SpecialJump,  // 7
    PLAYFX_Land,  // 8
    PLAYFX_Teleport,  // 9
    PLAYFX_PreTeleport,  // 10
    PLAYFX_Flourish,  // 11
};

enum TG_TELEPORT_STATE {
    TELEPORT_NONE,  // 0
    TELEPORT_ENTER,  // 1
    TELEPORT_EXIT,  // 2
    TELEPORT_ENTER_BLINK,  // 3
    TELEPORT_EXIT_BLINK,  // 4
    TELEPORT_KINESSA_TRANSPORTER_ENTER,  // 5
    TELEPORT_KINESSA_TRANSPORTER_EXIT,  // 6
};

enum OverlayMICType {
    OMT_None,  // 0
    OMT_Execute,  // 1
    OMT_Shield,  // 2
    OMT_CCImmune,  // 3
    OMT_CharacterCustom1,  // 4
    OMT_Freeze,  // 5
};

enum OverlayState {
    OMS_Normal,  // 0
    OMS_ForceVisible,  // 1
    OMS_ForceHidden,  // 2
};

enum EForcedSilhouetteVisibility {
    FSV_None,  // 0
    FSV_Visible,  // 1
    FSV_Hidden,  // 2
};

enum EHitReactionType {
    HIT_REACTION_Anim,  // 0
    HIT_Reaction_Procedural,  // 1
};

enum EMetaGameState {
    GAMESTATE_NONE,  // 0
    GAMESTATE_NEUTRAL,  // 1
    GAMESTATE_ACTIVE_POINT,  // 2
    GAMESTATE_ATTACKING,  // 3
    GAMESTATE_DEFENDING,  // 4
    GAMESTATE_TITAN_BATTLE,  // 5
};

enum EBotBehaviorState {
    BEHAVIORSTATE_IDLE,  // 0
    BEHAVIORSTATE_ENGAGING,  // 1
    BEHAVIORSTATE_FALLBACK,  // 2
};

enum LocalViewerRangeState {
    LVRS_EffectiveRange,  // 0
    LVRS_MaxRange,  // 1
    LVRS_BeyondRange,  // 2
};

struct EEmoteCategoryChance {
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
    structdefaultproperties {}
};

struct EEmoteAbilityChance {
    var float fDefault;
    var float fAbility1;
    var float fAbility2;
    var float fAbility3;
    var float fMount;
    structdefaultproperties {}
};

struct TGEQUIP_SLOTS_STRUCT {
    var int SlotIndices[33];
    var int MiscItems[33];
    structdefaultproperties {}
};

struct DeathInfo {
    var bool bDead;
    var Vector Momentum;
    var Class<DamageType> dmgType;
    var Vector HitLoc;
    structdefaultproperties {}
};

struct PostureStack {
    var array<int> GUIDs;
    var array<TgPawn.TG_POSTURE> Postures;
    var int NewPostureGUID;
    structdefaultproperties {}
};

struct PawnDamagerStruct {
    var TgPawn DamagerPawn;
    var float fTimestamp;
    structdefaultproperties {}
};

struct OverlayMICList {
    var init array<init MaterialInstanceConstant> MICs;
    structdefaultproperties {}
};

struct OverlayInfo {
    var export editinline TgSkeletalMeshComponent OverlayMesh;
    var export editinline SkeletalMeshComponent ParentMesh;
    var bool bIs1POverlay;
    var bool bIsVisible;
    var OverlayMICList OverlayMICInstances[OverlayMICType];
    structdefaultproperties {}
};

struct SilhouetteInfo {
};

struct HealingInfo {
    var float HealAmount;
    var float TimeStamp;
    structdefaultproperties {}
};

struct RigidBodyImpactInfo {
    var float LastImpactTime;
    var PhysicalMaterial PhysMat;
    structdefaultproperties {}
};

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
var () TgPawn.EForcedSilhouetteVisibility m_eForcedSilhouetteVisibility;
var () TgPawn.EHitReactionType m_HitReactionType;
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
var () bool m_bBlockCamera;
var bool m_bOverlaysEnabled;
var bool m_b1POverlaysActive;
var bool m_bSilhouettesVisible;
var () const bool m_bUseSilhouettes;
var () bool m_bIgnoreTearOffMomentum;
var () bool m_bAcceptsHitReactions;
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
var () bool m_bUseOutlines;
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
var (Mount) bool c_bHide3PWeaponMeshWhileMounted;
var (Mount) bool r_bMorphMounted;
var transient bool m_bShouldBeFirstPersonLastFrame;
var bool m_bFadeOutOnLifeAfterDeathTimerExpired;
var bool m_bUsesRecoil;
var bool m_bUsingSecondaryPhysicsAsset;
var transient bool m_bWasKilledByEnvironment;
var bool m_bShouldSmoothEyeHeight;
var bool m_bHasAstroBuff;
var bool r_bIsLifted;
var int r_nPhysTweenFlags;
var () string m_sGameplayPackage;
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
var () const export editinline LightEnvironmentComponent LightEnvironment;
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
var () float m_fRBPushStrengthMultiplier;
var () Vector2D m_fRBPushStrengthRange;
var Rotator m_PreviousNetReceiveRotation;
var Rotator m_TargetNetReceiveRotation;
var float m_RotationInterpRate;
var int m_nNetRotationCount;
var int m_nSmoothedRemoteViewPitch;
var int m_nPreviousReceivedRemoteViewPitch;
var int m_nTargetRemoteViewPitch;
var float m_PitchInterpRate;
var int m_nNetViewPitchCount;
var () float m_fSmoothCorrectionRate;
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
var () array<OverlayInfo> m_OverlayInfosBody;
var () array<OverlayInfo> m_OverlayInfosWeapon;
var const MaterialInstanceConstant m_ExecuteOverlayMaterialFriend;
var const MaterialInstanceConstant m_ExecuteOverlayMaterialEnemy;
var const MaterialInstanceConstant m_ShieldOverlayMaterialFriend;
var const MaterialInstanceConstant m_ShieldOverlayMaterialEnemy;
var const MaterialInstanceConstant m_ImmortalOverlayMaterialFriend;
var const MaterialInstanceConstant m_ImmortalOverlayMaterialEnemy;
var const MaterialInstanceConstant m_CharacterCustom1OverlayMaterial;
var const MaterialInstanceConstant m_FreezeOverlayMaterial;
var transient array<SilhouetteInfo> m_SilhouetteInfos;
var () Class<TgSilhouetteComponent> m_SilhouetteClass;
var array<int> m_IgnoredHitPulseIndicies;
var () float m_fHitReactionAIPauseTime;
var () float m_fHitReactionBlendOutTime;
var () float m_fHitReactionTweenTime;
var () float m_fFadeOutTime;
var () float m_fFadeOutSpeed;
var TgSpecialFx m_DeathAnimFX;
var array<TgSkelCon_HitReaction> m_HitReactionSkelControls;
var float m_fRemainingHitReactionPulseTime;
var () float m_fHitReactionPulseTime;
var () float m_fDisorientSpinRate;
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
var () const float m_BobFootstepFactor;
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
var () export editinline TgParticleSystemComponent c_HealingBeamPSC;
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
var () float m_fHUDOverlayZOffset;
var () float m_fHUDOverlayMorphMountedZOffset;
var int m_lastDamageSourceSlot;
var float m_fLastMoveTime;
var TgDeployable s_AttachedProjBlocker;
var () float m_fScaleMesh;
var () float m_fScaleMeshChangePerSecond;
var () float m_fScaleCollisionHeight;
var () float m_fScaleCollisionHeightChangePerSecond;
var () float m_fScaleCollisionRadius;
var () float m_fScaleCollisionRadiusChangePerSecond;
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
var (Mount) float m_fMountScaleOverride;
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

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_bFirstSpawnWave, r_bIsBot, r_bNeedPlaySpawnFx, r_fIntroOffset, r_fIntroTime, r_nHeadSkinId, r_nMountSkinId, r_nPacingType, r_nPawnId, r_nPhysicalType, r_nProfileId, r_nSettingsOverrideId, r_nSkinId, r_nWardSkinId, r_nWeaponSkinId, s_DefaultPropValues;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && !bNetOwner || bDemoRecording) r_CurrentVisibilityVolumes, r_bIsVolumeStealthFading, r_bIsVolumeStealthed;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_BlindingDeployables, r_CurrentPropValues, r_DeathInfo, r_EffectManager, r_HealTarget, r_ObscuringDeployables, r_Owner, r_ReplicatedDeviceState, r_TargetActor, r_VisibleThroughStealthInstigators, r_VisibleThroughWallsInstigators, r_aDebugDestination, r_aDebugNextNav, r_aDebugTarget, r_bDebugShowAIDebug, r_bDisableVolumeStealth, r_bInCombatFlag, r_bIsAFK, r_bIsAnimInStrafeMode, r_bIsLifted, r_bIsMounted, r_bMorphMounted, r_eCurrentStunType, r_eDeathReason, r_eIsStealthed, r_fCachedMaxHealth, r_fInCombatTime, r_fStealthFadeRate, r_nBigTeleportCount, r_nDebugFOV, r_nDebugHearingRange, r_nDebugSightRange, r_nInCombatNonce, r_nInsideTaskForceBase, r_nLiveRespawn, r_nPhase, r_nResetCharacter, r_sDebugAction, r_sDebugFactory, r_sDebugName, r_vDebugNextNavMeshPoint, r_vDebugSpreadoutLocation, r_vDown;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_CloneParentPRI, r_CurrentPolymorph, r_GrabAttachSocket, r_GrabSource, r_PolymorphInstigator, r_ReplicatedState, r_bChargeIgnoreHumanoidBlocking, r_bGrabInterrupted, r_bJustJumped, r_bPhysTweenInterrupted, r_bUseMountPosture, r_bUsePhysFlyingForCharge, r_eChargeState, r_eGrabState, r_eTweenState, r_fChargeInitialPitch, r_fChargeInitialYaw, r_fChargeRange, r_fChargeSpeed, r_fGrabDuration, r_fPhysTweenDuration, r_fRefireSpeed, r_fReloadScale, r_nBodyMeshOverride, r_nCannotBeGrabSource, r_nHeadMeshOverride, r_nPhysTweenFlags, r_nVoicePackId, r_rGrabRotationOffset, r_vChargeInitialLocation, r_vGrabLocationOffset, r_vPhysTweenTarget;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bDemoRecording) r_bDemoCanPurchaseItems;
}

simulated delegate On3pTransitionEvent();

native function bool GetTurnRotatorOverride(out int nYawOffset);  // Export UTgPawn::execGetTurnRotatorOverride(FFrame&, void* const)

native function OnViewTargetChanged(optional Actor aNewViewTarget);  // Export UTgPawn::execOnViewTargetChanged(FFrame&, void* const)

native function int GetUISkillEqpSlotOverride(int nEquipSlot, optional bool bAltSlot=false);  // Export UTgPawn::execGetUISkillEqpSlotOverride(FFrame&, void* const)

native function float GetLagPredictionTime();  // Export UTgPawn::execGetLagPredictionTime(FFrame&, void* const)

native function float GetUnclampedLagPredictionTime();  // Export UTgPawn::execGetUnclampedLagPredictionTime(FFrame&, void* const)

native function Actor GetTargetActor();  // Export UTgPawn::execGetTargetActor(FFrame&, void* const)

native function TgPawn GetTargetPawn();  // Export UTgPawn::execGetTargetPawn(FFrame&, void* const)

native function SetTargetActor(Actor Target);  // Export UTgPawn::execSetTargetActor(FFrame&, void* const)

native function UpdateShieldFX();  // Export UTgPawn::execUpdateShieldFX(FFrame&, void* const)

native function bool AreAnyOtherOffhandsLockingFiring(TgDevice CurrentDevice);  // Export UTgPawn::execAreAnyOtherOffhandsLockingFiring(FFrame&, void* const)

native function UpdateClientDevices(optional bool bForce=false);  // Export UTgPawn::execUpdateClientDevices(FFrame&, void* const)

native function TgDevice GetDeviceByEqPoint(int eEqPoint);  // Export UTgPawn::execGetDeviceByEqPoint(FFrame&, void* const)

native function TgDeviceForm CreateDeviceForm(EquipDeviceInfo Info);  // Export UTgPawn::execCreateDeviceForm(FFrame&, void* const)

native function DeviceFormChanged(optional bool bForceReload=false);  // Export UTgPawn::execDeviceFormChanged(FFrame&, void* const)

native function bool ApplyPawnSetup();  // Export UTgPawn::execApplyPawnSetup(FFrame&, void* const)

native function InitializeDefaultProps();  // Export UTgPawn::execInitializeDefaultProps(FFrame&, void* const)

native function AddProperty(int nPropId, float fBase, float fRaw, float FMin, float FMax);  // Export UTgPawn::execAddProperty(FFrame&, void* const)

native function TgProperty GetProperty(int nPropIndex);  // Export UTgPawn::execGetProperty(FFrame&, void* const)

native function TgProperty GetPropertyById(int nPropId);  // Export UTgPawn::execGetPropertyById(FFrame&, void* const)

native function SetProperty(int nPropIndex, float fNewValue);  // Export UTgPawn::execSetProperty(FFrame&, void* const)

native function SetPropCurrentValue(int nPropIndex, float nNewValue);  // Export UTgPawn::execSetPropCurrentValue(FFrame&, void* const)

native function ResetProperties();  // Export UTgPawn::execResetProperties(FFrame&, void* const)

native function float GetSlowDiminishing();  // Export UTgPawn::execGetSlowDiminishing(FFrame&, void* const)

native function bool IsDebuffImmune();  // Export UTgPawn::execIsDebuffImmune(FFrame&, void* const)

native function bool IsDamageOverTimeImmune();  // Export UTgPawn::execIsDamageOverTimeImmune(FFrame&, void* const)

native function bool IsSuperiorCrowdControlImmune();  // Export UTgPawn::execIsSuperiorCrowdControlImmune(FFrame&, void* const)

native function bool IsCrowdControlImmune();  // Export UTgPawn::execIsCrowdControlImmune(FFrame&, void* const)

native function CrowdControlBreak();  // Export UTgPawn::execCrowdControlBreak(FFrame&, void* const)

native function bool SpecialAOEImmunity(Vector AOECenter, TgDeviceFire instigatingFiremode);  // Export UTgPawn::execSpecialAOEImmunity(FFrame&, void* const)

native function int DrawScaledString(Canvas CanvasToUse, float StartX, float StartY, string NameString, Font NameFont, Color NameColor, float Scale);  // Export UTgPawn::execDrawScaledString(FFrame&, void* const)

native function int DrawNameText(Canvas CanvasToUse, float StartX, float StartY, string NameString, Font NameFont, Color NameColor, float Scale);  // Export UTgPawn::execDrawNameText(FFrame&, void* const)

native function Vector NativeCanvasProject(Canvas CanvasToUse, Vector vLocation);  // Export UTgPawn::execNativeCanvasProject(FFrame&, void* const)

native function FlashResetReplication();  // Export UTgPawn::execFlashResetReplication(FFrame&, void* const)

native function FlashFireMode(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashFireMode(FFrame&, void* const)

native function FlashTargeting(int nDeviceInstanceId, int nFireModeNum, optional int nEquipSlot, optional int nSocketIndex, optional bool bSuccessfulHit);  // Export UTgPawn::execFlashTargeting(FFrame&, void* const)

native function FlashBuildUp(int nDeviceInstanceId, int nFireModeNum, optional int nEquipSlot, optional int nSocketIndex, optional float fBuildupTime=0.0000000);  // Export UTgPawn::execFlashBuildUp(FFrame&, void* const)

native function FlashPlayEmote(TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execFlashPlayEmote(FFrame&, void* const)

native function FlashPlayEmoteExcludeOwner(TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execFlashPlayEmoteExcludeOwner(FFrame&, void* const)

native function FlashFire(int nDeviceInstanceId, int nFireModeNum, Vector vNewLoc, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit, optional float RefireTime);  // Export UTgPawn::execFlashFire(FFrame&, void* const)

native function FlashFireMulti(int nDeviceInstanceId, int nFireModeNum, Vector vAimStart, Vector vAimDir, array<float> hitRanges, float fMaxRange, int nSeed, float fSpreadAngle, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit, optional float RefireTime);  // Export UTgPawn::execFlashFireMulti(FFrame&, void* const)

native function FlashFireNoSim(int nDeviceInstanceId, int nFireModeNum, Vector vNewLoc, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit, optional float RefireTime);  // Export UTgPawn::execFlashFireNoSim(FFrame&, void* const)

native function FlashArcing(int nDeviceInstanceId, int nFireModeNum, Vector vNewLoc, Vector vOldLoc, Actor Target, optional int nEquipSlot, optional int nSocketIndex, optional bool bsuccesfulhit);  // Export UTgPawn::execFlashArcing(FFrame&, void* const)

native function FlashStopFire(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashStopFire(FFrame&, void* const)

native function FlashStartFire(int nDeviceInstanceId, int nFireModeNum, float RefireTime, Actor Target, optional int nAmmoRemaining=0);  // Export UTgPawn::execFlashStartFire(FFrame&, void* const)

native function FlashReload(int nDeviceInstanceId, float fReloadTime, optional int nAmmoRemaining=0, optional int nReloadAnimType=0);  // Export UTgPawn::execFlashReload(FFrame&, void* const)

native function FlashCooldown(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashCooldown(FFrame&, void* const)

native function FlashCooldownDone(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashCooldownDone(FFrame&, void* const)

native function FlashBlock(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashBlock(FFrame&, void* const)

native function FlashBlockFx(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashBlockFx(FFrame&, void* const)

native function FlashBlockDone(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashBlockDone(FFrame&, void* const)

native function FlashInterrupt(int nDeviceInstanceId);  // Export UTgPawn::execFlashInterrupt(FFrame&, void* const)

native function FlashSuccessfulHit(int nDeviceInstanceId, int nFireModeNum, Actor Target, float DamageAmount, Vector HitLocation, Vector HitNormal, optional ExtraDamageInfo ExtraInfo);  // Export UTgPawn::execFlashSuccessfulHit(FFrame&, void* const)

native function FlashEventUpdate();  // Export UTgPawn::execFlashEventUpdate(FFrame&, void* const)

native function FlashModeEquipDone(int nDeviceInstanceId, int nFireModeNum);  // Export UTgPawn::execFlashModeEquipDone(FFrame&, void* const)

native function FlashHitReaction();  // Export UTgPawn::execFlashHitReaction(FFrame&, void* const)

native function FlashDestruct(int nDeviceInstanceId, Vector vLocation);  // Export UTgPawn::execFlashDestruct(FFrame&, void* const)

native function FlashChangeMesh();  // Export UTgPawn::execFlashChangeMesh(FFrame&, void* const)

native function FlashTeleportFx(int nTeleportState, Vector vLocation);  // Export UTgPawn::execFlashTeleportFx(FFrame&, void* const)

native function FlashLevelupFx();  // Export UTgPawn::execFlashLevelupFx(FFrame&, void* const)

native function FlashPlaySpecialEffect(int PlaySpecialEffectIndex, optional Vector vLocation, optional Vector vHitNormal, optional Actor inActor);  // Export UTgPawn::execFlashPlaySpecialEffect(FFrame&, void* const)

native function FlashSpawnSpecialFX(int nFxID, Vector vLocation, optional Vector vNormal);  // Export UTgPawn::execFlashSpawnSpecialFX(FFrame&, void* const)

native function FlashPetSuccessfulHit(int nFxID);  // Export UTgPawn::execFlashPetSuccessfulHit(FFrame&, void* const)

native function FlashGeneric1(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated=false, optional byte byExtraData=0);  // Export UTgPawn::execFlashGeneric1(FFrame&, void* const)

native function FlashGeneric2(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated=false, optional byte byExtraData=0);  // Export UTgPawn::execFlashGeneric2(FFrame&, void* const)

native function FlashGeneric3(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated=false, optional byte byExtraData=0);  // Export UTgPawn::execFlashGeneric3(FFrame&, void* const)

native function FlashGeneric4(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated=false, optional byte byExtraData=0);  // Export UTgPawn::execFlashGeneric4(FFrame&, void* const)

native function FlashGeneric5(int nDeviceInstanceId, int nFireModeNum, optional bool bIsSimulated=false, optional byte byExtraData=0);  // Export UTgPawn::execFlashGeneric5(FFrame&, void* const)

native function FlashTransitionIn(int nDeviceInstanceId, int nFireModeNum, float fTransitionPercent, float fTotalTransitionTime);  // Export UTgPawn::execFlashTransitionIn(FFrame&, void* const)

native function FlashTransitionOut(int nDeviceInstanceId, int nFireModeNum, float fTransitionPercent, float fTotalTransitionTime);  // Export UTgPawn::execFlashTransitionOut(FFrame&, void* const)

native function FlashHitDirection(Vector vLocation, int nDamageAmount, Class<DamageType> DamageType, const out ExtraDamageInfo ExtraInfo);  // Export UTgPawn::execFlashHitDirection(FFrame&, void* const)

native function FlashKillOrAssist(Actor Target, bool bIsKill);  // Export UTgPawn::execFlashKillOrAssist(FFrame&, void* const)

native function ReapplyLevelEffectGroups(optional int nPrevLevel=0, optional int nCurrentLevel=0, optional bool bPreserveParams=false);  // Export UTgPawn::execReapplyLevelEffectGroups(FFrame&, void* const)

native function ReapplyLoadoutEffects(optional bool bKeepFiringMount);  // Export UTgPawn::execReapplyLoadoutEffects(FFrame&, void* const)

native function bool bIsEditor();  // Export UTgPawn::execbIsEditor(FFrame&, void* const)

native function DrawClientDebug();  // Export UTgPawn::execDrawClientDebug(FFrame&, void* const)

native function ShowCombo(int nPawnId, optional bool bCrit=false);  // Export UTgPawn::execShowCombo(FFrame&, void* const)

native function OnSpawnGatesOpened();  // Export UTgPawn::execOnSpawnGatesOpened(FFrame&, void* const)

native function bool TermRagdoll();  // Export UTgPawn::execTermRagdoll(FFrame&, void* const)

native function CancelEmote(optional bool bVerifyNoRelevantEmotes, optional TgAnimNodeEmoteSequence Exclude);  // Export UTgPawn::execCancelEmote(FFrame&, void* const)

native function AddRemoveAnimSetList(array<AnimSet> AnimSetList, bool bAdd);  // Export UTgPawn::execAddRemoveAnimSetList(FFrame&, void* const)

native function float GetGravityZ();  // Export UTgPawn::execGetGravityZ(FFrame&, void* const)

native function bool IsJumpDisabled();  // Export UTgPawn::execIsJumpDisabled(FFrame&, void* const)

native function bool CanSeeActor(Actor Other);  // Export UTgPawn::execCanSeeActor(FFrame&, void* const)

native function SetMeshVisibility(bool bVisible);  // Export UTgPawn::execSetMeshVisibility(FFrame&, void* const)

native function TgSpecialFx GetSpecialFx(int nSpecialFxId);  // Export UTgPawn::execGetSpecialFx(FFrame&, void* const)

native function MeshComponent CreateMeshComponent(int nMeshId, optional MeshComponent DestComponent, optional bool bPartialFixup=false);  // Export UTgPawn::execCreateMeshComponent(FFrame&, void* const)

native function AddPet(TgPawn PetPawn);  // Export UTgPawn::execAddPet(FFrame&, void* const)

native function SetPetOwner(TgPawn petOwner);  // Export UTgPawn::execSetPetOwner(FFrame&, void* const)

native function KillPet(TgPawn PetPawn);  // Export UTgPawn::execKillPet(FFrame&, void* const)

native function KillPets();  // Export UTgPawn::execKillPets(FFrame&, void* const)

native function bool IsMyPet(Actor Other);  // Export UTgPawn::execIsMyPet(FFrame&, void* const)

native function ReportPetDeath(TgPawn PetPawn);  // Export UTgPawn::execReportPetDeath(FFrame&, void* const)

native function KillOwnedBots();  // Export UTgPawn::execKillOwnedBots(FFrame&, void* const)

native function AdjustMeshTranslation();  // Export UTgPawn::execAdjustMeshTranslation(FFrame&, void* const)

native function SetTaskForceNumber(int nTaskForce);  // Export UTgPawn::execSetTaskForceNumber(FFrame&, void* const)

native function byte GetTaskForceNumber();  // Export UTgPawn::execGetTaskForceNumber(FFrame&, void* const)

native function TgRepInfo_Player GetPRI();  // Export UTgPawn::execGetPRI(FFrame&, void* const)

native function float GetAccuracyModifier(optional float ClientMovementTimeStamp);  // Export UTgPawn::execGetAccuracyModifier(FFrame&, void* const)

native function ModifyAccuracyForReticleBloom(out float fAccuracy);  // Export UTgPawn::execModifyAccuracyForReticleBloom(FFrame&, void* const)

native function ValidateStatsTracker();  // Export UTgPawn::execValidateStatsTracker(FFrame&, void* const)

native function StatsCleanup();  // Export UTgPawn::execStatsCleanup(FFrame&, void* const)

native function BeginStats();  // Export UTgPawn::execBeginStats(FFrame&, void* const)

native function EndStats();  // Export UTgPawn::execEndStats(FFrame&, void* const)

native function TrackDamagedPlayer(TgPawn TargetPawn, int nDeviceModeID, int nDamage, int nDamageType, bool bInHand);  // Export UTgPawn::execTrackDamagedPlayer(FFrame&, void* const)

native function TrackDamagedBot(TgPawn TargetPawn, int nDeviceModeID, int nDamage, int nDamageType, optional bool bIsGod);  // Export UTgPawn::execTrackDamagedBot(FFrame&, void* const)

native function TrackKilledPlayer(int nDeviceModeID);  // Export UTgPawn::execTrackKilledPlayer(FFrame&, void* const)

native function TrackFromPlayerDeath(int nDeviceModeID);  // Export UTgPawn::execTrackFromPlayerDeath(FFrame&, void* const)

native function TrackKilledBot(int nDeviceModeID);  // Export UTgPawn::execTrackKilledBot(FFrame&, void* const)

native function TrackHealing(int nDeviceModeID, float fDamage, float fMissingHealth, int nMaxHealth);  // Export UTgPawn::execTrackHealing(FFrame&, void* const)

native function TrackSelfHealing(float fHealing, float fMissingHealth, int nMaxHealth);  // Export UTgPawn::execTrackSelfHealing(FFrame&, void* const)

native function TrackBotHealing(int nDeviceModeID, float fDamage, float fMissingHealth, int nMaxHealth);  // Export UTgPawn::execTrackBotHealing(FFrame&, void* const)

native function TrackFired(int nDeviceModeID);  // Export UTgPawn::execTrackFired(FFrame&, void* const)

native function TrackCompleteKillInfo(int nKillerCharacterID, int nKillerDeviceModeID, int nVictimCharacterID, int nVictimDeviceModeID, Vector KillerLocation, Vector VictimLocation, Vector PetLocation, bool bPetKill);  // Export UTgPawn::execTrackCompleteKillInfo(FFrame&, void* const)

native function RemoveTrackFired(int nDeviceModeID);  // Export UTgPawn::execRemoveTrackFired(FFrame&, void* const)

native function TrackHit(int nDeviceModeID, float fDistance, bool bHitPlayer);  // Export UTgPawn::execTrackHit(FFrame&, void* const)

native function TrackReleaseTime(int nDeviceModeID, float fReleaseTime);  // Export UTgPawn::execTrackReleaseTime(FFrame&, void* const)

native function TrackTeamDamage(int nDeviceModeID, int nDamage);  // Export UTgPawn::execTrackTeamDamage(FFrame&, void* const)

native function TrackSelfDamage(int nDeviceModeID, int nDamage);  // Export UTgPawn::execTrackSelfDamage(FFrame&, void* const)

native function TrackTeamKill(int nDeviceModeID);  // Export UTgPawn::execTrackTeamKill(FFrame&, void* const)

native function TrackSelfKill(int nDeviceModeID);  // Export UTgPawn::execTrackSelfKill(FFrame&, void* const)

native function TrackDamageTaken(TgPawn theInstigator, int nDamage, int nDamageType);  // Export UTgPawn::execTrackDamageTaken(FFrame&, void* const)

native function TrackDamageMitigated(int nAmount);  // Export UTgPawn::execTrackDamageMitigated(FFrame&, void* const)

native function UpdateDamagers(TgPawn Damager);  // Export UTgPawn::execUpdateDamagers(FFrame&, void* const)

native function UpdateEnemyAssists(TgPawn Assister);  // Export UTgPawn::execUpdateEnemyAssists(FFrame&, void* const)

native function TrackKill(TgPawn Killer);  // Export UTgPawn::execTrackKill(FFrame&, void* const)

native function TrackDeath();  // Export UTgPawn::execTrackDeath(FFrame&, void* const)

native function UpdateHUDScores();  // Export UTgPawn::execUpdateHUDScores(FFrame&, void* const)

native function SetPhase(int nNewPhase);  // Export UTgPawn::execSetPhase(FFrame&, void* const)

native function PlaySoundCue(int nSoundCueId);  // Export UTgPawn::execPlaySoundCue(FFrame&, void* const)

native function bool ShouldPawnMeshBeHiddenThisTick();  // Export UTgPawn::execShouldPawnMeshBeHiddenThisTick(FFrame&, void* const)

native function bool ShouldInHandDeviceBeHiddenThisTick();  // Export UTgPawn::execShouldInHandDeviceBeHiddenThisTick(FFrame&, void* const)

native function bool IsInvisibleToAI();  // Export UTgPawn::execIsInvisibleToAI(FFrame&, void* const)

native function bool IsHittable();  // Export UTgPawn::execIsHittable(FFrame&, void* const)

native function CalcVolumeFadeValue(float fDeltaTime);  // Export UTgPawn::execCalcVolumeFadeValue(FFrame&, void* const)

native function CalcDistanceFadeValue(float fDeltaTime);  // Export UTgPawn::execCalcDistanceFadeValue(FFrame&, void* const)

native function CalcStealthFadeValue(float fDeltaTime);  // Export UTgPawn::execCalcStealthFadeValue(FFrame&, void* const)

native function CalcObscuringDeployableFadeValue(float fDeltaTime);  // Export UTgPawn::execCalcObscuringDeployableFadeValue(FFrame&, void* const)

native function CalcBlindingDeployableFadeValue(float fDeltaTime);  // Export UTgPawn::execCalcBlindingDeployableFadeValue(FFrame&, void* const)

native function bool OverrideDistanceFadeRange();  // Export UTgPawn::execOverrideDistanceFadeRange(FFrame&, void* const)

native function bool ShouldShowHudOverlay(TgPawn PlayerPawn);  // Export UTgPawn::execShouldShowHudOverlay(FFrame&, void* const)

native function bool CanBeAffectedByVortices();  // Export UTgPawn::execCanBeAffectedByVortices(FFrame&, void* const)

native function ForceRecalculateMaterial();  // Export UTgPawn::execForceRecalculateMaterial(FFrame&, void* const)

native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);  // Export UTgPawn::execRecalculateMaterial(FFrame&, void* const)

native function UpdateDropShadow();  // Export UTgPawn::execUpdateDropShadow(FFrame&, void* const)

native function UpdateStealthMaterialBasedOnNearbyEnemies();  // Export UTgPawn::execUpdateStealthMaterialBasedOnNearbyEnemies(FFrame&, void* const)

native function SetScalarMaterialParamOnMesh(MeshComponent MeshComp, string sName, float fValue, optional int nMaterialIndex=-1);  // Export UTgPawn::execSetScalarMaterialParamOnMesh(FFrame&, void* const)

native function float GetTerminalVelocity();  // Export UTgPawn::execGetTerminalVelocity(FFrame&, void* const)

native function PlayCurrencyFx(TgRepInfo_Player sourcePRI, int nCurrency, int nMsgId);  // Export UTgPawn::execPlayCurrencyFx(FFrame&, void* const)

native function PlayTeleportFx(int nTeleportState, Vector vLoc);  // Export UTgPawn::execPlayTeleportFx(FFrame&, void* const)

native function PlaySpecialEffectEvent(int PlaySpecialEffectIndex, Vector vLoc, Vector vHitNormal, optional Actor inActor);  // Export UTgPawn::execPlaySpecialEffectEvent(FFrame&, void* const)

simulated function PrepareIntro() { }

simulated function PlaySpawnFx() { }

native function OnPawnDied();  // Export UTgPawn::execOnPawnDied(FFrame&, void* const)

native function UpdatePhysicsAsset();  // Export UTgPawn::execUpdatePhysicsAsset(FFrame&, void* const)

native function TgDevice GetDeviceByInstanceId(int nDeviceInstanceId);  // Export UTgPawn::execGetDeviceByInstanceId(FFrame&, void* const)

native function TgDevice GetDeviceById(int nDeviceId);  // Export UTgPawn::execGetDeviceById(FFrame&, void* const)

native function bool ShouldBlockFiringFrom1pSwitch();  // Export UTgPawn::execShouldBlockFiringFrom1pSwitch(FFrame&, void* const)

native function TgDevice GetCurrentInhandDevice();  // Export UTgPawn::execGetCurrentInhandDevice(FFrame&, void* const)

native function bool IsStealthed(TgRepInfo_Player Viewer);  // Export UTgPawn::execIsStealthed(FFrame&, void* const)

native function bool IsHardStealthed();  // Export UTgPawn::execIsHardStealthed(FFrame&, void* const)

native function bool IsHardRevealed(TgRepInfo_Player Viewer);  // Export UTgPawn::execIsHardRevealed(FFrame&, void* const)

native function bool IsDetector();  // Export UTgPawn::execIsDetector(FFrame&, void* const)

native function PlayDetectedFx();  // Export UTgPawn::execPlayDetectedFx(FFrame&, void* const)

native function RemoveDetectedFx();  // Export UTgPawn::execRemoveDetectedFx(FFrame&, void* const)

native function int NumVisibilityVolumesTouching();  // Export UTgPawn::execNumVisibilityVolumesTouching(FFrame&, void* const)

native function int FindVisibilityVolume(TgVisibilityVolume VisVolume);  // Export UTgPawn::execFindVisibilityVolume(FFrame&, void* const)

native function bool IsInSameVisibilityVolume(TgPawn Other);  // Export UTgPawn::execIsInSameVisibilityVolume(FFrame&, void* const)

native function bool IsInSameVisibilityVolumeBeacon(TgRespawnBeaconExit Other);  // Export UTgPawn::execIsInSameVisibilityVolumeBeacon(FFrame&, void* const)

native function TgVisibilityVolume GetATouchingVisibilityVolume();  // Export UTgPawn::execGetATouchingVisibilityVolume(FFrame&, void* const)

native function bool IsInFriendlyObscuringDeployable();  // Export UTgPawn::execIsInFriendlyObscuringDeployable(FFrame&, void* const)

native function bool IsInCommonEnemyObscuringDeployable(TgPawn Viewer);  // Export UTgPawn::execIsInCommonEnemyObscuringDeployable(FFrame&, void* const)

native function bool IsInEnemyObscuringDeployable(TgPawn Viewer);  // Export UTgPawn::execIsInEnemyObscuringDeployable(FFrame&, void* const)

native function bool IsDeployableObscuredFrom(TgPawn Viewer);  // Export UTgPawn::execIsDeployableObscuredFrom(FFrame&, void* const)

native function bool IsDeployableBlindedFrom(Actor Viewer);  // Export UTgPawn::execIsDeployableBlindedFrom(FFrame&, void* const)

native function bool LocalPlayerHasLOS();  // Export UTgPawn::execLocalPlayerHasLOS(FFrame&, void* const)

native function Vector GetLocation();  // Export UTgPawn::execGetLocation(FFrame&, void* const)

native function KillDeployables(bool bAll);  // Export UTgPawn::execKillDeployables(FFrame&, void* const)

native function SetMeshScalarValue(name ScalarParam, float ScalarValue);  // Export UTgPawn::execSetMeshScalarValue(FFrame&, void* const)

native function SetMeshVectorValue(name ScalarParam, const out LinearColor ColorValue);  // Export UTgPawn::execSetMeshVectorValue(FFrame&, void* const)

native function SetMeshComponentScalarValue(MeshComponent theMesh, name ScalarParam, float ScalarValue);  // Export UTgPawn::execSetMeshComponentScalarValue(FFrame&, void* const)

native function SetMeshComponentVectorValue(MeshComponent theMesh, name ScalarParam, const out LinearColor ColorValue);  // Export UTgPawn::execSetMeshComponentVectorValue(FFrame&, void* const)

native function float GetHealthPercent();  // Export UTgPawn::execGetHealthPercent(FFrame&, void* const)

native function float GetManaPercent();  // Export UTgPawn::execGetManaPercent(FFrame&, void* const)

native function SyncMana();  // Export UTgPawn::execSyncMana(FFrame&, void* const)

native function RegainPools(float fDelta);  // Export UTgPawn::execRegainPools(FFrame&, void* const)

native function RegainManaPool(float fDelta);  // Export UTgPawn::execRegainManaPool(FFrame&, void* const)

native function RegainEnergyPool(float fDelta);  // Export UTgPawn::execRegainEnergyPool(FFrame&, void* const)

native function bool IsFriendlyWithLocalPawn();  // Export UTgPawn::execIsFriendlyWithLocalPawn(FFrame&, void* const)

native function bool PlayFullBodyAnim(name AnimName, float Rate, float BlendInTime, float BlendOutTime, bool bLooping, bool bOverride, optional bool bBlendOutIfVelocityIsGreaterThanZero, optional bool bHideInHandDevice);  // Export UTgPawn::execPlayFullBodyAnim(FFrame&, void* const)

native function float PlayFullBodyLoopingAnimWithTransition(name TransitionAnimName, name LoopingAnimName, float Rate, float BlendInTime, float BlendOutTime);  // Export UTgPawn::execPlayFullBodyLoopingAnimWithTransition(FFrame&, void* const)

native function PlayUpperBodyAnim(name AnimName, float Rate, float BlendInTime, float BlendOutTime, bool bLooping);  // Export UTgPawn::execPlayUpperBodyAnim(FFrame&, void* const)

native function bool CanMove();  // Export UTgPawn::execCanMove(FFrame&, void* const)

native function bool IsNonCombat();  // Export UTgPawn::execIsNonCombat(FFrame&, void* const)

native function LoadDazedMIC(int FxId);  // Export UTgPawn::execLoadDazedMIC(FFrame&, void* const)

native function float DazedStrafeOffset(float OffsetFromWorldTime);  // Export UTgPawn::execDazedStrafeOffset(FFrame&, void* const)

native function Vector2D DazedRotatorOffset(float OffsetFromWorldTime);  // Export UTgPawn::execDazedRotatorOffset(FFrame&, void* const)

native function PlayCustomAnimation(int nAnimResId, bool bFullBody, float fTime);  // Export UTgPawn::execPlayCustomAnimation(FFrame&, void* const)

native function UpdatePlayerStatUI();  // Export UTgPawn::execUpdatePlayerStatUI(FFrame&, void* const)

native function UpdateSpectatorStatUI();  // Export UTgPawn::execUpdateSpectatorStatUI(FFrame&, void* const)

native function ForceUpdateComponents(optional bool bCollisionUpdate=false, optional bool bTransformOnly=true);  // Export UTgPawn::execForceUpdateComponents(FFrame&, void* const)

native function float AdjustRespawnTime(float InRespawnTime);  // Export UTgPawn::execAdjustRespawnTime(FFrame&, void* const)

native function bool IsGod();  // Export UTgPawn::execIsGod(FFrame&, void* const)

native function bool IsGodDecoy();  // Export UTgPawn::execIsGodDecoy(FFrame&, void* const)

native function bool IsStatTrackable();  // Export UTgPawn::execIsStatTrackable(FFrame&, void* const)

native function Rotator TweenRelRotation(float fDeltaSeconds, Rotator currRel, Rotator targetRel);  // Export UTgPawn::execTweenRelRotation(FFrame&, void* const)

native function ResetSkelControls(SkeletalMeshComponent SkelComp);  // Export UTgPawn::execResetSkelControls(FFrame&, void* const)

native function bool IsGrabBreakable(TgPawn.EGrabState tweenState);  // Export UTgPawn::execIsGrabBreakable(FFrame&, void* const)

native function bool IsInOffensiveGrab();  // Export UTgPawn::execIsInOffensiveGrab(FFrame&, void* const)

native function bool IsPerformingOffensiveGrab();  // Export UTgPawn::execIsPerformingOffensiveGrab(FFrame&, void* const)

native function bool IsTweenBreakable(TgPawn.ETweenState tweenState);  // Export UTgPawn::execIsTweenBreakable(FFrame&, void* const)

native function bool IsInOffensiveTween();  // Export UTgPawn::execIsInOffensiveTween(FFrame&, void* const)

native function bool IsConfused();  // Export UTgPawn::execIsConfused(FFrame&, void* const)

native function bool ShouldBeFirstPersonThisTick();  // Export UTgPawn::execShouldBeFirstPersonThisTick(FFrame&, void* const)

native function GiveEnergy(float energy);  // Export UTgPawn::execGiveEnergy(FFrame&, void* const)

native function bool AllowBoostedJump();  // Export UTgPawn::execAllowBoostedJump(FFrame&, void* const)

native function UpdateRespawnBeaconReticule(optional bool bForce);  // Export UTgPawn::execUpdateRespawnBeaconReticule(FFrame&, void* const)

native function TryToPlayPainAkEvent();  // Export UTgPawn::execTryToPlayPainAkEvent(FFrame&, void* const)

native function SmoothCorrectionTranslationTick(float DeltaSeconds, optional bool bForce);  // Export UTgPawn::execSmoothCorrectionTranslationTick(FFrame&, void* const)

native function SetUncompressedRemoteViewPitch(int Pitch);  // Export UTgPawn::execSetUncompressedRemoteViewPitch(FFrame&, void* const)

native function ForceUpdateUncompressedRemoteYaw();  // Export UTgPawn::execForceUpdateUncompressedRemoteYaw(FFrame&, void* const)

native function ReloadMeshAssemblies();  // Export UTgPawn::execReloadMeshAssemblies(FFrame&, void* const)

native function Vector GetChargeDirection();  // Export UTgPawn::execGetChargeDirection(FFrame&, void* const)

native simulated function PhysicalMaterial TraceWorldPhysicalGeometry(Vector StartLoc, Vector EndLoc, out Vector TraceHitLocation);  // Export UTgPawn::execTraceWorldPhysicalGeometry(FFrame&, void* const)

native function bool MySpawnGatesAreOpen();  // Export UTgPawn::execMySpawnGatesAreOpen(FFrame&, void* const)

native function SetAkPlayerHealthPercent(float fPercent);  // Export UTgPawn::execSetAkPlayerHealthPercent(FFrame&, void* const)

native function UpdateReverbVolume(Vector WorldLocation, optional ReverbVolume VolumeTouched);  // Export UTgPawn::execUpdateReverbVolume(FFrame&, void* const)

native function ReverbVolume GetCurrentReverbVolume();  // Export UTgPawn::execGetCurrentReverbVolume(FFrame&, void* const)

native function ReverbVolume GettReverbVolumeForAudioAltitude();  // Export UTgPawn::execGettReverbVolumeForAudioAltitude(FFrame&, void* const)

native function PostAkEvent(AkEvent InAkEvent);  // Export UTgPawn::execPostAkEvent(FFrame&, void* const)

native function PostEmoteAkEvent(AkEvent InAkEvent, TgPawn.EEmote Emote);  // Export UTgPawn::execPostEmoteAkEvent(FFrame&, void* const)

native function bool IsCinematicMode();  // Export UTgPawn::execIsCinematicMode(FFrame&, void* const)

native function float GetHealth();  // Export UTgPawn::execGetHealth(FFrame&, void* const)

native function float GetMaxHealth();  // Export UTgPawn::execGetMaxHealth(FFrame&, void* const)

native function float GetMana();  // Export UTgPawn::execGetMana(FFrame&, void* const)

native function float GetMaxMana();  // Export UTgPawn::execGetMaxMana(FFrame&, void* const)

native function float GetShieldHealth();  // Export UTgPawn::execGetShieldHealth(FFrame&, void* const)

native function float GetMaxShield();  // Export UTgPawn::execGetMaxShield(FFrame&, void* const)

native function bool CanTakeHealthDamage();  // Export UTgPawn::execCanTakeHealthDamage(FFrame&, void* const)

native function bool CanDealHeadShots();  // Export UTgPawn::execCanDealHeadShots(FFrame&, void* const)

native function bool CanTakeHeadShots();  // Export UTgPawn::execCanTakeHeadShots(FFrame&, void* const)

native function bool OnlyTakeHeadShots();  // Export UTgPawn::execOnlyTakeHeadShots(FFrame&, void* const)

native function bool IsImmuneToDamage();  // Export UTgPawn::execIsImmuneToDamage(FFrame&, void* const)

native function bool CanBeExecuted();  // Export UTgPawn::execCanBeExecuted(FFrame&, void* const)

native function bool IsImmuneToHealing();  // Export UTgPawn::execIsImmuneToHealing(FFrame&, void* const)

native function BuffDamage(Actor Target, TgEffectDamage Effect, ImpactInfo Impact, float fBaseDamage, out float fProratedAmount, out ExtraDamageInfo ExtraInfo);  // Export UTgPawn::execBuffDamage(FFrame&, void* const)

native function float GetSpecialDamageDealtPercentAI();  // Export UTgPawn::execGetSpecialDamageDealtPercentAI(FFrame&, void* const)

native function float GetSpecialDamageTakenPercentAI();  // Export UTgPawn::execGetSpecialDamageTakenPercentAI(FFrame&, void* const)

native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgPawn::execMitigateHealthDamage(FFrame&, void* const)

native function float GetDamageReductionPerc(TgDevice damageDev, TgEffectGroup eg);  // Export UTgPawn::execGetDamageReductionPerc(FFrame&, void* const)

native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgPawn::execTakeHealthDamage(FFrame&, void* const)

native function bool WillHitSuccessfully(Actor aInstigator, ImpactInfo Impact);  // Export UTgPawn::execWillHitSuccessfully(FFrame&, void* const)

native function bool CanBeLifestealInstigator();  // Export UTgPawn::execCanBeLifestealInstigator(FFrame&, void* const)

native function bool CanBeLifestealTarget();  // Export UTgPawn::execCanBeLifestealTarget(FFrame&, void* const)

native function bool CanTakeManaDamage();  // Export UTgPawn::execCanTakeManaDamage(FFrame&, void* const)

native function TakeManaDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgPawn::execTakeManaDamage(FFrame&, void* const)

native function bool CanTakeShieldDamage();  // Export UTgPawn::execCanTakeShieldDamage(FFrame&, void* const)

native function bool CanUsePersonalShield();  // Export UTgPawn::execCanUsePersonalShield(FFrame&, void* const)

native function int TakePersonalShieldDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgPawn::execTakePersonalShieldDamage(FFrame&, void* const)

native function bool ShieldDamageAppliesToHealth();  // Export UTgPawn::execShieldDamageAppliesToHealth(FFrame&, void* const)

native function TakeStealthDamage(float fDamage);  // Export UTgPawn::execTakeStealthDamage(FFrame&, void* const)

native function float GetDamageToLeaveStealth();  // Export UTgPawn::execGetDamageToLeaveStealth(FFrame&, void* const)

native function HandleNotificationsForAI(float fStatChange, TgPawn InstigatorPawn);  // Export UTgPawn::execHandleNotificationsForAI(FFrame&, void* const)

native function float GetPropCurrentValue(int nPropIndex);  // Export UTgPawn::execGetPropCurrentValue(FFrame&, void* const)

native function float GetPropCurrentValueByName(string propName);  // Export UTgPawn::execGetPropCurrentValueByName(FFrame&, void* const)

native function int GetPropIndex(int nPropId);  // Export UTgPawn::execGetPropIndex(FFrame&, void* const)

native function float GetMarkedPercent(Actor InstigatorPawn);  // Export UTgPawn::execGetMarkedPercent(FFrame&, void* const)

native function float GetMarkedPercentInhand(Actor InstigatorPawn);  // Export UTgPawn::execGetMarkedPercentInhand(FFrame&, void* const)

native function bool IsMarkedForMarkShot();  // Export UTgPawn::execIsMarkedForMarkShot(FFrame&, void* const)

native function TgEffectManager GetEffectManager();  // Export UTgPawn::execGetEffectManager(FFrame&, void* const)

native function TgCombatActor.GameplayDesignType GetDesignType();  // Export UTgPawn::execGetDesignType(FFrame&, void* const)

native function bool IsPet();  // Export UTgPawn::execIsPet(FFrame&, void* const)

native function Actor GetPetOwner();  // Export UTgPawn::execGetPetOwner(FFrame&, void* const)

native function CheckUiVolumeTriggers();  // Export UTgPawn::execCheckUiVolumeTriggers(FFrame&, void* const)

native function Vector GetTargetCenter();  // Export UTgPawn::execGetTargetCenter(FFrame&, void* const)

native function bool NativeReplicatedEvent(name VarName);  // Export UTgPawn::execNativeReplicatedEvent(FFrame&, void* const)

native function OnLevelUp();  // Export UTgPawn::execOnLevelUp(FFrame&, void* const)

native function OnProjectileExploded(TgProjectile ExplodedProjectile, Actor HitActor, Vector HitLocation, Vector HitNormal);  // Export UTgPawn::execOnProjectileExploded(FFrame&, void* const)

native function OnProjectileHitTarget(TgProjectile HittingProjectile, Vector HitLocation, Vector HitNormal, out byte bDestroyProjectile);  // Export UTgPawn::execOnProjectileHitTarget(FFrame&, void* const)

native function OnPostureChange();  // Export UTgPawn::execOnPostureChange(FFrame&, void* const)

native function float NativeGetCollisionHeight();  // Export UTgPawn::execNativeGetCollisionHeight(FFrame&, void* const)

native function float NativeGetCollisionRadius();  // Export UTgPawn::execNativeGetCollisionRadius(FFrame&, void* const)

native function OnSetPlayerLevel(TgSeqAct_SetPlayerLevel Action);  // Export UTgPawn::execOnSetPlayerLevel(FFrame&, void* const)

native function float GetAirControl();  // Export UTgPawn::execGetAirControl(FFrame&, void* const)

native function bool CanKnockbackAffectAC();  // Export UTgPawn::execCanKnockbackAffectAC(FFrame&, void* const)

native function bool IsInFireLock();  // Export UTgPawn::execIsInFireLock(FFrame&, void* const)

native function ConsumePowerPool(TgDevice Dev, int nPacingType, float fAmount);  // Export UTgPawn::execConsumePowerPool(FFrame&, void* const)

native function float GetCurrentPowerPoolValue(int nPacingType);  // Export UTgPawn::execGetCurrentPowerPoolValue(FFrame&, void* const)

native function float GetMaxPowerPoolValue(int nPacingType);  // Export UTgPawn::execGetMaxPowerPoolValue(FFrame&, void* const)

native reliable server function bool ServerUpdateLockedTarget(Actor Locked);  // Export UTgPawn::execServerUpdateLockedTarget(FFrame&, void* const)

native exec function bool HasDeathPostureAnimation();  // Export UTgPawn::execHasDeathPostureAnimation(FFrame&, void* const)

native function UpdateMountScale(bool bIsMounted);  // Export UTgPawn::execUpdateMountScale(FFrame&, void* const)

native function float GetPhysicalPower();  // Export UTgPawn::execGetPhysicalPower(FFrame&, void* const)

native function float GetMagicalPower();  // Export UTgPawn::execGetMagicalPower(FFrame&, void* const)

native function float GetUtilityPower();  // Export UTgPawn::execGetUtilityPower(FFrame&, void* const)

native function float GetPhysicalPowerBot();  // Export UTgPawn::execGetPhysicalPowerBot(FFrame&, void* const)

native function float GetMagicalPowerBot();  // Export UTgPawn::execGetMagicalPowerBot(FFrame&, void* const)

native function float GetUtilityPowerBot();  // Export UTgPawn::execGetUtilityPowerBot(FFrame&, void* const)

native function float GetPhysicalPowerItem();  // Export UTgPawn::execGetPhysicalPowerItem(FFrame&, void* const)

native function float GetMagicalPowerItem();  // Export UTgPawn::execGetMagicalPowerItem(FFrame&, void* const)

native function float GetUtilityPowerItem();  // Export UTgPawn::execGetUtilityPowerItem(FFrame&, void* const)

native function float GetLifeSteal();  // Export UTgPawn::execGetLifeSteal(FFrame&, void* const)

native function float GetLifeStealInstigatorOnly(TgPawn InstigatorPawn);  // Export UTgPawn::execGetLifeStealInstigatorOnly(FFrame&, void* const)

native function float GetVengeanceLifesteal(TgPawn Target);  // Export UTgPawn::execGetVengeanceLifesteal(FFrame&, void* const)

native function float GetCombatDurationReduction();  // Export UTgPawn::execGetCombatDurationReduction(FFrame&, void* const)

native function float GetHealthRegen();  // Export UTgPawn::execGetHealthRegen(FFrame&, void* const)

native function float GetManaRegen();  // Export UTgPawn::execGetManaRegen(FFrame&, void* const)

native function float GetEnergyRegen();  // Export UTgPawn::execGetEnergyRegen(FFrame&, void* const)

native function float GetEnergy();  // Export UTgPawn::execGetEnergy(FFrame&, void* const)

native function float GetMaxEnergy();  // Export UTgPawn::execGetMaxEnergy(FFrame&, void* const)

native function float GetMaxHealthWithoutPercentBuff();  // Export UTgPawn::execGetMaxHealthWithoutPercentBuff(FFrame&, void* const)

native function float GetMaxShieldHealth();  // Export UTgPawn::execGetMaxShieldHealth(FFrame&, void* const)

native function float GetVisionRange();  // Export UTgPawn::execGetVisionRange(FFrame&, void* const)

native function float GetHealingTakenPerc();  // Export UTgPawn::execGetHealingTakenPerc(FFrame&, void* const)

native function float GetHealingTakenOthersPerc();  // Export UTgPawn::execGetHealingTakenOthersPerc(FFrame&, void* const)

native function float ApplyDamageTakenScaling(float Value);  // Export UTgPawn::execApplyDamageTakenScaling(FFrame&, void* const)

native function float GetProtectionCC();  // Export UTgPawn::execGetProtectionCC(FFrame&, void* const)

native function float GetDamageTakenPerc();  // Export UTgPawn::execGetDamageTakenPerc(FFrame&, void* const)

native function float GetDamageTakenPercInhand();  // Export UTgPawn::execGetDamageTakenPercInhand(FFrame&, void* const)

native function float GetDamageTakenPercAOE();  // Export UTgPawn::execGetDamageTakenPercAOE(FFrame&, void* const)

native function float GetDamageTakenPercDirect();  // Export UTgPawn::execGetDamageTakenPercDirect(FFrame&, void* const)

native function float GetDamageTakenPercPhys();  // Export UTgPawn::execGetDamageTakenPercPhys(FFrame&, void* const)

native function float GetDamageCapPercMaxHP();  // Export UTgPawn::execGetDamageCapPercMaxHP(FFrame&, void* const)

native function float GetDamageCapPercCurHP();  // Export UTgPawn::execGetDamageCapPercCurHP(FFrame&, void* const)

native function float GetDamageDealtPerc();  // Export UTgPawn::execGetDamageDealtPerc(FFrame&, void* const)

native function float GetDamageDealtPercBasicAttack();  // Export UTgPawn::execGetDamageDealtPercBasicAttack(FFrame&, void* const)

native function float GetDamageDealtPercPhysical();  // Export UTgPawn::execGetDamageDealtPercPhysical(FFrame&, void* const)

native function float GetDamageDealtPercMagical();  // Export UTgPawn::execGetDamageDealtPercMagical(FFrame&, void* const)

native function float GetDamageDealtPercDeployableTarget();  // Export UTgPawn::execGetDamageDealtPercDeployableTarget(FFrame&, void* const)

native function float GetDamageDealtPercShieldTarget();  // Export UTgPawn::execGetDamageDealtPercShieldTarget(FFrame&, void* const)

native function float GetDamageDealtFlat();  // Export UTgPawn::execGetDamageDealtFlat(FFrame&, void* const)

native function float GetHealBlock();  // Export UTgPawn::execGetHealBlock(FFrame&, void* const)

native function bool GetMinimapRequireLOS();  // Export UTgPawn::execGetMinimapRequireLOS(FFrame&, void* const)

native function float GetBackpedalPercent();  // Export UTgPawn::execGetBackpedalPercent(FFrame&, void* const)

native function float GetUIGroundSpeed();  // Export UTgPawn::execGetUIGroundSpeed(FFrame&, void* const)

native function float GetProcChanceMultiplier();  // Export UTgPawn::execGetProcChanceMultiplier(FFrame&, void* const)

native function SetSpawnHealth();  // Export UTgPawn::execSetSpawnHealth(FFrame&, void* const)

native function SetSpawnMana();  // Export UTgPawn::execSetSpawnMana(FFrame&, void* const)

native function SetSpawnEnergy();  // Export UTgPawn::execSetSpawnEnergy(FFrame&, void* const)

native function PawnOnDamaged(out OnDamagedParams Params);  // Export UTgPawn::execPawnOnDamaged(FFrame&, void* const)

native function PawnOnPreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);  // Export UTgPawn::execPawnOnPreDamageMitigation(FFrame&, void* const)

native function PawnOnDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);  // Export UTgPawn::execPawnOnDamageMitigation(FFrame&, void* const)

native function PawnOnHealed(out OnHealedParams Params);  // Export UTgPawn::execPawnOnHealed(FFrame&, void* const)

native function PawnOnKilled(Actor pVictim);  // Export UTgPawn::execPawnOnKilled(FFrame&, void* const)

native function PawnOnAssisted(Actor pVictim);  // Export UTgPawn::execPawnOnAssisted(FFrame&, void* const)

native function PawnOnRevive();  // Export UTgPawn::execPawnOnRevive(FFrame&, void* const)

native function PawnOnEnterCombat();  // Export UTgPawn::execPawnOnEnterCombat(FFrame&, void* const)

native function PawnOnExitCombat();  // Export UTgPawn::execPawnOnExitCombat(FFrame&, void* const)

native function PawnOnBecomeStill();  // Export UTgPawn::execPawnOnBecomeStill(FFrame&, void* const)

native function PawnOnEndStill();  // Export UTgPawn::execPawnOnEndStill(FFrame&, void* const)

native function PawnOnXp(out int nXp, Actor Source);  // Export UTgPawn::execPawnOnXp(FFrame&, void* const)

native function PawnOnCurrency(out int nCurrency, Actor Source);  // Export UTgPawn::execPawnOnCurrency(FFrame&, void* const)

native function PawnOnTaskforceRemove(TgRepInfo_TaskForce tf);  // Export UTgPawn::execPawnOnTaskforceRemove(FFrame&, void* const)

native function PawnOnTaskforceAdd(TgRepInfo_TaskForce tf);  // Export UTgPawn::execPawnOnTaskforceAdd(FFrame&, void* const)

native function PawnOnModifyEffectLifeTime(TgEffectGroup eg, out float fLifeTime);  // Export UTgPawn::execPawnOnModifyEffectLifeTime(FFrame&, void* const)

native function bool PawnCanDisplayImmuneMessage();  // Export UTgPawn::execPawnCanDisplayImmuneMessage(FFrame&, void* const)

native function PawnOnStartSprint();  // Export UTgPawn::execPawnOnStartSprint(FFrame&, void* const)

native function PawnOnEndSprint();  // Export UTgPawn::execPawnOnEndSprint(FFrame&, void* const)

native function PawnOnPetSuccessfulHit(int nFxID);  // Export UTgPawn::execPawnOnPetSuccessfulHit(FFrame&, void* const)

native function PawnOnLand();  // Export UTgPawn::execPawnOnLand(FFrame&, void* const)

native function PawnOnLandAfterJump();  // Export UTgPawn::execPawnOnLandAfterJump(FFrame&, void* const)

native function PawnOnLandAfterLeap();  // Export UTgPawn::execPawnOnLandAfterLeap(FFrame&, void* const)

native function PawnOnDamageInterruptedStealth();  // Export UTgPawn::execPawnOnDamageInterruptedStealth(FFrame&, void* const)

native function PawnOnPetAdded(TgPawn Pet, TgPawn petOwner);  // Export UTgPawn::execPawnOnPetAdded(FFrame&, void* const)

native function PawnOnPetDied(TgPawn Pet, TgPawn petOwner);  // Export UTgPawn::execPawnOnPetDied(FFrame&, void* const)

native function PawnOnTeleported(TgSpawnTeleporterEntrance From, TgSpawnTeleporterExit To, Vector OriginalPawnLocation);  // Export UTgPawn::execPawnOnTeleported(FFrame&, void* const)

native function DeviceOnStartBuildup(TgDevice Dev);  // Export UTgPawn::execDeviceOnStartBuildup(FFrame&, void* const)

native function DeviceOnStopBuildup(TgDevice Dev, optional bool WasInterrupted=false);  // Export UTgPawn::execDeviceOnStopBuildup(FFrame&, void* const)

native function DeviceOnFire(TgDevice Dev);  // Export UTgPawn::execDeviceOnFire(FFrame&, void* const)

native function ProjectileOnFire(TgProjectile Proj);  // Export UTgPawn::execProjectileOnFire(FFrame&, void* const)

native function DeviceOnStartFire(TgDevice Dev);  // Export UTgPawn::execDeviceOnStartFire(FFrame&, void* const)

native function DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted=false);  // Export UTgPawn::execDeviceOnStopFire(FFrame&, void* const)

native function DeviceOnStartCooldown(TgDevice Dev, float fCooldownTime);  // Export UTgPawn::execDeviceOnStartCooldown(FFrame&, void* const)

native function DeviceOnStopCooldown(TgDevice Dev);  // Export UTgPawn::execDeviceOnStopCooldown(FFrame&, void* const)

native function DeviceOnPostHit(TgDevice Dev);  // Export UTgPawn::execDeviceOnPostHit(FFrame&, void* const)

native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);  // Export UTgPawn::execDeviceOnHit(FFrame&, void* const)

native function DeviceOnHitSpecial(TgDevice Dev, const out ImpactInfo Impact, int nHitSpecialSituationalType);  // Export UTgPawn::execDeviceOnHitSpecial(FFrame&, void* const)

native function DeviceOnDamaged(out OnDamagedParams Params);  // Export UTgPawn::execDeviceOnDamaged(FFrame&, void* const)

native function DeviceOnHealed(out OnHealedParams Params);  // Export UTgPawn::execDeviceOnHealed(FFrame&, void* const)

native function DeviceOnKilled(TgDevice Dev, const out ImpactInfo Impact, float fDamage);  // Export UTgPawn::execDeviceOnKilled(FFrame&, void* const)

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn::execDeviceAdjustDamage(FFrame&, void* const)

native function DeviceAdjustHeal(const out AdjustHealParams Params, out float fHeal);  // Export UTgPawn::execDeviceAdjustHeal(FFrame&, void* const)

native function bool DeviceHasEnoughPowerPool(TgDevice Dev, byte FireModeNum);  // Export UTgPawn::execDeviceHasEnoughPowerPool(FFrame&, void* const)

native function DeviceOnSetFireMode(TgDevice Dev);  // Export UTgPawn::execDeviceOnSetFireMode(FFrame&, void* const)

native function DeployableOnDeployed(TgDeployable dep);  // Export UTgPawn::execDeployableOnDeployed(FFrame&, void* const)

native function DeployableOnDestroyed(TgDeployable dep);  // Export UTgPawn::execDeployableOnDestroyed(FFrame&, void* const)

native function DeployableOnApplyEffect(TgDeployable dep, Actor HitActor);  // Export UTgPawn::execDeployableOnApplyEffect(FFrame&, void* const)

native function DeployableOnRemoveEffect(TgDeployable dep, Actor HitActor);  // Export UTgPawn::execDeployableOnRemoveEffect(FFrame&, void* const)

native function EffectGroupOnSetActive(bool bActive, bool bRemoving, TgEffectGroup EffectGroup);  // Export UTgPawn::execEffectGroupOnSetActive(FFrame&, void* const)

native function RetouchAllVolumes();  // Export UTgPawn::execRetouchAllVolumes(FFrame&, void* const)

native function SwapToDestroyedMesh();  // Export UTgPawn::execSwapToDestroyedMesh(FFrame&, void* const)

native function SwapToLiveMesh();  // Export UTgPawn::execSwapToLiveMesh(FFrame&, void* const)

native function OnMeshSwapped();  // Export UTgPawn::execOnMeshSwapped(FFrame&, void* const)

native function PostPawnSetupServer();  // Export UTgPawn::execPostPawnSetupServer(FFrame&, void* const)

native function CacheHitReactionSkelControls();  // Export UTgPawn::execCacheHitReactionSkelControls(FFrame&, void* const)

native function int InitializeOverlayMeshComponent(SkeletalMeshComponent InMesh, optional bool bIs1POverlay);  // Export UTgPawn::execInitializeOverlayMeshComponent(FFrame&, void* const)

native function int InitializeOverlayIndexBody(SkeletalMeshComponent ParentMesh, bool bIs1POverlay);  // Export UTgPawn::execInitializeOverlayIndexBody(FFrame&, void* const)

native function int InitializeOverlayIndexWeapon(SkeletalMeshComponent ParentMesh, bool bIs1POverlay);  // Export UTgPawn::execInitializeOverlayIndexWeapon(FFrame&, void* const)

native function MaterialInstanceConstant InitializeOverlayInfo(TgPawn.OverlayMICType Type, Texture NormalMap, Texture MaskMap);  // Export UTgPawn::execInitializeOverlayInfo(FFrame&, void* const)

native function MaterialInstanceConstant GetOverlayMaterial(TgPawn.OverlayMICType Type);  // Export UTgPawn::execGetOverlayMaterial(FFrame&, void* const)

native function Scene.ESceneDepthPriorityGroup GetOverlayDepthPriority(TgPawn.OverlayMICType Type);  // Export UTgPawn::execGetOverlayDepthPriority(FFrame&, void* const)

native function bool Is1PBodyOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn::execIs1PBodyOverlay(FFrame&, void* const)

native function bool Is1PWeaponOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn::execIs1PWeaponOverlay(FFrame&, void* const)

native function bool Is3PBodyOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn::execIs3PBodyOverlay(FFrame&, void* const)

native function bool Is3PWeaponOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn::execIs3PWeaponOverlay(FFrame&, void* const)

native function ReinitializeOverlays();  // Export UTgPawn::execReinitializeOverlays(FFrame&, void* const)

native function bool RemoveOverlayInfo(SkeletalMeshComponent ParentMesh);  // Export UTgPawn::execRemoveOverlayInfo(FFrame&, void* const)

native function SwapOverlayMICsBody(TgPawn.OverlayMICType Type);  // Export UTgPawn::execSwapOverlayMICsBody(FFrame&, void* const)

native function SwapOverlayMICsWeapon(TgPawn.OverlayMICType Type);  // Export UTgPawn::execSwapOverlayMICsWeapon(FFrame&, void* const)

native function UpdateOverlayVisibilityBody();  // Export UTgPawn::execUpdateOverlayVisibilityBody(FFrame&, void* const)

native function UpdateOverlayVisibilityWeapon();  // Export UTgPawn::execUpdateOverlayVisibilityWeapon(FFrame&, void* const)

native function ToggleOverlay1P3P(bool bActivate1P);  // Export UTgPawn::execToggleOverlay1P3P(FFrame&, void* const)

native function bool ShouldForceHideOverlaysBody();  // Export UTgPawn::execShouldForceHideOverlaysBody(FFrame&, void* const)

native function bool ShouldForceHideOverlaysWeapon();  // Export UTgPawn::execShouldForceHideOverlaysWeapon(FFrame&, void* const)

native function ReplaceMaterial(MaterialInstanceConstant materialToUse, optional float ParamValue=0.0000000);  // Export UTgPawn::execReplaceMaterial(FFrame&, void* const)

native function ClearReplacementMaterial();  // Export UTgPawn::execClearReplacementMaterial(FFrame&, void* const)

native function int InitializeSilhouetteComponent(MeshComponent InMesh);  // Export UTgPawn::execInitializeSilhouetteComponent(FFrame&, void* const)

native function ReinitializeSilhouettes();  // Export UTgPawn::execReinitializeSilhouettes(FFrame&, void* const)

native function int FindSilhouetteInfo(MeshComponent ParentMesh);  // Export UTgPawn::execFindSilhouetteInfo(FFrame&, void* const)

native function bool RemoveSilhouetteInfo(MeshComponent ParentMesh);  // Export UTgPawn::execRemoveSilhouetteInfo(FFrame&, void* const)

native function SetSilhouetteState(MeshComponent ParentMesh, TgPawn.OverlayState NewState);  // Export UTgPawn::execSetSilhouetteState(FFrame&, void* const)

native function ToggleSilhouetteVisibility(bool bVisible, optional bool bDead);  // Export UTgPawn::execToggleSilhouetteVisibility(FFrame&, void* const)

native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn::execDropHealthNugget(FFrame&, void* const)

native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride=-1.0000000, optional float fHoTOverride=-1.0000000);  // Export UTgPawn::execDropHealthNuggetTeamOnly(FFrame&, void* const)

native function FxActivateGroupAllMesh(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm, optional bool bSkipWeaponMesh);  // Export UTgPawn::execFxActivateGroupAllMesh(FFrame&, void* const)

native function FxDeactivateGroupAllMesh(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bSkipWeaponMesh);  // Export UTgPawn::execFxDeactivateGroupAllMesh(FFrame&, void* const)

native function FxActivateGroupSelf(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxActivateGroupSelf(FFrame&, void* const)

native function FxReactivateGroupSelf(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxReactivateGroupSelf(FFrame&, void* const)

native function FxDeactivateGroupSelf(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgPawn::execFxDeactivateGroupSelf(FFrame&, void* const)

native function Object FxActivateGroupBody(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxActivateGroupBody(FFrame&, void* const)

native function Object FxReactivateGroupBody(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxReactivateGroupBody(FFrame&, void* const)

native function FxDeactivateGroupBody(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgPawn::execFxDeactivateGroupBody(FFrame&, void* const)

native function Object FxActivateGroupHead(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxActivateGroupHead(FFrame&, void* const)

native function Object FxReactivateGroupHead(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxReactivateGroupHead(FFrame&, void* const)

native function FxDeactivateGroupHead(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgPawn::execFxDeactivateGroupHead(FFrame&, void* const)

native function FxActivateGroupWeapon(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxActivateGroupWeapon(FFrame&, void* const)

native function FxReactivateGroupWeapon(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxReactivateGroupWeapon(FFrame&, void* const)

native function FxDeactivateGroupWeapon(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgPawn::execFxDeactivateGroupWeapon(FFrame&, void* const)

native function Object FxActivateGroupWeapon1P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxActivateGroupWeapon1P(FFrame&, void* const)

native function Object FxReactivateGroupWeapon1P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxReactivateGroupWeapon1P(FFrame&, void* const)

native function FxDeactivateGroupWeapon1P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgPawn::execFxDeactivateGroupWeapon1P(FFrame&, void* const)

native function Object FxActivateGroupWeapon3P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxActivateGroupWeapon3P(FFrame&, void* const)

native function Object FxReactivateGroupWeapon3P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot, optional bool bIgnoreRelevancy, optional bool bFromEffectForm);  // Export UTgPawn::execFxReactivateGroupWeapon3P(FFrame&, void* const)

native function FxDeactivateGroupWeapon3P(name nmGroup, int nMode, optional int nSocketIndex, optional int nEquipSlot);  // Export UTgPawn::execFxDeactivateGroupWeapon3P(FFrame&, void* const)

native function BeginLocalKillRTPC();  // Export UTgPawn::execBeginLocalKillRTPC(FFrame&, void* const)

native function EndLocalKillRTPC();  // Export UTgPawn::execEndLocalKillRTPC(FFrame&, void* const)

native function BeginLocalDeathRTPC();  // Export UTgPawn::execBeginLocalDeathRTPC(FFrame&, void* const)

native function EndLocalDeathRTPC();  // Export UTgPawn::execEndLocalDeathRTPC(FFrame&, void* const)

native function OnEnterItemShop();  // Export UTgPawn::execOnEnterItemShop(FFrame&, void* const)

native function OnLeaveItemShop();  // Export UTgPawn::execOnLeaveItemShop(FFrame&, void* const)

native function OnDismount();  // Export UTgPawn::execOnDismount(FFrame&, void* const)

simulated event int PushPosture(TgPawn.TG_POSTURE Posture) { }

simulated event bool PopPosture(int PostureID) { }

simulated function GetAimAssistBounds(const out Vector ObserverLocation, out float Width, out float Height, out Vector Center) { }

simulated function Actor GetActorFromCombatActor() { }

function PossessedBy(Controller C, bool bVehicleTransition) { }

function UnPossessed() { }

simulated function OnGetTeamIndex(TgSeqAct_GetTeamIndex Action) { }

simulated function OnGetTaskForceNumber(TgSeqAct_GetTaskForceNumber Action) { }

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

simulated function OnUIAlert(TgSeqAct_UIAlert Action) { }

function OnSetCrowdControlImmune(TgSeqAct_SetCrowdControlImmune inAction) { }

event CollisionChanged() { }

event Falling() { }

simulated function OnKillpawns(TgSeqAct_Killpawns Action) { }

function OnDespawnBots(TgSeqAct_DespawnBots inAction) { }

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) { }

simulated function CacheMainMeshReferences(TgSkeletalMeshComponent smcomp) { }

simulated function ClearMultiMeshAnimNodeReferences() { }

simulated function CacheMultiMeshAnimNodeReferences(TgSkeletalMeshComponent smcomp) { }

simulated function CacheSkelControlLocks(TgSkeletalMeshComponent smcomp) { }

simulated function ToggleSkelControlLocks(bool bOn) { }

native simulated function AllManifestsLoaded();  // Export UTgPawn::execAllManifestsLoaded(FFrame&, void* const)

simulated event PreBeginPlay() { }

simulated function SetLocalPlayer() { }

simulated function PostBeginPlay() { }

function ClearSpawnFxTimer() { }

function SetupPIEMesh(GameInfo.PIEPawnMeshTypes PIEPawnType, int BotId) { }

function CrushedBy(Pawn OtherPawn) { }

simulated event bool PostPawnSetup() { }

reliable server function MissionTimeUpdate() { }

simulated event bool IsCustomCharacter() { }

simulated function PreRender(Canvas Canvas) { }

function SetDeathZoomInfo(TgPawn theKiller, TgRepInfo_Player theKillerPRI, int nHealthPct, int nDeviceId, optional TgRepInfo_Player OwnerPRI) { }

event Suicide() { }

event Despawn() { }

event DespawnOnReconnect() { }

simulated function OnJoinTeam(TgSeqAct_JoinTeam Action) { }

simulated function TakeFallingDamage() { }

event UpdateDeathReason() { }

event bool ShouldScoreKill() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated event Destroyed() { }

simulated event KillAllOwnedPets() { }

simulated function bool CanChangeInHandDeviceOrMode() { }

simulated event PutInHandDeviceAwayFast(TgDeviceForm form) { }

exec function ShowAnimSets() { }

simulated function EquipPendingDeviceTimer(optional bool SkipPlayAnim=false) { }

function OnDeviceFormEnteredTargetingMode(TgDeviceForm form) { }

function OnDeviceFormExitedTargetingMode(TgDeviceForm form) { }

exec function UIH() { }

simulated event AnimSwapDevice() { }

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp=true) { }

simulated event StopAction(TgDevice Dev) { }

simulated event StopFiringAllDevices(optional bool bClearEquipEffectFlag, optional bool bResetCooldowns, optional bool bKeepFiringMount, optional bool bServerDeviceLockout=false) { }

function PutAllCardsOnCooldown() { }

reliable client simulated function ClientStopFiringAllDevices(optional bool bClearEquipEffectFlag, optional bool bResetCooldowns, optional bool bKeepFiringMount, optional bool bServerDeviceLockout=false) { }

simulated event RestartAllDevices() { }

native function SwapEquippedDevices(TgDevice newDev, int nEqpSlot);  // Export UTgPawn::execSwapEquippedDevices(FFrame&, void* const)

native function SyncDeviceTimers(TgDevice SourceDevice, TgDevice DestinationDevice);  // Export UTgPawn::execSyncDeviceTimers(FFrame&, void* const)

simulated function OnDeviceFormBuildup(int nEquipSlot, float fBuildupTime) { }

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining) { }

simulated function OnDeviceFormFire(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function OnDeviceFormHit(int nEquipSlot, Actor Target, float DamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }

simulated function PostRecallTimerToKillParticles() { }

simulated function OnDeviceFormStopFire(int nEquipSlot) { }

simulated function bool ShouldStopWeaponMeshFireEffectsOnDeviceFormStopFire(int nEquipSlot) { }

simulated function OnDeviceFormInterruptFire(int nEquipSlot) { }

event bool CanApplyEffects() { }

simulated function ForceUpdate1PMeshes() { }

simulated function IncrementFlashCount(Weapon Who, byte FireModeNum) { }

simulated function ClearFlashCount(Weapon Who) { }

function ClearFlashLocation(Weapon Who) { }

simulated function StopPlayFiring() { }

function RememberPlayerAttackerExpired() { }

simulated event PlayHeal3P() { }

simulated function EndHeal3P() { }

simulated event PlayHitReactionMaterialPulse() { }

simulated function PlayTakeHit(Vector Direction, int Damage, Class<DamageType> dmgType, const out ExtraDamageInfo ExtraInfo, TgPawn.EHitAudioCue eCue) { }

event SendNotifyTakeHit(Controller InstigatedBy, Vector HitLocation, int Damage, Class<DamageType> DamageType, Vector Momentum) { }

function NotifyTakeHit(Controller InstigatedBy, vector HitLocation, int Damage, class<DamageType> DamageType, vector Momentum, Actor DamageCauser) { }

simulated event DrawAIDebug(Canvas Canvas, Vector ScreenLoc) { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

event int TakeShieldDamage(int fDamage, Class<DamageType> DamageType) { }

event TakeHealing(float fHealAmount) { }

function PulseStealth() { }

singular event EndPulseStealth() { }

function AdjustDamage(out int InDamage, out vector Momentum, Controller InstigatedBy, vector HitLocation, class<DamageType> DamageType, TraceHitInfo HitInfo, Actor DamageCauser) { }

function SetHealth(int NewHealth) { }

event ModifyHealthProp(int nDamage) { }

simulated event DrawMultiLineText(Canvas Canvas, string Text, int X, int Y, int LineHeight) { }

simulated function bool LoadPlayerIcons() { }

function DamageTakenMaxReset() { }

function DamageTakenRTPCReset() { }

simulated function TgPawn GetLocalPlayerPawn() { }

simulated function int GetX1CoordBasedOnIndex(int nIndex) { }

simulated function int GetY1CoordBasedOnIndex(int nIndex) { }

simulated function int GetX2CoordBasedOnIndex(int nIndex) { }

simulated function int GetY2CoordBasedOnIndex(int nIndex) { }

simulated function int GetRowBasedOnIndex(int nIndex) { }

simulated function int GetColumnBasedOnIndex(int nIndex) { }

simulated function NotifyTeamChanged() { }

simulated function NotifyLocalPlayerTeamReceived() { }

simulated event OnGroupChange() { }

simulated function Color GetTargetBoxColor(TgPawn LocalPlayerPawn) { }

simulated event string GetPlayerNameForRender() { }

simulated event string GetPlayerTagForRender() { }

simulated event float GetPlayerHealthForRender() { }

simulated event BecomeViewTarget(PlayerController PC) { }

simulated event EndViewTarget(PlayerController PC) { }

simulated function bool CalcCamera(float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV) { }

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration) { }

simulated function bool IgnoreFaceRotationWithInterp() { }

simulated function InterceptInputDeltaRotation(out Rotator rDeltaRotation) { }

simulated function FaceRotation(rotator NewRotation, float DeltaTime) { }

simulated event PostureTransitionEnded(TgPawn.TG_POSTURE PostureThatEnded) { }

function String GetDebugName() { }

simulated event PlayJumpSound() { }

simulated event PlayPreTeleportEffects() { }

simulated event PlayTeleportEffects(Vector OriginLocation) { }

simulated event PlayJumpFx() { }

simulated event StopJumpFx() { }

simulated event PlaySpecialJumpFx() { }

simulated event StopSpecialJumpFx() { }

simulated function CalculateMaterialSwitch(Vector TraceStart, Vector TraceEnd) { }

simulated event PlayLandingSound(Vector LandingVelocity) { }

simulated event PlayFootStepSound(int FootDown) { }

simulated function name GetFootStepOverride() { }

reliable client simulated event ClientTriggerGlobalEventClass(Class<SequenceEvent> InEventClass, Actor InInstigator, optional int ActivateIndex=-1) { }

simulated function bool IsFiringMelee() { }

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc) { }

simulated function FindNewTargetTimer() { }

simulated function PlayDyingEffects() { }

simulated function bool AllowRagdoll() { }

simulated event PlayDeathAnimation() { }

simulated function RagdollPawn() { }

simulated event name GetDeathAnimName() { }

native function AttachDeathAnimationFX(int SpecialFXId, name SocketName);  // Export UTgPawn::execAttachDeathAnimationFX(FFrame&, void* const)

simulated function OnSwapToDestroyedMesh() { }

simulated function CleanUpDyingEffects() { }

reliable server function RemoveAllEffectsOnDeath() { }

simulated event Vector GetPhysTweenTargetLocation() { }

simulated event StartPhysTween(Vector Target, float fTime, TgPawn.ETweenState tweenState, optional bool bCollideWithWorld=false, optional bool bRotateTowardsTarget=false) { }

simulated event UpdatePhysTweenTargetLocation(Vector NewTarget, float updatedTime) { }

simulated event EndPhysTween(optional bool bInterrupted=false) { }

simulated function BeginTween(TgPawn.ETweenState newTweenState, optional bool bCollideWithWorld=false) { }

simulated function DefaultTweenStart(optional bool bCanBeHit=false, optional bool bRemoveRoots=false, optional bool bCollideWithWorld=false) { }

event SendHitReaction(byte HitDirection) { }

simulated event PlayHitReaction(int BitPackedHitReaction) { }

simulated function EndTween(TgPawn.ETweenState endingTweenState, bool bInterrupted) { }

simulated function DefaultTweenEnd(bool bInterrupted) { }

simulated event StartPhysGrab(TgPawn Source, float fTime, TgPawn.EGrabState grabState, optional name grabSocket, optional Vector grabLocOffset, optional Rotator grabRotOffset) { }

simulated event EndPhysGrab(optional bool bInterrupted=false) { }

event ForceAllGrabTargetsDetach(optional TgPawn.EGrabState State) { }

simulated function OnGrabTargetAttach(TgPawn.EGrabState newGrabState, TgPawn Target) { }

simulated function OnGrabTargetDetach(TgPawn.EGrabState endingGrabState, TgPawn Target, bool bInterrupted) { }

simulated event bool ShouldGrabBreakStealth(TgPawn.EGrabState grabState) { }

simulated event bool IsBaselessGrab(TgPawn.EGrabState grabState) { }

simulated function BeginGrab(TgPawn.EGrabState newGrabState) { }

simulated function EndGrab(TgPawn.EGrabState endingGrabState, bool bInterrupted) { }

simulated function DefaultGrabStart(optional bool bRemoveRoots=false) { }

simulated function DefaultGrabEnd(bool bInterrupted) { }

simulated function BaselessGrabStart(optional bool bRemoveRoots=false) { }

simulated function BaselessGrabEnd(bool bInterrupted) { }

event AddVelocity(vector NewVelocity, vector HitLocation, class<DamageType> damageType, optional TraceHitInfo HitInfo) { }

simulated function bool CanBeBaseForPawn(Pawn aPawn) { }

function SetMovementPhysics() { }

simulated function TickGrab(float DeltaSeconds) { }

event IncrementCannotBeGrabSource(optional bool bBreakGrabs=true) { }

event DecrementCannotBeGrabSource() { }

simulated event bool IsGrabSourceValid(TgPawn Target, optional bool bAllowTurrets=false, optional bool bAllowStealthed=false) { }

simulated function float GetChargeTurnRate() { }

simulated event StartPhysCharge(TgPawn.EChargeState newChargeType, Rotator InitialDirection, optional Vector InitialLocation, optional float fChargeSpeed=0.0000000, optional float fChargeRange=0.0000000, optional bool bIngoreHumanoidBlocking=false, optional bool bUsePhysFlyingForCharge) { }

simulated event EndPhysCharge(bool bInterrupted) { }

simulated function GetHitLocationForProximityTouch(Actor Target, out Vector HitLocation, out Vector HitNormal) { }

simulated event bool PredictChargeHit(Vector ChargeDir, Vector ChargeStart, float fChargeRange, Vector HitLocation, Vector HitNormal, Vector TargetLocation, Actor Other) { }

simulated event bool VerifyChargeHit(Vector HitLocation, Vector HitNormal, Vector TargetLocation, Actor Other) { }

simulated function StopAllAnimations() { }

simulated function TimerDestroy() { }

event EquipBestInHandDevice(optional bool bForceFastClear) { }

singular simulated function OnRespawn() { }

simulated function OnLiveRespawn() { }

simulated function SetMountOnRespawn() { }

simulated event AutoMount(bool bShouldBeMounted, optional bool bToggleMount=false) { }

function LiveRespawn(bool bResetHealth, bool bResetDevices) { }

reliable client simulated function SyncClientEnergy(float energy) { }

simulated function RemoveDeathEffects() { }

simulated function SetPawnState(name NewState) { }

simulated event bool IsInItemShop() { }

simulated event bool IsInFriendlyItemShop() { }

simulated event SetActiveWeapon(Weapon NewWeapon) { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated function TgObject.TG_EQUIP_POINT GetEquipSlotOfDevice(TgDevice Dev) { }

event LockTargetingDeviceToInHand(bool bEnable) { }

simulated function name GetDefaultCameraMode(PlayerController RequestedBy) { }

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos) { }

simulated function TgPawnControllerSet() { }

simulated event UpdateWeaponMesh() { }

simulated event UpdateFirstValidFlashEventIdx() { }

simulated event ReplicatedEvent(name VarName) { }

simulated event ReceivedPropValues() { }

simulated event ReceivedCachedMaxHealth() { }

event ApplyStealthServer(TgPawn.STEALTH_TYPE eStealthed, optional float fRate=9999.0000000, optional bool bForce=false) { }

event InterruptStealth(optional TgDevice OriginatingDevice) { }

event InterruptLift(optional TgDevice OriginatingDevice) { }

simulated function bool ShouldShowAsStealthed(bool bDetected) { }

simulated event ApplyStealthClient(optional bool bForce=false) { }

event FixUpVisibilityVolumes() { }

function AddVisibilityVolume(TgVisibilityVolume Vol) { }

function RemoveVisibilityVolume(TgVisibilityVolume Vol) { }

function VolumeStealthFadeComplete() { }

function VolumeStealthOn(TgVisibilityVolume Vol, optional bool bFull) { }

function VolumeStealthOff() { }

function ClearStealthDamage() { }

function GrassOn(TgVisibilityVolume Vol) { }

function GrassOff() { }

function DisableVolumeStealth() { }

function EnableVolumeStealth() { }

function UpdateObscuringDeployableState() { }

function UpdateBlindingDeployableState() { }

unreliable client simulated event ClientEnterCombat(Actor aInstigator, Actor ATarget, optional float fLength) { }

event BeginMoving() { }

function IsStillTimer() { }

simulated event EnterCombat(Actor aInstigator, Actor ATarget, optional float fLength) { }

simulated event ExitCombat() { }

simulated function InCombatTimer() { }

simulated event Combat(bool bInCombat) { }

event bool InCombat() { }

simulated event float GetEnergyPercent() { }

simulated function ApplyPawnShadows(bool bOn) { }

simulated event bool IsDying() { }

event Landed(vector HitNormal, actor FloorActor) { }

function OnJumpPenaltyEnded() { }

function PlayHit(float Damage, Controller InstigatedBy, vector HitLocation, class<DamageType> damageType, vector Momentum, TraceHitInfo HitInfo) { }

exec function FlushDebug() { }

simulated event FellOutOfWorld(class<DamageType> dmgType) { }

singular simulated event OutsideWorldBounds() { }

event KilledBy(pawn EventInstigator) { }

simulated function TurnOff() { }

native simulated function bool InitRagdoll();  // Export UTgPawn::execInitRagdoll(FFrame&, void* const)

native function DelayedRagdollConstraintBreak();  // Export UTgPawn::execDelayedRagdollConstraintBreak(FFrame&, void* const)

simulated event HoldFlag(TgCarriedFlag NewFlag) { }

event DropFlag(optional Controller C) { }

simulated function BeginFadeOut() { }

simulated function OnLifeAfterDeathTimerExpired() { }

simulated function UpdateHealingBeamEffects() { }

simulated event DetachDevice() { }

simulated event AttachDevice() { }

simulated event PropertySet(int nPropertyId, float fPreviousValue, float fNewValue) { }

simulated event HandleClientPostPawnSetup() { }

simulated event WaitForInventoryThenDoPostPawnSetup() { }

simulated function OnWaitingForPawnDone() { }

simulated event OnPawnInitialized() { }

simulated function TriggerKismetPlayerInitialized() { }

simulated function PlayInitialSpawnFX() { }

simulated function DrawConeComponent AttachConeComponent(DrawConeComponent ConeComponent, float fRadius, float fAngle) { }

simulated function DetachConeComponent(DrawConeComponent ConeComponent) { }

function gibbedBy(actor Other) { }

simulated event OnAnimPlay(AnimNodeSequence SeqNode) { }

simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime) { }

simulated function StopFullBodyAnimation(optional float BlendOutTime=0.1500000) { }

simulated function ClientSetStun() { }

function ResetStunnedBehavior(TgPlayerController PC, TgAIController aic) { }

event Silence(bool bSilenced) { }

event Disarm(bool bDisarmed) { }

simulated function PlayDisarmFX() { }

simulated function StopDisarmFX() { }

event Knock(bool bKnocked, optional float fKnockbackFrictionOverride=-1.0000000, optional Vector vKnockbackVelocityOverride=vect(0.0000000, 0.0000000, 0.0000000)) { }

event Cripple(bool bCrippled) { }

event FlashBang(bool bIsFlashBang) { }

event Stasis(bool bStasised) { }

event Daze(bool bDazed, optional float Duration=8.0000000, optional int FxId=2430) { }

reliable client simulated function ClientDaze(bool bDazed, optional float Duration=8.0000000, optional int FxId=2430) { }

simulated function DrawHUD(HUD H) { }

event bool CanBePulled() { }

event bool CanBeGrabbed() { }

event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp) { }

simulated event EnableFootControls(int foot, bool bDisable) { }

simulated event InterruptUse() { }

simulated event bool IsUseInterrupted() { }

simulated event InterruptAllDevices(optional bool bForceInterrupt=false) { }

simulated function SetTriggerToUse(TgTrigger_Use Trigger, bool bEnable) { }

simulated function ClientSetTriggerMessage(TgTrigger_Use newTrigger, int msgId) { }

event CheckUseDuration(out float fDuration) { }

simulated function DisplayWeaponSwitchProgressBar(float Duration) { }

simulated function HideWeaponSwitchProgressBar() { }

simulated event Vector GetWeaponStartTraceLocation(optional Weapon CurrentWeapon) { }

simulated event Vector GetWeaponStartTraceLocationAlt(Vector Offset) { }

simulated event GetBaseAimRotationNative(Weapon W, bool bIgnoreAutoLock, out Rotator Rot) { }

simulated event GetAdjustedAimNative(Weapon W, Vector StartFireLoc, out Rotator Rot) { }

singular simulated function Rotator GetBaseAimRotation() { }

simulated function float ApplyPitchLimit(float fPitch) { }

simulated event EndCrouch(float HeightAdjust) { }

simulated event StartCrouch(float HeightAdjust) { }

simulated event TriggerJump() { }

reliable server function ServerCancelJump() { }

unreliable client simulated event ClientCancelJump() { }

function bool DoJump(bool bUpdating) { }

simulated function FlashJumpEffects() { }

simulated function float GetJumpHeightMultiplier() { }

simulated function float GetJumpSpeedMultiplier() { }

simulated function OnTeleport(SeqAct_Teleport Action) { }

simulated event ApplyTeleportEffects(Vector StartLocation) { }

reliable server function ServerSetVar(int varId) { }

exec function SetVar(int varId) { }

simulated function BlendToAnimTreeDeviceType() { }

simulated function TgPawn FindLocalPlayerPawn() { }

simulated exec event SetUsePhysicsWithAnimation(bool Enable) { }

simulated event OnRigidBodySpringOverextension(RB_BodyInstance BodyInstance) { }

event ModifyPawnPropertiesVolumeChanged() { }

simulated function DisplayMessage(string sMessage) { }

event bool ShouldRecharge() { }

simulated function TickFriendlyPush() { }

simulated function DoubleCheckSimulatedProxy() { }

simulated function Tick(float DeltaSeconds) { }

simulated event UpdateRecoil(float DeltaTime) { }

function AddRecoil(Rotator rNewRecoil, float fRecoilSmoothRate, float fSettleDelay, float fSettleSpeed) { }

simulated function float TickScaleVariable(float fDesiredValue, float fOldValue, float fScaleChangePerSecond, float DeltaSeconds) { }

simulated function TickScale(float DeltaSeconds) { }

simulated function UpdateBob(float DeltaSeconds) { }

simulated event TickTargeting(float DeltaSeconds) { }

simulated event bool IsTargetWithInCone(Actor Target) { }

native function bool IsTalentEquipped(int nTalentDeviceId);  // Export UTgPawn::execIsTalentEquipped(FFrame&, void* const)

native function bool WasPlayerSpawned();  // Export UTgPawn::execWasPlayerSpawned(FFrame&, void* const)

native function TgPawn GetCurrentOwnerPawn();  // Export UTgPawn::execGetCurrentOwnerPawn(FFrame&, void* const)

native function bool TeleportTraceCheck(Vector vTestLoc, Vector vDestLoc);  // Export UTgPawn::execTeleportTraceCheck(FFrame&, void* const)

native function bool IsAboveNonbaseableSurface(Vector vTestLoc, float fTestDist, out Actor HitActor, out Vector HitNormal);  // Export UTgPawn::execIsAboveNonbaseableSurface(FFrame&, void* const)

simulated event bool Teleport(Vector vDest, Rotator rDest, bool bPlayFx, optional int TeleportEnterState, optional int TeleportExitState, optional bool bFailOnNoSafeSpot, optional out Vector vTeleportLocation, optional bool bFakeTeleport=false) { }

simulated function bool CanApplyAimAssist(TgPlayerController LocalPlayerController, TgPawn LocalPawn) { }

simulated event Stun(bool bStunController, optional Controller.EStunType eType) { }

event UpdateCooldownsOnDevices() { }

event SaveDeathInfoForZoomCam(TgPawn KillerOwner, TgPawn Killer, int DeviceID, bool bPetKill) { }

simulated function bool IsValidMeleeTarget(TgPawn ProspectiveMeleeTarget) { }

simulated function bool CanPickupDroppedItem() { }

event BaseChange() { }

simulated event OnPhaseEnded(int nPhaseThatEnded) { }

simulated event OnPhaseChange() { }

simulated function OnPhaseTransitionComplete() { }

exec function Perf2(bool bEnabled) { }

exec function ChangePhase(int NewPhase) { }

reliable server function ServerChangePhase(int NewPhase) { }

event AddToTeleportNotify(Actor ToBeNotified) { }

event RemoveFromTeleportNotify(Actor RemoveActor) { }

event TeleportNotify() { }

function OnTeleportNotify(Actor TeleportingActor) { }

function bool PreTeleport(Teleporter InTeleporter) { }

simulated function HaltFXForTeleport() { }

simulated function ResumeFXFromTeleport() { }

simulated function PostTeleport(Teleporter OutTeleporter) { }

simulated function PostBigTeleport() { }

native simulated function TgObject.TG_EQUIP_POINT GetPerCharacterAltEquipPoint();  // Export UTgPawn::execGetPerCharacterAltEquipPoint(FFrame&, void* const)

native function int GetBotId();  // Export UTgPawn::execGetBotId(FFrame&, void* const)

native function string GetBotName();  // Export UTgPawn::execGetBotName(FFrame&, void* const)

native function SoundCue GetEmoteSoundCue(int BotId, TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execGetEmoteSoundCue(FFrame&, void* const)

native function AkEvent GetEmoteAkEvent(int BotId, TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execGetEmoteAkEvent(FFrame&, void* const)

native function AkEvent GetVoxKillAkEvent(int BotId, TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execGetVoxKillAkEvent(FFrame&, void* const)

native function string GetEmoteSuffix(TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execGetEmoteSuffix(FFrame&, void* const)

native function string GetEmoteCustomSuffix(TgPawn.EEmote Emote, int ExtraInfo);  // Export UTgPawn::execGetEmoteCustomSuffix(FFrame&, void* const)

native function string GetVGSCustomSuffix();  // Export UTgPawn::execGetVGSCustomSuffix(FFrame&, void* const)

function TgPawn.EEmote GetDeviceEmoteType(TgDevice Dev) { }

event PlayDeviceEmoteAll(TgDevice Dev, optional bool bCallOnOwner=false) { }

event PlayEmote(TgPawn.EEmote Emote, optional int nExtraInfo) { }

unreliable server function ServerPlayEmote(TgPawn.EEmote Emote, optional int nExtraInfo) { }

exec event PlayEmoteAtWorldLocation(TgPawn.EEmote Emote, optional int nExtraInfo) { }

unreliable client simulated event PlayEmoteSelfOnly(TgPawn.EEmote Emote, optional int nExtraInfo) { }

simulated event ClientPlayEmote(TgPawn.EEmote Emote, optional int nExtraInfo) { }

simulated event PlayEmoteSilhouetteEffect(TgPawn.EEmote Emote, optional int nExtraInfo) { }

simulated event bool CanEmoteDuringTimelapse(TgPawn.EEmote Emote) { }

simulated event TgPawn.EEmoteCategory GetEmoteCategory(TgPawn.EEmote Emote) { }

simulated event int GetEmotePriority(TgPawn.EEmote Emote) { }

simulated event float GetAbilityEmoteChance(TgPawn.EEmote Emote) { }

simulated event float GetEmoteChance(TgPawn.EEmote Emote) { }

simulated event bool EmoteDiceRoll(TgPawn.EEmote Emote) { }

simulated event bool TriggersEmoteGlobalCooldown(TgPawn.EEmote Emote) { }

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote) { }

simulated event float GetEmoteInternalCooldown(TgPawn.EEmote Emote) { }

simulated event RecordInternalEmoteTime(TgPawn.EEmote Emote) { }

simulated event RecordGlobalEmoteTime() { }

simulated event RecordNonLocalEmoteTime() { }

simulated event float GetLastEmoteTime(TgPawn.EEmote Emote) { }

simulated event bool IsEmoteOnInternalCooldown(TgPawn.EEmote Emote) { }

simulated event bool AreEmotesOnGlobalCooldown() { }

simulated event bool IsEmoteOnNonLocalCooldown(TgPawn.EEmote Emote) { }

simulated event bool EmoteShouldKillAllOtherVox(TgPawn.EEmote Emote) { }

function bool EmoteShouldForce3P(TgPawn.EEmote Emote) { }

event SetEmote3PCamera(bool bOn) { }

simulated event bool AnimNotifySound(SoundCue Cue) { }

simulated event PreDemoRewind() { }

simulated event PostDemoRewind() { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

function AdjustDevicesForNewDilation(float fPrevDilation, float fNewDilation) { }

simulated event bool CanFlyWithoutHover() { }

function bool CheckPhysicsStateForJumping() { }

function bool IsFiringAny() { }

function bool CannotJumpNow() { }

simulated event bool IsInJumpLanding() { }

function InterruptInhand() { }

function TgObject.TG_EQUIP_POINT OverrideOffhandSlot(TgObject.TG_EQUIP_POINT eqp) { }

simulated function SetMeshDepthPriority(Scene.ESceneDepthPriorityGroup NewDepth) { }

event bool CanPlayHitReaction() { }

function KillCloneTimer() { }

simulated event OnCameraCutAnimNotify(TgAnimNotify_CameraCut CameraCutNotify) { }

simulated function bool IsInputLocked() { }

simulated function bool InputLockedDueToFiring() { }

simulated function bool IsRotationLocked() { }

simulated function bool IsCameraLocked() { }

event bool CanApplyShield() { }

function bool OnMountCancelOffhandSlotPressed(TgDevice newDev) { }

simulated function PlayMountingEffects(bool bPlayMountAnim, bool bPostureChange) { }

simulated function StopMountingEffects(bool bPlayDismount, bool bPostureChange) { }

simulated function DetachMountMesh() { }

simulated function OnMountBegin(bool bForceFireDueToRespawn, bool bPostureChange) { }

simulated function SwitchBackToInhandInstantly() { }

simulated event bool IsFirstPerson() { }

function RemoveStealthEffects() { }

simulated event PlayBleedEffects(bool bEnabled) { }

simulated event PlayDazeEffects(bool bEnabled) { }

simulated event PlayCCImmuneEffects(bool bEnabled) { }

simulated event PlayOnFireEffects(bool bEnabled) { }

simulated event PlayFreezeEffects(bool bEnabled) { }

simulated event PlayKnockbackEffects(bool bEnabled) { }

simulated event PlayMarkEffects(bool bEnabled) { }

function ClientPlayGrassEffects(bool bEnabled, optional ParticleSystem Template) { }

function ClientPlayHiddenEffects(bool bEnabled, optional ParticleSystem Template) { }

simulated event PlayRootEffects(bool bEnabled) { }

simulated event PlayPoisonedEffects(bool bEnabled) { }

simulated event PlayCrippledEffects(bool bEnabled) { }

simulated event PlayFlashBangEffects(bool bEnabled) { }

simulated function CleanUpScreenCapturePostProcess() { }

simulated event PlaySlowEffects(bool bEnabled) { }

simulated event PlayRevealedEffects(bool bEnabled) { }

simulated function InterruptAllReloads() { }

simulated event InterruptInhandReload() { }

event bool HasDeviceByID(int DeviceID) { }

event bool HasActiveDeviceByID(int DeviceID) { }

event bool HasDeviceByClass(Class DeviceClass) { }

event bool HasActiveDeviceByClass(name DeviceClassName) { }

native event TgDevice GetDeviceByClass(Class DeviceClass);  // Export UTgPawn::execGetDeviceByClass(FFrame&, void* const)

event TgDevice GetActiveDeviceByClass(name DeviceClassName) { }

event InterruptDeviceFiringByClass(Class DeviceClass, optional bool bForce) { }

event InterruptAllMovementDevices() { }

event float GetDistanceToNearestCapturePoint() { }

simulated event SetUITargetingType(TgObject.EUITargetingType NewTargetingType, optional bool bForceRequiredToSet, optional TgObject.EUITargetingType RequiredToSet) { }

simulated function AddIncomingImpact(int bNumToAdd) { }

reliable client simulated function ClientSetActiveWeapon(Weapon NewWeapon) { }

function UpdateMetaGameState(TgPawn.EMetaGameState NewState) { }

function TgPawn.EMetaGameState GetMetaGameState() { }

function UpdateBotBehaviorState(TgPawn.EBotBehaviorState NewState) { }

function TgPawn.EBotBehaviorState GetBotBehaviorState() { }

native exec function TestFx(float Pct);  // Export UTgPawn::execTestFx(FFrame&, void* const)

exec function TgSpecialFx TestFx2(int Id) { }

function UpdateLastPlayerStart(PlayerStart NewLastPlayerStart) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

event AddInstigatorWallReveal(Actor Viewer) { }

event RemoveInstigatorWallReveal(Actor Viewer) { }

simulated event bool IsInstigatorWallRevealed(Actor Viewer) { }

event AddInstigatorStealthReveal(Actor Viewer) { }

event RemoveInstigatorStealthReveal(Actor Viewer) { }

native simulated function bool IsInstigatorStealthRevealed(Actor Viewer);  // Export UTgPawn::execIsInstigatorStealthRevealed(FFrame&, void* const)

event AddObscuringDeployable(TgDeployable deployable) { }

event RemoveObscuringDeployable(TgDeployable deployable) { }

event AddBlindingDeployable(TgDeployable deployable) { }

event RemoveBlindingDeployable(TgDeployable deployable) { }

native function UpdateWhiteOut();  // Export UTgPawn::execUpdateWhiteOut(FFrame&, void* const)

native function EndWhiteOut();  // Export UTgPawn::execEndWhiteOut(FFrame&, void* const)

function IntroTimer() { }

simulated function SetWhiteOutStartTimer() { }

simulated function BeginWhiteOutScaleUp() { }

simulated event bool IsPlayingIntro() { }

event DoIntroduction(bool bUseInitialIntro) { }

simulated function SetupIntroAnimNodesAndTimers() { }

simulated function EnterIntroPosture() { }

simulated function ExitIntroPosture(optional bool bForceAnimTreeOut) { }

simulated event FinishedIntroAnim(AnimNode IntroAnimNode) { }

event SetInitialHUDOverlayInfo() { }

simulated function TgRespawnBeaconExit GetTouchingRespawnBeacon() { }

function TouchingRespawnBeaconExit(TgRespawnBeaconExit RespawnBeacon, bool IsTouching) { }

singular simulated function UpdateHasRespawnBeacon(bool bHasRespawnBeacon) { }

reliable client simulated function ClientUpdateHasRespawnBeacon(bool bHasRespawnBeacon) { }

simulated function PlayFXHoldsBeacon(bool bShouldPlay) { }

simulated function PlayGenericTakeHit(Vector HitLocation, Vector HitNormal, TgPawn HitInstigator, float fDamageAmount, const out ExtraDamageInfo ExtraInfo) { }

simulated function OnStartTimelapseNewDeviceState() { }

simulated function Vector GetCameraOffsetOverride(Vector originalOffset) { }

exec function Polymorph(TgObject.EPolymorphType NewPolymorph) { }

native function SetPolymorph(TgObject.EPolymorphType NewPolymorph, Actor instigatingActor);  // Export UTgPawn::execSetPolymorph(FFrame&, void* const)

native function int GetPolymorphMeshID();  // Export UTgPawn::execGetPolymorphMeshID(FFrame&, void* const)

native function PlayPolymorphEffects(optional bool bForceOff);  // Export UTgPawn::execPlayPolymorphEffects(FFrame&, void* const)

native function SetAux(name AuxBusName, float Level);  // Export UTgPawn::execSetAux(FFrame&, void* const)

simulated event PreTimeLapse(bool bPlayOfTheGame) { }

simulated event PostTimeLapse(bool bPlayOfTheGame) { }

simulated function PrepTrackedProjectileRecreation(float recreateTimeOut) { }

simulated event RecreateTrackedProjectiles() { }

simulated event OnPolymorphChanged(bool bDead) { }

simulated function Rotator ApplyCameraRotationModifier(Rotator rCameraRot) { }

simulated function Rotator ApplyRecoilToRotation(Rotator rRot) { }

simulated function AllowDeviceToModifyInput(TgPlayerInput tgInput) { }

simulated event ForceUpdateAmmoAnim() { }

simulated event OnBecameSpectatorViewTarget() { }

simulated event OnCeaseSpectatorViewTarget() { }

native function SetThreatLevel(TgObject.EThreatLevel NewThreatLevel);  // Export UTgPawn::execSetThreatLevel(FFrame&, void* const)

native function float CheckOcclusion();  // Export UTgPawn::execCheckOcclusion(FFrame&, void* const)

event SetHUDOverlayDisplayMask(int dodm) { }

event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi) { }

event SetHUDOverlayState(TgObject.DeployableOverlayState dos) { }

event SetHUDOverlayEnemyViewDist(float enemyViewDist) { }

event UpdateHUDHealthPercent(float fPercent) { }

event ToggleHealAkEvent(bool bEnable) { }

function SetFaceRotationToController() { }

simulated function ForwardEffects(ImpactInfo Impact, TgEffectGroup EffectGroup, TgDevice SourceDevice, optional bool bRemove, optional int StackCount=1) { }

simulated function bool CanBeNudged() { }

simulated function bool ShouldNudgePlayer(TgPawn PlayerPawn) { }

simulated function float GetReloadScale() { }

native function float GetEnergyChargeModifier();  // Export UTgPawn::execGetEnergyChargeModifier(FFrame&, void* const)

native function ResetUlt();  // Export UTgPawn::execResetUlt(FFrame&, void* const)

simulated function TgDevice GetDeviceForAimAssist() { }

simulated function float GetMaxAimAssistStacks() { }

reliable server function ServerStartFlourish() { }

simulated function FlourishTimeoutFinished() { }

simulated event StartFlourish() { }

simulated event AppliedEffectRemoved(TgEffect RemovedEffect) { }

simulated event RegisterFor3pTransitionCB(delegate<On3pTransitionEvent> EventDelegate) { }

simulated function Invoke3pTransitionDelegates() { }

simulated event DisableMovementCorrection(float fDisableTime) { }

simulated event EnableMovementCorrection() { }

simulated function bool ShouldUseScopeSensitivity() { }

simulated event OnVGSSoundPlayed(int nVgsId) { }

simulated event OnVGSSoundFinished() { }

simulated event OnEmoteSoundPlayed(TgPawn.EEmote Emote) { }

simulated event OnEmoteSoundFinished() { }

state Dying {}

state Intro {}

state Idle {}

defaultproperties
{}
