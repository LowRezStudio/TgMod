class TgDevice extends Weapon
    native(Devices)
    hidecategories(Navigation)
    implements(TgGameplayCurveOwner)
    config(Engine)
    dependson(TgAimAssistKeyframe, TgClientSettings, TgGameplayCurvesSet, TgObject, TgTimerManager);

const TGMAX_FIRE_MODE = 5;

const TGEGT_EQUIP = 261;

const TGEGT_BUILDUP = 262;

const TGEGT_WHILE_FIRING = 263;

const TGEGT_WHILE_HOLDING = 15173;

const TGEGT_PRE_HIT_DELAY = 10455;

const TGEGT_POST_HIT_DELAY = 10456;

const TGEGT_EQUIP_MODE = 283;

const TGEGT_FIRED_PER_SHOT = 10030;

const TGEGT_ACTIVE = 11073;

const TGEGT_SUCCESSFUL_HIT = 759;

const TGEGT_HIT = 264;

const TGEGT_HIT_SPECIAL_MANAGED = 10036;

const TGEGT_HIT_SPECIAL_INSTANT = 10681;

const TGEGT_HIT_AURA = 10060;

const TGEGT_FINAL_BLOW = 10575;

const TGD_MESH_TYPE_INHAND = 855;

const TGD_MESH_TYPE_ATTACHED = 856;

const TG_VV_PACING_TYPE_HEALTH = 10692;

const TG_VV_PACING_TYPE_MANA = 10013;

const TG_VV_PACING_TYPE_ENERGY = 10014;

const TG_AIM_FUDGE_FACTOR = 256.0f;

const TG_RANGE_FALLOFF_BEGIN_PERCENT = 50.0f;

const TG_RANGE_FALLOFF_MIN_PERCENT = 10.0f;

const TG_AOE_FALLOFF_BEGIN_PERCENT = 70.0f;

const TG_AOE_FALLOFF_MIN_PERCENT = 70.0f;

const TG_MIN_REFIRE_SPEED = 0.5;

const TG_RETICULE_AIM_DISTANCE = 10.f;

const DEPLOYMODE_GROUND_DELTA_CHECK_DIST = 60.0f;

const DEPLOYMODE_MINIMUM_RADIUS_CHECK_DIST = 20.0f;

const REFIRE_SERVER_GRACE = 0.1f;

const COOLDOWN_SERVER_GRACE = 0.5f;

const TGDT_ABILITY1_CARD = 15000;

const TGDT_ABILITY2_CARD = 15188;

const TGDT_ALTFIRE_CARD = 15189;

const TGDT_ARMOR_CARD = 11051;

const TGDT_WEAPON_CARD = 11049;

const TGDT_BASIC_ATTACK = 10828;

const TGDT_TEST_DEVICE = 10844;

const TGDT_PASSIVES = 10964;

const TGDT_ABILITY = 11041;

const TGDT_MOVEMENT_ABILITY = 11070;

const TGDT_MOUNT = 11077;

const TGDT_SUB_COMPONENT = 11052;

const TGDT_ULTIMATE = 15052;

const TGDT_RECALL = 15054;

const TGDT_ACTIVES = 15055;

const TGDT_EMOTE = 15205;

const TGDT_SPRAY = 15332;

const TGDT_TALENT_ABILITY1 = 15381;

const TGDT_TALENT_ABILITY2 = 15390;

const TGDT_TALENT_ALTFIRE = 15391;

const TGDT_TALENT_ARMOR = 15392;

const TGDT_TALENT_WEAPON = 15393;

const TGDT_TALENT_ULTIMATE = 15437;

const TGDT_BOT_MELEE = 671;

const TGDT_BOT_RANGED = 670;

const TGDT_RANGED = 388;

const TGDT_CONSUMABLE = 10097;

const TG_CANCEL_SAFETY_PERIOD = 0.5f;

const TGDT_MAX_QUEUED_PROJECTILE_TOUCHES = 128;

const MAX_RECOIL_SEED = 32749;

enum EWeaponFireType {
    EWFT_InstantHit,  // 0
    EWFT_Projectile,  // 1
    EWFT_Custom,  // 2
    EWFT_None,  // 3
};

enum ETargetingModeStatus {
    TMS_None,  // 0
    TMS_CannotFire,  // 1
    TMS_CannotPlace,  // 2
    TMS_OK,  // 3
    TMS_OutOfRange,  // 4
};

enum EDeviceChangeEvent {
    DCE_Created,  // 0
    DCE_ToggleState,  // 1
    DCE_CanFire,  // 2
    DCE_Selected,  // 3
    DCE_Cooldown,  // 4
    DCE_PtsAlloc,  // 5
    DCE_Refire,  // 6
    DCE_InstanceCount,  // 7
    DCE_DeviceBuildup,  // 8
};

enum EAltFireType {
    ALTFIRE_None,  // 0
    ALTFIRE_SecondMode,  // 1
    ALTFIRE_AlternateDevice,  // 2
    ALTFIRE_AlternateDeviceAndFireInhand,  // 3
};

enum ENotifyDelegateEvents {
    NDE_OnFired,  // 0
    NDE_OnReload,  // 1
    NDE_OnStartFire,  // 2
    NDE_OnStopFire,  // 3
    NDE_Generic1,  // 4
    NDE_Generic2,  // 5
    NDE_Generic3,  // 6
};

enum DeviceEmoteAt {
    DEA_StartBuildup,  // 0
    DEA_StartFire,  // 1
    DEA_Custom,  // 2
};

enum DeviceTimerBarType {
    DTBT_None,  // 0
    DTBT_PreHit,  // 1
    DTBT_PostHit,  // 2
    DTBT_PersistTime,  // 3
    DTBT_RefireTime,  // 4
    DTBT_FireHold,  // 5
    DTBT_Custom,  // 6
};

struct AmmoTransaction {
    var float TransactionTimestamp;
    var int TransactionId;
    var int AmmoAmountChanged;
    var bool FilledClip;
    structdefaultproperties {}
};

struct TrackedFiringAmmoConsumption {
    var int FiringRequestID;
    var int AmmoConsumed;
    structdefaultproperties {}
};

struct TgQueuedSimulatedProjectileSpawn {
    var float TimeStampToSpawn;
    var int FireRequestId;
    var TgDeviceFire FireMode;
    var Vector ProjectileSpawnLocation;
    var Vector ProjectileSpawnDir;
    var int ProjectileIndex;
    var int ProjectileIdOverride;
    var float Range;
    var Actor trackingTarget;
    var Vector EndTrace;
    var float ClientMovementTimeStamp;
    var float AccuracyRandomValue1;
    var float AccuracyRandomValue2;
    structdefaultproperties {}
};

struct TgQueuedProjectileExplosion {
    var int ClientFireRequestId;
    var Actor Target;
    var Vector HitLocation;
    var Vector HitNormal;
    var float ProjectileAliveTime;
    var float MovementTimeStamp;
    var float AoeRewindTimeStamp;
    structdefaultproperties {}
};

struct ImpactToValidate {
    var int PackedAssociatedShotIDs;
    var float ImpactTimeStamp;
    var ImpactInfo Impact;
    structdefaultproperties {}
};

struct TgQueuedRefire {
    var int ClientFireRequestId;
    var byte DesiredFireMode;
    var AimData Aim;
    structdefaultproperties {}
};

struct TgQueuedInstantFireShot {
    var int FireRequestId;
    var AimData Aim;
    var ImpactToValidate PrimaryImpact;
    var array<ImpactToValidate> Impacts;
    var int AmmoToConsume;
    var float AccuracyRandomValue1;
    var float AccuracyRandomValue2;
    structdefaultproperties {}
};

struct AccuracySettings {
    var bool bUsesAdvancedAccuracy;
    var float fMaxAccuracy;
    var float fMinAccuracy;
    var float fAccuracyLossPerShot;
    var float fAccuracyGainPerSec;
    var float fAccuracyGainDelay;
    var int nNumFreeShots;
    structdefaultproperties {}
};

struct RecoilSettings {
    var bool bUsesRecoil;
    var float fRecoilReductionPerSec;
    var float fRecoilCenterDelay;
    var float fRecoilSmoothRate;
    structdefaultproperties {}
};

var repnotify int r_nDeviceId;
var int r_nDeviceInstanceId;
var repnotify int r_nInstanceCount;
var TgObject.TG_EQUIP_POINT r_eEquippedAt;
var byte CurrentFireMode;
var byte m_PendingFireMode;
var TgDevice.ETargetingModeStatus c_eTargetingModeStatus;
var byte m_nDesiredFireMode;
var TgObject.EDeviceFailType m_eCachedDeviceFailType;
var TgClientSettings.ECastMode m_eCastModeOverride;
var () TgDevice.EAltFireType m_AltFireType;
var TgObject.EReticuleType m_ReticuleType;
var TgObject.EReticuleType m_ZoomedReticuleType;
var TgDevice.DeviceEmoteAt m_DeviceEmoteAt;
var TgDevice.DeviceTimerBarType m_DeviceTimerBarType;
var repnotify int r_nPointsAllocated;
var bool m_bSocketMaxCalculated;
var bool r_bParentDeviceOwnedByOffhand;
var bool bPendingFire;
var bool m_IsPendingSetFireMode;
var bool m_bEquipEffectsApplied;
var bool m_CachedMissedInstantFire;
var bool c_bUsesTargetingReticle;
var bool r_OverrideUsesTargetingModeAsFalse;
var bool s_bIgnoreReceivedAim;
var bool m_bHandDevice;
var bool m_bProcAsIfHandDevice;
var bool m_bLockInputDuringFire;
var bool m_bLockCameraDuringFire;
var bool m_bShouldCacheAim;
var bool r_bConsumedOnUse;
var bool r_bConsumedOnDeath;
var bool m_bCachedDeviceCanFire;
var bool m_bCarryPreFireToPostFire;
var bool m_bIsSecondaryFire;
var bool m_bIgnoreSecondaryFireLogic;
var bool m_bConsumePowerPoolOnStartFire;
var bool m_bAlwaysStartCooldown;
var bool m_bInTargetingMode;
var bool m_IsBeingInterrupted;
var bool HasAlreadyFiredOnce;
var bool c_bAltFireSecondModeNow;
var bool m_bBuildupShouldInterruptStealth;
var bool m_bPreFireShouldInterruptStealth;
var bool m_bFireShouldInterruptStealth;
var bool m_bPostFireShouldInterruptStealth;
var bool m_bReloadingShouldInterruptStealth;
var bool m_bCancelingShouldInterruptStealth;
var bool m_bStartFireShouldEnterCombat;
var bool m_bFireShouldEnterCombat;
var bool m_bShouldUseInstigatorsTimeDilation;
var bool m_bDamages;
var bool m_bStuns;
var bool m_bSlows;
var bool m_bProjectileFollowOwnerYaw;
var bool m_bAimThroughReticule;
var bool m_bNoReticleBloom;
var bool m_bUseCustomCastMode;
var bool m_bIsAltFiring;
var bool m_bAltFireEnabled;
var bool m_bUsesBurstFire;
var bool m_bIsFirstBurstShot;
var bool m_bOnlyFirstBurstCostsAmmo;
var bool m_bBurstCanBeInterrupted;
var bool m_bCanEndBurstEarly;
var bool c_bBurstPendingStopFire;
var bool s_bInBurstRecovery;
var bool s_bIsStartingBurstFire;
var bool m_bCanRegenAmmoWhileFiring;
var bool m_bUsesSimulatedAmmo;
var bool m_bCanReloadEarly;
var bool m_bForce3PViewWhileFiring;
var bool m_bCanCancelWithJump;
var bool m_bEnterCombatOnFire;
var () bool m_bDeployAtFeetOnFailure;
var bool m_bMustBeOnGroundToFire;
var bool m_bHideTargeterWhenInvalid;
var bool m_bAbilityRequiresInhandResync;
var bool m_bParentAnimComponentHands;
var bool m_bParentAnimComponent1PHead;
var bool m_bAmmoWasGiven;
var bool m_bFirstAmmoWasGiven;
var bool m_bCooldownWasModified;
var bool m_bDisableLagCompensation;
var bool m_bUseRangeFalloffCurve;
var bool m_bUseDeviceMeshWhenTargeting;
var bool m_bPlayPutAway;
var bool m_bCanToggleTargeting;
var bool m_bRemoveTargetingOnMount;
var const bool m_bDoNotAllowHeadShots;
var const bool m_bConsolidateMultipleShots;
var bool m_bAllowFiringDuring3pTo1pTransition;
var bool s_bLockFiringForRoundEnd;
var bool m_bPreventInterrupt;
var bool m_bPreventCancel;
var bool m_bLogServerFireFailures;
var bool m_bUsesOutroLockout;
var bool m_bIsFireHoldDevice;
var bool m_bForceReleaseFireHoldWhenCharged;
var bool m_bFireHoldFull;
var bool m_DeviceTimerBarCountsUp;
var bool m_bCooldownAfterDeployDeath;
var int m_nSocketIndex;
var int m_nSocketMax;
var TgDevice s_ParentDevice;
var array<TgDeviceFire> m_FireMode;
var int r_nMeleeComboSeed;
var TgDeviceForm c_DeviceForm;
var TgTimerManager m_CooldownTimers;
var array<ImpactInfo> PendingImpactList;
var AimData c_TargetingAim;
var AimData m_CachedAim;
var float m_fCachedFirePostHitDelay;
var int m_CachedFireRequestId;
var AimData s_ReceivedAim;
var native Pointer m_pwzDeviceName;
var int m_nDeviceType;
var float EquipTime;
var TgInventoryObject_Device s_InventoryObject;
var int m_nSkillId;
var int r_nInventoryId;
var float m_fLastDeviceCanFireTimeStamp;
var float m_EndOfLastFireTimeStamp;
var float m_fFiringTimer;
var float m_fTimeAccountedFor;
var float m_fTimeStampAccountedFor;
var float m_IndividualOffhandCooldownTime;
var float m_fTotalReloadTime;
var float r_fCooldownDelay;
var float c_fCachedManaAtStartFire;
var TgDeviceFire s_WhileFiringDeviceMode;
var float m_fPreviousEnergy;
var float m_fUnequipTime;
var Vector m_vMeshViewOffset;
var float m_fWeaponBob;
var float m_fMeshFOV;
var () Vector m_vProjectileSpawnOffset;
var float m_fAltFireTimeStamp;
var float m_fAltFireLockOutTime;
var int m_nBurstTotalShots;
var int m_nBurstShotsRemaining;
var repnotify int r_nAmmoClipCount;
var int c_nSimLocalAmmoClipCount;
var array<AmmoTransaction> m_AmmoTransactions;
var array<AmmoTransaction> m_DelayedAmmoTransactions;
var array<AmmoTransaction> s_RecievedUnverifiedDelayedAmmoTransactions;
var array<AmmoTransaction> m_DelayedAmmoTransactionRegen;
var int m_nPendingRegenAmmoTransactionID;
var int m_nPendingReloadAmmoTransactionID;
var TrackedFiringAmmoConsumption c_EligableRefundFiringIDs[30];
var int c_nEligableRefundFiringIDsIndexLast;
var int c_nEligableRefundFiringIDsIndexFirst;
var int m_nLastFiringIDToConsumeAmmo;
var int r_nMaxAmmoClipCount;
var int m_UniqueAmmoValidationId;
var float m_fAmmoRegenPerSec;
var float m_fAmmoRegenCounter;
var array<TgProjectile> m_FiredProjectiles;
var float m_fForce3PPersistDuration;
var float m_fForce3PPersistTimer;
var float m_fEnterCombatDuration;
var repnotify TgDeployable r_Deployable;
var int r_nProjectiles;
var () float m_fDeployZForgiveness;
var float m_fBottomlessPitCheck;
var () float m_fDeployZOffset;
var array<int> m_Abilities;
var int m_DisplayIcon;
var string m_DisplayName;
var TgDevice m_PrimaryWeaponParent;
var () Class<TgWeaponMeshActor> m_WeaponMeshActorClass;
var Actor m_LastKnownHitActor;
var array< delegate<DeviceEvent> > m_OnFiredDelegates;
var array< delegate<DeviceEvent> > m_OnReloadDelegates;
var array< delegate<DeviceEvent> > m_OnStartFireDelegates;
var array< delegate<DeviceEvent> > m_OnStopFireDelegates;
var array< delegate<DeviceEvent> > m_Generic1Delegates;
var array< delegate<DeviceEvent> > m_Generic2Delegates;
var array< delegate<DeviceEvent> > m_Generic3Delegates;
var array<int> m_nLinkedDeviceIDs;
var array<int> m_nLinkedDeviceTypes;
var array<TgQueuedSimulatedProjectileSpawn> c_QueuedSimulatedProjectileSpawns;
var array<TgQueuedSimulatedProjectileSpawn> s_QueuedProjectileSpawnsFromServer;
var array<TgQueuedSimulatedProjectileSpawn> s_QueuedProjectileSpawnsFromClient;
var array<TgQueuedProjectileExplosion> s_QueuedProjectileExplosions;
var int s_nNumServerRefires;
var int s_nNumClientRefires;
var array<TgQueuedRefire> s_QueuedRefireRequests;
var array<TgQueuedInstantFireShot> s_QueuedInstantFireShotsFromServer;
var array<TgQueuedInstantFireShot> s_QueuedInstantFireShotsFromClient;
var native const transient Pointer m_RandomShotSpreadStream;
var int m_nLastSetShotSpreadSeed;
var Vector2D m_AimAssistMagnetScale;
var Vector2D m_AimAssistFrictionScale;
var Vector2D m_AimAssistTrackingScale;
var Vector2D m_AimVectorAssistMaxBoundsScale;
var Vector2D m_AimVectorAssistMaxAssistanceDegrees;
var array<AimAssistKeyframeData> m_AimAssistKeyframesMagnetVert;
var array<AimAssistKeyframeData> m_AimAssistKeyframesMagnetHoriz;
var array<AimAssistKeyframeData> m_AimAssistKeyframesFriction;
var array<AimAssistKeyframeData> m_AimAssistKeyframesTrackingAccHoriz;
var array<AimAssistKeyframeData> m_AimAssistKeyframesTrackingAngleHoriz;
var array<AimAssistKeyframeData> m_AimAssistKeyframesTrackingAccVert;
var array<AimAssistKeyframeData> m_AimAssistKeyframesTrackingAngleVert;
var TgGameplayCurves m_GameplayCurvesDeprecated;
var array<TgDevice> m_GameplayCurveOverrideDevices;
var int m_nServerControlledShotSpreadSeed;
var float m_fOutroLockoutTime;
var () float m_fMinTimeBetweenAmmoCharges;
var () ForceFeedbackWaveform m_ForceFeedbackStartHold;
var () ForceFeedbackWaveform m_ForceFeedbackFullHold;
var () ForceFeedbackWaveform m_ForceFeedbackStopHold;
var () ForceFeedbackWaveform m_ForceFeedbackStartFire;
var () ForceFeedbackWaveform m_ForceFeedbackStopFire;
var () ForceFeedbackWaveform m_ForceFeedbackStartBuildup;
var () ForceFeedbackWaveform m_ForceFeedbackStopBuildup;
var () ForceFeedbackWaveform m_ForceFeedbackPostFire;
var () ForceFeedbackWaveform m_ForceFeedbackStartReload;
var () ForceFeedbackWaveform m_ForceFeedbackStopReload;
var () ForceFeedbackWaveform m_ForceFeedbackStartCooldown;
var float s_fForceReleaseFirHoldFUBARTime;
var int s_nLastRequestedFireHoldReleaseID;
var (Accuracy) AccuracySettings m_AccuracySettings[5];
var float m_fCurrentAdvancedAccuracy;
var float m_fLastShotTimestamp;
var int m_nFreeShotsLeft;
var float m_fLastMinAccuracy;
var float m_fReticleBloomScale;
var (Recoil) RecoilSettings m_RecoilSettings[5];
var float m_fStartFiringTimestamp;
var float m_fAccumulatedFiringTime;
var transient int m_nRandRecoilNum;
var repnotify transient int r_nRecoilSeed;
var int m_nAimAssistPriorityWhileFiring;
var repnotify int r_nAllowUseWhileFlags;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) CurrentFireMode, r_Deployable, r_OverrideUsesTargetingModeAsFalse, r_eEquippedAt, r_fCooldownDelay, r_nAllowUseWhileFlags, r_nAmmoClipCount, r_nInstanceCount, r_nInventoryId, r_nMaxAmmoClipCount, r_nMeleeComboSeed, r_nPointsAllocated, r_nProjectiles, r_nRecoilSeed;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_bConsumedOnDeath, r_bConsumedOnUse, r_bParentDeviceOwnedByOffhand, r_nDeviceId, r_nDeviceInstanceId;
}

simulated delegate DeviceEvent();

native function bool ApplyDeviceSetup();  // Export UTgDevice::execApplyDeviceSetup(FFrame&, void* const)

native function name QueryProjectileClass(optional int nMode);  // Export UTgDevice::execQueryProjectileClass(FFrame&, void* const)

native function name QueryDeployableClass(optional int nMode);  // Export UTgDevice::execQueryDeployableClass(FFrame&, void* const)

native function name GetFireSocketName();  // Export UTgDevice::execGetFireSocketName(FFrame&, void* const)

native function CalcFireSocketIndexMax();  // Export UTgDevice::execCalcFireSocketIndexMax(FFrame&, void* const)

native function string GetDeviceName();  // Export UTgDevice::execGetDeviceName(FFrame&, void* const)

native function RemoveConsumableFromOwnerInventory();  // Export UTgDevice::execRemoveConsumableFromOwnerInventory(FFrame&, void* const)

native function bool LogDebugInfo();  // Export UTgDevice::execLogDebugInfo(FFrame&, void* const)

native function bool ServerDetonate(optional int nFireMode=0);  // Export UTgDevice::execServerDetonate(FFrame&, void* const)

native function TickTargetingMode(float DeltaSeconds);  // Export UTgDevice::execTickTargetingMode(FFrame&, void* const)

native function TgDeviceFire GetCurrentFire();  // Export UTgDevice::execGetCurrentFire(FFrame&, void* const)

native function TgDeviceFire GetDeviceFire(int nMode);  // Export UTgDevice::execGetDeviceFire(FFrame&, void* const)

native function ApplyEquipEffects();  // Export UTgDevice::execApplyEquipEffects(FFrame&, void* const)

native function RemoveEquipEffects();  // Export UTgDevice::execRemoveEquipEffects(FFrame&, void* const)

native function BecomeActive(optional bool bSkipActiveEffects);  // Export UTgDevice::execBecomeActive(FFrame&, void* const)

native function CeaseActive(optional bool bSkipActiveEffects);  // Export UTgDevice::execCeaseActive(FFrame&, void* const)

native function OnBecomeActive();  // Export UTgDevice::execOnBecomeActive(FFrame&, void* const)

native function OnCeaseActive();  // Export UTgDevice::execOnCeaseActive(FFrame&, void* const)

native function bool CheckModeRange(int nMode, Vector vDelta);  // Export UTgDevice::execCheckModeRange(FFrame&, void* const)

native function int GetModeRange(int nMode);  // Export UTgDevice::execGetModeRange(FFrame&, void* const)

native function bool IsOffhand();  // Export UTgDevice::execIsOffhand(FFrame&, void* const)

native function bool IsOwnedByOffhand();  // Export UTgDevice::execIsOwnedByOffhand(FFrame&, void* const)

native function bool IsPurchasedAbility();  // Export UTgDevice::execIsPurchasedAbility(FFrame&, void* const)

native function bool IsAbility(optional bool bExcludeMovement);  // Export UTgDevice::execIsAbility(FFrame&, void* const)

native function bool IsMovementAbility();  // Export UTgDevice::execIsMovementAbility(FFrame&, void* const)

native function bool IsEmote();  // Export UTgDevice::execIsEmote(FFrame&, void* const)

native function bool IsCard();  // Export UTgDevice::execIsCard(FFrame&, void* const)

native function bool IsArmorCard();  // Export UTgDevice::execIsArmorCard(FFrame&, void* const)

native function bool IsBurnCard();  // Export UTgDevice::execIsBurnCard(FFrame&, void* const)

native function bool IsTestDevice();  // Export UTgDevice::execIsTestDevice(FFrame&, void* const)

native function bool CanBeStunned();  // Export UTgDevice::execCanBeStunned(FFrame&, void* const)

native function bool CanBeSilenced();  // Export UTgDevice::execCanBeSilenced(FFrame&, void* const)

native function bool CanBeDisarmed();  // Export UTgDevice::execCanBeDisarmed(FFrame&, void* const)

native function bool CanBeCrippled();  // Export UTgDevice::execCanBeCrippled(FFrame&, void* const)

native function bool CanBeStasisLocked();  // Export UTgDevice::execCanBeStasisLocked(FFrame&, void* const)

native function bool CanBeGrabbed();  // Export UTgDevice::execCanBeGrabbed(FFrame&, void* const)

native function float GetConePullbackDistance();  // Export UTgDevice::execGetConePullbackDistance(FFrame&, void* const)

native function bool HasEnoughPowerPool(byte FireModeNum);  // Export UTgDevice::execHasEnoughPowerPool(FFrame&, void* const)

native function bool IsDeviceCoolingDown();  // Export UTgDevice::execIsDeviceCoolingDown(FFrame&, void* const)

native function bool IsInCooldownGracePeriod();  // Export UTgDevice::execIsInCooldownGracePeriod(FFrame&, void* const)

native function bool IsDeviceRefiring();  // Export UTgDevice::execIsDeviceRefiring(FFrame&, void* const)

native function TgTimerManager GetCooldownTimerManager();  // Export UTgDevice::execGetCooldownTimerManager(FFrame&, void* const)

native function CheckAndUpdateCooldown();  // Export UTgDevice::execCheckAndUpdateCooldown(FFrame&, void* const)

native function SendDeviceChangeEvent(TgDevice.EDeviceChangeEvent Event);  // Export UTgDevice::execSendDeviceChangeEvent(FFrame&, void* const)

native function SendCombatLogEvent(TgObject.ITEM_EVENT_TYPE Type);  // Export UTgDevice::execSendCombatLogEvent(FFrame&, void* const)

native function GetCombatLogEventLocation(out int LocationX, out int LocationY);  // Export UTgDevice::execGetCombatLogEventLocation(FFrame&, void* const)

native function float GetBuildupTime();  // Export UTgDevice::execGetBuildupTime(FFrame&, void* const)

native function float GetRefireTime(optional int nMode=-1);  // Export UTgDevice::execGetRefireTime(FFrame&, void* const)

native function float GetFiringPreHitDelay(optional int nMode=-1);  // Export UTgDevice::execGetFiringPreHitDelay(FFrame&, void* const)

native function float GetFiringPostHitDelay(optional int nMode=-1);  // Export UTgDevice::execGetFiringPostHitDelay(FFrame&, void* const)

native function float CacheFiringPostHitDelay();  // Export UTgDevice::execCacheFiringPostHitDelay(FFrame&, void* const)

native function float GetCachedFiringPostHitDelay();  // Export UTgDevice::execGetCachedFiringPostHitDelay(FFrame&, void* const)

native function TgObject.DeviceTargetMode GetTargetingMode();  // Export UTgDevice::execGetTargetingMode(FFrame&, void* const)

native function bool UsesTargetingMode();  // Export UTgDevice::execUsesTargetingMode(FFrame&, void* const)

native function bool UsesTrackingTarget();  // Export UTgDevice::execUsesTrackingTarget(FFrame&, void* const)

native function bool ForceDefaultCastMode();  // Export UTgDevice::execForceDefaultCastMode(FFrame&, void* const)

native function TgClientSettings.ECastMode DetermineCastMode(TgClientSettings.ECastMode desiredCastMode);  // Export UTgDevice::execDetermineCastMode(FFrame&, void* const)

native function bool UsesCachedAim();  // Export UTgDevice::execUsesCachedAim(FFrame&, void* const)

native function GetCachedAim(out AimData Aim);  // Export UTgDevice::execGetCachedAim(FFrame&, void* const)

native function AimData CacheAim();  // Export UTgDevice::execCacheAim(FFrame&, void* const)

native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);  // Export UTgDevice::execValidateReceivedAim(FFrame&, void* const)

native function UpdateTargetingModeStatus(const out AimData Aim);  // Export UTgDevice::execUpdateTargetingModeStatus(FFrame&, void* const)

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice::execGetTargetingAim(FFrame&, void* const)

native function GetReticleTargetAim(out AimData Aim);  // Export UTgDevice::execGetReticleTargetAim(FFrame&, void* const)

native function GetReticleFindSpotAim(out AimData Aim);  // Export UTgDevice::execGetReticleFindSpotAim(FFrame&, void* const)

native function GetConeTargetAim(out AimData Aim);  // Export UTgDevice::execGetConeTargetAim(FFrame&, void* const)

native function GetAOETargetAim(out AimData Aim);  // Export UTgDevice::execGetAOETargetAim(FFrame&, void* const)

native function GetSelfTargetAim(out AimData Aim);  // Export UTgDevice::execGetSelfTargetAim(FFrame&, void* const)

native function GetLinearTargetAim(out AimData Aim);  // Export UTgDevice::execGetLinearTargetAim(FFrame&, void* const)

native function GetGroundTargetAim(out AimData Aim);  // Export UTgDevice::execGetGroundTargetAim(FFrame&, void* const)

native function GetLockOnTargetAim(out AimData Aim);  // Export UTgDevice::execGetLockOnTargetAim(FFrame&, void* const)

native function GetSpawnPointTargetAim(out AimData Aim);  // Export UTgDevice::execGetSpawnPointTargetAim(FFrame&, void* const)

native function GetWorldMapTargetAim(out AimData Aim);  // Export UTgDevice::execGetWorldMapTargetAim(FFrame&, void* const)

native function bool CanLockOnToTarget(Actor Target);  // Export UTgDevice::execCanLockOnToTarget(FFrame&, void* const)

native function bool CanAllowLagCompensation();  // Export UTgDevice::execCanAllowLagCompensation(FFrame&, void* const)

native function UpdateAimWhileFiring(out AimData Aim);  // Export UTgDevice::execUpdateAimWhileFiring(FFrame&, void* const)

native function bool IsActive(optional bool bIgnoreCooldown, optional bool bIngoreEquipped);  // Export UTgDevice::execIsActive(FFrame&, void* const)

native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);  // Export UTgDevice::execIsTargetingModeReady(FFrame&, void* const)

native function bool IsInTargetingMode();  // Export UTgDevice::execIsInTargetingMode(FFrame&, void* const)

native function EnterTargetingMode();  // Export UTgDevice::execEnterTargetingMode(FFrame&, void* const)

native function ExitTargetingMode();  // Export UTgDevice::execExitTargetingMode(FFrame&, void* const)

native function int GetTotalDevicePoints();  // Export UTgDevice::execGetTotalDevicePoints(FFrame&, void* const)

native function int GetAllocatedDevicePoints();  // Export UTgDevice::execGetAllocatedDevicePoints(FFrame&, void* const)

native function bool AllocateDevicePoint();  // Export UTgDevice::execAllocateDevicePoint(FFrame&, void* const)

native function ClientPtsAllocatedUpdated();  // Export UTgDevice::execClientPtsAllocatedUpdated(FFrame&, void* const)

native function SetPointsAllocated(int nPoints);  // Export UTgDevice::execSetPointsAllocated(FFrame&, void* const)

native function SetInstanceCount(int nInstanceCount);  // Export UTgDevice::execSetInstanceCount(FFrame&, void* const)

native function bool ShouldInterruptStealth();  // Export UTgDevice::execShouldInterruptStealth(FFrame&, void* const)

native function bool ShouldInterruptLift();  // Export UTgDevice::execShouldInterruptLift(FFrame&, void* const)

native function bool ShouldLiftInterrupt();  // Export UTgDevice::execShouldLiftInterrupt(FFrame&, void* const)

native function bool ShouldShowAmmoCount();  // Export UTgDevice::execShouldShowAmmoCount(FFrame&, void* const)

native function bool HasAmmo(byte FireModeNum, optional int Amount);  // Export UTgDevice::execHasAmmo(FFrame&, void* const)

native function bool RequiresAmmoToFire();  // Export UTgDevice::execRequiresAmmoToFire(FFrame&, void* const)

native function int GetCurrentAmmoAmount();  // Export UTgDevice::execGetCurrentAmmoAmount(FFrame&, void* const)

native function bool ShouldTreatAmmoAsCharges();  // Export UTgDevice::execShouldTreatAmmoAsCharges(FFrame&, void* const)

native function UpdateAmmoRegen(optional bool bUpdateCooldown=false, optional float fCooldownFloor=0.0000000);  // Export UTgDevice::execUpdateAmmoRegen(FFrame&, void* const)

native function float GetCurrentReloadPct();  // Export UTgDevice::execGetCurrentReloadPct(FFrame&, void* const)

native function bool CheckAutoReload();  // Export UTgDevice::execCheckAutoReload(FFrame&, void* const)

native function bool CanReload(optional bool bIsAutoReload=false);  // Export UTgDevice::execCanReload(FFrame&, void* const)

native function bool IsReloading();  // Export UTgDevice::execIsReloading(FFrame&, void* const)

native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);  // Export UTgDevice::execShouldBlockReload(FFrame&, void* const)

native function float GetAccuracy(optional int nMode=-1);  // Export UTgDevice::execGetAccuracy(FFrame&, void* const)

native function float GetRandRecoil(float Min, float Max);  // Export UTgDevice::execGetRandRecoil(FFrame&, void* const)

native function SetFireMode(int nFireModeNum, optional bool ForceSet=false);  // Export UTgDevice::execSetFireMode(FFrame&, void* const)

native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);  // Export UTgDevice::execDeviceAdjustDamage(FFrame&, void* const)

native function DeviceAdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);  // Export UTgDevice::execDeviceAdjustHeal(FFrame&, void* const)

native function int GetPetIDOverride(int PetIndex);  // Export UTgDevice::execGetPetIDOverride(FFrame&, void* const)

native function ReplicatePlayerDeviceAmmo();  // Export UTgDevice::execReplicatePlayerDeviceAmmo(FFrame&, void* const)

native function bool HasRemoteOwner();  // Export UTgDevice::execHasRemoteOwner(FFrame&, void* const)

native function int GenerateUniqueFireRequestId();  // Export UTgDevice::execGenerateUniqueFireRequestId(FFrame&, void* const)

native function int GenerateUniqueAmmoValidationId();  // Export UTgDevice::execGenerateUniqueAmmoValidationId(FFrame&, void* const)

native function bool ValidateClientProjectileImpact(TgProj_Simulated SimulatedProjectile, float ProjectileAliveTime, Actor Other, float MovementTimeStamp, Vector HitLocation, Vector HitNormal);  // Export UTgDevice::execValidateClientProjectileImpact(FFrame&, void* const)

native function bool ValidateClientInstantHit(out ImpactInfo ValidPrimaryImpact, out array<ImpactInfo> OutValidImpacts, const out AimData InServerAim, const out AimData InClientAim, const out ImpactToValidate InPrimaryImpact, const out array<ImpactToValidate> InClientImpacts, out array<float> OutHitRanges);  // Export UTgDevice::execValidateClientInstantHit(FFrame&, void* const)

native function SetRandomShotSpreadSeed(int Seed);  // Export UTgDevice::execSetRandomShotSpreadSeed(FFrame&, void* const)

native function RecordUsedAim(const out Vector InAim);  // Export UTgDevice::execRecordUsedAim(FFrame&, void* const)

native function string GetLastUsedAimStats();  // Export UTgDevice::execGetLastUsedAimStats(FFrame&, void* const)

native function string GetAimValidationStats();  // Export UTgDevice::execGetAimValidationStats(FFrame&, void* const)

native function string GetInstantFirePredictionStats();  // Export UTgDevice::execGetInstantFirePredictionStats(FFrame&, void* const)

native function string GetProjectilePredictionStats();  // Export UTgDevice::execGetProjectilePredictionStats(FFrame&, void* const)

native function float GetHeadShotDamage(optional TgDeviceFire FireMode);  // Export UTgDevice::execGetHeadShotDamage(FFrame&, void* const)

native function bool IsSuccessfulHitImpact(Actor ImpactedActor);  // Export UTgDevice::execIsSuccessfulHitImpact(FFrame&, void* const)

native function bool ShouldAltFireOnTick();  // Export UTgDevice::execShouldAltFireOnTick(FFrame&, void* const)

native function bool UpdateUltChargePercent();  // Export UTgDevice::execUpdateUltChargePercent(FFrame&, void* const)

native function float GetRequiredEnergyToFire();  // Export UTgDevice::execGetRequiredEnergyToFire(FFrame&, void* const)

native function ConsolidateImpacts(out array<ImpactInfo> ImpactsToConsolidate, out array<float> ShotRanges, optional out array<byte> ShotToImpactIndex);  // Export UTgDevice::execConsolidateImpacts(FFrame&, void* const)

native function float GetBaseDamageMultiplier(const out ImpactInfo hitImpact);  // Export UTgDevice::execGetBaseDamageMultiplier(FFrame&, void* const)

native function TgGameplayCurvesSet GetShotSpreadTendencyCurvesSet();  // Export UTgDevice::execGetShotSpreadTendencyCurvesSet(FFrame&, void* const)

native function float GetFireHoldTime();  // Export UTgDevice::execGetFireHoldTime(FFrame&, void* const)

native function float GetFireHoldRate();  // Export UTgDevice::execGetFireHoldRate(FFrame&, void* const)

native function float GetFireHoldAccuracyLow();  // Export UTgDevice::execGetFireHoldAccuracyLow(FFrame&, void* const)

native function float GetFireHoldDamageLow();  // Export UTgDevice::execGetFireHoldDamageLow(FFrame&, void* const)

native function float GetFireHoldPct();  // Export UTgDevice::execGetFireHoldPct(FFrame&, void* const)

native function bool ShouldAutoFire();  // Export UTgDevice::execShouldAutoFire(FFrame&, void* const)

native function DeviceFailLog(bool bDeviceFailLog, coerce string S);  // Export UTgDevice::execDeviceFailLog(FFrame&, void* const)

native function TgGameplayCurves GetCurrentGameplayCurves();  // Export UTgDevice::execGetCurrentGameplayCurves(FFrame&, void* const)

native function TgGameplayCurvesSet GetCurrentGameplayCurveSet(TgGameplayCurvesSet.ECurveSetTypes Type);  // Export UTgDevice::execGetCurrentGameplayCurveSet(FFrame&, void* const)

native function bool UseRangeFalloffCurve();  // Export UTgDevice::execUseRangeFalloffCurve(FFrame&, void* const)

native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm=false);  // Export UTgDevice::execShouldForce3P(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function WeaponLog(coerce string msg, coerce string FuncStr) { }

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos) { }

simulated function DisplayMessage(string sMessage) { }

event ForceCooldownIfFiring() { }

native function bool CanSpawnOnClientFirst(Class<Projectile> ProjectileClass, bool bUsesTrackingTarget);  // Export UTgDevice::execCanSpawnOnClientFirst(FFrame&, void* const)

native function bool NativeIsFiring();  // Export UTgDevice::execNativeIsFiring(FFrame&, void* const)

native function bool IsDeviceFiringForUI();  // Export UTgDevice::execIsDeviceFiringForUI(FFrame&, void* const)

native function bool IsDeviceFiringLockedForUI();  // Export UTgDevice::execIsDeviceFiringLockedForUI(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice::execCanDeviceFireNow(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice::execMustBeOnGroundToFire(FFrame&, void* const)

native function bool CanFireWhileMounted();  // Export UTgDevice::execCanFireWhileMounted(FFrame&, void* const)

native function bool CanFiringBeLocked();  // Export UTgDevice::execCanFiringBeLocked(FFrame&, void* const)

simulated event bool IsEquipping() { }

simulated function float GetRange() { }

simulated function float GetEffectiveRange() { }

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController) { }

simulated function bool InterceptRightMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptRightMouseReleased(TgPlayerController TgController) { }

simulated function bool InterceptSlotPressed(TgPlayerController TgController) { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated event bool CanBeCanceled() { }

simulated event bool CanFiringBeCanceledByLeftMouse() { }

simulated event bool CanFiringBeCanceledByRightMouse() { }

simulated function bool CheckReactivationToggleLogic(out byte bSuccessfulCancel) { }

simulated event bool CanFiringBeCanceledByReactivation() { }

simulated event bool CanBeFiredWhileTweening() { }

simulated event bool CanJumpWhileFiring() { }

simulated event bool CancelledByJumping() { }

simulated event bool CanBeInterrupted() { }

simulated event bool ShouldInterruptInhand() { }

simulated function bool ShouldInterruptMount() { }

simulated function bool ShouldInterruptEmote() { }

function GenerateRecoilSeed() { }

simulated function AddRecoil() { }

simulated function TgGameplayCurvesSet_RecoilSimple GetRecoilCurve() { }

simulated function float GetRecoilMultiplier() { }

simulated function PostBeginPlay() { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice::execCanFireIfLeftMouseDown(FFrame&, void* const)

native function Rotator GetAdjustedAim(vector StartFireLoc);  // Export UTgDevice::execGetAdjustedAim(FFrame&, void* const)

simulated event SetActiveState() { }

reliable server function ServerDoRemoteDetonation(int nFireMode) { }

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns) { }

simulated function DeviceRestart() { }

simulated function StopFiringServerDeviceLockout() { }

reliable server function ServerNotifyClientAckLockout() { }

reliable server event InterruptFiring() { }

reliable server event InterruptFiringServerOnly() { }

function InterruptFiringOnServerInternal(optional bool bSendClientInterrupt=true) { }

simulated function AsynchronusInterrupt() { }

simulated function ClientInitiatedInterrupt() { }

reliable client simulated function ClientRefundAmmo(int nRefundAmount, int nFireRequestID) { }

reliable client simulated event ClientInterrupt() { }

reliable client simulated function ClientRemoveSpawnedProjectile(int nFiringID) { }

simulated function OnInterruptEvent() { }

simulated function bool ShouldCancelStealth() { }

reliable server event ServerFlashEnterTargetingMode(bool bEnterTargeting) { }

simulated function PlayClientFireFx(Vector HitLocation, int nSocketIndex, bool bSuccessfulHit, float fRefireTime) { }

simulated event DeviceConsumePowerPool(byte FireModeNum) { }

simulated function bool UsesHealth() { }

simulated function bool UsesMana() { }

simulated function bool UsesEnergy() { }

event ConsumeDevice() { }

simulated function bool CanFireWhileHanging() { }

simulated function float GetLockoutExtensionTime() { }

simulated function bool IsInhandOverrideActive() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanFireWithoutAimResult() { }

simulated function CacheDeviceCanFire(bool bDeviceCanFire, TgObject.EDeviceFailType failType) { }

simulated event bool CanDeviceStartFiringNow(byte FireModeNum, AimData Aim, bool bDebugRelevant, optional out TgObject.EDeviceFailType failType) { }

simulated event bool Use() { }

simulated function bool StartFireHold() { }

simulated function FireHoldTimer() { }

function FireHoldValidationTimer() { }

function FireHoldForceReleaseFUBAR() { }

simulated function InterruptFireHold() { }

simulated function InterruptBurst() { }

simulated function SetFireHoldAmt(float fFireHoldTime) { }

simulated event ReleaseFireHold() { }

reliable server function ServerReleaseFireHold(float fClientFireHoldPercent, int nClientFireRequestId) { }

simulated function ReleaseFireHoldInternal() { }

reliable client simulated event ClientSimulateStartFireFromServer() { }

simulated event bool SimulateStartFire() { }

function bool DeviceSpawnsClientProjectilesFirst() { }

simulated event bool ShouldInterruptReloadOnFire() { }

simulated event bool ShouldInterruptReloadOnBeginTargeting() { }

simulated function bool CanEnterCombat() { }

simulated event bool ShouldCooldownAfterFire() { }

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

simulated function bool ShouldConsumePowerPoolAfterFire() { }

simulated function bool ShouldSwitchBackToBasicAttackTargeting(TgClientSettings.ECastMode CastMode) { }

simulated event float GetRemainingFiringTime() { }

simulated event StartFire(byte FireModeNum) { }

simulated event HandleFalseFireRecory() { }

simulated function OnStartFireRequestSent() { }

simulated function SetFireLock() { }

simulated function GlobalOffhandCooldownCompleteServer() { }

simulated function GlobalOffhandCooldownCompleteClient() { }

simulated function FireLockComplete() { }

event ServerStartFireAsEvent() { }

reliable server function ServerQueueProjectileExplode(int ClientFireRequestId, float ProjectileAliveTime, Actor Other, float MovementTimeStamp, float HitLocationX, float HitLocationY, float HitLocationZ, float HitNormalX, float HitNormalY, float HitNormalZ) { }

function HandleQueuedProjectileExplosion(TgProj_Simulated SimulatedProjectile, float ProjectileAliveTime, Actor Other, float MovementTimeStamp, float AoeRewindTimeStamp, Vector HitLocation, Vector HitNormal) { }

reliable server function ServerAckProjectileSpawn(int ClientFireRequestId) { }

simulated function float GetLastMoveTimeStamp(out Vector LastSentMoveAcceleration, out int LastSentMoveCompressedFlags, out Vector LastSentClientLoc, out byte LastSentClientRoll, out int LastSentView) { }

simulated function CallServerStartFire(AimData Aim, optional bool bPendingUpdate) { }

simulated function CallServerRestartFireLoop(AimData Aim) { }

reliable server function ServerRestartFireLoop(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, byte ClientFireMode, Actor HitActor, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, int nCompressedAimVector, bool bFirstBurstShot) { }

reliable server function ServerStartFire(byte FireModeNum) { }

singular function StartFiringOnServer(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, byte ClientFireMode, Actor HitActor, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, int nCompressedAimVector, bool bFirstBurstShot) { }

simulated function bool CanToggleDeviceStopFiring() { }

simulated function StopFire(byte FireModeNum) { }

event StopFireAsEvent() { }

event ServerStopFireAsEvent() { }

reliable server function ServerStopFire(byte FireModeNum) { }

simulated event ForceStopFire() { }

reliable server function ServerForceStopFire() { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

simulated event DeliverQueuedPendingHits() { }

simulated event DeliverHit(ImpactInfo Impact) { }

simulated event InstantFire() { }

simulated function HandleInstantFireWithConsolidation(const out AimData baseaim, const out AimData Aim, out ImpactInfo Impact, bool bSendForServerValidation) { }

function PerformOnInstantFireServerValidation(const out AimData Aim, float AccuracyRandomValue1, float AccuracyRandomValue2) { }

simulated function SendImpactsForVerification(const out AimData baseaim, const out ImpactInfo Impact, const optional out array<byte> nShotsToImpactIndex) { }

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact) { }

function OnInstantShotRejected(ImpactToValidate RejectedPrimaryImpact) { }

function HandleClientReportedInstantShot(AimData InServerAim, AimData InClientAim, ImpactToValidate InPrimaryImpact, array<ImpactToValidate> InClientImpacts) { }

reliable server function ServerInstantFire(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, ImpactToValidate Impact, int NumImpacts, ImpactToValidate InImpactList[10]) { }

reliable server function ServerInstantFireThreeImpacts(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, ImpactToValidate Impact, int NumImpacts, ImpactToValidate InImpactList[3]) { }

reliable server function ServerInstantFireSingleImpact(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, ImpactToValidate Impact) { }

function AOEArcingFlash(array<ImpactInfo> ImpactList, optional Vector StartLocation=vect(0.0000000, 0.0000000, 0.0000000)) { }

simulated function CustomFire() { }

simulated function TgDeviceFire GetFireModeForFiringProjectile() { }

simulated function SpawnQueuedSimulatedProjectile() { }

simulated function TgProj_Simulated SpawnSimulatedProjectile(bool bCanSpawnOnClientFirst, int FireRequestId, int ProjectileInstanceId, TgDeviceFire FireMode, Vector ProjectileSpawnLocation, Vector ProjectileSpawnDir, int ProjectileIndex, int ProjectileIdOverride, float Range, Actor trackingTarget, Vector EndTrace) { }

simulated function AdjustSpawnedProjectile(out TgProj_Simulated SpawnedProjectile) { }

reliable server function ServerProjectileFire(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, int ProjectileIndex, float ProjectileLocationX, float ProjectileLocationY, float ProjectileLocationZ, float ProjectileAimVectorX, float ProjectileAimVectorY, float ProjectileAimVectorZ, float ProjectileEndTraceX, float ProjectileEndTraceY, float ProjectileEndTraceZ) { }

simulated function Projectile ProjectileFire() { }

simulated function int GetProjectileIDOverride(int ProjectileIndex) { }

simulated function vector GetPhysicalFireStartLoc(optional vector AimDir) { }

simulated function Actor GetTrackingTarget() { }

function TrackDeviceModeFired(TgPawn PawnFiring) { }

simulated function int GetAmmoToConsume() { }

simulated function bool ShouldConsumeAmmo(int nFireRequestID, optional array<ImpactToValidate> Impacts) { }

simulated function ConsumeAmmoFromFiring(optional int nAmmoConsumptionOverride=-1, optional int nFireRequestIDOverride=-1) { }

simulated function FireAmmunition() { }

simulated function float GetMinAccuracy() { }

simulated function UpdateActiveProjectiles(optional TgProjectile Proj) { }

simulated function bool AltFireDetonate() { }

simulated function float GetAltFireDetonateDamagePct() { }

simulated event float GetCooldownRemaining() { }

function CooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent, optional bool bNoBecomeActive) { }

simulated function ClientCooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent) { }

function AlternateStartCooldown() { }

simulated event StartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

event ResetCooldown(int nMode, optional float fCooldownTimeOverride=-1.0000000) { }

simulated event float GetCooldownTime(optional int nMode=-1) { }

simulated event EndCooldown() { }

reliable client simulated event ClientStartCooldown(int nMode, float fCooldownTime) { }

reliable client simulated event ClientResetCooldown(int nMode, float fCooldownTime) { }

reliable client simulated event ClientEndCooldown() { }

simulated function NotifyPutAway() { }

simulated event NotifySwitchMode() { }

simulated function UpdateDesiredFireMode() { }

simulated function ChangeFireModeOnRefire() { }

function OnTeleportNotify(Actor TeleportingActor) { }

function OnProjectileShutdown(TgProjectile Proj) { }

simulated event LockInput(bool bShouldLock) { }

simulated function LockCamera(bool bShouldLock) { }

simulated function LockRotation(bool bShouldLock) { }

simulated function RefireCheckTimer() { }

simulated function FirePreHitDelay() { }

simulated function FirePostHitDelay() { }

simulated function DeviceBuildupTimer() { }

simulated function OutroLockoutTime() { }

simulated function bool ShouldRefire() { }

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function UpdateIndex() { }

simulated event Destroyed() { }

simulated event bool ApplyGlobalOffhandCooldown() { }

simulated event bool IsToggleDevice() { }

simulated event bool IsFunctionallyToggleDevice() { }

simulated function AdjustForNewDilation(float fPrevDilation, float fNewDilation) { }

event ClientReconnected() { }

simulated function StopFiringLogic() { }

simulated function bool IsUnEquipping() { }

simulated function bool TryPutDown() { }

simulated function UnequipWeapon() { }

simulated function CancelUnequip() { }

simulated function bool AllowSwitchTo(Weapon NewWeapon) { }

simulated function Activate() { }

simulated function AltUse(bool bEnable) { }

reliable server function ServerAltUse(bool bEnable) { }

simulated event SetAltFireSecondModeNow(bool bEnable) { }

reliable server function ServerSetAltFireSecondModeNow(bool bEnable) { }

simulated event bool UsesSimulatedAmmo() { }

simulated function VerifyAmmoTransaction(int nTransactionID, int nAmmoChanged, bool bFilledClip) { }

reliable server function ServerValidateAmmoTransaction(int nTransactionID, int nAmmoChanged) { }

reliable client simulated function LogWarnDelayedAmmoTransactionOnClient(int nTransactionID, int nAmmoAmountChanged, float fTimeDelayed, bool bLateServer, int nServerCurrentTransactionID) { }

reliable client simulated function ClientValidateAmmoResponse(int nTransactionID, int nAmmoChanged, optional bool bFubar=false) { }

simulated event int SetAmmoDelayedWithValidation(int AmmoCount, float DelayAmt) { }

simulated event bool CancelSetAmmoDelayed(int nTransactionID) { }

simulated event bool SendImmediateSetAmmoDelayed(int nTransactionID) { }

simulated event bool ValidateDelayedAmmoTransactionRegen(int nTransactionID, optional bool bInitiateNewTransactionForRegen=false) { }

reliable server function ServerValidateDelayedRegenAmmoTransaction(int nTransactionID, int nAmmoChanged, bool bInitiateNewTransactionForRegen) { }

reliable client simulated function ClientValidateDelayedRegenAmmoResponse(int nTransactionID, int nAmmoChanged) { }

simulated event int GiveAmmoDelayedWithValidationRegen(int nAmmoCountAdded) { }

simulated event bool UpdateDelayedAmmoTransactionRegen(int nTransactionID, int nAmmoCountAdded) { }

simulated event SetAmmo(int AmmoCount, optional int ClipSize=-1, optional bool bShouldValidate=false, optional int ValidationIDOverride=0) { }

simulated function UpdateLocalAmmoCount(int nNewAmmoAmt) { }

simulated event ConsumeAmmo(byte FireModeNum) { }

simulated event GiveAmmo(optional int Amount=1, optional bool bShouldValidate=false) { }

event GiveAmmoWithClientSync(optional int Amount=1) { }

reliable client simulated function ClientSyncAmmoGivenFromServer(int Amount) { }

simulated event ReloadAmmo(optional bool bToFull, optional bool bShouldValidate=false) { }

simulated function ReloadAmmoWithSynchronization() { }

reliable server function ServerSyncAmmoTransactionID(int nNewID) { }

simulated event ResetAmmoTransactions() { }

event FlashUpdateAmmoOnPawn() { }

reliable server function ServerStartReload() { }

reliable client simulated function ClientForceReload() { }

simulated event bool StartReload(optional bool bIgnoreCurrentAmmo=false) { }

simulated function FullReloadTimer() { }

simulated function PreReloadTimer() { }

simulated function PostReloadTimer() { }

simulated event InterruptReload() { }

reliable client simulated function ClientInterruptReload(optional bool bAllowAmmoFill=false) { }

event OnDeployableDestroyed(TgDeployable deployable) { }

simulated event OnDeployableSpawned(TgDeployable deployable) { }

simulated event float GetRefirePercent() { }

simulated event float GetRefireRate() { }

simulated event Vector GetProjectileSpawnOffset() { }

simulated event bool ShouldMountCancelFiring() { }

simulated function bool RegisterDelegate(TgDevice.ENotifyDelegateEvents ndeType, delegate<DeviceEvent> DeviceEventDelegate) { }

simulated function bool UnregisterDelegate(TgDevice.ENotifyDelegateEvents ndeType, delegate<DeviceEvent> DeviceEventDelegate) { }

simulated function NotifyDeviceEvent(TgDevice.ENotifyDelegateEvents ndeType) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

event OnLinkDevice(TgPawn TgP) { }

event OnUnlinkDevice(TgPawn TgP) { }

reliable client simulated event ClientDeviceFirePropertyChange(int nMode, int nPropertyId, float fNewValue) { }

function OnCripple() { }

function OnKnock() { }

reliable server event OnCanceled() { }

simulated function OnCanceledClient() { }

simulated event bool PlayHitReactionOverride() { }

simulated function bool ShouldStopActionOnOffhandSlotReleased() { }

simulated exec function DesyncAmmoTransactionID(optional int Amt=1) { }

reliable client simulated function ClientSetAimAssistValues(float MagnetScaleX, float MagnetScaleY, float FrictionScaleX, float FrictionScaleY, float TrackingScaleX, float TrackingScaleY) { }

reliable client simulated function ClientSetAimVectorAssistValues(float BoundsScaleX, float BoundsScaleY, float MaxAngleX, float MaxAngleY) { }

simulated function bool CanToggleTargetingOff() { }

simulated function bool ReleaseHoldOnRightMouseReleased() { }

simulated function OnOwnerRespawn() { }

simulated event PlayNextSimulatedForceFeedbackWaveform(ForceFeedbackWaveform Prev, ForceFeedbackWaveform Next, optional float fScaleMagnitude=1.0000000, optional float fScaleDuration=1.0000000, optional bool bFromPawnPosition) { }

simulated function int GetAimAssistPriority() { }

simulated function bool RequireLookForAimAssist() { }

simulated function bool RequireMovementForAimAssist() { }

simulated function UpdateOutroLockoutTime() { }

simulated event RegisterAsGameplayCurveOverrideDevice(TgDevice Dev) { }

simulated event UnregisterAsGameplayCurveOverrideDevice(TgDevice Dev) { }

simulated event ApplyAllowUseWhileFlags(int nAllowUseWhileFlags) { }

simulated function float GetIndividualOffhandCooldownTime() { }

simulated event float GetCustomTimerBarCurrentTime() { }

simulated event float GetCustomTimerBarMaxTime() { }

auto state Active {}

state DeviceBuildup {}

state DeviceFiring {}

state WeaponEquipping {}

state WeaponUnequipping {}

state Inactive {}

defaultproperties
{
    m_nDesiredFireMode=255
    m_ReticuleType=RETICULE_Circle
    m_ZoomedReticuleType=RETICULE_Circle
    c_bUsesTargetingReticle=true
    m_bHandDevice=true
    m_bCarryPreFireToPostFire=true
    m_bBuildupShouldInterruptStealth=true
    m_bPreFireShouldInterruptStealth=true
    m_bFireShouldInterruptStealth=true
    m_bPostFireShouldInterruptStealth=true
    m_bReloadingShouldInterruptStealth=true
    m_bCancelingShouldInterruptStealth=true
    m_bStartFireShouldEnterCombat=true
    m_bFireShouldEnterCombat=true
    m_bShouldUseInstigatorsTimeDilation=true
    m_bBurstCanBeInterrupted=true
    m_bCanReloadEarly=true
    m_bAbilityRequiresInhandResync=true
    m_bParentAnimComponentHands=true
    m_bUseRangeFalloffCurve=true
    m_nSocketIndex=1
    m_CachedFireRequestId=-1
    EquipTime=0.3300000
    m_IndividualOffhandCooldownTime=0.1500000
    r_fCooldownDelay=-1.0000000
    m_fUnequipTime=0.5000000
    m_vMeshViewOffset=(X=0.0000000,Y=0.0000000,Z=-6.0000000)
    m_fWeaponBob=0.1600000
    m_fMeshFOV=65.0000000
    m_fAltFireLockOutTime=0.5000000
    m_nLastFiringIDToConsumeAmmo=-1
    m_fEnterCombatDuration=5.0000000
    m_fDeployZForgiveness=70.0000000
    m_fBottomlessPitCheck=16.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor'
    m_AimAssistMagnetScale=(X=0.2000000,Y=0.4000000)
    m_AimAssistTrackingScale=(X=1.0000000,Y=1.0000000)
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetVert[1]=(KeyframeName="V100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ft",Distance=3200.0000000)
    m_AimAssistKeyframesFriction[0]=(KeyframeName="Basic",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_fOutroLockoutTime=0.5000000
    m_fMinTimeBetweenAmmoCharges=0.5000000
    s_fForceReleaseFirHoldFUBARTime=0.5000000
    m_fReticleBloomScale=1.0000000
    RespawnTime=30.0000000
    bOnlyRelevantToOwner=false
    s_bThrottleNetRelevancy=true
    NetPriority=3.0000000
}
