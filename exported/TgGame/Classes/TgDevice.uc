class TgDevice extends Weapon
    native(Devices)
    hidecategories(Navigation)
    implements(TgGameplayCurveOwner);

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

enum EWeaponFireType
{
    EWFT_InstantHit,                // 0
    EWFT_Projectile,                // 1
    EWFT_Custom,                    // 2
    EWFT_None,                      // 3
    EWFT_MAX                        // 4
};

enum ETargetingModeStatus
{
    TMS_None,                       // 0
    TMS_CannotFire,                 // 1
    TMS_CannotPlace,                // 2
    TMS_OK,                         // 3
    TMS_OutOfRange,                 // 4
    TMS_MAX                         // 5
};

enum EDeviceChangeEvent
{
    DCE_Created,                    // 0
    DCE_ToggleState,                // 1
    DCE_CanFire,                    // 2
    DCE_Selected,                   // 3
    DCE_Cooldown,                   // 4
    DCE_PtsAlloc,                   // 5
    DCE_Refire,                     // 6
    DCE_InstanceCount,              // 7
    DCE_DeviceBuildup,              // 8
    DCE_MAX                         // 9
};

enum EAltFireType
{
    ALTFIRE_None,                   // 0
    ALTFIRE_SecondMode,             // 1
    ALTFIRE_AlternateDevice,        // 2
    ALTFIRE_AlternateDeviceAndFireInhand,// 3
    ALTFIRE_MAX                     // 4
};

enum ENotifyDelegateEvents
{
    NDE_OnFired,                    // 0
    NDE_OnReload,                   // 1
    NDE_OnStartFire,                // 2
    NDE_OnStopFire,                 // 3
    NDE_Generic1,                   // 4
    NDE_Generic2,                   // 5
    NDE_Generic3,                   // 6
    NDE_MAX                         // 7
};

enum DeviceEmoteAt
{
    DEA_StartBuildup,               // 0
    DEA_StartFire,                  // 1
    DEA_Custom,                     // 2
    DEA_MAX                         // 3
};

enum DeviceTimerBarType
{
    DTBT_None,                      // 0
    DTBT_PreHit,                    // 1
    DTBT_PostHit,                   // 2
    DTBT_PersistTime,               // 3
    DTBT_RefireTime,                // 4
    DTBT_FireHold,                  // 5
    DTBT_Custom,                    // 6
    DTBT_MAX                        // 7
};

struct native AmmoTransaction
{
    var float TransactionTimestamp;
    var int TransactionId;
    var int AmmoAmountChanged;
    var bool FilledClip;

    structdefaultproperties
    {
        TransactionTimestamp=0.0000000
        TransactionId=0
        AmmoAmountChanged=0
        FilledClip=false
    }
};

struct native TrackedFiringAmmoConsumption
{
    var int FiringRequestID;
    var int AmmoConsumed;

    structdefaultproperties
    {
        FiringRequestID=0
        AmmoConsumed=0
    }
};

struct native TgQueuedSimulatedProjectileSpawn
{
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

    structdefaultproperties
    {
        TimeStampToSpawn=0.0000000
        FireRequestId=0
        FireMode=none
        ProjectileSpawnLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ProjectileSpawnDir=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ProjectileIndex=0
        ProjectileIdOverride=0
        Range=0.0000000
        trackingTarget=none
        EndTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ClientMovementTimeStamp=0.0000000
        AccuracyRandomValue1=0.0000000
        AccuracyRandomValue2=0.0000000
    }
};

struct native TgQueuedProjectileExplosion
{
    var int ClientFireRequestId;
    var Actor Target;
    var Vector HitLocation;
    var Vector HitNormal;
    var float ProjectileAliveTime;
    var float MovementTimeStamp;
    var float AoeRewindTimeStamp;

    structdefaultproperties
    {
        ClientFireRequestId=0
        Target=none
        HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ProjectileAliveTime=0.0000000
        MovementTimeStamp=0.0000000
        AoeRewindTimeStamp=0.0000000
    }
};

struct native ImpactToValidate
{
    var int PackedAssociatedShotIDs;
    var float ImpactTimeStamp;
    var ImpactInfo Impact;

    structdefaultproperties
    {
        PackedAssociatedShotIDs=0
        ImpactTimeStamp=0.0000000
        Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0)
    }
};

struct native TgQueuedRefire
{
    var int ClientFireRequestId;
    var byte DesiredFireMode;
    var AimData Aim;

    structdefaultproperties
    {
        ClientFireRequestId=0
        DesiredFireMode=255
        Aim=(StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),EndTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),AimVector=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitActor=none,ClientMovementTimeStamp=0.0000000,bResult=false)
    }
};

struct native TgQueuedInstantFireShot
{
    var int FireRequestId;
    var AimData Aim;
    var ImpactToValidate PrimaryImpact;
    var array<ImpactToValidate> Impacts;
    var int AmmoToConsume;
    var float AccuracyRandomValue1;
    var float AccuracyRandomValue2;

    structdefaultproperties
    {
        FireRequestId=0
        Aim=(StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),EndTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),AimVector=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitActor=none,ClientMovementTimeStamp=0.0000000,bResult=false)
        PrimaryImpact=(PackedAssociatedShotIDs=0,ImpactTimeStamp=0.0000000,Impact=(HitActor=none,HitLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitNormal=(X=0.0000000,Y=0.0000000,Z=0.0000000),RayDir=(X=0.0000000,Y=0.0000000,Z=0.0000000),StartTrace=(X=0.0000000,Y=0.0000000,Z=0.0000000),HitInfo=(Material=none,PhysMaterial=none,Item=0,LevelIndex=0,BoneName="None",HitComponent=none),PercAbsorbedDamage=0.0000000,DeviceModeReference=none,Projectile=none,bDirectHit=false,nFiringInstance=0,nShotsHit=0))
        Impacts=none
        AmmoToConsume=0
        AccuracyRandomValue1=0.0000000
        AccuracyRandomValue2=0.0000000
    }
};

struct native AccuracySettings
{
    var bool bUsesAdvancedAccuracy;
    var float fMaxAccuracy;
    var float fMinAccuracy;
    var float fAccuracyLossPerShot;
    var float fAccuracyGainPerSec;
    var float fAccuracyGainDelay;
    var int nNumFreeShots;

    structdefaultproperties
    {
        bUsesAdvancedAccuracy=false
        fMaxAccuracy=0.0000000
        fMinAccuracy=0.0000000
        fAccuracyLossPerShot=0.0000000
        fAccuracyGainPerSec=0.0000000
        fAccuracyGainDelay=0.0000000
        nNumFreeShots=0
    }
};

struct native RecoilSettings
{
    var bool bUsesRecoil;
    var float fRecoilReductionPerSec;
    var float fRecoilCenterDelay;
    var float fRecoilSmoothRate;

    structdefaultproperties
    {
        bUsesRecoil=false
        fRecoilReductionPerSec=0.0000000
        fRecoilCenterDelay=0.0000000
        fRecoilSmoothRate=0.0000000
    }
};

var private native const noexport Pointer VfTable_ITgGameplayCurveOwner;
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
var() TgDevice.EAltFireType m_AltFireType;
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
var() bool m_bDeployAtFeetOnFailure;
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
var() Vector m_vProjectileSpawnOffset;
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
var() float m_fDeployZForgiveness;
var float m_fBottomlessPitCheck;
var() float m_fDeployZOffset;
var array<int> m_Abilities;
var int m_DisplayIcon;
var string m_DisplayName;
var TgDevice m_PrimaryWeaponParent;
var() Class<TgWeaponMeshActor> m_WeaponMeshActorClass;
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
var() float m_fMinTimeBetweenAmmoCharges;
var() ForceFeedbackWaveform m_ForceFeedbackStartHold;
var() ForceFeedbackWaveform m_ForceFeedbackFullHold;
var() ForceFeedbackWaveform m_ForceFeedbackStopHold;
var() ForceFeedbackWaveform m_ForceFeedbackStartFire;
var() ForceFeedbackWaveform m_ForceFeedbackStopFire;
var() ForceFeedbackWaveform m_ForceFeedbackStartBuildup;
var() ForceFeedbackWaveform m_ForceFeedbackStopBuildup;
var() ForceFeedbackWaveform m_ForceFeedbackPostFire;
var() ForceFeedbackWaveform m_ForceFeedbackStartReload;
var() ForceFeedbackWaveform m_ForceFeedbackStopReload;
var() ForceFeedbackWaveform m_ForceFeedbackStartCooldown;
var float s_fForceReleaseFirHoldFUBARTime;
var int s_nLastRequestedFireHoldReleaseID;
var(Accuracy) AccuracySettings m_AccuracySettings[5];
var float m_fCurrentAdvancedAccuracy;
var float m_fLastShotTimestamp;
var int m_nFreeShotsLeft;
var float m_fLastMinAccuracy;
var float m_fReticleBloomScale;
var(Recoil) RecoilSettings m_RecoilSettings[5];
var float m_fStartFiringTimestamp;
var float m_fAccumulatedFiringTime;
var transient int m_nRandRecoilNum;
var repnotify transient int r_nRecoilSeed;
var int m_nAimAssistPriorityWhileFiring;
var repnotify int r_nAllowUseWhileFlags;
//var delegate<DeviceEvent> __DeviceEvent__Delegate;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        CurrentFireMode, r_Deployable, 
        r_OverrideUsesTargetingModeAsFalse, r_eEquippedAt, 
        r_fCooldownDelay, r_nAllowUseWhileFlags, 
        r_nAmmoClipCount, r_nInstanceCount, 
        r_nInventoryId, r_nMaxAmmoClipCount, 
        r_nMeleeComboSeed, r_nPointsAllocated, 
        r_nProjectiles, r_nRecoilSeed;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_bConsumedOnDeath, r_bConsumedOnUse, 
        r_bParentDeviceOwnedByOffhand, r_nDeviceId, 
        r_nDeviceInstanceId;
}

simulated delegate DeviceEvent()
{
    //return;    
}

// Export UTgDevice::execApplyDeviceSetup(FFrame&, void* const)
native function bool ApplyDeviceSetup();

// Export UTgDevice::execQueryProjectileClass(FFrame&, void* const)
native function name QueryProjectileClass(optional int nMode);

// Export UTgDevice::execQueryDeployableClass(FFrame&, void* const)
native function name QueryDeployableClass(optional int nMode);

// Export UTgDevice::execGetFireSocketName(FFrame&, void* const)
native function name GetFireSocketName();

// Export UTgDevice::execCalcFireSocketIndexMax(FFrame&, void* const)
native function CalcFireSocketIndexMax();

// Export UTgDevice::execGetDeviceName(FFrame&, void* const)
native function string GetDeviceName();

// Export UTgDevice::execRemoveConsumableFromOwnerInventory(FFrame&, void* const)
native function RemoveConsumableFromOwnerInventory();

// Export UTgDevice::execLogDebugInfo(FFrame&, void* const)
native function bool LogDebugInfo();

// Export UTgDevice::execServerDetonate(FFrame&, void* const)
native function bool ServerDetonate(optional int nFireMode = 0);

// Export UTgDevice::execTickTargetingMode(FFrame&, void* const)
native function TickTargetingMode(float DeltaSeconds);

// Export UTgDevice::execGetCurrentFire(FFrame&, void* const)
native function TgDeviceFire GetCurrentFire();

// Export UTgDevice::execGetDeviceFire(FFrame&, void* const)
native function TgDeviceFire GetDeviceFire(int nMode);

// Export UTgDevice::execApplyEquipEffects(FFrame&, void* const)
native function ApplyEquipEffects();

// Export UTgDevice::execRemoveEquipEffects(FFrame&, void* const)
native function RemoveEquipEffects();

// Export UTgDevice::execBecomeActive(FFrame&, void* const)
native final function BecomeActive(optional bool bSkipActiveEffects);

// Export UTgDevice::execCeaseActive(FFrame&, void* const)
native final function CeaseActive(optional bool bSkipActiveEffects);

// Export UTgDevice::execOnBecomeActive(FFrame&, void* const)
native function OnBecomeActive();

// Export UTgDevice::execOnCeaseActive(FFrame&, void* const)
native function OnCeaseActive();

// Export UTgDevice::execCheckModeRange(FFrame&, void* const)
native function bool CheckModeRange(int nMode, Vector vDelta);

// Export UTgDevice::execGetModeRange(FFrame&, void* const)
native function int GetModeRange(int nMode);

// Export UTgDevice::execIsOffhand(FFrame&, void* const)
native function bool IsOffhand();

// Export UTgDevice::execIsOwnedByOffhand(FFrame&, void* const)
native function bool IsOwnedByOffhand();

// Export UTgDevice::execIsPurchasedAbility(FFrame&, void* const)
native function bool IsPurchasedAbility();

// Export UTgDevice::execIsAbility(FFrame&, void* const)
native final function bool IsAbility(optional bool bExcludeMovement);

// Export UTgDevice::execIsMovementAbility(FFrame&, void* const)
native final function bool IsMovementAbility();

// Export UTgDevice::execIsEmote(FFrame&, void* const)
native final function bool IsEmote();

// Export UTgDevice::execIsCard(FFrame&, void* const)
native final function bool IsCard();

// Export UTgDevice::execIsArmorCard(FFrame&, void* const)
native final function bool IsArmorCard();

// Export UTgDevice::execIsBurnCard(FFrame&, void* const)
native final function bool IsBurnCard();

// Export UTgDevice::execIsTestDevice(FFrame&, void* const)
native final function bool IsTestDevice();

// Export UTgDevice::execCanBeStunned(FFrame&, void* const)
native function bool CanBeStunned();

// Export UTgDevice::execCanBeSilenced(FFrame&, void* const)
native function bool CanBeSilenced();

// Export UTgDevice::execCanBeDisarmed(FFrame&, void* const)
native function bool CanBeDisarmed();

// Export UTgDevice::execCanBeCrippled(FFrame&, void* const)
native function bool CanBeCrippled();

// Export UTgDevice::execCanBeStasisLocked(FFrame&, void* const)
native function bool CanBeStasisLocked();

// Export UTgDevice::execCanBeGrabbed(FFrame&, void* const)
native function bool CanBeGrabbed();

// Export UTgDevice::execGetConePullbackDistance(FFrame&, void* const)
native function float GetConePullbackDistance();

// Export UTgDevice::execHasEnoughPowerPool(FFrame&, void* const)
native function bool HasEnoughPowerPool(byte FireModeNum);

// Export UTgDevice::execIsDeviceCoolingDown(FFrame&, void* const)
native function bool IsDeviceCoolingDown();

// Export UTgDevice::execIsInCooldownGracePeriod(FFrame&, void* const)
native function bool IsInCooldownGracePeriod();

// Export UTgDevice::execIsDeviceRefiring(FFrame&, void* const)
native function bool IsDeviceRefiring();

// Export UTgDevice::execGetCooldownTimerManager(FFrame&, void* const)
native function TgTimerManager GetCooldownTimerManager();

// Export UTgDevice::execCheckAndUpdateCooldown(FFrame&, void* const)
native function CheckAndUpdateCooldown();

// Export UTgDevice::execSendDeviceChangeEvent(FFrame&, void* const)
native function SendDeviceChangeEvent(TgDevice.EDeviceChangeEvent Event);

// Export UTgDevice::execSendCombatLogEvent(FFrame&, void* const)
native function SendCombatLogEvent(TgObject.ITEM_EVENT_TYPE Type);

// Export UTgDevice::execGetCombatLogEventLocation(FFrame&, void* const)
native function GetCombatLogEventLocation(out int LocationX, out int LocationY);

// Export UTgDevice::execGetBuildupTime(FFrame&, void* const)
native function float GetBuildupTime();

// Export UTgDevice::execGetRefireTime(FFrame&, void* const)
native function float GetRefireTime(optional int nMode = -1);

// Export UTgDevice::execGetFiringPreHitDelay(FFrame&, void* const)
native function float GetFiringPreHitDelay(optional int nMode = -1);

// Export UTgDevice::execGetFiringPostHitDelay(FFrame&, void* const)
native function float GetFiringPostHitDelay(optional int nMode = -1);

// Export UTgDevice::execCacheFiringPostHitDelay(FFrame&, void* const)
native function float CacheFiringPostHitDelay();

// Export UTgDevice::execGetCachedFiringPostHitDelay(FFrame&, void* const)
native function float GetCachedFiringPostHitDelay();

// Export UTgDevice::execGetTargetingMode(FFrame&, void* const)
native function TgObject.DeviceTargetMode GetTargetingMode();

// Export UTgDevice::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

// Export UTgDevice::execUsesTrackingTarget(FFrame&, void* const)
native function bool UsesTrackingTarget();

// Export UTgDevice::execForceDefaultCastMode(FFrame&, void* const)
native function bool ForceDefaultCastMode();

// Export UTgDevice::execDetermineCastMode(FFrame&, void* const)
native function TgClientSettings.ECastMode DetermineCastMode(TgClientSettings.ECastMode desiredCastMode);

// Export UTgDevice::execUsesCachedAim(FFrame&, void* const)
native function bool UsesCachedAim();

// Export UTgDevice::execGetCachedAim(FFrame&, void* const)
native function GetCachedAim(out AimData Aim);

// Export UTgDevice::execCacheAim(FFrame&, void* const)
native function AimData CacheAim();

// Export UTgDevice::execValidateReceivedAim(FFrame&, void* const)
native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);

// Export UTgDevice::execUpdateTargetingModeStatus(FFrame&, void* const)
native function UpdateTargetingModeStatus(const out AimData Aim);

// Export UTgDevice::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice::execGetReticleTargetAim(FFrame&, void* const)
native function GetReticleTargetAim(out AimData Aim);

// Export UTgDevice::execGetReticleFindSpotAim(FFrame&, void* const)
native function GetReticleFindSpotAim(out AimData Aim);

// Export UTgDevice::execGetConeTargetAim(FFrame&, void* const)
native function GetConeTargetAim(out AimData Aim);

// Export UTgDevice::execGetAOETargetAim(FFrame&, void* const)
native function GetAOETargetAim(out AimData Aim);

// Export UTgDevice::execGetSelfTargetAim(FFrame&, void* const)
native function GetSelfTargetAim(out AimData Aim);

// Export UTgDevice::execGetLinearTargetAim(FFrame&, void* const)
native function GetLinearTargetAim(out AimData Aim);

// Export UTgDevice::execGetGroundTargetAim(FFrame&, void* const)
native function GetGroundTargetAim(out AimData Aim);

// Export UTgDevice::execGetLockOnTargetAim(FFrame&, void* const)
native function GetLockOnTargetAim(out AimData Aim);

// Export UTgDevice::execGetSpawnPointTargetAim(FFrame&, void* const)
native function GetSpawnPointTargetAim(out AimData Aim);

// Export UTgDevice::execGetWorldMapTargetAim(FFrame&, void* const)
native function GetWorldMapTargetAim(out AimData Aim);

// Export UTgDevice::execCanLockOnToTarget(FFrame&, void* const)
native function bool CanLockOnToTarget(Actor Target);

// Export UTgDevice::execCanAllowLagCompensation(FFrame&, void* const)
native function bool CanAllowLagCompensation();

// Export UTgDevice::execUpdateAimWhileFiring(FFrame&, void* const)
native function UpdateAimWhileFiring(out AimData Aim);

// Export UTgDevice::execIsActive(FFrame&, void* const)
native final function bool IsActive(optional bool bIgnoreCooldown, optional bool bIngoreEquipped);

// Export UTgDevice::execIsTargetingModeReady(FFrame&, void* const)
native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);

// Export UTgDevice::execIsInTargetingMode(FFrame&, void* const)
native function bool IsInTargetingMode();

// Export UTgDevice::execEnterTargetingMode(FFrame&, void* const)
native function EnterTargetingMode();

// Export UTgDevice::execExitTargetingMode(FFrame&, void* const)
native function ExitTargetingMode();

// Export UTgDevice::execGetTotalDevicePoints(FFrame&, void* const)
native function int GetTotalDevicePoints();

// Export UTgDevice::execGetAllocatedDevicePoints(FFrame&, void* const)
native function int GetAllocatedDevicePoints();

// Export UTgDevice::execAllocateDevicePoint(FFrame&, void* const)
native function bool AllocateDevicePoint();

// Export UTgDevice::execClientPtsAllocatedUpdated(FFrame&, void* const)
native function ClientPtsAllocatedUpdated();

// Export UTgDevice::execSetPointsAllocated(FFrame&, void* const)
native function SetPointsAllocated(int nPoints);

// Export UTgDevice::execSetInstanceCount(FFrame&, void* const)
native function SetInstanceCount(int nInstanceCount);

// Export UTgDevice::execShouldInterruptStealth(FFrame&, void* const)
native function bool ShouldInterruptStealth();

// Export UTgDevice::execShouldInterruptLift(FFrame&, void* const)
native function bool ShouldInterruptLift();

// Export UTgDevice::execShouldLiftInterrupt(FFrame&, void* const)
native function bool ShouldLiftInterrupt();

// Export UTgDevice::execShouldShowAmmoCount(FFrame&, void* const)
native function bool ShouldShowAmmoCount();

// Export UTgDevice::execHasAmmo(FFrame&, void* const)
native function bool HasAmmo();

// Export UTgDevice::execRequiresAmmoToFire(FFrame&, void* const)
native function bool RequiresAmmoToFire();

// Export UTgDevice::execGetCurrentAmmoAmount(FFrame&, void* const)
native function int GetCurrentAmmoAmount();

// Export UTgDevice::execShouldTreatAmmoAsCharges(FFrame&, void* const)
native function bool ShouldTreatAmmoAsCharges();

// Export UTgDevice::execUpdateAmmoRegen(FFrame&, void* const)
native function UpdateAmmoRegen(optional bool bUpdateCooldown = false, optional float fCooldownFloor = 0.0000000);

// Export UTgDevice::execGetCurrentReloadPct(FFrame&, void* const)
native function float GetCurrentReloadPct();

// Export UTgDevice::execCheckAutoReload(FFrame&, void* const)
native function bool CheckAutoReload();

// Export UTgDevice::execCanReload(FFrame&, void* const)
native function bool CanReload(optional bool bIsAutoReload = false);

// Export UTgDevice::execIsReloading(FFrame&, void* const)
native function bool IsReloading();

// Export UTgDevice::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

// Export UTgDevice::execGetAccuracy(FFrame&, void* const)
native function float GetAccuracy(optional int nMode = -1);

// Export UTgDevice::execGetRandRecoil(FFrame&, void* const)
native function float GetRandRecoil(float Min, float Max);

// Export UTgDevice::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nFireModeNum, optional bool ForceSet = false);

// Export UTgDevice::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);

// Export UTgDevice::execDeviceAdjustHeal(FFrame&, void* const)
native function DeviceAdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);

// Export UTgDevice::execGetPetIDOverride(FFrame&, void* const)
native function int GetPetIDOverride(int PetIndex);

// Export UTgDevice::execReplicatePlayerDeviceAmmo(FFrame&, void* const)
native function ReplicatePlayerDeviceAmmo();

// Export UTgDevice::execHasRemoteOwner(FFrame&, void* const)
native final function bool HasRemoteOwner();

// Export UTgDevice::execGenerateUniqueFireRequestId(FFrame&, void* const)
native final function int GenerateUniqueFireRequestId();

// Export UTgDevice::execGenerateUniqueAmmoValidationId(FFrame&, void* const)
native final function int GenerateUniqueAmmoValidationId();

// Export UTgDevice::execValidateClientProjectileImpact(FFrame&, void* const)
native final function bool ValidateClientProjectileImpact(TgProj_Simulated SimulatedProjectile, float ProjectileAliveTime, Actor Other, float MovementTimeStamp, Vector HitLocation, Vector HitNormal);

// Export UTgDevice::execValidateClientInstantHit(FFrame&, void* const)
native final function bool ValidateClientInstantHit(out ImpactInfo ValidPrimaryImpact, out array<ImpactInfo> OutValidImpacts, const out AimData InServerAim, const out AimData InClientAim, const out ImpactToValidate InPrimaryImpact, const out array<ImpactToValidate> InClientImpacts, out array<float> OutHitRanges);

// Export UTgDevice::execSetRandomShotSpreadSeed(FFrame&, void* const)
native final function SetRandomShotSpreadSeed(int Seed);

// Export UTgDevice::execRecordUsedAim(FFrame&, void* const)
native static function RecordUsedAim(const out Vector InAim);

// Export UTgDevice::execGetLastUsedAimStats(FFrame&, void* const)
native static function string GetLastUsedAimStats();

// Export UTgDevice::execGetAimValidationStats(FFrame&, void* const)
native static function string GetAimValidationStats();

// Export UTgDevice::execGetInstantFirePredictionStats(FFrame&, void* const)
native static function string GetInstantFirePredictionStats();

// Export UTgDevice::execGetProjectilePredictionStats(FFrame&, void* const)
native static function string GetProjectilePredictionStats();

// Export UTgDevice::execGetHeadShotDamage(FFrame&, void* const)
native function float GetHeadShotDamage(optional TgDeviceFire FireMode);

// Export UTgDevice::execIsSuccessfulHitImpact(FFrame&, void* const)
native static function bool IsSuccessfulHitImpact(Actor ImpactedActor);

// Export UTgDevice::execShouldAltFireOnTick(FFrame&, void* const)
native function bool ShouldAltFireOnTick();

// Export UTgDevice::execUpdateUltChargePercent(FFrame&, void* const)
native function bool UpdateUltChargePercent();

// Export UTgDevice::execGetRequiredEnergyToFire(FFrame&, void* const)
native function float GetRequiredEnergyToFire();

// Export UTgDevice::execConsolidateImpacts(FFrame&, void* const)
native function ConsolidateImpacts(out array<ImpactInfo> ImpactsToConsolidate, out array<float> ShotRanges, optional out array<byte> ShotToImpactIndex);

// Export UTgDevice::execGetBaseDamageMultiplier(FFrame&, void* const)
native function float GetBaseDamageMultiplier(const out ImpactInfo hitImpact);

// Export UTgDevice::execGetShotSpreadTendencyCurvesSet(FFrame&, void* const)
native function TgGameplayCurvesSet GetShotSpreadTendencyCurvesSet();

// Export UTgDevice::execGetFireHoldTime(FFrame&, void* const)
native function float GetFireHoldTime();

// Export UTgDevice::execGetFireHoldRate(FFrame&, void* const)
native function float GetFireHoldRate();

// Export UTgDevice::execGetFireHoldAccuracyLow(FFrame&, void* const)
native function float GetFireHoldAccuracyLow();

// Export UTgDevice::execGetFireHoldDamageLow(FFrame&, void* const)
native function float GetFireHoldDamageLow();

// Export UTgDevice::execGetFireHoldPct(FFrame&, void* const)
native final function float GetFireHoldPct();

// Export UTgDevice::execShouldAutoFire(FFrame&, void* const)
native function bool ShouldAutoFire();

// Export UTgDevice::execDeviceFailLog(FFrame&, void* const)
native function DeviceFailLog(bool bDeviceFailLog, coerce string S);

// Export UTgDevice::execGetCurrentGameplayCurves(FFrame&, void* const)
native function TgGameplayCurves GetCurrentGameplayCurves();

// Export UTgDevice::execGetCurrentGameplayCurveSet(FFrame&, void* const)
native function TgGameplayCurvesSet GetCurrentGameplayCurveSet(TgGameplayCurvesSet.ECurveSetTypes Type);

// Export UTgDevice::execUseRangeFalloffCurve(FFrame&, void* const)
native function bool UseRangeFalloffCurve();

// Export UTgDevice::execShouldForce3P(FFrame&, void* const)
native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm = false);

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x2C
        case 'r_nDeviceId':
            ApplyDeviceSetup();
            // End:0xEE
            break;
        // End:0x5D
        case 'r_Deployable':
            // End:0x5A
            if(r_Deployable != none)
            {
                OnDeployableSpawned(r_Deployable);
            }
            // End:0xEE
            break;
        // End:0x76
        case 'r_nPointsAllocated':
            ClientPtsAllocatedUpdated();
            // End:0xEE
            break;
        // End:0x91
        case 'r_nInstanceCount':
            SendDeviceChangeEvent(7);
            // End:0xEE
            break;
        // End:0xB3
        case 'r_nRecoilSeed':
            m_nRandRecoilNum = r_nRecoilSeed;
            // End:0xEE
            break;
        // End:0xD5
        case 'r_nAllowUseWhileFlags':
            ApplyAllowUseWhileFlags(r_nAllowUseWhileFlags);
            // End:0xEE
            break;
        // End:0xFFFF
        default:
            super(Actor).ReplicatedEvent(VarName);
            // End:0xEE
            break;
            break;
    }
    super(Actor).ReplicatedEvent(VarName);
    //return;    
}

simulated function WeaponLog(coerce string msg, coerce string FuncStr)
{
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local string T;

    super(Actor).DisplayDebug(HUD, out_YL, out_YPos);
    T = (("Eyeheight " $ string(Instigator.EyeHeight)) $ " base ") $ string(Instigator.BaseEyeHeight);
    HUD.Canvas.DrawText(T, false);
    out_YPos += out_YL;
    //return;    
}

simulated function DisplayMessage(string sMessage)
{
    // End:0xAA
    if((Instigator != none) && Instigator.Controller != none)
    {
        // End:0xAA
        if(TgPlayerController(Instigator.Controller) != none)
        {
            TgPlayerController(Instigator.Controller).ClientMessage(sMessage);
        }
    }
    //return;    
}

event ForceCooldownIfFiring()
{
    //return;    
}

// Export UTgDevice::execCanSpawnOnClientFirst(FFrame&, void* const)
native function bool CanSpawnOnClientFirst(Class<Projectile> ProjectileClass, bool bUsesTrackingTarget);

// Export UTgDevice::execNativeIsFiring(FFrame&, void* const)
native function bool NativeIsFiring();

// Export UTgDevice::execIsDeviceFiringForUI(FFrame&, void* const)
native function bool IsDeviceFiringForUI();

// Export UTgDevice::execIsDeviceFiringLockedForUI(FFrame&, void* const)
native function bool IsDeviceFiringLockedForUI();

// Export UTgDevice::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

// Export UTgDevice::execCanFireWhileMounted(FFrame&, void* const)
native function bool CanFireWhileMounted();

// Export UTgDevice::execCanFiringBeLocked(FFrame&, void* const)
native function bool CanFiringBeLocked();

simulated event bool IsEquipping()
{
    return false;
    //return ReturnValue;    
}

simulated function float GetRange()
{
    local float Range;

    Range = GetCurrentFire().GetRange();
    return ((Range > float(0)) ? Range : 1600.0000000);
    //return ReturnValue;    
}

simulated function float GetEffectiveRange()
{
    local float Range;

    Range = GetCurrentFire().GetEffectiveRange();
    return ((Range > float(0)) ? Range : 1600.0000000);
    //return ReturnValue;    
}

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    // End:0x17
    if(CanFiringBeCanceledByLeftMouse())
    {
        ClientInitiatedInterrupt();
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController)
{
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptRightMousePressed(TgPlayerController TgController)
{
    local TgPawn P;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x3C
    if((CanFiringBeCanceledByRightMouse()) && TgController.false)
    {
        InterruptFiring();
        ClientInterrupt();
    }
    // End:0x25F
    if((IsAbility() && m_bInTargetingMode) && int(r_eEquippedAt) != int(18))
    {
        TgController.bPressingRightMouseButton = false;
        P = TgPawn(Owner);
        // End:0x25D
        if((P.c_CurrentTargetingDevice == none) || ((P.c_CurrentTargetingDevice != none) && int(P.c_CurrentTargetingDevice.r_eEquippedAt) != int(1)) && P.c_CurrentTargetingDevice.ShouldSwitchBackToBasicAttackTargeting(TgController.GetClientSettings().GetCastMode(P.r_nProfileId, P.c_CurrentTargetingDevice.r_eEquippedAt)))
        {
            P.SetTargetingDevice(P.GetDeviceByEqPoint(1), SwapStrategy);
            P.c_CurrentStartActionDevice = none;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptRightMouseReleased(TgPlayerController TgController)
{
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptSlotPressed(TgPlayerController TgController)
{
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return !m_bPreventCancel && IsInState('DeviceBuildup') || (IsFiring()) && (IsFunctionallyToggleDevice()) || (((int(CurrentFireMode) >= int(0)) && GetCurrentFire().m_bContinuousFire) && IsA('TgDevice_HitPulse')) && !m_bHandDevice;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByLeftMouse()
{
    local TgPawn TgP;
    local bool bCanCancel;

    bCanCancel = IsMovementAbility() && CanBeCanceled();
    // End:0x35
    if(!bCanCancel)
    {
        return false;
    }
    TgP = TgPawn(Instigator);
    return TgP.GetPropCurrentValue(133) == float(0);
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByRightMouse()
{
    return CanBeCanceled();
    //return ReturnValue;    
}

simulated function bool CheckReactivationToggleLogic(out byte bSuccessfulCancel)
{
    bSuccessfulCancel = 0;
    // End:0x75
    if((CanFiringBeCanceledByReactivation()) && IsFiring())
    {
        // End:0x73
        if(CanBeCanceled())
        {
            // End:0x53
            if(int(Role) < int(ROLE_Authority))
            {
                OnCanceledClient();
            }
            OnCanceled();
            ClientInitiatedInterrupt();
            bSuccessfulCancel = 1;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return (CanBeCanceled()) || IsFunctionallyToggleDevice();
    //return ReturnValue;    
}

simulated event bool CanBeFiredWhileTweening()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CancelledByJumping()
{
    return !CanJumpWhileFiring();
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    local TgDeviceFire FireMode;

    // End:0x0F
    if(m_bPreventInterrupt)
    {
        return false;
    }
    // End:0x2D
    if(m_bUsesBurstFire && m_bBurstCanBeInterrupted)
    {
        return true;
    }
    // End:0x3F
    if(IsInState('DeviceBuildup'))
    {
        return true;
    }
    // End:0x58
    if(IsTimerActive('FirePreHitDelay'))
    {
        return true;
    }
    FireMode = GetCurrentFire();
    // End:0xD7
    if(((((int(CurrentFireMode) >= int(0)) && FireMode != none) && FireMode.m_bContinuousFire) && IsFiring()) && !m_bHandDevice)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptInhand()
{
    return (IsOffhand()) && !IsToggleDevice();
    //return ReturnValue;    
}

simulated function bool ShouldInterruptMount()
{
    local TgDevice Dev;
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x8E
    if(TgP != none)
    {
        Dev = TgP.GetDeviceByEqPoint(23);
        // End:0x8E
        if((Dev != none) && Dev.IsInState('DeviceBuildup'))
        {
            return false;
        }
    }
    return IsAbility() || m_bHandDevice;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptEmote()
{
    return IsAbility() || m_bHandDevice;
    //return ReturnValue;    
}

function GenerateRecoilSeed()
{
    r_nRecoilSeed = int(RandRange(1.0000000, 32749.0000000));
    m_nRandRecoilNum = r_nRecoilSeed;
    //return;    
}

simulated function AddRecoil()
{
    local TgGameplayCurvesSet_RecoilSimple recoilCurves;
    local Rotator newRecoil;
    local TgPawn PawnOwner;
    local TgGameplayCurves GPCurves;

    // End:0x2A
    if((int(CurrentFireMode) < int(0)) || int(CurrentFireMode) >= 5)
    {
        return;
    }
    GPCurves = GetCurrentGameplayCurves();
    // End:0x7F
    if(!m_RecoilSettings[int(CurrentFireMode)].bUsesRecoil || GPCurves == none)
    {
        return;
    }
    PawnOwner = TgPawn(Owner);
    // End:0xAC
    if(PawnOwner == none)
    {
        return;
    }
    recoilCurves = GetRecoilCurve();
    // End:0xD1
    if(recoilCurves == none)
    {
        return;
    }
    newRecoil.Yaw = int(recoilCurves.GetHorizRecoilValue(m_fAccumulatedFiringTime, GetRandRecoil(0.0000000, 1.0000000)) * 182.0444000);
    newRecoil.Pitch = int(recoilCurves.GetVertRecoilValue(m_fAccumulatedFiringTime, GetRandRecoil(0.0000000, 1.0000000)) * 182.0444000);
    newRecoil.Roll = 0;
    newRecoil *= (GetRecoilMultiplier());
    PawnOwner.AddRecoil(newRecoil, m_RecoilSettings[int(CurrentFireMode)].fRecoilSmoothRate, m_RecoilSettings[int(CurrentFireMode)].fRecoilCenterDelay, m_RecoilSettings[int(CurrentFireMode)].fRecoilReductionPerSec);
    //return;    
}

simulated function TgGameplayCurvesSet_RecoilSimple GetRecoilCurve()
{
    local int I;
    local TgGameplayCurvesSet_RecoilSimple recoilCurves;
    local TgGameplayCurves GPCurves;

    GPCurves = GetCurrentGameplayCurves();
    // End:0x25
    if(GPCurves == none)
    {
        return none;
    }
    I = 0;
    J0x30:

    // End:0x162 [Loop If]
    if(I < GPCurves.CurveSets.Length)
    {
        // End:0x154
        if((GPCurves.CurveSets[I] != none) && int(GPCurves.CurveSets[I].CurveSetType) == int(2))
        {
            recoilCurves = TgGameplayCurvesSet_RecoilSimple(GPCurves.CurveSets[I]);
            // End:0x154
            if((recoilCurves != none) && int(recoilCurves.RecoilType) == int(0))
            {
                return recoilCurves;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x30;
    }
    return none;
    //return ReturnValue;    
}

simulated function float GetRecoilMultiplier()
{
    return 1.0000000;
    //return ReturnValue;    
}

simulated function PostBeginPlay()
{
    // End:0x1E
    if(int(Role) == int(ROLE_Authority))
    {
        GenerateRecoilSeed();
    }
    super(Actor).PostBeginPlay();
    //return;    
}

simulated function InterruptOtherDevices(TgPawn TgP)
{
    local TgDevice Dev;

    // End:0xCF
    if(ShouldInterruptMount())
    {
        // End:0xCF
        if(TgP != none)
        {
            Dev = TgP.GetDeviceByEqPoint(23);
            // End:0xCF
            if((Dev != none) && Dev.CanBeCanceled())
            {
                // End:0xB0
                if(int(Role) == int(ROLE_AutonomousProxy))
                {
                    Dev.ClientInterrupt();                    
                }
                else
                {
                    Dev.InterruptFiring();
                }
            }
        }
    }
    // End:0x19E
    if(ShouldInterruptEmote())
    {
        // End:0x19E
        if(TgP != none)
        {
            Dev = TgP.GetDeviceByEqPoint(7);
            // End:0x19E
            if((Dev != none) && Dev.CanBeCanceled())
            {
                // End:0x17F
                if(int(Role) == int(ROLE_AutonomousProxy))
                {
                    Dev.ClientInterrupt();                    
                }
                else
                {
                    Dev.InterruptFiring();
                }
            }
        }
    }
    //return;    
}

// Export UTgDevice::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

// Export UTgDevice::execGetAdjustedAim(FFrame&, void* const)
native function GetAdjustedAim(out AimData Aim, out float UsedRandomValue1, out float UsedRandomValue2, optional float RandomValueOverride1 = -1.0000000, optional float RandomValueOverride2 = -1.0000000);

simulated event SetActiveState()
{
    GotoState('Active');
    //return;    
}

reliable server function ServerDoRemoteDetonation(int nFireMode)
{
    ServerDetonate(nFireMode);
    //return;    
}

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns)
{
    local TgTimerManager TimerManager;

    // End:0x23
    if(int(Role) == int(ROLE_Authority))
    {
        InterruptFiring();        
    }
    else
    {
        ClientInterrupt();
    }
    StopFire();
    // End:0x78
    if(bResetCooldowns)
    {
        TimerManager = GetCooldownTimerManager();
        TimerManager.CloseAllTimers();
    }
    // End:0x99
    if(IsTimerActive('AlternateStartCooldown'))
    {
        AlternateStartCooldown();
    }
    //return;    
}

simulated function DeviceRestart()
{
    ApplyEquipEffects();
    //return;    
}

simulated function StopFiringServerDeviceLockout()
{
    // End:0x45
    if((int(Role) == int(ROLE_Authority)) && HasRemoteOwner())
    {
        s_bLockFiringForRoundEnd = true;
        SetTimer(3.0000000, false, 'ServerNotifyClientAckLockout');        
    }
    else
    {
        ServerNotifyClientAckLockout();
    }
    //return;    
}

reliable server function ServerNotifyClientAckLockout()
{
    s_bLockFiringForRoundEnd = false;
    //return;    
}

reliable server event InterruptFiring()
{
    // End:0x1F
    if(int(Role) == int(ROLE_Authority))
    {
        InterruptFiringOnServerInternal();
    }
    //return;    
}

reliable server event InterruptFiringServerOnly()
{
    // End:0x1F
    if(int(Role) == int(ROLE_Authority))
    {
        InterruptFiringOnServerInternal(false);
    }
    //return;    
}

function InterruptFiringOnServerInternal(optional bool bSendClientInterrupt = true)
{
    local TgPawn TgP;
    local TgDeviceFire FireMode;

    m_IsBeingInterrupted = true;
    // End:0x2BC
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x32
        if(LogDebugInfo())
        {
        }
        OnInterruptEvent();
        TgP = TgPawn(Instigator);
        // End:0xFF
        if(IsFiring())
        {
            // End:0x9C
            if(TgP != none)
            {
                TgP.FlashInterrupt(r_nDeviceInstanceId);
            }
            // End:0xFF
            if(((c_DeviceForm != none) && Instigator.IsLocallyControlled()) && !HasRemoteOwner())
            {
                c_DeviceForm.DoInterrupt();
            }
        }
        // End:0x159
        if(UsesEnergy())
        {
            // End:0x159
            if(TgP != none)
            {
                TgP.SyncClientEnergy(TgP.GetEnergy());
            }
        }
        // End:0x274
        if(UsesSimulatedAmmo())
        {
            // End:0x274
            if(((s_QueuedRefireRequests.Length > 0) || m_nLastFiringIDToConsumeAmmo < m_CachedFireRequestId) && RequiresAmmoToFire())
            {
                FireMode = GetCurrentFire();
                // End:0x274
                if((FireMode != none) && FireMode.m_nAmmoCostPerShot > 0)
                {
                    ClientRefundAmmo(FireMode.m_nAmmoCostPerShot, (((m_nLastFiringIDToConsumeAmmo < m_CachedFireRequestId) && s_QueuedRefireRequests.Length > 0) ? s_QueuedRefireRequests[0].ClientFireRequestId : m_CachedFireRequestId));
                    m_nLastFiringIDToConsumeAmmo = m_CachedFireRequestId;
                }
            }
        }
        InterruptFireHold();
        InterruptBurst();
        // End:0x29F
        if(bSendClientInterrupt)
        {
            ClientInterrupt();
        }
        GotoState('Active');
        m_fLastDeviceCanFireTimeStamp = 0.0000000;
    }
    m_IsBeingInterrupted = false;
    //return;    
}

simulated function AsynchronusInterrupt()
{
    // End:0x21
    if(int(Role) < int(ROLE_Authority))
    {
        ClientInterrupt();        
    }
    else
    {
        InterruptFiringOnServerInternal(false);
    }
    //return;    
}

simulated function ClientInitiatedInterrupt()
{
    ClientInterrupt();
    InterruptFiringServerOnly();
    //return;    
}

reliable client simulated function ClientRefundAmmo(int nRefundAmount, int nFireRequestID)
{
    local int I;

    // End:0x36
    if(nFireRequestID < c_EligableRefundFiringIDs[c_nEligableRefundFiringIDsIndexFirst].FiringRequestID)
    {
        return;
    }
    I = c_nEligableRefundFiringIDsIndexFirst - 1;
    J0x4C:

    I = (I + 1) % 30;
    // End:0xB0
    if(c_EligableRefundFiringIDs[I].FiringRequestID < nFireRequestID)
    {
        c_nEligableRefundFiringIDsIndexFirst = I;        
    }
    else
    {
        // End:0x153
        if(c_EligableRefundFiringIDs[I].FiringRequestID == nFireRequestID)
        {
            c_nEligableRefundFiringIDsIndexFirst = I;
            c_EligableRefundFiringIDs[I].FiringRequestID = 0;
            GiveAmmo(c_EligableRefundFiringIDs[I].AmmoConsumed);            
        }
        else
        {
            return;
        }
    }
    // End:0x4C
    if(!(I == c_nEligableRefundFiringIDsIndexLast))
        goto J0x4C;
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    m_IsBeingInterrupted = true;
    // End:0x19
    if(LogDebugInfo())
    {
    }
    OnInterruptEvent();
    // End:0x60
    if((c_DeviceForm != none) && IsFiring())
    {
        c_DeviceForm.DoInterrupt();
    }
    InterruptFireHold();
    InterruptBurst();
    GotoState('Active');
    m_fLastDeviceCanFireTimeStamp = 0.0000000;
    m_IsBeingInterrupted = false;
    //return;    
}

reliable client simulated function ClientRemoveSpawnedProjectile(int nFiringID)
{
    local TgRepInfo_Game GRI;
    local TgProj_Simulated Proj;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xA0
    if(GRI != none)
    {
        Proj = GRI.GetClientSpawnedProjectile(nFiringID);
        // End:0xA0
        if(Proj != none)
        {
            Proj.ShutDown();
        }
    }
    //return;    
}

simulated function OnInterruptEvent()
{
    //return;    
}

simulated function bool ShouldCancelStealth()
{
    return false;
    //return ReturnValue;    
}

reliable server event ServerFlashEnterTargetingMode(bool bEnterTargeting)
{
    // End:0x72
    if(TgPawn(Instigator) != none)
    {
        TgPawn(Instigator).FlashTargeting(r_nDeviceInstanceId, int(CurrentFireMode), int(r_eEquippedAt), m_nSocketIndex, bEnterTargeting);
    }
    //return;    
}

simulated function PlayClientFireFx(Vector HitLocation, int nSocketIndex, bool bSuccessfulHit, float fRefireTime)
{
    local TgPawn devicePawn;

    devicePawn = TgPawn(Instigator);
    // End:0xF7
    if(devicePawn != none)
    {
        devicePawn.FlashFire(r_nDeviceInstanceId, int(CurrentFireMode), HitLocation, int(r_eEquippedAt), nSocketIndex, bSuccessfulHit, fRefireTime);
        // End:0xF7
        if(c_DeviceForm != none)
        {
            c_DeviceForm.Fire(HitLocation, int(CurrentFireMode), int(r_eEquippedAt), nSocketIndex, bSuccessfulHit, fRefireTime);
        }
    }
    //return;    
}

simulated event DeviceConsumePowerPool(byte FireModeNum)
{
    local TgPawn myPawn;

    myPawn = TgPawn(Instigator);
    // End:0x162
    if((myPawn != none) && (c_fCachedManaAtStartFire <= myPawn.GetMana()) || int(Role) == int(ROLE_Authority))
    {
        // End:0xCE
        if(int(Role) == int(ROLE_Authority))
        {
            myPawn.ConsumePowerPool(self, 10692, GetCurrentFire().GetShotPowerCost(10692));
        }
        myPawn.ConsumePowerPool(self, 10013, GetCurrentFire().GetShotPowerCost(10013));
        myPawn.ConsumePowerPool(self, 10014, GetCurrentFire().GetShotPowerCost(10014));
    }
    //return;    
}

simulated function bool UsesHealth()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x47
    if(FireMode != none)
    {
        return FireMode.m_fHealthCost > float(0);
    }
    return false;
    //return ReturnValue;    
}

simulated function bool UsesMana()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x47
    if(FireMode != none)
    {
        return FireMode.m_fManaCost > float(0);
    }
    return false;
    //return ReturnValue;    
}

simulated function bool UsesEnergy()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x47
    if(FireMode != none)
    {
        return FireMode.m_fEnergyCost > float(0);
    }
    return false;
    //return ReturnValue;    
}

event ConsumeDevice()
{
    local int InstanceCount;
    local TgInventoryManager CachedInvManager;
    local TgRepInfo_Player CachedInstigatorPRI;

    // End:0x15F
    if(!bPendingDelete)
    {
        CachedInvManager = TgInventoryManager(InvManager);
        // End:0xA7
        if(CachedInvManager != none)
        {
            CachedInstigatorPRI = ((CachedInvManager.Instigator != none) ? TgRepInfo_Player(CachedInvManager.Instigator.PlayerReplicationInfo) : none);
        }
        InstanceCount = s_InventoryObject.GetInstanceCount();
        // End:0x10D
        if(InstanceCount > 1)
        {
            s_InventoryObject.SetInstanceCount(InstanceCount - 1);            
        }
        else
        {
            RemoveConsumableFromOwnerInventory();
        }
        // End:0x15F
        if((CachedInvManager != none) && CachedInstigatorPRI != none)
        {
            CachedInstigatorPRI.UpdateBroadcastedItems(CachedInvManager);
        }
    }
    //return;    
}

simulated function bool CanFireWhileHanging()
{
    return false;
    //return ReturnValue;    
}

simulated function float GetLockoutExtensionTime()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x94
    if(FireMode != none)
    {
        // End:0x94
        if((((IsOffhand()) || IsPurchasedAbility()) && (GetRefireTime()) > float(0)) && !FireMode.m_bContinuousFire)
        {
            // End:0x94
            if(int(Role) < int(ROLE_Authority))
            {
                return 0.1000000;
            }
        }
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated function bool IsInhandOverrideActive()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x52
    if(TgP != none)
    {
        return TgP.GetPropCurrentValue(133) != float(0);
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    local bool bInFireLockout;

    // End:0x1E
    if(m_bHandDevice || IsToggleDevice())
    {
        return false;
    }
    bInFireLockout = ((IsFiring()) || IsTimerActive('OutroLockoutTime')) || (WorldInfo.TimeSeconds - m_EndOfLastFireTimeStamp) < (GetLockoutExtensionTime());
    // End:0xD3
    if(Current != none)
    {
        // End:0xD3
        if(Current.m_bHandDevice)
        {
            return bInFireLockout && !IsInhandOverrideActive();
        }
    }
    return bInFireLockout;
    //return ReturnValue;    
}

simulated event bool CanFireWithoutAimResult()
{
    return false;
    //return ReturnValue;    
}

simulated function CacheDeviceCanFire(bool bDeviceCanFire, TgObject.EDeviceFailType failType)
{
    m_bCachedDeviceCanFire = bDeviceCanFire;
    m_eCachedDeviceFailType = failType;
    m_fLastDeviceCanFireTimeStamp = WorldInfo.TimeSeconds;
    //return;    
}

simulated event bool CanDeviceStartFiringNow(byte FireModeNum, AimData Aim, bool bDebugRelevant, optional out TgObject.EDeviceFailType failType)
{
    local bool Success, bDeviceFailLog;
    local TgPawn P;
    local TgDeviceFire FireMode;
    local TgRepInfo_Game GRI;

    P = TgPawn(Owner);
    bDeviceFailLog = bDebugRelevant && (LogDebugInfo()) || m_bLogServerFireFailures && HasRemoteOwner();
    // End:0x103
    if(m_fLastDeviceCanFireTimeStamp == WorldInfo.TimeSeconds)
    {
        // End:0xF8
        if(!m_bCachedDeviceCanFire)
        {
            DeviceFailLog(bDeviceFailLog, string(self) @ "Device cannot fire because cached value is false");
            failType = m_eCachedDeviceFailType;
        }
        return m_bCachedDeviceCanFire;
    }
    // End:0x15D
    if(Owner == none)
    {
        DeviceFailLog(bDeviceFailLog, "Warning, no owner specified on" @ string(self));
        CacheDeviceCanFire(false, 1);
        return false;        
    }
    else
    {
        // End:0x1C4
        if(bPendingDelete)
        {
            DeviceFailLog(bDeviceFailLog, "Attempting to use a device that is in the process of being deleted");
            return false;
        }
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    Success = false;
    FireMode = GetCurrentFire();
    // End:0x8AA
    if(CanDeviceFireNow(FireModeNum, Aim, bDeviceFailLog, failType))
    {
        Success = true;
        // End:0x2EA
        if((IsDeviceCoolingDown()) && !IsInCooldownGracePeriod())
        {
            DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because this mode is still cooling down");
            failType = 4;
            Success = false;            
        }
        else
        {
            // End:0x394
            if((IsFiring()) && !FireMode.m_bContinuousFire)
            {
                DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because this device is already firing");
                failType = 0;
                Success = false;                
            }
            else
            {
                // End:0x44C
                if(IsDeviceRefiring())
                {
                    DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because your refire time on this continuous fire device indicates you are button spamming");
                    failType = 0;
                    Success = false;                    
                }
                else
                {
                    // End:0x520
                    if(!Aim.bResult && !CanFireWithoutAimResult())
                    {
                        DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because this device uses targeting mode and targeting mode is not able to place");
                        failType = 5;
                        Success = false;                        
                    }
                    else
                    {
                        // End:0x5F7
                        if(((P.r_bInGlobalOffhandCooldown == true) || P.bInGlobalOffhandCooldownClient == true) && (ApplyGlobalOffhandCooldown()) == true)
                        {
                            DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because you in Global Offhand Cooldown.");
                            failType = 10;
                            Success = false;                            
                        }
                        else
                        {
                            // End:0x6F8
                            if((((IsOffhand()) || IsPurchasedAbility()) && GetCurrentFire().GetCooldownTime() > float(0)) && (WorldInfo.TimeSeconds - m_EndOfLastFireTimeStamp) < (GetIndividualOffhandCooldownTime()))
                            {
                                DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because you are in Individual Offhand Cooldown.");
                                failType = 4;
                                Success = false;                                
                            }
                            else
                            {
                                // End:0x821
                                if((((FireMode != none) && FireMode.m_nAttackType == 1442) && GRI != none) && (int(GRI.r_GameType) == int(13)) || int(GRI.r_GameType) == int(14))
                                {
                                    DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because you cannot use recall devices in this game type");
                                    failType = 2;
                                    Success = false;                                    
                                }
                                else
                                {
                                    // End:0x8AA
                                    if(WorldInfo.Pauser != none)
                                    {
                                        DeviceFailLog(bDeviceFailLog, (string(self) @ string(FireModeNum)) @ "Failed to fire because game is paused");
                                        failType = 0;
                                        Success = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    CacheDeviceCanFire(Success, failType);
    return Success;
    //return ReturnValue;    
}

simulated event bool Use()
{
    // End:0x6E
    if(m_bUsesBurstFire && m_nBurstTotalShots > 0)
    {
        // End:0x6E
        if((Instigator.IsLocallyControlled() && !HasRemoteOwner()) && c_bBurstPendingStopFire)
        {
            c_bBurstPendingStopFire = false;
            return true;
        }
    }
    return StartFire();
    //return ReturnValue;    
}

simulated function bool StartFireHold()
{
    local float fFireHoldTime;

    fFireHoldTime = (GetFireHoldTime()) / (GetFireHoldRate());
    // End:0x44
    if(!m_bIsFireHoldDevice || fFireHoldTime <= float(0))
    {
        return false;
    }
    m_bFireHoldFull = false;
    // End:0x88
    if(c_DeviceForm != none)
    {
        c_DeviceForm.FireHoldFull(m_bFireHoldFull);
    }
    // End:0xCC
    if(int(Role) == int(ROLE_Authority))
    {
        GetCurrentFire().ApplyEffectType(Instigator, 15173);
    }
    PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStartHold);
    SetTimer(fFireHoldTime, false, 'FireHoldTimer');
    // End:0x138
    if(HasRemoteOwner() && m_CachedFireRequestId <= s_nLastRequestedFireHoldReleaseID)
    {
        ServerReleaseFireHold(0.0000000, s_nLastRequestedFireHoldReleaseID);
    }
    return true;
    //return ReturnValue;    
}

simulated function FireHoldTimer()
{
    m_bFireHoldFull = true;
    // End:0x44
    if(c_DeviceForm != none)
    {
        c_DeviceForm.FireHoldFull(m_bFireHoldFull);
    }
    // End:0xA8
    if(m_bForceReleaseFireHoldWhenCharged)
    {
        // End:0x91
        if((Instigator != none) && Instigator.IsLocallyControlled())
        {
            ReleaseFireHold();            
        }
        else
        {
            SetTimer(s_fForceReleaseFirHoldFUBARTime, false, 'FireHoldForceReleaseFUBAR');
        }
    }
    PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackFullHold);
    //return;    
}

function FireHoldValidationTimer()
{
    m_bFireHoldFull = true;
    // End:0x44
    if(c_DeviceForm != none)
    {
        c_DeviceForm.FireHoldFull(m_bFireHoldFull);
    }
    // End:0x68
    if(m_bForceReleaseFireHoldWhenCharged)
    {
        SetTimer(s_fForceReleaseFirHoldFUBARTime, false, 'FireHoldForceReleaseFUBAR');
    }
    //return;    
}

function FireHoldForceReleaseFUBAR()
{
    InterruptFiring();
    //return;    
}

simulated function InterruptFireHold()
{
    // End:0x11
    if(!m_bIsFireHoldDevice)
    {
        return;
    }
    // End:0x55
    if(int(Role) == int(ROLE_Authority))
    {
        GetCurrentFire().RemoveEffectType(Instigator, true, 15173, 0);
    }
    m_bFireHoldFull = false;
    // End:0x99
    if(c_DeviceForm != none)
    {
        c_DeviceForm.FireHoldFull(m_bFireHoldFull);
    }
    ClearTimer('FireHoldTimer');
    ClearTimer('FireHoldForceReleaseFUBAR');
    //return;    
}

simulated function InterruptBurst()
{
    // End:0x22
    if(!m_bUsesBurstFire || !m_bBurstCanBeInterrupted)
    {
        return;
    }
    m_bIsFirstBurstShot = false;
    m_nBurstShotsRemaining = 0;
    //return;    
}

simulated function SetFireHoldAmt(float fFireHoldTime)
{
    //return;    
}

simulated event ReleaseFireHold()
{
    local float fFireHoldPct;

    // End:0x3B
    if(!m_bIsFireHoldDevice || !m_bFireHoldFull || IsTimerActive('FireHoldTimer'))
    {
        return;
    }
    fFireHoldPct = GetFireHoldPct();
    SetFireHoldAmt(fFireHoldPct);
    // End:0x92
    if(int(Role) < int(ROLE_Authority))
    {
        ServerReleaseFireHold(fFireHoldPct, m_CachedFireRequestId);
    }
    PlayNextSimulatedForceFeedbackWaveform(m_ForceFeedbackStartHold, m_ForceFeedbackStopHold);
    ReleaseFireHoldInternal();
    //return;    
}

reliable server function ServerReleaseFireHold(float fClientFireHoldPercent, int nClientFireRequestId)
{
    local float fFireHoldPct;

    s_nLastRequestedFireHoldReleaseID = nClientFireRequestId;
    // End:0x4E
    if(!m_bIsFireHoldDevice || !m_bFireHoldFull || IsTimerActive('FireHoldTimer'))
    {
        return;
    }
    fClientFireHoldPercent = FClamp(fClientFireHoldPercent, 0.0000000, 1.0000000);
    fFireHoldPct = GetFireHoldPct();
    // End:0xD5
    if(((fClientFireHoldPercent + 0.2000000) > fFireHoldPct) && (fClientFireHoldPercent - 0.2000000) < fFireHoldPct)
    {
        SetFireHoldAmt(fClientFireHoldPercent);        
    }
    else
    {
        SetFireHoldAmt(fFireHoldPct);
    }
    ReleaseFireHoldInternal();
    //return;    
}

simulated function ReleaseFireHoldInternal()
{
    local float fPreHitDelay;

    // End:0x44
    if(int(Role) == int(ROLE_Authority))
    {
        GetCurrentFire().RemoveEffectType(Instigator, true, 15173, 0);
    }
    ClearTimer('FireHoldTimer');
    ClearTimer('FireHoldForceReleaseFUBAR');
    m_bFireHoldFull = false;
    // End:0xB0
    if(c_DeviceForm != none)
    {
        c_DeviceForm.FireHoldFull(m_bFireHoldFull);
    }
    fPreHitDelay = GetFiringPreHitDelay();
    m_fFiringTimer = WorldInfo.TimeSeconds + (fPreHitDelay / CustomTimeDilation);
    m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
    m_fTimeAccountedFor = 0.0000000;
    // End:0x165
    if(fPreHitDelay > float(0))
    {
        SetTimer(fPreHitDelay, false, 'FirePreHitDelay');        
    }
    else
    {
        FirePreHitDelay();
    }
    //return;    
}

reliable client simulated event ClientSimulateStartFireFromServer()
{
    CacheAim();
    SimulateStartFire();
    //return;    
}

simulated event bool SimulateStartFire()
{
    local TgDeviceFire FireMode;
    local AimData Aim;
    local TgRepInfo_Player PRI;
    local TgPawn TgP;

    // End:0x0D
    if(LogDebugInfo())
    {
    }
    FireMode = GetCurrentFire();
    // End:0x32
    if(FireMode == none)
    {
        return false;
    }
    GetCachedAim(Aim);
    // End:0x139
    if(((int(Role) == int(ROLE_Authority)) && (IsOwnedByOffhand()) || IsPurchasedAbility()) && Instigator != none)
    {
        PRI = TgRepInfo_Player(Instigator.PlayerReplicationInfo);
        TgP = TgPawn(Instigator);
        // End:0x139
        if(((PRI != none) && PRI.r_bHasFlag) && TgP != none)
        {
            TgP.DropFlag();
        }
    }
    TgP = TgPawn(Instigator);
    InterruptOtherDevices(TgP);
    // End:0x1B9
    if((IsFiring()) && FireMode.m_bContinuousFire)
    {
        // End:0x1B4
        if(!bPendingFire)
        {
            bPendingFire = true;
        }
        return true;        
    }
    else
    {
        // End:0x2DA
        if(CanDeviceStartFiringNow(CurrentFireMode, Aim, true))
        {
            bPendingFire = true;
            // End:0x221
            if(TgP != none)
            {
                // End:0x221
                if(ShouldInterruptReloadOnFire())
                {
                    TgP.InterruptInhandReload();
                }
            }
            SetFireLock();
            // End:0x265
            if(int(Role) == int(ROLE_Authority))
            {
                // End:0x265
                if((IsDeviceCoolingDown()) && IsInCooldownGracePeriod())
                {
                    EndCooldown();
                }
            }
            // End:0x2BB
            if(m_bStartFireShouldEnterCombat && CanEnterCombat())
            {
                TgP.EnterCombat(TgP, TgP, m_fEnterCombatDuration);
            }
            NotifyDeviceEvent(2);
            GotoState('DeviceBuildup');
            return true;            
        }
        else
        {
            // End:0x309
            if((int(Role) == int(ROLE_Authority)) && !IsFiring())
            {
                InterruptFiring();
            }
        }
    }
    return false;
    //return ReturnValue;    
}

function bool DeviceSpawnsClientProjectilesFirst()
{
    local TgDeviceFire FireMode;
    local Class<Projectile> projClass;

    FireMode = GetFireModeForFiringProjectile();
    // End:0x50
    if((FireMode == none) || int(FireMode.m_nFireType) != int(1))
    {
        return false;
    }
    projClass = FireMode.GetProjectileClass();
    // End:0x8A
    if(projClass == none)
    {
        return false;
    }
    return CanSpawnOnClientFirst(projClass, UsesTrackingTarget());
    //return ReturnValue;    
}

simulated event bool ShouldInterruptReloadOnFire()
{
    return (IsAbility() || m_bHandDevice) && !IsToggleDevice();
    //return ReturnValue;    
}

simulated event bool ShouldInterruptReloadOnBeginTargeting()
{
    return false;
    //return ReturnValue;    
}

simulated function bool CanEnterCombat()
{
    return (m_fEnterCombatDuration > float(0)) && (int(r_eEquippedAt) == int(1)) || int(r_eEquippedAt) == int(17);
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    // End:0x34
    if(GetCurrentFire().m_bTreatAmmoAsCharges || m_bCooldownAfterDeployDeath)
    {
        return false;
    }
    return m_bAlwaysStartCooldown || HasAlreadyFiredOnce && (r_fCooldownDelay <= 0.0000000) || m_bIsSecondaryFire;
    //return ReturnValue;    
}

simulated function bool ShouldConsumePowerPoolOnStartFire()
{
    return m_bConsumePowerPoolOnStartFire || m_bAlwaysStartCooldown;
    //return ReturnValue;    
}

simulated function bool ShouldConsumePowerPoolAfterFire()
{
    return !ShouldConsumePowerPoolOnStartFire();
    //return ReturnValue;    
}

simulated function bool ShouldSwitchBackToBasicAttackTargeting(TgClientSettings.ECastMode CastMode)
{
    return true;
    //return ReturnValue;    
}

simulated event float GetRemainingFiringTime()
{
    // End:0x2F
    if(IsTimerActive('FirePostHitDelay'))
    {
        return GetRemainingTimeForTimer('FirePostHitDelay');        
    }
    else
    {
        // End:0x6A
        if(IsTimerActive('FirePreHitDelay'))
        {
            return GetRemainingTimeForTimer('FirePreHitDelay') + (GetCachedFiringPostHitDelay());            
        }
        else
        {
            return 0.0000000;
        }
    }
    //return ReturnValue;    
}

simulated event bool StartFire()
{
    local TgDeviceFire FireMode;
    local AimData Aim, ForwardAim;
    local TgPawn TgP;

    ChangeFireModeOnRefire();
    FireMode = GetCurrentFire();
    // End:0x5C
    if((((FireMode == none) || bPendingDelete) || IsEquipping()) || IsUnEquipping())
    {
        return false;
    }
    Aim = CacheAim();
    ForwardAim = Aim;
    // End:0x160
    if((IsFiring()) && FireMode.m_bContinuousFire)
    {
        TgP = TgPawn(Instigator);
        // End:0xFE
        if(TgP != none)
        {
            TgP.SetFaceRotationToController();
        }
        // End:0x15B
        if(!bPendingFire)
        {
            // End:0x138
            if(int(Role) < int(ROLE_Authority))
            {
                CallServerStartFire(ForwardAim, true);                
            }
            else
            {
                // End:0x151
                if(!HasRemoteOwner())
                {
                    OnStartFireRequestSent();
                }
            }
            SimulateStartFire();
        }
        return true;        
    }
    else
    {
        // End:0x26F
        if(CanDeviceStartFiringNow(CurrentFireMode, Aim, true))
        {
            TgP = TgPawn(Instigator);
            // End:0x1CB
            if(TgP != none)
            {
                TgP.SetFaceRotationToController();
            }
            // End:0x208
            if((Instigator != none) && Instigator.IsLocallyControlled())
            {
                UpdateDesiredFireMode();
            }
            // End:0x247
            if(int(Role) < int(ROLE_Authority))
            {
                m_CachedFireRequestId = GenerateUniqueFireRequestId();
                CallServerStartFire(ForwardAim);                
            }
            else
            {
                // End:0x260
                if(!HasRemoteOwner())
                {
                    OnStartFireRequestSent();
                }
            }
            SimulateStartFire();
            return true;            
        }
        else
        {
            // End:0x297
            if(HasRemoteOwner() && !IsFiring())
            {
                HandleFalseFireRecory();
            }
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event HandleFalseFireRecory()
{
    // End:0x20
    if(DeviceSpawnsClientProjectilesFirst())
    {
        ClientRemoveSpawnedProjectile(m_CachedFireRequestId);
    }
    InterruptFiring();
    // End:0x5E
    if((int(m_eCachedDeviceFailType) == int(14)) && int(Role) == int(ROLE_Authority))
    {
        ClientForceReload();
    }
    // End:0x77
    if(s_bIsStartingBurstFire)
    {
        s_bInBurstRecovery = true;
    }
    //return;    
}

simulated function OnStartFireRequestSent()
{
    // End:0x44
    if(UsesSimulatedAmmo())
    {
        // End:0x44
        if((m_nPendingRegenAmmoTransactionID == 0) && m_fAmmoRegenPerSec >= float(0))
        {
            m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
        }
    }
    //return;    
}

simulated function SetFireLock()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0xB3
    if(FireMode != none)
    {
        // End:0xB3
        if(FireMode.m_fFireLockTime > float(0))
        {
            TgPawn(Owner).m_bInFireLock = true;
            ClearTimer('FireLockComplete');
            SetTimer(FireMode.m_fFireLockTime, false, 'FireLockComplete');
        }
    }
    //return;    
}

simulated function GlobalOffhandCooldownCompleteServer()
{
    TgPawn(Owner).r_bInGlobalOffhandCooldown = false;
    //return;    
}

simulated function GlobalOffhandCooldownCompleteClient()
{
    TgPawn(Owner).bInGlobalOffhandCooldownClient = false;
    //return;    
}

simulated function FireLockComplete()
{
    TgPawn(Owner).m_bInFireLock = false;
    //return;    
}

event ServerStartFireAsEvent()
{
    ServerStartFire();
    //return;    
}

reliable server function ServerQueueProjectileExplode(int ClientFireRequestId, float ProjectileAliveTime, Actor Other, float MovementTimeStamp, float HitLocationX, float HitLocationY, float HitLocationZ, float HitNormalX, float HitNormalY, float HitNormalZ)
{
    local Vector HitLocation, HitNormal;
    local TgProjectile Projectile;
    local TgProj_Simulated SimulatedProjectile;
    local TgQueuedProjectileExplosion NewQueuedExplosion;
    local TgPawn OwningPawn;
    local float AoeRewindTimeStamp;

    HitLocation.X = HitLocationX;
    HitLocation.Y = HitLocationY;
    HitLocation.Z = HitLocationZ;
    HitNormal.X = HitNormalX;
    HitNormal.Y = HitNormalY;
    HitNormal.Z = HitNormalZ;
    OwningPawn = TgPawn(Owner);
    // End:0x158
    if(OwningPawn != none)
    {
        AoeRewindTimeStamp = WorldInfo.TimeSeconds - OwningPawn.GetUnclampedLagPredictionTime();
    }
    // End:0x237
    foreach m_FiredProjectiles(Projectile)
    {
        SimulatedProjectile = TgProj_Simulated(Projectile);
        // End:0x236
        if((SimulatedProjectile != none) && SimulatedProjectile.m_nClientFireRequestId == ClientFireRequestId)
        {
            // End:0x233
            if(SimulatedProjectile.m_bShouldQueueServerHits)
            {
                HandleQueuedProjectileExplosion(SimulatedProjectile, ProjectileAliveTime, Other, MovementTimeStamp, AoeRewindTimeStamp, HitLocation, HitNormal);
            }            
            return;
        }        
    }    
    NewQueuedExplosion.ClientFireRequestId = ClientFireRequestId;
    NewQueuedExplosion.Target = Other;
    NewQueuedExplosion.HitLocation = HitLocation;
    NewQueuedExplosion.HitNormal = HitNormal;
    NewQueuedExplosion.ProjectileAliveTime = ProjectileAliveTime;
    NewQueuedExplosion.MovementTimeStamp = MovementTimeStamp;
    NewQueuedExplosion.AoeRewindTimeStamp = AoeRewindTimeStamp;
    s_QueuedProjectileExplosions.AddItem(NewQueuedExplosion);
    // End:0x376
    if(s_QueuedProjectileExplosions.Length > 128)
    {
        s_QueuedProjectileExplosions.Remove(0, 1);
    }
    //return;    
}

function HandleQueuedProjectileExplosion(TgProj_Simulated SimulatedProjectile, float ProjectileAliveTime, Actor Other, float MovementTimeStamp, float AoeRewindTimeStamp, Vector HitLocation, Vector HitNormal)
{
    // End:0x67
    if(!ValidateClientProjectileImpact(SimulatedProjectile, ProjectileAliveTime, Other, MovementTimeStamp, HitLocation, HitNormal))
    {
        SimulatedProjectile.SetShouldQueueServerHits(false);
        return;
    }
    SimulatedProjectile.FudgeProjectileHitLocationForShields(Other, HitLocation, HitNormal);
    SimulatedProjectile.s_fAoeRewindTime = WorldInfo.TimeSeconds - AoeRewindTimeStamp;
    SimulatedProjectile.m_bShouldQueueServerHits = false;
    SimulatedProjectile.SetLocation(HitLocation);
    SimulatedProjectile.ProcessTouch(Other, HitLocation, HitNormal);
    //return;    
}

reliable server function ServerAckProjectileSpawn(int ClientFireRequestId)
{
    local int I;
    local TgProj_Simulated SimulatedProjectile;

    I = 0;
    J0x0B:

    // End:0xB6 [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        SimulatedProjectile = TgProj_Simulated(m_FiredProjectiles[I]);
        // End:0xA8
        if((SimulatedProjectile != none) && SimulatedProjectile.m_nClientFireRequestId == ClientFireRequestId)
        {
            SimulatedProjectile.SetShouldQueueServerHits(false);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function float GetLastMoveTimeStamp(out Vector LastSentMoveAcceleration, out int LastSentMoveCompressedFlags, out Vector LastSentClientLoc, out byte LastSentClientRoll, out int LastSentView)
{
    local TgPlayerController OwningPlayerController;

    OwningPlayerController = ((Instigator != none) ? TgPlayerController(Instigator.Controller) : none);
    // End:0x139
    if(OwningPlayerController != none)
    {
        LastSentMoveAcceleration = OwningPlayerController.c_LastSentMoveAcceleration;
        LastSentMoveCompressedFlags = OwningPlayerController.c_LastSentMoveCompressedFlags;
        LastSentClientLoc = OwningPlayerController.c_LastSentClientLoc;
        LastSentClientRoll = OwningPlayerController.c_LastSentClientRoll;
        LastSentView = OwningPlayerController.c_LastSentView;
        return OwningPlayerController.c_LastSentMoveTimeStamp;
    }
    return -1.0000000;
    //return ReturnValue;    
}

simulated function CallServerStartFire(AimData Aim, optional bool bPendingUpdate)
{
    local Rotator AimRotation;
    local int nCompressedAim;
    local float LastSentMoveTimeStamp;
    local Vector LastSentMoveAcceleration;
    local int LastSentMoveCompressedFlags;
    local Vector LastSentClientLoc;
    local byte LastSentClientRoll;
    local int LastSentView;

    // End:0x17
    if(int(Role) == int(ROLE_Authority))
    {
        return;
    }
    LastSentMoveTimeStamp = GetLastMoveTimeStamp(LastSentMoveAcceleration, LastSentMoveCompressedFlags, LastSentClientLoc, LastSentClientRoll, LastSentView);
    AimRotation = Rotator(Aim.AimVector);
    nCompressedAim = (AimRotation.Yaw & 65535) | (AimRotation.Pitch << 16);
    ServerStartFire(LastSentMoveTimeStamp, LastSentMoveAcceleration * float(10), LastSentClientLoc, byte(LastSentMoveCompressedFlags), LastSentClientRoll, LastSentView, m_CachedFireRequestId, m_nDesiredFireMode, Aim.HitActor, Aim.StartTrace.X, Aim.StartTrace.Y, Aim.StartTrace.Z, Aim.EndTrace.X, Aim.EndTrace.Y, Aim.EndTrace.Z, nCompressedAim, m_bUsesBurstFire && m_nBurstShotsRemaining == 0);
    OnStartFireRequestSent();
    //return;    
}

simulated function CallServerRestartFireLoop(AimData Aim)
{
    local Rotator AimRotation;
    local int nCompressedAim;
    local float LastSentMoveTimeStamp;
    local Vector LastSentMoveAcceleration;
    local int LastSentMoveCompressedFlags;
    local Vector LastSentClientLoc;
    local byte LastSentClientRoll;
    local int LastSentView;

    // End:0x16
    if(int(Role) == int(ROLE_Authority))
    {
        return;
    }
    LastSentMoveTimeStamp = GetLastMoveTimeStamp(LastSentMoveAcceleration, LastSentMoveCompressedFlags, LastSentClientLoc, LastSentClientRoll, LastSentView);
    AimRotation = Rotator(Aim.AimVector);
    nCompressedAim = (AimRotation.Yaw & 65535) | (AimRotation.Pitch << 16);
    ServerRestartFireLoop(LastSentMoveTimeStamp, LastSentMoveAcceleration * float(10), LastSentClientLoc, byte(LastSentMoveCompressedFlags), LastSentClientRoll, LastSentView, m_CachedFireRequestId, m_nDesiredFireMode, Aim.HitActor, Aim.StartTrace.X, Aim.StartTrace.Y, Aim.StartTrace.Z, Aim.EndTrace.X, Aim.EndTrace.Y, Aim.EndTrace.Z, nCompressedAim, m_bUsesBurstFire && m_nBurstShotsRemaining == 0);
    //return;    
}

reliable server function ServerRestartFireLoop(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, byte ClientFireMode, Actor HitActor, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, int nCompressedAimVector, bool bFirstBurstShot)
{
    StartFiringOnServer(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView, ClientFireRequestId, ClientFireMode, HitActor, StartTraceX, StartTraceY, StartTraceZ, EndTraceX, EndTraceY, EndTraceZ, nCompressedAimVector, bFirstBurstShot);
    //return;    
}

reliable server function ServerStartFire(optional float MovementTimeStamp, optional Vector MovementInAccel, optional Vector MovementClientLoc, optional byte MovementNewFlags, optional byte MovementClientRoll, optional int MovementView, optional int ClientFireRequestId = -1, optional byte ClientFireMode = 255, optional Actor HitActor = none, optional float StartTraceX = -10000000.0000000, optional float StartTraceY = -10000000.0000000, optional float StartTraceZ = -10000000.0000000, optional float EndTraceX = -10000000.0000000, optional float EndTraceY = -10000000.0000000, optional float EndTraceZ = -10000000.0000000, optional int nCompressedAimVector = -1, optional bool bFirstBurstShot = false)
{
    OnStartFireRequestSent();
    StartFiringOnServer(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView, ClientFireRequestId, ClientFireMode, HitActor, StartTraceX, StartTraceY, StartTraceZ, EndTraceX, EndTraceY, EndTraceZ, nCompressedAimVector, bFirstBurstShot);
    //return;    
}

singular function StartFiringOnServer(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, byte ClientFireMode, Actor HitActor, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, int nCompressedAimVector, bool bFirstBurstShot)
{
    local TgRepInfo_Game GRI;
    local bool bUseLagCompensation;
    local Rotator AimRotation;
    local TgDevice inhand;
    local TgPawn TgP;
    local TgPlayerController OwningPlayerController;
    local float fRemainingFiringTime;
    local AimData DefaultAim;
    local bool bCanRefire;
    local TgQueuedRefire QueuedRefire;

    TgP = TgPawn(Instigator);
    // End:0x5C
    if(TgP != none)
    {
        OwningPlayerController = TgPlayerController(TgP.Controller);
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    bUseLagCompensation = ((GRI != none) && GRI.r_bAllowWeaponLagPrediction) && CanAllowLagCompensation();
    // End:0x150
    if((MovementTimeStamp > 0.0000000) && OwningPlayerController != none)
    {
        OwningPlayerController.ServerMove(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView);
    }
    // End:0x176
    if(s_QueuedInstantFireShotsFromServer.Length > 0)
    {
        s_QueuedInstantFireShotsFromServer.Remove(0, s_QueuedInstantFireShotsFromServer.Length);
    }
    s_bIsStartingBurstFire = m_bUsesBurstFire && bFirstBurstShot;
    // End:0x234
    if(!IsFiring())
    {
        // End:0x1D1
        if(bUseLagCompensation && ClientFireRequestId <= m_CachedFireRequestId)
        {
            return;
        }
        m_CachedFireRequestId = ClientFireRequestId;
        m_nDesiredFireMode = ClientFireMode;
        // End:0x231
        if(m_bUsesBurstFire && s_bInBurstRecovery)
        {
            // End:0x22F
            if(bFirstBurstShot)
            {
                s_bInBurstRecovery = false;                
            }
            else
            {
                return;
            }
        }        
    }
    else
    {
        bCanRefire = true;
        // End:0x291
        foreach s_QueuedRefireRequests(QueuedRefire)
        {
            // End:0x290
            if(QueuedRefire.ClientFireRequestId >= ClientFireRequestId)
            {
                bCanRefire = false;                
            }
            else
            {                
            }
        }        
        bCanRefire = bCanRefire && ClientFireRequestId > m_CachedFireRequestId;
        // End:0x3AA
        if(bCanRefire)
        {
            m_CachedFireRequestId = ClientFireRequestId;
            m_nDesiredFireMode = ClientFireMode;
            SetRandomShotSpreadSeed(m_CachedFireRequestId);
            ServerRestartFireLoop(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView, ClientFireRequestId, ClientFireMode, HitActor, StartTraceX, StartTraceY, StartTraceZ, EndTraceX, EndTraceY, EndTraceZ, nCompressedAimVector, bFirstBurstShot);
        }
    }
    s_ReceivedAim = DefaultAim;
    s_ReceivedAim.HitActor = HitActor;
    s_ReceivedAim.ClientMovementTimeStamp = MovementTimeStamp;
    // End:0x4F1
    if(((StartTraceX > -10000000.0000000) && StartTraceY > -10000000.0000000) && StartTraceZ > -10000000.0000000)
    {
        s_ReceivedAim.StartTrace.X = StartTraceX;
        s_ReceivedAim.StartTrace.Y = StartTraceY;
        s_ReceivedAim.StartTrace.Z = StartTraceZ;
    }
    // End:0x5D9
    if(((EndTraceX > -10000000.0000000) && EndTraceY > -10000000.0000000) && EndTraceZ > -10000000.0000000)
    {
        s_ReceivedAim.EndTrace.X = EndTraceX;
        s_ReceivedAim.EndTrace.Y = EndTraceY;
        s_ReceivedAim.EndTrace.Z = EndTraceZ;
    }
    // End:0x672
    if(nCompressedAimVector != -1)
    {
        AimRotation.Yaw = nCompressedAimVector & 65535;
        AimRotation.Pitch = (nCompressedAimVector >> 16) & 65535;
        s_ReceivedAim.AimVector = Vector(AimRotation);
    }
    s_ReceivedAim = ValidateReceivedAim(MovementTimeStamp, s_ReceivedAim);
    // End:0x78C
    if(self.IsAbility() && m_bAbilityRequiresInhandResync)
    {
        // End:0x78C
        if(TgP != none)
        {
            inhand = TgP.GetDeviceByEqPoint(1);
            // End:0x78C
            if(inhand != none)
            {
                fRemainingFiringTime = inhand.GetRemainingFiringTime();
                // End:0x78C
                if(fRemainingFiringTime > float(0))
                {
                    inhand.InterruptFiring();
                    inhand.StartCooldown(,, fRemainingFiringTime);
                }
            }
        }
    }
    StartFire();
    //return;    
}

simulated function bool CanToggleDeviceStopFiring()
{
    return true;
    //return ReturnValue;    
}

simulated function StopFire()
{
    // End:0x8C
    if(m_bUsesBurstFire && m_nBurstTotalShots > 0)
    {
        // End:0x8C
        if(Instigator.IsLocallyControlled() && !HasRemoteOwner())
        {
            // End:0x80
            if((m_nBurstShotsRemaining > 0) && IsFiring())
            {
                c_bBurstPendingStopFire = true;
                return;                
            }
            else
            {
                c_bBurstPendingStopFire = false;
            }
        }
    }
    // End:0x99
    if(LogDebugInfo())
    {
    }
    bPendingFire = false;
    // End:0xD4
    if((int(Role) < int(ROLE_Authority)) && !IsPendingKill())
    {
        ServerStopFire();
    }
    // End:0x15F
    if(((!IsToggleDevice() && IsTimerActive('FirePreHitDelay') || IsTimerActive('FirePostHitDelay')) || (IsFiring()) && s_nNumClientRefires > s_nNumServerRefires) || (IsToggleDevice()) && !CanToggleDeviceStopFiring())
    {
        return;
    }
    // End:0x1B1
    if((IsFiring()) && (GetCurrentFire().m_bContinuousFire == true) || IsToggleDevice())
    {
        GotoState('Active');
    }
    bNetDirty = true;
    //return;    
}

event StopFireAsEvent()
{
    StopFire();
    //return;    
}

event ServerStopFireAsEvent()
{
    ServerStopFire();
    //return;    
}

reliable server function ServerStopFire()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    // End:0x26
    if(!IsPendingKill())
    {
        StopFire();
    }
    //return;    
}

simulated event ForceStopFire()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    bPendingFire = false;
    // End:0x48
    if((int(Role) < int(ROLE_Authority)) && !IsPendingKill())
    {
        ServerForceStopFire();
    }
    GotoState('Active');
    bNetDirty = true;
    //return;    
}

reliable server function ServerForceStopFire()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    // End:0x26
    if(!IsPendingKill())
    {
        ForceStopFire();
    }
    //return;    
}

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo Impact;
    local TgDeviceFire currDevFire;
    local TgRepInfo_Game GRI;

    currDevFire = GetCurrentFire();
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xEE
    if(currDevFire != none)
    {
        Impact = currDevFire.CalcWeaponModeFire(Instigator, Aim, ImpactList, false, ((GRI != none) && GRI.r_bUseInstantFireMeshTrace) && m_bDoNotAllowHeadShots).Impact;
    }
    return Impact;
    //return ReturnValue;    
}

simulated event DeliverQueuedPendingHits()
{
    local int Idx;
    local TgPawn_Character TgP;

    // End:0x6A
    if(PendingImpactList.Length == 0)
    {
        m_CachedMissedInstantFire = true;
        TgP = TgPawn_Character(Owner);
        // End:0x67
        if(TgP != none)
        {
            TgP.DeviceOnMiss(self);
        }        
    }
    else
    {
        m_CachedMissedInstantFire = false;
        // End:0xF6
        if(int(TgPawn(Instigator).Role) == int(ROLE_Authority))
        {
            Idx = 0;
            J0xB3:

            // End:0xF6 [Loop If]
            if(Idx < PendingImpactList.Length)
            {
                DeliverHit(PendingImpactList[Idx]);
                Idx++;
                // [Loop Continue]
                goto J0xB3;
            }
        }
        PendingImpactList.Length = 0;
    }
    //return;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x78
    if((FireMode != none) && Impact.HitActor != none)
    {
        FireMode.ApplyHit(Impact, Instigator);
    }
    //return;    
}

simulated event InstantFire()
{
    local float rand1, rand2;
    local AimData baseaim, Aim;
    local ImpactInfo Impact;
    local int nShotsFired;
    local TgRepInfo_Game GRI;
    local bool bPerformingServerValidation;
    local int nNumShotsToFire;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    bPerformingServerValidation = ((((int(Role) == int(ROLE_Authority)) && GRI != none) && GRI.r_bAllowWeaponLagPrediction) && CanAllowLagCompensation()) && !Instigator.IsLocallyControlled() || HasRemoteOwner();
    nNumShotsToFire = ((m_bConsolidateMultipleShots) ? 1 : GetCurrentFire().m_nShotsPerFire);
    // End:0x10C
    if(LogDebugInfo())
    {
    }
    GetCachedAim(baseaim);
    nShotsFired = 0;
    J0x12A:

    // End:0x4BA [Loop If]
    if(nShotsFired < nNumShotsToFire)
    {
        Aim = baseaim;
        // End:0x1A1
        if((int(GetTargetingMode()) == int(1)) && !m_bConsolidateMultipleShots)
        {
            GetAdjustedAim(Aim, rand1, rand2);
        }
        // End:0x3BB
        if((GRI != none) && GRI.r_bAllowWeaponLagPrediction && CanAllowLagCompensation())
        {
            // End:0x386
            if(Instigator.IsLocallyControlled() && !HasRemoteOwner())
            {
                PendingImpactList.Length = 0;
                Impact = CalcWeaponFire(Aim, PendingImpactList);
                // End:0x28E
                if(m_bConsolidateMultipleShots)
                {
                    HandleInstantFireWithConsolidation(baseaim, Aim, Impact, int(Role) < int(ROLE_Authority));                    
                }
                else
                {
                    // End:0x2FA
                    if(int(Role) < int(ROLE_Authority))
                    {
                        Class'TgGame.TgDevice'.static.RecordUsedAim(Aim.AimVector);
                        SendImpactsForVerification(baseaim, Impact);
                    }
                    PlayClientFireFx(Impact.HitLocation, m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(Impact.HitActor), GetRefireTime());
                }
                DeliverQueuedPendingHits();
                UpdateIndex();                
            }
            else
            {
                // End:0x3B8
                if(bPerformingServerValidation)
                {
                    PerformOnInstantFireServerValidation(Aim, rand1, rand2);
                }
            }            
        }
        else
        {
            PendingImpactList.Length = 0;
            Impact = CalcWeaponFire(Aim, PendingImpactList);
            // End:0x423
            if(m_bConsolidateMultipleShots)
            {
                HandleInstantFireWithConsolidation(baseaim, Aim, Impact, false);                
            }
            else
            {
                PlayClientFireFx(Impact.HitLocation, m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(Impact.HitActor), GetRefireTime());
            }
            DeliverQueuedPendingHits();
            UpdateIndex();
        }
        nShotsFired++;
        // [Loop Continue]
        goto J0x12A;
    }
    //return;    
}

simulated function HandleInstantFireWithConsolidation(const out AimData baseaim, const out AimData Aim, out ImpactInfo Impact, bool bSendForServerValidation)
{
    local array<float> fConsolidatedShotRanges;
    local array<Vector> vHitLocations;
    local int I;
    local TgPawn TgP;
    local array<byte> nShotsToImpactIndex;

    // End:0x11
    if(!m_bConsolidateMultipleShots)
    {
        return;
    }
    bSendForServerValidation = bSendForServerValidation && int(Role) < int(ROLE_Authority);
    // End:0x13D
    if(c_DeviceForm != none)
    {
        I = 0;
        J0x56:

        // End:0xAF [Loop If]
        if(I < PendingImpactList.Length)
        {
            vHitLocations.AddItem(PendingImpactList[I].HitLocation);
            I++;
            // [Loop Continue]
            goto J0x56;
        }
        c_DeviceForm.FireMultiUnpacked(vHitLocations, int(CurrentFireMode), int(r_eEquippedAt), m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(Impact.HitActor), GetRefireTime());
    }
    // End:0x172
    if(bSendForServerValidation)
    {
        ConsolidateImpacts(PendingImpactList, fConsolidatedShotRanges, nShotsToImpactIndex);        
    }
    else
    {
        ConsolidateImpacts(PendingImpactList, fConsolidatedShotRanges);
    }
    // End:0x1B4
    if(PendingImpactList.Length > 0)
    {
        Impact = PendingImpactList[0];
    }
    // End:0x2FF
    if(int(Role) == int(ROLE_Authority))
    {
        TgP = TgPawn(Instigator);
        // End:0x2FF
        if(TgP != none)
        {
            TgP.FlashFireMulti(r_nDeviceInstanceId, int(CurrentFireMode), Aim.StartTrace, Aim.AimVector, fConsolidatedShotRanges, GetCurrentFire().GetRange(), m_nLastSetShotSpreadSeed, GetAccuracy(int(CurrentFireMode)), int(r_eEquippedAt), m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(Impact.HitActor), GetRefireTime());
        }
    }
    // End:0x331
    if(bSendForServerValidation)
    {
        SendImpactsForVerification(baseaim, Impact, nShotsToImpactIndex);
    }
    //return;    
}

function PerformOnInstantFireServerValidation(const out AimData Aim, float AccuracyRandomValue1, float AccuracyRandomValue2)
{
    local TgQueuedInstantFireShot NewQueuedShot;
    local bool bFoundMatchingQueuedShot;
    local AimData ClientAdjustedAim;

    bFoundMatchingQueuedShot = false;
    // End:0x1CB
    if(s_QueuedInstantFireShotsFromClient.Length > 0)
    {
        J0x1C:

        // End:0x6A [Loop If]
        if((s_QueuedInstantFireShotsFromClient.Length > 0) && s_QueuedInstantFireShotsFromClient[0].FireRequestId != m_CachedFireRequestId)
        {
            s_QueuedInstantFireShotsFromClient.Remove(0, 1);
            // [Loop Continue]
            goto J0x1C;
        }
        // End:0x1CB
        if((s_QueuedInstantFireShotsFromClient.Length > 0) && s_QueuedInstantFireShotsFromClient[0].FireRequestId == m_CachedFireRequestId)
        {
            bFoundMatchingQueuedShot = true;
            ClientAdjustedAim = s_QueuedInstantFireShotsFromClient[0].Aim;
            s_ReceivedAim = ClientAdjustedAim;
            GetAdjustedAim(ClientAdjustedAim, AccuracyRandomValue1, AccuracyRandomValue2, AccuracyRandomValue1, AccuracyRandomValue2);
            HandleClientReportedInstantShot(Aim, ClientAdjustedAim, s_QueuedInstantFireShotsFromClient[0].PrimaryImpact, s_QueuedInstantFireShotsFromClient[0].Impacts);
            // End:0x1BE
            if(ShouldConsumeAmmo(m_CachedFireRequestId, s_QueuedInstantFireShotsFromClient[0].Impacts))
            {
                ConsumeAmmoFromFiring();
            }
            s_QueuedInstantFireShotsFromClient.Remove(0, 1);
        }
    }
    // End:0x2D8
    if(!bFoundMatchingQueuedShot)
    {
        // End:0x203
        if(s_QueuedInstantFireShotsFromServer.Length > (r_nMaxAmmoClipCount * 3))
        {
            s_QueuedInstantFireShotsFromServer.Remove(0, 1);
        }
        NewQueuedShot.FireRequestId = m_CachedFireRequestId;
        NewQueuedShot.Aim = Aim;
        NewQueuedShot.AmmoToConsume = GetAmmoToConsume();
        NewQueuedShot.AccuracyRandomValue1 = AccuracyRandomValue1;
        NewQueuedShot.AccuracyRandomValue2 = AccuracyRandomValue2;
        s_QueuedInstantFireShotsFromServer.AddItem(NewQueuedShot);
    }
    //return;    
}

simulated function SendImpactsForVerification(const out AimData baseaim, const out ImpactInfo Impact, const optional out array<byte> nShotsToImpactIndex)
{
    local ImpactToValidate PrimaryImpact;
    local TgPawn HitPawn;
    local int nPendingImpactIndex;
    local ImpactToValidate NetworkPendingImpactList[10], NetworkPendingImpactListSmall[3];
    local int I;
    local float LastSentMoveTimeStamp;
    local Vector LastSentMoveAcceleration;
    local int LastSentMoveCompressedFlags;
    local Vector LastSentClientLoc;
    local byte LastSentClientRoll;
    local int LastSentView;

    LastSentMoveTimeStamp = GetLastMoveTimeStamp(LastSentMoveAcceleration, LastSentMoveCompressedFlags, LastSentClientLoc, LastSentClientRoll, LastSentView);
    PrimaryImpact.Impact = Impact;
    PrimaryImpact.PackedAssociatedShotIDs = 0;
    HitPawn = TgPawn(Impact.HitActor);
    // End:0x195
    if(HitPawn != none)
    {
        PrimaryImpact.ImpactTimeStamp = HitPawn.c_fServerTimeStamp;
        I = 0;
        J0x10A:

        // End:0x195 [Loop If]
        if(I < nShotsToImpactIndex.Length)
        {
            // End:0x187
            if(int(nShotsToImpactIndex[I]) == int(1))
            {
                PrimaryImpact.PackedAssociatedShotIDs = PrimaryImpact.PackedAssociatedShotIDs | (1 << I);
            }
            I++;
            // [Loop Continue]
            goto J0x10A;
        }
    }
    // End:0x36F
    if((PendingImpactList.Length == 0) || (PendingImpactList.Length == 1) && Impact.HitActor == PendingImpactList[0].HitActor)
    {
        ServerInstantFireSingleImpact(LastSentMoveTimeStamp, LastSentMoveAcceleration * float(10), LastSentClientLoc, byte(LastSentMoveCompressedFlags), LastSentClientRoll, LastSentView, m_CachedFireRequestId, baseaim.StartTrace.X, baseaim.StartTrace.Y, baseaim.StartTrace.Z, baseaim.EndTrace.X, baseaim.EndTrace.Y, baseaim.EndTrace.Z, PrimaryImpact);        
    }
    else
    {
        // End:0x6B8
        if(PendingImpactList.Length < 4)
        {
            nPendingImpactIndex = 0;
            J0x38B:

            // End:0x52E [Loop If]
            if(nPendingImpactIndex < Min(PendingImpactList.Length, 3))
            {
                NetworkPendingImpactListSmall[nPendingImpactIndex].Impact = PendingImpactList[nPendingImpactIndex];
                HitPawn = TgPawn(PendingImpactList[nPendingImpactIndex].HitActor);
                // End:0x520
                if(HitPawn != none)
                {
                    NetworkPendingImpactListSmall[nPendingImpactIndex].ImpactTimeStamp = HitPawn.c_fServerTimeStamp;
                    I = 0;
                    J0x479:

                    // End:0x520 [Loop If]
                    if(I < nShotsToImpactIndex.Length)
                    {
                        // End:0x512
                        if(int(nShotsToImpactIndex[I]) == (nPendingImpactIndex + 1))
                        {
                            NetworkPendingImpactListSmall[nPendingImpactIndex].PackedAssociatedShotIDs = NetworkPendingImpactListSmall[nPendingImpactIndex].PackedAssociatedShotIDs | (1 << I);
                        }
                        I++;
                        // [Loop Continue]
                        goto J0x479;
                    }
                }
                nPendingImpactIndex++;
                // [Loop Continue]
                goto J0x38B;
            }
            ServerInstantFireThreeImpacts(LastSentMoveTimeStamp, LastSentMoveAcceleration * float(10), LastSentClientLoc, byte(LastSentMoveCompressedFlags), LastSentClientRoll, LastSentView, m_CachedFireRequestId, baseaim.StartTrace.X, baseaim.StartTrace.Y, baseaim.StartTrace.Z, baseaim.EndTrace.X, baseaim.EndTrace.Y, baseaim.EndTrace.Z, PrimaryImpact, PendingImpactList.Length, NetworkPendingImpactListSmall);            
        }
        else
        {
            nPendingImpactIndex = 0;
            J0x6C3:

            // End:0x866 [Loop If]
            if(nPendingImpactIndex < Min(PendingImpactList.Length, 10))
            {
                NetworkPendingImpactList[nPendingImpactIndex].Impact = PendingImpactList[nPendingImpactIndex];
                HitPawn = TgPawn(PendingImpactList[nPendingImpactIndex].HitActor);
                // End:0x858
                if(HitPawn != none)
                {
                    NetworkPendingImpactList[nPendingImpactIndex].ImpactTimeStamp = HitPawn.c_fServerTimeStamp;
                    I = 0;
                    J0x7B1:

                    // End:0x858 [Loop If]
                    if(I < nShotsToImpactIndex.Length)
                    {
                        // End:0x84A
                        if(int(nShotsToImpactIndex[I]) == (nPendingImpactIndex + 1))
                        {
                            NetworkPendingImpactListSmall[nPendingImpactIndex].PackedAssociatedShotIDs = NetworkPendingImpactListSmall[nPendingImpactIndex].PackedAssociatedShotIDs | (1 << I);
                        }
                        I++;
                        // [Loop Continue]
                        goto J0x7B1;
                    }
                }
                nPendingImpactIndex++;
                // [Loop Continue]
                goto J0x6C3;
            }
            ServerInstantFire(LastSentMoveTimeStamp, LastSentMoveAcceleration * float(10), LastSentClientLoc, byte(LastSentMoveCompressedFlags), LastSentClientRoll, LastSentView, m_CachedFireRequestId, baseaim.StartTrace.X, baseaim.StartTrace.Y, baseaim.StartTrace.Z, baseaim.EndTrace.X, baseaim.EndTrace.Y, baseaim.EndTrace.Z, PrimaryImpact, PendingImpactList.Length, NetworkPendingImpactList);
        }
    }
    //return;    
}

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact)
{
    //return;    
}

function OnInstantShotRejected(ImpactToValidate RejectedPrimaryImpact)
{
    //return;    
}

function HandleClientReportedInstantShot(AimData InServerAim, AimData InClientAim, ImpactToValidate InPrimaryImpact, array<ImpactToValidate> InClientImpacts)
{
    local TgPawn TgP;
    local ImpactInfo VerifiedPrimaryImpact;
    local array<float> hitRanges;

    PendingImpactList.Length = 0;
    // End:0x240
    if(ValidateClientInstantHit(VerifiedPrimaryImpact, PendingImpactList, InServerAim, InClientAim, InPrimaryImpact, InClientImpacts, hitRanges))
    {
        OnInstantShotVerified(VerifiedPrimaryImpact);
        // End:0xF2
        if(!m_bConsolidateMultipleShots)
        {
            PlayClientFireFx(VerifiedPrimaryImpact.HitLocation, m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(VerifiedPrimaryImpact.HitActor), GetRefireTime());            
        }
        else
        {
            TgP = TgPawn(Instigator);
            // End:0x229
            if(TgP != none)
            {
                TgP.FlashFireMulti(r_nDeviceInstanceId, int(CurrentFireMode), InClientAim.StartTrace, InClientAim.AimVector, hitRanges, GetCurrentFire().GetRange(), m_nLastSetShotSpreadSeed, GetAccuracy(int(CurrentFireMode)), int(r_eEquippedAt), m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(VerifiedPrimaryImpact.HitActor), GetRefireTime());
            }
        }
        DeliverQueuedPendingHits();
        UpdateIndex();        
    }
    else
    {
        OnInstantShotRejected(InPrimaryImpact);
    }
    //return;    
}

reliable server function ServerInstantFire(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, ImpactToValidate Impact, int NumImpacts, ImpactToValidate InImpactList[10])
{
    local AimData ClientAim;
    local bool bFoundMatchingQueuedShot;
    local TgQueuedInstantFireShot NewQueuedShot;
    local array<ImpactToValidate> Impacts;
    local int nPendingImpactIndex;
    local TgPawn OwningPawn;
    local TgPlayerController TgPlayerController;
    local float LagPredictionTime;
    local TgRepInfo_Game GRI;
    local float AccuracyRandomValue1, AccuracyRandomValue2;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x68
    if((GRI == none) || !GRI.r_bAllowWeaponLagPrediction)
    {
        return;
    }
    OwningPawn = TgPawn(Owner);
    // End:0xED
    if(OwningPawn != none)
    {
        LagPredictionTime = OwningPawn.GetLagPredictionTime();
        TgPlayerController = TgPlayerController(OwningPawn.Controller);
    }
    // End:0x166
    if((MovementTimeStamp > 0.0000000) && TgPlayerController != none)
    {
        TgPlayerController.ServerMove(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView);
    }
    nPendingImpactIndex = 0;
    J0x171:

    // End:0x1EA [Loop If]
    if(nPendingImpactIndex < Min(NumImpacts, 10))
    {
        InImpactList[nPendingImpactIndex].ImpactTimeStamp = WorldInfo.TimeSeconds - LagPredictionTime;
        nPendingImpactIndex++;
        // [Loop Continue]
        goto J0x171;
    }
    ClientAim.StartTrace.X = StartTraceX;
    ClientAim.StartTrace.Y = StartTraceY;
    ClientAim.StartTrace.Z = StartTraceZ;
    ClientAim.EndTrace.X = EndTraceX;
    ClientAim.EndTrace.Y = EndTraceY;
    ClientAim.EndTrace.Z = EndTraceZ;
    ClientAim.AimVector = Normal(ClientAim.EndTrace - ClientAim.StartTrace);
    ClientAim = ValidateReceivedAim(MovementTimeStamp, ClientAim);
    bFoundMatchingQueuedShot = false;
    J0x3CB:

    // End:0x5D4 [Loop If]
    if((s_QueuedInstantFireShotsFromServer.Length > 0) && s_QueuedInstantFireShotsFromServer[0].FireRequestId <= ClientFireRequestId)
    {
        // End:0x5C4
        if(s_QueuedInstantFireShotsFromServer[0].FireRequestId == ClientFireRequestId)
        {
            nPendingImpactIndex = 0;
            J0x440:

            // End:0x489 [Loop If]
            if(nPendingImpactIndex < Min(NumImpacts, 10))
            {
                Impacts.AddItem(InImpactList[nPendingImpactIndex]);
                nPendingImpactIndex++;
                // [Loop Continue]
                goto J0x440;
            }
            s_ReceivedAim = ClientAim;
            GetAdjustedAim(ClientAim, AccuracyRandomValue1, AccuracyRandomValue2, s_QueuedInstantFireShotsFromServer[0].AccuracyRandomValue1, s_QueuedInstantFireShotsFromServer[0].AccuracyRandomValue2);
            HandleClientReportedInstantShot(s_QueuedInstantFireShotsFromServer[0].Aim, ClientAim, Impact, Impacts);
            // End:0x5A5
            if(ShouldConsumeAmmo(m_CachedFireRequestId, Impacts))
            {
                ConsumeAmmoFromFiring(s_QueuedInstantFireShotsFromServer[0].AmmoToConsume, s_QueuedInstantFireShotsFromServer[0].FireRequestId);
            }
            bFoundMatchingQueuedShot = true;
            s_QueuedInstantFireShotsFromServer.Remove(0, 1);
            // [Explicit Break]
            goto J0x5D4;            
        }
        else
        {
            s_QueuedInstantFireShotsFromServer.Remove(0, 1);
        }
        // [Loop Continue]
        goto J0x3CB;
    }
    J0x5D4:

    // End:0x6FB
    if(!bFoundMatchingQueuedShot)
    {
        // End:0x60C
        if(s_QueuedInstantFireShotsFromClient.Length > (r_nMaxAmmoClipCount * 3))
        {
            s_QueuedInstantFireShotsFromClient.Remove(0, 1);
        }
        NewQueuedShot.FireRequestId = ClientFireRequestId;
        NewQueuedShot.Aim = ClientAim;
        NewQueuedShot.PrimaryImpact = Impact;
        nPendingImpactIndex = 0;
        J0x689:

        // End:0x6E5 [Loop If]
        if(nPendingImpactIndex < Min(NumImpacts, 10))
        {
            NewQueuedShot.Impacts.AddItem(InImpactList[nPendingImpactIndex]);
            nPendingImpactIndex++;
            // [Loop Continue]
            goto J0x689;
        }
        s_QueuedInstantFireShotsFromClient.AddItem(NewQueuedShot);
    }
    //return;    
}

reliable server function ServerInstantFireThreeImpacts(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, ImpactToValidate Impact, int NumImpacts, ImpactToValidate InImpactList[3])
{
    local ImpactToValidate ImpactList[10];

    ImpactList[0] = InImpactList[0];
    ImpactList[1] = InImpactList[1];
    ImpactList[2] = InImpactList[2];
    ServerInstantFire(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView, ClientFireRequestId, StartTraceX, StartTraceY, StartTraceZ, EndTraceX, EndTraceY, EndTraceZ, Impact, NumImpacts, ImpactList);
    //return;    
}

reliable server function ServerInstantFireSingleImpact(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, ImpactToValidate Impact)
{
    local ImpactToValidate ImpactList[10];

    ImpactList[0] = Impact;
    ServerInstantFire(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView, ClientFireRequestId, StartTraceX, StartTraceY, StartTraceZ, EndTraceX, EndTraceY, EndTraceZ, Impact, 1, ImpactList);
    //return;    
}

function AOEArcingFlash(array<ImpactInfo> ImpactList, optional Vector StartLocation = vect(0.0000000, 0.0000000, 0.0000000))
{
    local int I;

    // End:0x27
    if(int(Role) < int(ROLE_Authority))
    {
        return;
    }
    I = 0;
    J0x32:

    // End:0x175 [Loop If]
    if(I < ImpactList.Length)
    {
        // End:0x167
        if((ImpactList[I].HitActor != none) && ImpactList[I].HitActor != Instigator)
        {
            TgPawn(Instigator).FlashArcing(r_nDeviceInstanceId, int(CurrentFireMode), ImpactList[I].HitActor.Location, StartLocation, ImpactList[I].HitActor, int(r_eEquippedAt), m_nSocketIndex, true);
        }
        I++;
        // [Loop Continue]
        goto J0x32;
    }
    //return;    
}

simulated function CustomFire()
{
    local AimData Aim;
    local TgDeviceFire FireMode;

    UpdateIndex();
    GetCachedAim(Aim);
    TgPawn(Instigator).FlashFireNoSim(r_nDeviceInstanceId, int(CurrentFireMode), Aim.EndTrace, int(r_eEquippedAt), m_nSocketIndex, false, GetRefireTime());
    FireMode = GetCurrentFire();
    // End:0x1EB
    if(FireMode != none)
    {
        // End:0x1B8
        if((((FireMode.m_nAttackType == 1442) || FireMode.m_nAttackType == 10636) || FireMode.m_nAttackType == 10657) || FireMode.m_nAttackType == 15034)
        {
            // End:0x1B5
            if(FireMode.CanSimulateTeleportFire() || int(Role) == int(ROLE_Authority))
            {
                FireMode.TeleportFire();
            }            
        }
        else
        {
            // End:0x1EB
            if(int(Role) == int(ROLE_Authority))
            {
                FireMode.CustomFire();
            }
        }
    }
    //return;    
}

simulated function TgDeviceFire GetFireModeForFiringProjectile()
{
    return GetCurrentFire();
    //return ReturnValue;    
}

simulated function SpawnQueuedSimulatedProjectile()
{
    local TgProjectile SpawnedProjectile;

    J0x00:
    SpawnedProjectile = SpawnSimulatedProjectile(true, c_QueuedSimulatedProjectileSpawns[0].FireRequestId, 0, c_QueuedSimulatedProjectileSpawns[0].FireMode, c_QueuedSimulatedProjectileSpawns[0].ProjectileSpawnLocation, c_QueuedSimulatedProjectileSpawns[0].ProjectileSpawnDir, c_QueuedSimulatedProjectileSpawns[0].ProjectileIndex, c_QueuedSimulatedProjectileSpawns[0].ProjectileIdOverride, c_QueuedSimulatedProjectileSpawns[0].Range, c_QueuedSimulatedProjectileSpawns[0].trackingTarget, c_QueuedSimulatedProjectileSpawns[0].EndTrace);
    // End:0x16F
    if(SpawnedProjectile != none)
    {
        SpawnedProjectile.CompleteInitialization();
        UpdateIndex();
        UpdateActiveProjectiles(SpawnedProjectile);
    }
    c_QueuedSimulatedProjectileSpawns.Remove(0, 1);
    // End:0x00
    if(!((c_QueuedSimulatedProjectileSpawns.Length == 0) || c_QueuedSimulatedProjectileSpawns[0].TimeStampToSpawn > WorldInfo.TimeSeconds))
        goto J0x00;
    // End:0x22B
    if(c_QueuedSimulatedProjectileSpawns.Length > 0)
    {
        SetTimer(c_QueuedSimulatedProjectileSpawns[0].TimeStampToSpawn - WorldInfo.TimeSeconds, false, 'SpawnQueuedSimulatedProjectile');
    }
    //return;    
}

simulated function TgProj_Simulated SpawnSimulatedProjectile(bool bCanSpawnOnClientFirst, int FireRequestId, int ProjectileInstanceId, TgDeviceFire FireMode, Vector ProjectileSpawnLocation, Vector ProjectileSpawnDir, int ProjectileIndex, int ProjectileIdOverride, float Range, Actor trackingTarget, Vector EndTrace)
{
    local TgProj_Simulated SpawnedProjectile;
    local int QueuedTouchIndex;

    SpawnedProjectile = TgRepInfo_Game(WorldInfo.GRI).SpawnSimulatedProjectile(ProjectileInstanceId, FireMode.m_nId, Instigator, ProjectileSpawnLocation, ProjectileSpawnDir, ProjectileIdOverride, (int(Role) == int(ROLE_Authority)) && bCanSpawnOnClientFirst);
    // End:0xD1
    if(int(Role) == int(ROLE_Authority))
    {
        r_nProjectiles++;
    }
    // End:0xE2
    if(SpawnedProjectile == none)
    {
        return none;
    }
    // End:0x153
    if((!Instigator.IsLocallyControlled() || HasRemoteOwner()) || int(Role) < int(ROLE_Authority))
    {
        Class'TgGame.TgDevice'.static.RecordUsedAim(ProjectileSpawnDir);
    }
    SpawnedProjectile.m_nClientFireRequestId = m_CachedFireRequestId;
    SpawnedProjectile.m_OwnerFireMode = FireMode;
    SpawnedProjectile.r_fRange = FireMode.GetRange();
    AdjustSpawnedProjectile(SpawnedProjectile);
    SpawnedProjectile.SetShouldQueueServerHits((bCanSpawnOnClientFirst && int(Role) == int(ROLE_Authority)) && !Instigator.IsLocallyControlled() || HasRemoteOwner());
    // End:0x2D7
    if(SpawnedProjectile.m_TrackingSettings.bUsesTracking && trackingTarget != none)
    {
        SpawnedProjectile.SetTarget(trackingTarget);
    }
    QueuedTouchIndex = 0;
    J0x2E2:

    // End:0x468 [Loop If]
    if(QueuedTouchIndex < s_QueuedProjectileExplosions.Length)
    {
        // End:0x45A
        if(s_QueuedProjectileExplosions[QueuedTouchIndex].ClientFireRequestId == SpawnedProjectile.m_nClientFireRequestId)
        {
            HandleQueuedProjectileExplosion(SpawnedProjectile, s_QueuedProjectileExplosions[QueuedTouchIndex].ProjectileAliveTime, s_QueuedProjectileExplosions[QueuedTouchIndex].Target, s_QueuedProjectileExplosions[QueuedTouchIndex].MovementTimeStamp, s_QueuedProjectileExplosions[QueuedTouchIndex].AoeRewindTimeStamp, s_QueuedProjectileExplosions[QueuedTouchIndex].HitLocation, s_QueuedProjectileExplosions[QueuedTouchIndex].HitNormal);
            s_QueuedProjectileExplosions.Remove(QueuedTouchIndex, 1);
            QueuedTouchIndex--;
        }
        QueuedTouchIndex++;
        // [Loop Continue]
        goto J0x2E2;
    }
    return SpawnedProjectile;
    //return ReturnValue;    
}

simulated function AdjustSpawnedProjectile(out TgProj_Simulated SpawnedProjectile)
{
    //return;    
}

reliable server function ServerProjectileFire(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, int ProjectileIndex, float ProjectileLocationX, float ProjectileLocationY, float ProjectileLocationZ, float ProjectileAimVectorX, float ProjectileAimVectorY, float ProjectileAimVectorZ, float ProjectileEndTraceX, float ProjectileEndTraceY, float ProjectileEndTraceZ)
{
    local bool bFoundMatchingQueuedShot;
    local Vector ProjectileSpawnLocation, ProjectileSpawnDir, ProjectileEndTrace;
    local TgQueuedSimulatedProjectileSpawn NewQueuedSpawn;
    local TgRepInfo_Game GRI;
    local TgProj_Simulated SpawnedProjectile;
    local TgPawn TgPawn;
    local TgPlayerController TgPlayerController;
    local AimData AimData;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x68
    if((GRI == none) || !GRI.r_bAllowWeaponLagPrediction)
    {
        return;
    }
    TgPawn = TgPawn(Instigator);
    // End:0xC4
    if(TgPawn != none)
    {
        TgPlayerController = TgPlayerController(TgPawn.Controller);
    }
    // End:0x13D
    if((MovementTimeStamp > 0.0000000) && TgPlayerController != none)
    {
        TgPlayerController.ServerMove(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView);
    }
    ProjectileSpawnLocation.X = ProjectileLocationX;
    ProjectileSpawnLocation.Y = ProjectileLocationY;
    ProjectileSpawnLocation.Z = ProjectileLocationZ;
    ProjectileEndTrace.X = ProjectileEndTraceX;
    ProjectileEndTrace.Y = ProjectileEndTraceY;
    ProjectileEndTrace.Z = ProjectileEndTraceZ;
    ProjectileSpawnDir.X = ProjectileAimVectorX;
    ProjectileSpawnDir.Y = ProjectileAimVectorY;
    ProjectileSpawnDir.Z = ProjectileAimVectorZ;
    bFoundMatchingQueuedShot = false;
    AimData.ClientMovementTimeStamp = MovementTimeStamp;
    AimData.StartTrace = ProjectileSpawnLocation;
    AimData.EndTrace = ProjectileEndTrace;
    AimData.AimVector = ProjectileSpawnDir;
    AimData = ValidateReceivedAim(MovementTimeStamp, AimData);
    J0x35D:

    // End:0x671 [Loop If]
    if((s_QueuedProjectileSpawnsFromServer.Length > 0) && s_QueuedProjectileSpawnsFromServer[0].FireRequestId <= ClientFireRequestId)
    {
        // End:0x661
        if(s_QueuedProjectileSpawnsFromServer[0].FireRequestId == ClientFireRequestId)
        {
            bFoundMatchingQueuedShot = true;
            NewQueuedSpawn = s_QueuedProjectileSpawnsFromServer[0];
            s_ReceivedAim = AimData;
            GetAdjustedAim(AimData, NewQueuedSpawn.AccuracyRandomValue1, NewQueuedSpawn.AccuracyRandomValue2, NewQueuedSpawn.AccuracyRandomValue1, NewQueuedSpawn.AccuracyRandomValue2);
            SpawnedProjectile = SpawnSimulatedProjectile(true, ClientFireRequestId, TgGame(WorldInfo.Game).GetNextProjectileInstanceId(), NewQueuedSpawn.FireMode, AimData.StartTrace, AimData.AimVector, ProjectileIndex, NewQueuedSpawn.ProjectileIdOverride, NewQueuedSpawn.Range, NewQueuedSpawn.trackingTarget, AimData.EndTrace);
            SpawnedProjectile.CompleteInitialization();
            UpdateIndex();
            PlayClientFireFx(AimData.EndTrace, m_nSocketIndex, true, GetRefireTime());
            TgPawn(Instigator).ProjectileOnFire(SpawnedProjectile);
            s_QueuedProjectileSpawnsFromServer.Remove(0, 1);
            UpdateActiveProjectiles(SpawnedProjectile);
            // [Explicit Break]
            goto J0x671;            
        }
        else
        {
            s_QueuedProjectileSpawnsFromServer.Remove(0, 1);
        }
        // [Loop Continue]
        goto J0x35D;
    }
    J0x671:

    // End:0x883
    if(!bFoundMatchingQueuedShot)
    {
        // End:0x6B8
        if(s_QueuedProjectileSpawnsFromClient.Length > (Max(Max(r_nMaxAmmoClipCount, m_nBurstTotalShots), 5) * 3))
        {
            s_QueuedProjectileSpawnsFromClient.Remove(0, 1);
        }
        NewQueuedSpawn.ClientMovementTimeStamp = MovementTimeStamp;
        NewQueuedSpawn.FireRequestId = ClientFireRequestId;
        NewQueuedSpawn.FireMode = GetFireModeForFiringProjectile();
        NewQueuedSpawn.ProjectileSpawnLocation = AimData.StartTrace;
        NewQueuedSpawn.ProjectileSpawnDir = AimData.AimVector;
        NewQueuedSpawn.EndTrace = AimData.EndTrace;
        NewQueuedSpawn.ProjectileIndex = ProjectileIndex;
        NewQueuedSpawn.Range = GetFireModeForFiringProjectile().GetRange();
        // End:0x86D
        if(UsesTrackingTarget())
        {
            NewQueuedSpawn.trackingTarget = GetTrackingTarget();
        }
        s_QueuedProjectileSpawnsFromClient.AddItem(NewQueuedSpawn);
    }
    //return;    
}

simulated function Projectile ProjectileFire(optional int ProjectileIndex = 0)
{
    local AimData baseaim, Aim;
    local Projectile SpawnedProjectile;
    local Class<Projectile> projClass;
    local TgDeviceFire FireMode;
    local Actor trackingTarget;
    local Vector ProjectileSpawnLocation, ProjectileSpawnDir;
    local Rotator OwnerRotationYawOnly;
    local int ProjectileInstanceId;
    local bool bCanSpawnOnClientFirst;
    local TgPawn OwnerPawn;
    local TgQueuedSimulatedProjectileSpawn NewQueuedSpawn;
    local float SpawnSleepTime, AccuracyRandomValue1, AccuracyRandomValue2;
    local TgPlayerController TgPlayerController;
    local float LastSentMoveTimeStamp;
    local Vector LastSentMoveAcceleration;
    local int LastSentMoveCompressedFlags;
    local Vector LastSentClientLoc;
    local byte LastSentClientRoll;
    local int LastSentView;

    FireMode = GetFireModeForFiringProjectile();
    GetCachedAim(baseaim);
    // End:0x4D
    if(UsesTrackingTarget())
    {
        trackingTarget = GetTrackingTarget();
    }
    Aim = baseaim;
    GetAdjustedAim(Aim, AccuracyRandomValue1, AccuracyRandomValue2);
    ProjectileSpawnLocation = Aim.StartTrace;
    ProjectileSpawnDir = Aim.AimVector;
    // End:0x159
    if(m_bProjectileFollowOwnerYaw)
    {
        OwnerRotationYawOnly = Owner.Rotation;
        OwnerRotationYawOnly.Roll = 0;
        OwnerRotationYawOnly.Pitch = 0;
        ProjectileSpawnDir = Vector(OwnerRotationYawOnly);
    }
    FireMode.VerifyProjectile();
    projClass = FireMode.GetProjectileClass();
    UpdateIndex();
    PlayClientFireFx(Aim.EndTrace, m_nSocketIndex, true, GetRefireTime());
    bCanSpawnOnClientFirst = CanSpawnOnClientFirst(projClass, UsesTrackingTarget());
    // End:0x235
    if((int(Role) < int(ROLE_Authority)) && !bCanSpawnOnClientFirst)
    {
        return none;
    }
    // End:0xE14
    if(ClassIsChildOf(projClass, Class'TgGame.TgProj_Simulated'))
    {
        // End:0x26F
        if(int(Role) < int(ROLE_Authority))
        {
            ProjectileInstanceId = 0;            
        }
        else
        {
            ProjectileInstanceId = TgGame(WorldInfo.Game).GetNextProjectileInstanceId();
        }
        OwnerPawn = TgPawn(Owner);
        // End:0x782
        if((bCanSpawnOnClientFirst && int(Role) == int(ROLE_Authority)) && ((Instigator != none) && !Instigator.IsLocallyControlled()) || HasRemoteOwner())
        {
            J0x33B:

            // End:0x389 [Loop If]
            if((s_QueuedProjectileSpawnsFromClient.Length > 0) && s_QueuedProjectileSpawnsFromClient[0].FireRequestId != m_CachedFireRequestId)
            {
                s_QueuedProjectileSpawnsFromClient.Remove(0, 1);
                // [Loop Continue]
                goto J0x33B;
            }
            // End:0x614
            if((s_QueuedProjectileSpawnsFromClient.Length > 0) && s_QueuedProjectileSpawnsFromClient[0].FireRequestId == m_CachedFireRequestId)
            {
                Aim.ClientMovementTimeStamp = s_QueuedProjectileSpawnsFromClient[0].ClientMovementTimeStamp;
                Aim.StartTrace = s_QueuedProjectileSpawnsFromClient[0].ProjectileSpawnLocation;
                Aim.EndTrace = s_QueuedProjectileSpawnsFromClient[0].EndTrace;
                Aim.AimVector = s_QueuedProjectileSpawnsFromClient[0].ProjectileSpawnDir;
                s_ReceivedAim = Aim;
                GetAdjustedAim(Aim, AccuracyRandomValue1, AccuracyRandomValue2, AccuracyRandomValue1, AccuracyRandomValue2);
                SpawnedProjectile = SpawnSimulatedProjectile(true, s_QueuedProjectileSpawnsFromClient[0].FireRequestId, ProjectileInstanceId, FireMode, Aim.StartTrace, Aim.AimVector, s_QueuedProjectileSpawnsFromClient[0].ProjectileIndex, GetProjectileIDOverride(s_QueuedProjectileSpawnsFromClient[0].ProjectileIndex), FireMode.GetRange(), trackingTarget, Aim.EndTrace);
                s_QueuedProjectileSpawnsFromClient.Remove(0, 1);                
            }
            else
            {
                // End:0x63D
                if(s_QueuedProjectileSpawnsFromServer.Length > (r_nMaxAmmoClipCount * 3))
                {
                    s_QueuedProjectileSpawnsFromServer.Remove(0, 1);
                }
                NewQueuedSpawn.FireRequestId = m_CachedFireRequestId;
                NewQueuedSpawn.FireMode = FireMode;
                NewQueuedSpawn.Range = FireMode.GetRange();
                NewQueuedSpawn.trackingTarget = trackingTarget;
                NewQueuedSpawn.ProjectileIdOverride = GetProjectileIDOverride(ProjectileIndex);
                NewQueuedSpawn.AccuracyRandomValue1 = AccuracyRandomValue1;
                NewQueuedSpawn.AccuracyRandomValue2 = AccuracyRandomValue2;
                s_QueuedProjectileSpawnsFromServer.AddItem(NewQueuedSpawn);
                return none;
            }            
        }
        else
        {
            // End:0xD46
            if((int(Role) < int(ROLE_Authority)) && OwnerPawn != none)
            {
                TgPlayerController = TgPlayerController(OwnerPawn.Controller);
                // End:0x8D7
                if(TgPlayerController != none)
                {
                    LastSentMoveTimeStamp = TgPlayerController.c_LastSentMoveTimeStamp;
                    LastSentMoveAcceleration = TgPlayerController.c_LastSentMoveAcceleration;
                    LastSentMoveCompressedFlags = TgPlayerController.c_LastSentMoveCompressedFlags;
                    LastSentClientLoc = TgPlayerController.c_LastSentClientLoc;
                    LastSentClientRoll = TgPlayerController.c_LastSentClientRoll;
                    LastSentView = TgPlayerController.c_LastSentView;
                }
                ServerProjectileFire(LastSentMoveTimeStamp, LastSentMoveAcceleration, LastSentClientLoc, byte(LastSentMoveCompressedFlags), LastSentClientRoll, LastSentView, m_CachedFireRequestId, ProjectileIndex, baseaim.StartTrace.X, baseaim.StartTrace.Y, baseaim.StartTrace.Z, baseaim.AimVector.X, baseaim.AimVector.Y, baseaim.AimVector.Z, baseaim.EndTrace.X, baseaim.EndTrace.Y, baseaim.EndTrace.Z);
                SpawnSleepTime = OwnerPawn.GetUnclampedLagPredictionTime() - OwnerPawn.GetLagPredictionTime();
                // End:0xD46
                if(SpawnSleepTime > 0.0000000)
                {
                    NewQueuedSpawn.TimeStampToSpawn = WorldInfo.TimeSeconds + SpawnSleepTime;
                    NewQueuedSpawn.FireRequestId = m_CachedFireRequestId;
                    NewQueuedSpawn.FireMode = FireMode;
                    NewQueuedSpawn.ProjectileSpawnLocation = ProjectileSpawnLocation;
                    NewQueuedSpawn.ProjectileSpawnDir = ProjectileSpawnDir;
                    NewQueuedSpawn.ProjectileIndex = ProjectileIndex;
                    NewQueuedSpawn.ProjectileIdOverride = GetProjectileIDOverride(ProjectileIndex);
                    NewQueuedSpawn.Range = FireMode.GetRange();
                    NewQueuedSpawn.trackingTarget = trackingTarget;
                    NewQueuedSpawn.EndTrace = Aim.EndTrace;
                    c_QueuedSimulatedProjectileSpawns.AddItem(NewQueuedSpawn);
                    // End:0xD44
                    if(!IsTimerActive('SpawnQueuedSimulatedProjectile'))
                    {
                        SetTimer(SpawnSleepTime, false, 'SpawnQueuedSimulatedProjectile');
                    }
                    return none;
                }
            }
        }
        // End:0xE00
        if(SpawnedProjectile == none)
        {
            SpawnedProjectile = SpawnSimulatedProjectile(bCanSpawnOnClientFirst, m_CachedFireRequestId, ProjectileInstanceId, FireMode, ProjectileSpawnLocation, ProjectileSpawnDir, ProjectileIndex, GetProjectileIDOverride(ProjectileIndex), FireMode.GetRange(), trackingTarget, Aim.EndTrace);
        }
        // End:0xE11
        if(SpawnedProjectile == none)
        {
            return none;
        }        
    }
    else
    {
        SpawnedProjectile = Spawn(projClass, none,, ProjectileSpawnLocation, Rotator(Aim.AimVector),, true);
        // End:0xE6D
        if(SpawnedProjectile == none)
        {
            return none;
        }
        // End:0x100B
        if(!SpawnedProjectile.bDeleteMe)
        {
            TgProjectile(SpawnedProjectile).r_Owner = self;
            TgProjectile(SpawnedProjectile).r_nOwnerFireModeId = FireMode.m_nId;
            TgProjectile(SpawnedProjectile).m_OwnerFireMode = FireMode;
            TgProjectile(SpawnedProjectile).r_vSpawnLocation = SpawnedProjectile.Location;
            TgProjectile(SpawnedProjectile).r_eEquippedAt = r_eEquippedAt;
            FireMode.InitializeProjectile(SpawnedProjectile);
            SpawnedProjectile.Init(Aim.AimVector);
        }
    }
    TgProjectile(SpawnedProjectile).CompleteInitialization();
    return SpawnedProjectile;
    //return ReturnValue;    
}

simulated function int GetProjectileIDOverride(int ProjectileIndex)
{
    return 0;
    //return ReturnValue;    
}

simulated function Vector GetPhysicalFireStartLoc(optional Vector AimDir)
{
    local Vector SocketLocation;
    local Rotator SocketRotation;

    // End:0x1A
    if(Instigator == none)
    {
        return Location;
    }
    // End:0xA3
    if(!m_bHandDevice && c_DeviceForm != none)
    {
        SkeletalMeshComponent(c_DeviceForm.c_AttachedMesh).GetSocketWorldLocationAndRotation(name("WSO_Emit_01"), SocketLocation, SocketRotation);
        return SocketLocation;
    }
    return Instigator.GetPawnViewLocation();
    //return ReturnValue;    
}

simulated function Actor GetTrackingTarget()
{
    local AimData Aim;

    GetCachedAim(Aim);
    // End:0x72
    if(GetCurrentFire().IsValidTarget(Aim.HitActor))
    {
        return Aim.HitActor;
    }
    return none;
    //return ReturnValue;    
}

function TrackDeviceModeFired(TgPawn PawnFiring)
{
    local TgPawn ResponsiblePawn;
    local int nDeviceModeID;

    // End:0x75
    if(PawnFiring.WasPlayerSpawned())
    {
        ResponsiblePawn = PawnFiring.r_Owner;
        nDeviceModeID = PawnFiring.s_nSpawnerDeviceModeId;        
    }
    else
    {
        // End:0x112
        if((PawnFiring.Controller != none) && PawnFiring.Controller.IsA('TgPlayerController'))
        {
            ResponsiblePawn = PawnFiring;
            nDeviceModeID = GetCurrentFire().m_nId;            
        }
        else
        {
            return;
        }
    }
    ResponsiblePawn.TrackFired(nDeviceModeID);
    //return;    
}

simulated function int GetAmmoToConsume()
{
    // End:0x2F
    if((m_bUsesBurstFire && m_bOnlyFirstBurstCostsAmmo) && !m_bIsFirstBurstShot)
    {
        return 0;
    }
    return GetCurrentFire().m_nAmmoCostPerShot;
    //return ReturnValue;    
}

simulated function bool ShouldConsumeAmmo(int nFireRequestID, optional array<ImpactToValidate> Impacts)
{
    return true;
    //return ReturnValue;    
}

simulated function ConsumeAmmoFromFiring(optional int nAmmoConsumptionOverride = -1, optional int nFireRequestIDOverride = -1)
{
    local int nAmmoToConsume, nFireRequestIDToUse;
    local TgRepInfo_Game GRI;

    nFireRequestIDToUse = ((nFireRequestIDOverride > 0) ? nFireRequestIDOverride : m_CachedFireRequestId);
    nAmmoToConsume = ((nAmmoConsumptionOverride > 0) ? nAmmoConsumptionOverride : GetAmmoToConsume());
    // End:0x155
    if(m_nLastFiringIDToConsumeAmmo == nFireRequestIDToUse)
    {
        GRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x155
        if((((((int(Role) == int(ROLE_Authority)) && GRI != none) && Instigator != none) && GRI.r_bAllowWeaponLagPrediction) && CanAllowLagCompensation()) && !Instigator.IsLocallyControlled() || HasRemoteOwner())
        {
            return;
        }
    }
    // End:0x325
    if(nAmmoToConsume > 0)
    {
        ConsumeAmmo(GetCurrentFire().m_nAmmoCostPerShot);
        // End:0x325
        if((((UsesSimulatedAmmo()) && int(Role) < int(ROLE_Authority)) && Instigator != none) && Instigator.IsLocallyControlled())
        {
            // End:0x2DE
            if(c_EligableRefundFiringIDs[c_nEligableRefundFiringIDsIndexLast].FiringRequestID != nFireRequestIDToUse)
            {
                c_nEligableRefundFiringIDsIndexLast = (c_nEligableRefundFiringIDsIndexLast + 1) % 30;
                // End:0x265
                if(c_nEligableRefundFiringIDsIndexLast == c_nEligableRefundFiringIDsIndexFirst)
                {
                    c_nEligableRefundFiringIDsIndexFirst = (c_nEligableRefundFiringIDsIndexLast + 1) % 30;
                }
                c_EligableRefundFiringIDs[c_nEligableRefundFiringIDsIndexLast].FiringRequestID = nFireRequestIDToUse;
                c_EligableRefundFiringIDs[c_nEligableRefundFiringIDsIndexLast].AmmoConsumed = GetCurrentFire().m_nAmmoCostPerShot;                
            }
            else
            {
                c_EligableRefundFiringIDs[c_nEligableRefundFiringIDsIndexLast].AmmoConsumed += GetCurrentFire().m_nAmmoCostPerShot;
            }
        }
    }
    m_nLastFiringIDToConsumeAmmo = nFireRequestIDToUse;
    m_bIsFirstBurstShot = false;
    //return;    
}

simulated function FireAmmunition()
{
    local TgDeviceFire FireMode;
    local int I;
    local Projectile Proj;
    local TgPawn TgP;
    local TgRepInfo_Game GRI;

    // End:0x0D
    if(LogDebugInfo())
    {
    }
    TgP = TgPawn(Instigator);
    // End:0x65
    if(ShouldInterruptStealth())
    {
        // End:0x65
        if(TgP != none)
        {
            TgP.InterruptStealth(self);
        }
    }
    // End:0xA1
    if(ShouldInterruptLift())
    {
        // End:0xA1
        if(TgP != none)
        {
            TgP.InterruptLift();
        }
    }
    // End:0xE2
    if(TgPawn(Owner) != none)
    {
        TgPawn(Owner).DeviceOnFire(self);
    }
    FireMode = GetCurrentFire();
    // End:0x140
    if((TgPawn(Owner) != none) && int(Role) == int(ROLE_Authority))
    {
        TrackDeviceModeFired(TgPawn(Owner));
    }
    // End:0x160
    if(ShouldConsumePowerPoolAfterFire())
    {
        DeviceConsumePowerPool(CurrentFireMode);
    }
    switch(FireMode.m_nFireType)
    {
        // End:0x19A
        case 0:
            InstantFire();
            // End:0x34A
            break;
        // End:0x335
        case 1:
            // End:0x26C
            if(FireMode.m_nShotsPerFire > 0)
            {
                // End:0x207
                if(IsA('TgDevice_HitPulse'))
                {
                    Proj = ProjectileFire(TgDevice_HitPulse(self).m_CurrentPulseIndex);                    
                }
                else
                {
                    I = 0;
                    J0x212:

                    // End:0x269 [Loop If]
                    if(I < FireMode.m_nShotsPerFire)
                    {
                        Proj = ProjectileFire(I);
                        ++I;
                        // [Loop Continue]
                        goto J0x212;
                    }
                }                
            }
            else
            {
                Proj = ProjectileFire();
            }
            // End:0x2FE
            if(((Proj != none) && TgPawn(Owner) != none) && TgProjectile(Proj) != none)
            {
                TgPawn(Owner).ProjectileOnFire(TgProjectile(Proj));
            }
            // End:0x332
            if(TgProjectile(Proj) != none)
            {
                UpdateActiveProjectiles(TgProjectile(Proj));
            }
            // End:0x34A
            break;
        // End:0x347
        case 2:
            CustomFire();
            // End:0x34A
            break;
        // End:0xFFFF
        default:
            break;
    }
    FireMode.ApplyEffectType(Instigator, 10030);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x498
    if((int(FireMode.m_nFireType) != int(0)) || !(((((int(Role) == int(ROLE_Authority)) && GRI != none) && Instigator != none) && GRI.r_bAllowWeaponLagPrediction) && CanAllowLagCompensation()) && !Instigator.IsLocallyControlled() || HasRemoteOwner())
    {
        // End:0x498
        if(ShouldConsumeAmmo(m_CachedFireRequestId))
        {
            ConsumeAmmoFromFiring();
        }
    }
    // End:0x4EE
    if(m_bFireShouldEnterCombat && CanEnterCombat())
    {
        TgP.EnterCombat(TgP, TgP, m_fEnterCombatDuration);
    }
    // End:0x562
    if(AIController(Instigator.Controller) != none)
    {
        AIController(Instigator.Controller).NotifyWeaponFired(self, CurrentFireMode);
    }
    NotifyDeviceEvent(0);
    SendDeviceChangeEvent(6);
    m_fLastDeviceCanFireTimeStamp = 0.0000000;
    // End:0x680
    if(((int(CurrentFireMode) >= int(0)) && int(CurrentFireMode) < 5) && m_AccuracySettings[int(CurrentFireMode)].bUsesAdvancedAccuracy)
    {
        // End:0x5FC
        if(m_nFreeShotsLeft > 0)
        {
            m_nFreeShotsLeft--;            
        }
        else
        {
            m_fCurrentAdvancedAccuracy = FMax(GetMinAccuracy(), m_fCurrentAdvancedAccuracy - m_AccuracySettings[int(CurrentFireMode)].fAccuracyLossPerShot);
        }
        m_fLastMinAccuracy = m_fCurrentAdvancedAccuracy;
        m_fLastShotTimestamp = WorldInfo.TimeSeconds;
    }
    // End:0x6E0
    if(((int(CurrentFireMode) >= int(0)) && int(CurrentFireMode) < 5) && m_RecoilSettings[int(CurrentFireMode)].bUsesRecoil)
    {
        AddRecoil();
    }
    //return;    
}

simulated function float GetMinAccuracy()
{
    return m_AccuracySettings[int(CurrentFireMode)].fMinAccuracy;
    //return ReturnValue;    
}

simulated function UpdateActiveProjectiles(optional TgProjectile Proj)
{
    local int I;

    m_FiredProjectiles.AddItem(Proj);
    I = 0;
    J0x22:

    // End:0x102 [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        // End:0xF4
        if((((m_FiredProjectiles[I] == none) || m_FiredProjectiles[I].m_bHasExploded) || m_FiredProjectiles[I].bDeleteMe) || m_FiredProjectiles[I].m_bIsShutDown)
        {
            m_FiredProjectiles.Remove(I--, 1);
        }
        I++;
        // [Loop Continue]
        goto J0x22;
    }
    //return;    
}

simulated function bool AltFireDetonate()
{
    local int I;
    local bool bDetonatedAProjectile;

    I = 0;
    J0x0B:

    // End:0x7F [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        // End:0x71
        if(m_FiredProjectiles[I] != none)
        {
            m_FiredProjectiles[I].AltFireDetonate();
            bDetonatedAProjectile = true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    UpdateActiveProjectiles();
    return bDetonatedAProjectile;
    //return ReturnValue;    
}

simulated function float GetAltFireDetonateDamagePct()
{
    return 1.0000000;
    //return ReturnValue;    
}

simulated event float GetCooldownRemaining()
{
    local TgTimerManager TimerManager;

    TimerManager = GetCooldownTimerManager();
    // End:0x58
    if(TimerManager.IsSet(0))
    {
        return TimerManager.GetTimeRemaining(0);
    }
    return 0.0000000;
    //return ReturnValue;    
}

function CooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent, optional bool bNoBecomeActive)
{
    // End:0x17
    if(int(eEvent) != int(0))
    {
        return;
    }
    // End:0x56
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x56
        if(!bNoBecomeActive && IsActive())
        {
            BecomeActive();
        }
    }
    TgPawn(Instigator).FlashCooldownDone(r_nDeviceInstanceId, 0);
    // End:0x11C
    if(int(r_eEquippedAt) == int(5))
    {
        // End:0x11C
        if((Instigator != none) && TgRepInfo_Player(Instigator.PlayerReplicationInfo) != none)
        {
            TgRepInfo_Player(Instigator.PlayerReplicationInfo).UpdateUltimateIsReady(0.0000000);
        }
    }
    //return;    
}

simulated function ClientCooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent)
{
    SendDeviceChangeEvent(4);
    //return;    
}

function AlternateStartCooldown()
{
    ClearTimer('AlternateStartCooldown');
    m_bIgnoreSecondaryFireLogic = false;
    m_bIsSecondaryFire = false;
    StartCooldown(int(CurrentFireMode));
    //return;    
}

simulated event StartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    // End:0x42
    if(int(Role) == int(ROLE_Authority))
    {
        AuthStartCooldown(nMode, fCooldownTimeOverride);
    }
    //return;    
}

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    local TgTimerManager TimerManager;
    local float fCooldownTime;
    local TgPawn TgPawn;
    local int AbilityCooldownTimerIndex;
    local bool bWasActive;

    AbilityCooldownTimerIndex = 0;
    // End:0x2A
    if(LogDebugInfo())
    {
    }
    fCooldownTime = ((fCooldownTimeOverride >= float(0)) ? fCooldownTimeOverride : GetCooldownTime(nMode));
    // End:0x76
    if(fCooldownTime <= float(0))
    {
        return;
    }
    TgPawn = TgPawn(Instigator);
    // End:0x10E
    if(TgPawn != none)
    {
        // End:0xDB
        if(TgPawn.m_bCheatNoRecharge)
        {
            CooldownTimerExpired(AbilityCooldownTimerIndex, 0, true);
            return;
        }
        TgPawn.FlashCooldown(r_nDeviceInstanceId, int(CurrentFireMode));
    }
    TimerManager = GetCooldownTimerManager();
    // End:0x24A
    if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
    {
        bWasActive = IsActive();
        // End:0x1DD
        if(fCooldownTime > float(0))
        {
            TimerManager.RegisterForEvents(AbilityCooldownTimerIndex, self, 'CooldownTimerExpired');
            TimerManager.Start(AbilityCooldownTimerIndex, fCooldownTime);
        }
        ClientStartCooldown(int(CurrentFireMode), fCooldownTime);
        PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStartCooldown);
        // End:0x24A
        if(TgPawn != none)
        {
            TgPawn.DeviceOnStartCooldown(self, fCooldownTime);
        }
    }
    // End:0x290
    if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
    {
        CooldownTimerExpired(AbilityCooldownTimerIndex, 0, true);        
    }
    else
    {
        // End:0x2A8
        if(bWasActive)
        {
            CeaseActive();
        }
    }
    // End:0x341
    if(int(r_eEquippedAt) == int(5))
    {
        // End:0x341
        if((Instigator != none) && TgRepInfo_Player(Instigator.PlayerReplicationInfo) != none)
        {
            TgRepInfo_Player(Instigator.PlayerReplicationInfo).UpdateUltimateIsReady(GetCooldownRemaining());
        }
    }
    //return;    
}

event ResetCooldown(int nMode, optional float fCooldownTimeOverride = -1.0000000)
{
    local TgTimerManager TimerManager;
    local float fCooldownTime;
    local int AbilityCooldownTimerIndex;
    local TgPawn TgPawn;

    AbilityCooldownTimerIndex = 0;
    // End:0x21
    if(LogDebugInfo())
    {
    }
    TgPawn = TgPawn(Instigator);
    // End:0xA3
    if(TgPawn != none)
    {
        // End:0x70
        if(TgPawn.m_bCheatNoRecharge)
        {
            return;
        }
        TgPawn.FlashCooldown(r_nDeviceInstanceId, int(CurrentFireMode));
    }
    TimerManager = GetCooldownTimerManager();
    fCooldownTime = ((fCooldownTimeOverride >= float(0)) ? fCooldownTimeOverride : GetCooldownTime(nMode));
    // End:0x195
    if(fCooldownTime > 0.0000000)
    {
        // End:0x153
        if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
        {
            StartCooldown(int(CurrentFireMode), fCooldownTime);
            return;            
        }
        else
        {
            m_bCooldownWasModified = true;
            TimerManager.Update(AbilityCooldownTimerIndex, fCooldownTime);
        }        
    }
    else
    {
        // End:0x20B
        if(TimerManager.IsSet(AbilityCooldownTimerIndex))
        {
            m_bCooldownWasModified = true;
            TimerManager.Close(AbilityCooldownTimerIndex, false);
            CooldownTimerExpired(AbilityCooldownTimerIndex, 0);
        }
    }
    ClientResetCooldown(int(CurrentFireMode), fCooldownTime);
    // End:0x2C2
    if(int(r_eEquippedAt) == int(5))
    {
        // End:0x2C2
        if((Instigator != none) && TgRepInfo_Player(Instigator.PlayerReplicationInfo) != none)
        {
            TgRepInfo_Player(Instigator.PlayerReplicationInfo).UpdateUltimateIsReady(GetCooldownRemaining());
        }
    }
    //return;    
}

simulated event float GetCooldownTime(optional int nMode = -1)
{
    local TgDeviceFire Mode;

    Mode = ((nMode < 0) ? GetCurrentFire() : m_FireMode[nMode]);
    // End:0x91
    if(Mode != none)
    {
        return FMax(Mode.GetMinCooldownTime(), Mode.GetCooldownTime());
    }
    return -1.0000000;
    //return ReturnValue;    
}

simulated event EndCooldown()
{
    local TgTimerManager TimerManager;

    TimerManager = GetCooldownTimerManager();
    // End:0x77
    if((TimerManager != none) && TimerManager.IsSet(0))
    {
        TimerManager.Close(0, false);
        CooldownTimerExpired(0, 0);
    }
    ClientEndCooldown();
    //return;    
}

reliable client simulated event ClientStartCooldown(int nMode, float fCooldownTime)
{
    local int AbilityCooldownTimerIndex;
    local TgTimerManager TimerManager;

    AbilityCooldownTimerIndex = 0;
    // End:0x18
    if(LogDebugInfo())
    {
    }
    TimerManager = GetCooldownTimerManager();
    // End:0x80
    if(TimerManager.IsSet(AbilityCooldownTimerIndex))
    {
        TimerManager.Close(AbilityCooldownTimerIndex, false);
    }
    // End:0xF7
    if(fCooldownTime > float(0))
    {
        TimerManager.RegisterForEvents(AbilityCooldownTimerIndex, self, 'ClientCooldownTimerExpired');
        TimerManager.Start(AbilityCooldownTimerIndex, fCooldownTime);
    }
    SendDeviceChangeEvent(4);
    //return;    
}

reliable client simulated event ClientResetCooldown(int nMode, float fCooldownTime)
{
    local int AbilityCooldownTimerIndex;
    local TgTimerManager TimerManager;

    AbilityCooldownTimerIndex = 0;
    // End:0x18
    if(LogDebugInfo())
    {
    }
    TimerManager = GetCooldownTimerManager();
    // End:0x10B
    if(fCooldownTime > 0.0000000)
    {
        // End:0xD5
        if(!TimerManager.IsSet(AbilityCooldownTimerIndex))
        {
            TimerManager.RegisterForEvents(AbilityCooldownTimerIndex, self, 'ClientCooldownTimerExpired');
            TimerManager.Start(AbilityCooldownTimerIndex, fCooldownTime);            
        }
        else
        {
            TimerManager.Update(AbilityCooldownTimerIndex, fCooldownTime);
        }        
    }
    else
    {
        // End:0x15F
        if(TimerManager.IsSet(AbilityCooldownTimerIndex))
        {
            TimerManager.Close(AbilityCooldownTimerIndex, false);
        }
    }
    SendDeviceChangeEvent(4);
    //return;    
}

reliable client simulated event ClientEndCooldown()
{
    local TgTimerManager TimerManager;

    // End:0x04
    if(true)
    {
    }
    TimerManager = GetCooldownTimerManager();
    // End:0x6D
    if((TimerManager != none) && TimerManager.IsSet(0))
    {
        TimerManager.Close(0, false);
    }
    SendDeviceChangeEvent(4);
    //return;    
}

simulated function NotifyPutAway()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    StopFire();
    GotoState('Active');
    PendingImpactList.Length = 0;
    // End:0x48
    if(IsInTargetingMode())
    {
        ExitTargetingMode();
    }
    //return;    
}

simulated event NotifySwitchMode()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    PendingImpactList.Length = 0;
    //return;    
}

simulated function UpdateDesiredFireMode()
{
    //return;    
}

simulated function ChangeFireModeOnRefire()
{
    // End:0x47
    if((int(m_nDesiredFireMode) != int(255)) && int(m_nDesiredFireMode) != int(CurrentFireMode))
    {
        SetFireMode(int(m_nDesiredFireMode));
    }
    //return;    
}

function OnTeleportNotify(Actor TeleportingActor)
{
    //return;    
}

function OnProjectileShutdown(TgProjectile Proj)
{
    // End:0x2D
    if(int(Role) == int(ROLE_Authority))
    {
        r_nProjectiles = Max(r_nProjectiles - 1, 0);
    }
    //return;    
}

simulated event LockInput(bool bShouldLock)
{
    local TgPawn PawnOwner;
    local TgAIController_Behavior OwnerAI;
    local TgPlayerController OwnerPC;

    PawnOwner = TgPawn(Instigator);
    // End:0x8D
    if(PawnOwner != none)
    {
        OwnerAI = TgAIController_Behavior(PawnOwner.Controller);
        OwnerPC = TgPlayerController(PawnOwner.Controller);
    }
    // End:0x119
    if(OwnerPC != none)
    {
        OwnerPC.m_nDevicesLockingInput += ((bShouldLock) ? 1 : -1);
        OwnerPC.m_nDevicesLockingInput = int(FMax(float(OwnerPC.m_nDevicesLockingInput), 0.0000000));
    }
    // End:0x1E6
    if(OwnerAI != none)
    {
        OwnerAI.m_nDevicesLockingInput += ((bShouldLock) ? 1 : -1);
        OwnerAI.m_nDevicesLockingInput = int(FMax(float(OwnerAI.m_nDevicesLockingInput), 0.0000000));
        OwnerAI.bIsRotationLocked = OwnerAI.m_nDevicesLockingInput > 0;
    }
    //return;    
}

simulated function LockCamera(bool bShouldLock)
{
    local TgPawn PawnOwner;
    local TgPlayerController OwnerPC;

    PawnOwner = TgPawn(Instigator);
    // End:0x5C
    if(PawnOwner != none)
    {
        OwnerPC = TgPlayerController(PawnOwner.Controller);
    }
    // End:0xE8
    if(OwnerPC != none)
    {
        OwnerPC.m_nDevicesLockingCamera += ((bShouldLock) ? 1 : -1);
        OwnerPC.m_nDevicesLockingCamera = int(FMax(float(OwnerPC.m_nDevicesLockingCamera), 0.0000000));
    }
    //return;    
}

simulated function LockRotation(bool bShouldLock)
{
    local TgPawn PawnOwner;
    local TgPlayerController OwnerPC;

    PawnOwner = TgPawn(Instigator);
    // End:0x5C
    if(PawnOwner != none)
    {
        OwnerPC = TgPlayerController(PawnOwner.Controller);
    }
    // End:0xE8
    if(OwnerPC != none)
    {
        OwnerPC.m_nDevicesLockingRotation += ((bShouldLock) ? 1 : -1);
        OwnerPC.m_nDevicesLockingRotation = int(FMax(float(OwnerPC.m_nDevicesLockingRotation), 0.0000000));
    }
    //return;    
}

simulated function RefireCheckTimer()
{
    ClearTimer('RefireCheckTimer');
    SendDeviceChangeEvent(6);
    //return;    
}

simulated function FirePreHitDelay()
{
    //return;    
}

simulated function FirePostHitDelay()
{
    CheckAutoReload();
    //return;    
}

simulated function DeviceBuildupTimer()
{
    //return;    
}

simulated function OutroLockoutTime()
{
    //return;    
}

simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
{
    return false;
    //return ReturnValue;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    TgPawn(Instigator).FlashStartFire(r_nDeviceInstanceId, nDeviceModeNum, fRefireTime, Aim.HitActor, GetCurrentAmmoAmount());
    // End:0xCF
    if(c_DeviceForm != none)
    {
        c_DeviceForm.StartFire(nDeviceModeNum, fRefireTime, Aim.HitActor, GetCurrentAmmoAmount());
    }
    //return;    
}

simulated function UpdateIndex()
{
    CalcFireSocketIndexMax();
    // End:0x3D
    if(m_nSocketMax > 0)
    {
        m_nSocketIndex = (m_nSocketIndex % m_nSocketMax) + 1;        
    }
    else
    {
        m_nSocketIndex = 1;
    }
    //return;    
}

simulated event Destroyed()
{
    // End:0x1A
    if(m_CooldownTimers != none)
    {
        m_CooldownTimers = none;
    }
    // End:0x4F
    if(IsTimerActive('GlobalOffhandCooldownCompleteServer'))
    {
        ClearTimer('GlobalOffhandCooldownCompleteServer');
        GlobalOffhandCooldownCompleteServer();
    }
    // End:0x84
    if(IsTimerActive('GlobalOffhandCooldownCompleteClient'))
    {
        ClearTimer('GlobalOffhandCooldownCompleteClient');
        GlobalOffhandCooldownCompleteClient();
    }
    super(Inventory).Destroyed();
    //return;    
}

simulated event bool ApplyGlobalOffhandCooldown()
{
    return (!IsToggleDevice() && !m_bHandDevice) && (((int(r_eEquippedAt) == int(2)) || int(r_eEquippedAt) == int(3)) || int(r_eEquippedAt) == int(4)) || int(r_eEquippedAt) == int(5);
    //return ReturnValue;    
}

simulated event bool IsToggleDevice()
{
    return false;
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    return IsToggleDevice();
    //return ReturnValue;    
}

simulated function AdjustForNewDilation(float fPrevDilation, float fNewDilation)
{
    local float fNextTimeAccountedFor, fTotalTime;

    // End:0x1C7
    if((IsFiring()) && m_bShouldUseInstigatorsTimeDilation)
    {
        // End:0x72
        if(IsTimerActive('FirePreHitDelay'))
        {
            fNextTimeAccountedFor = GetTimerCount('FirePreHitDelay');
            fTotalTime = GetTimerRate('FirePreHitDelay');            
        }
        else
        {
            // End:0xC8
            if(IsTimerActive('FirePostHitDelay'))
            {
                fNextTimeAccountedFor = GetTimerCount('FirePostHitDelay');
                fTotalTime = GetTimerRate('FirePostHitDelay');                
            }
            else
            {
                // End:0x11B
                if(IsTimerActive('PersistTimer'))
                {
                    fNextTimeAccountedFor = GetTimerCount('PersistTimer');
                    fTotalTime = GetTimerRate('PersistTimer');
                }
            }
        }
        // End:0x1C7
        if((fNextTimeAccountedFor > 0.0000000) && fTotalTime > 0.0000000)
        {
            m_fFiringTimer = WorldInfo.TimeSeconds + ((fTotalTime - fNextTimeAccountedFor) / fNewDilation);
            m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
            m_fTimeAccountedFor = fNextTimeAccountedFor;
        }
    }
    //return;    
}

event ClientReconnected()
{
    // End:0x0D
    if(IsFiring())
    {
    }
    // End:0x39
    if(IsDeviceCoolingDown())
    {
        ClientResetCooldown(int(CurrentFireMode), GetCooldownRemaining());
    }
    ResetAmmoTransactions();
    //return;    
}

simulated function StopFiringLogic()
{
    //return;    
}

simulated function bool IsUnEquipping()
{
    return false;
    //return ReturnValue;    
}

simulated function bool TryPutDown()
{
    UnequipWeapon();
    return true;
    //return ReturnValue;    
}

simulated function UnequipWeapon()
{
    GotoState('WeaponUnequipping');
    //return;    
}

simulated function CancelUnequip()
{
    //return;    
}

simulated function bool AllowSwitchTo(Weapon NewWeapon)
{
    return true;
    //return ReturnValue;    
}

simulated function Activate()
{
    TgPawn(Instigator).SetActiveWeapon(self);
    //return;    
}

simulated function AltUse(bool bEnable)
{
    local TgPawn_Character TgP;

    // End:0x11
    if(!m_bAltFireEnabled)
    {
        return;
    }
    TgP = TgPawn_Character(Instigator);
    // End:0x54
    if((int(m_AltFireType) == int(0)) || TgP == none)
    {
        return;
    }
    // End:0x7C
    if(int(Role) < int(ROLE_Authority))
    {
        ServerAltUse(bEnable);
    }
    // End:0x97
    if(m_bIsAltFiring == bEnable)
    {
        return;
    }
    m_bIsAltFiring = bEnable;
    switch(m_AltFireType)
    {
        // End:0xF2
        case 1:
            SetAltFireSecondModeNow(bEnable);
            // End:0xEF
            if(bEnable)
            {
                Use();
            }
            // End:0xF5
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

reliable server function ServerAltUse(bool bEnable)
{
    AltUse(bEnable);
    //return;    
}

simulated event SetAltFireSecondModeNow(bool bEnable)
{
    c_bAltFireSecondModeNow = bEnable;
    CurrentFireMode = ((bEnable) ? 1 : 0);
    ServerSetAltFireSecondModeNow(bEnable);
    //return;    
}

reliable server function ServerSetAltFireSecondModeNow(bool bEnable)
{
    CurrentFireMode = ((bEnable) ? 1 : 0);
    //return;    
}

simulated event bool UsesSimulatedAmmo()
{
    return (CanAllowLagCompensation()) && m_bHandDevice;
    //return ReturnValue;    
}

simulated function VerifyAmmoTransaction(int nTransactionID, int nAmmoChanged, bool bFilledClip)
{
    local AmmoTransaction transaction;
    local int I;

    // End:0x15
    if(nTransactionID == -1)
    {
        return;
    }
    // End:0x314
    if((((int(Role) < int(ROLE_Authority)) && Instigator != none) && Instigator.IsLocallyControlled()) || (int(Role) == int(ROLE_Authority)) && HasRemoteOwner())
    {
        // End:0x21F
        if(int(Role) == int(ROLE_Authority))
        {
            I = 0;
            J0xA2:

            // End:0x21F [Loop If]
            if(I < s_RecievedUnverifiedDelayedAmmoTransactions.Length)
            {
                // End:0x211
                if(s_RecievedUnverifiedDelayedAmmoTransactions[I].TransactionId == nTransactionID)
                {
                    // End:0x1A8
                    if((WorldInfo.TimeSeconds - s_RecievedUnverifiedDelayedAmmoTransactions[I].TransactionTimestamp) > float(1))
                    {
                        LogWarnDelayedAmmoTransactionOnClient(nTransactionID, nAmmoChanged, WorldInfo.TimeSeconds - s_RecievedUnverifiedDelayedAmmoTransactions[I].TransactionTimestamp, true, m_UniqueAmmoValidationId);
                    }
                    ClientValidateAmmoResponse(nTransactionID, ((bFilledClip) ? s_RecievedUnverifiedDelayedAmmoTransactions[I].AmmoAmountChanged : nAmmoChanged));
                    s_RecievedUnverifiedDelayedAmmoTransactions.Remove(I, 1);
                    return;
                }
                I++;
                // [Loop Continue]
                goto J0xA2;
            }
        }
        transaction.TransactionTimestamp = WorldInfo.TimeSeconds;
        transaction.TransactionId = nTransactionID;
        transaction.AmmoAmountChanged = nAmmoChanged;
        transaction.FilledClip = bFilledClip;
        m_AmmoTransactions.AddItem(transaction);
        // End:0x314
        if(int(Role) < int(ROLE_Authority))
        {
            ServerValidateAmmoTransaction(nTransactionID, nAmmoChanged);
        }
    }
    //return;    
}

reliable server function ServerValidateAmmoTransaction(int nTransactionID, int nAmmoChanged)
{
    local AmmoTransaction transaction;
    local int I;

    I = 0;
    J0x0B:

    // End:0x1C2 [Loop If]
    if(I < m_AmmoTransactions.Length)
    {
        // End:0x1B4
        if(m_AmmoTransactions[I].TransactionId == nTransactionID)
        {
            // End:0x12E
            if((WorldInfo.TimeSeconds - m_AmmoTransactions[I].TransactionTimestamp) > float(1))
            {
                LogWarnDelayedAmmoTransactionOnClient(nTransactionID, m_AmmoTransactions[I].AmmoAmountChanged, WorldInfo.TimeSeconds - m_AmmoTransactions[I].TransactionTimestamp, false, m_UniqueAmmoValidationId);
            }
            ClientValidateAmmoResponse(nTransactionID, ((m_AmmoTransactions[I].FilledClip) ? nAmmoChanged : m_AmmoTransactions[I].AmmoAmountChanged));
            m_AmmoTransactions.Remove(I, 1);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x1CD:

    // End:0x2C6 [Loop If]
    if(I < m_DelayedAmmoTransactions.Length)
    {
        // End:0x2B8
        if(m_DelayedAmmoTransactions[I].TransactionId == nTransactionID)
        {
            transaction.TransactionId = nTransactionID;
            transaction.AmmoAmountChanged = nAmmoChanged;
            transaction.TransactionTimestamp = WorldInfo.TimeSeconds;
            s_RecievedUnverifiedDelayedAmmoTransactions.AddItem(transaction);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x1CD;
    }
    logr((("SIMAMMO TRANSACTION DESYNC: No corresponding server ammo transaction was found for Transaction ID " @ string(nTransactionID)) @ " for device ") @ (GetDeviceName()));
    // End:0x3EF
    if(nTransactionID > m_UniqueAmmoValidationId)
    {
        logr((("SIMAMMO TRANSACTION DESYNC: Client, " @ string(nTransactionID)) @ ", is ahead of the server, ") @ string(m_UniqueAmmoValidationId));
        m_UniqueAmmoValidationId = nTransactionID;
    }
    ClientValidateAmmoResponse(nTransactionID, 0, true);
    //return;    
}

reliable client simulated function LogWarnDelayedAmmoTransactionOnClient(int nTransactionID, int nAmmoAmountChanged, float fTimeDelayed, bool bLateServer, int nServerCurrentTransactionID)
{
    logr((((((((("SIMAMMO TRANSACTION DESYNC: Possible server desync " @ string(nTransactionID)) @ " for device ") @ (GetDeviceName())) @ " Ammo Modified: ") @ string(nAmmoAmountChanged)) @ " Seconds Delayed: ") @ string(fTimeDelayed)) @ " Is Server Late: ") @ string(bLateServer));
    // End:0x161
    if(nServerCurrentTransactionID > m_UniqueAmmoValidationId)
    {
        logr((("SIMAMMO TRANSACTION DESYNC: Server, " @ string(nServerCurrentTransactionID)) @ ", is ahead of the client, ") @ string(m_UniqueAmmoValidationId));
        m_UniqueAmmoValidationId = nServerCurrentTransactionID;
    }
    //return;    
}

reliable client simulated function ClientValidateAmmoResponse(int nTransactionID, int nAmmoChanged, optional bool bFubar = false)
{
    local int I;

    I = 0;
    J0x10:

    // End:0x1BE [Loop If]
    if(I < m_AmmoTransactions.Length)
    {
        // End:0x1B0
        if(m_AmmoTransactions[I].TransactionId == nTransactionID)
        {
            // End:0x147
            if(bFubar)
            {
                logr((((((("SIMAMMO TRANSACTION DESYNC: No Server transaction was found for Transaction ID " @ string(nTransactionID)) @ " for device ") @ (GetDeviceName())) @ ". ServerAmmo: ") @ string(nAmmoChanged)) @ " ClientAmmo: ") @ string(m_AmmoTransactions[I].AmmoAmountChanged));
            }
            UpdateLocalAmmoCount(Clamp(c_nSimLocalAmmoClipCount + (nAmmoChanged - m_AmmoTransactions[I].AmmoAmountChanged), 0, r_nMaxAmmoClipCount));
            m_AmmoTransactions.Remove(I, 1);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x10;
    }
    // End:0x2A9
    if(bFubar)
    {
        logr((((((("SIMAMMO TRANSACTION DESYNC: No Server transaction was found for Transaction ID " @ string(nTransactionID)) @ " for device ") @ (GetDeviceName())) @ ". ServerAmmo: ") @ string(nAmmoChanged)) @ " ClientAmmo: ") @ string(m_AmmoTransactions[I].AmmoAmountChanged));
    }
    logr((("SIMAMMO TRANSACTION DESYNC: No corresponding client ammo transaction was found for Transaction ID " @ string(nTransactionID)) @ " for device ") @ (GetDeviceName()));
    UpdateLocalAmmoCount(Clamp(c_nSimLocalAmmoClipCount + nAmmoChanged, 0, r_nMaxAmmoClipCount));
    //return;    
}

simulated event int SetAmmoDelayedWithValidation(int AmmoCount, float DelayAmt)
{
    local AmmoTransaction transaction;

    transaction.TransactionTimestamp = WorldInfo.TimeSeconds + DelayAmt;
    transaction.TransactionId = GenerateUniqueAmmoValidationId();
    transaction.AmmoAmountChanged = AmmoCount - (GetCurrentAmmoAmount());
    m_DelayedAmmoTransactions.AddItem(transaction);
    return transaction.TransactionId;
    //return ReturnValue;    
}

simulated event bool CancelSetAmmoDelayed(int nTransactionID)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x8F [Loop If]
    if(I < m_DelayedAmmoTransactions.Length)
    {
        // End:0x81
        if(m_DelayedAmmoTransactions[I].TransactionId == nTransactionID)
        {
            m_DelayedAmmoTransactions[I].AmmoAmountChanged = 0;
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool SendImmediateSetAmmoDelayed(int nTransactionID)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xE4 [Loop If]
    if(I < m_DelayedAmmoTransactions.Length)
    {
        // End:0xD6
        if(m_DelayedAmmoTransactions[I].TransactionId == nTransactionID)
        {
            SetAmmo((GetCurrentAmmoAmount()) + m_DelayedAmmoTransactions[I].AmmoAmountChanged, -1, true, m_DelayedAmmoTransactions[I].TransactionId);
            m_DelayedAmmoTransactions.Remove(I, 1);
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ValidateDelayedAmmoTransactionRegen(int nTransactionID, optional bool bInitiateNewTransactionForRegen = false)
{
    local int I;

    // End:0x141
    if(((Instigator != none) && Instigator.IsLocallyControlled()) && UsesSimulatedAmmo())
    {
        I = 0;
        J0x52:

        // End:0x141 [Loop If]
        if(I < m_DelayedAmmoTransactionRegen.Length)
        {
            // End:0x133
            if((m_DelayedAmmoTransactionRegen[I].TransactionId == nTransactionID) && m_DelayedAmmoTransactionRegen[I].AmmoAmountChanged != 0)
            {
                ServerValidateDelayedRegenAmmoTransaction(nTransactionID, m_DelayedAmmoTransactionRegen[I].AmmoAmountChanged, bInitiateNewTransactionForRegen);
                // End:0x131
                if(bInitiateNewTransactionForRegen)
                {
                    m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
                }
                return true;
            }
            I++;
            // [Loop Continue]
            goto J0x52;
        }
    }
    return false;
    //return ReturnValue;    
}

reliable server function ServerValidateDelayedRegenAmmoTransaction(int nTransactionID, int nAmmoChanged, bool bInitiateNewTransactionForRegen)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x10C [Loop If]
    if(I < m_DelayedAmmoTransactionRegen.Length)
    {
        // End:0xFE
        if(m_DelayedAmmoTransactionRegen[I].TransactionId == nTransactionID)
        {
            ClientValidateDelayedRegenAmmoResponse(nTransactionID, ((m_DelayedAmmoTransactionRegen[I].FilledClip) ? nAmmoChanged : m_DelayedAmmoTransactionRegen[I].AmmoAmountChanged));
            m_DelayedAmmoTransactionRegen.Remove(I, 1);
            // End:0xFC
            if(bInitiateNewTransactionForRegen)
            {
                m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
            }
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    // End:0x12E
    if(bInitiateNewTransactionForRegen)
    {
        m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
    }
    I = 0;
    J0x139:

    // End:0x1B3 [Loop If]
    if(I < m_DelayedAmmoTransactionRegen.Length)
    {
        // End:0x1A5
        if(m_DelayedAmmoTransactionRegen[I].TransactionId < nTransactionID)
        {
            m_DelayedAmmoTransactionRegen.Remove(I, 1);
            I--;
        }
        I++;
        // [Loop Continue]
        goto J0x139;
    }
    ClientValidateDelayedRegenAmmoResponse(nTransactionID, 0);
    //return;    
}

reliable client simulated function ClientValidateDelayedRegenAmmoResponse(int nTransactionID, int nAmmoChanged)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xCE [Loop If]
    if(I < m_DelayedAmmoTransactionRegen.Length)
    {
        // End:0xC0
        if(m_DelayedAmmoTransactionRegen[I].TransactionId == nTransactionID)
        {
            UpdateLocalAmmoCount(Clamp(c_nSimLocalAmmoClipCount + (nAmmoChanged - m_DelayedAmmoTransactionRegen[I].AmmoAmountChanged), 0, r_nMaxAmmoClipCount));
            m_DelayedAmmoTransactionRegen.Remove(I, 1);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    UpdateLocalAmmoCount(Clamp(c_nSimLocalAmmoClipCount + nAmmoChanged, 0, r_nMaxAmmoClipCount));
    //return;    
}

simulated event int GiveAmmoDelayedWithValidationRegen(int nAmmoCountAdded)
{
    local AmmoTransaction transaction;

    transaction.TransactionTimestamp = WorldInfo.TimeSeconds;
    transaction.TransactionId = GenerateUniqueAmmoValidationId();
    transaction.AmmoAmountChanged = nAmmoCountAdded;
    m_DelayedAmmoTransactionRegen.AddItem(transaction);
    return transaction.TransactionId;
    //return ReturnValue;    
}

simulated event bool UpdateDelayedAmmoTransactionRegen(int nTransactionID, int nAmmoCountAdded)
{
    local int I;

    GiveAmmo(nAmmoCountAdded, false);
    I = 0;
    J0x1F:

    // End:0xED [Loop If]
    if(I < m_DelayedAmmoTransactionRegen.Length)
    {
        // End:0xDF
        if(m_DelayedAmmoTransactionRegen[I].TransactionId == nTransactionID)
        {
            m_DelayedAmmoTransactionRegen[I].AmmoAmountChanged += nAmmoCountAdded;
            // End:0xDD
            if((GetCurrentAmmoAmount()) >= r_nMaxAmmoClipCount)
            {
                m_DelayedAmmoTransactionRegen[I].FilledClip = true;
            }
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x1F;
    }
    return false;
    //return ReturnValue;    
}

simulated event SetAmmo(int AmmoCount, optional int ClipSize = -1, optional bool bShouldValidate = false, optional int ValidationIDOverride = 0)
{
    // End:0x41
    if(ClipSize >= 0)
    {
        r_nMaxAmmoClipCount = ClipSize;
        bNetDirty = true;
    }
    AmmoCount = Clamp(AmmoCount, 0, r_nMaxAmmoClipCount);
    // End:0xD3
    if((UsesSimulatedAmmo()) && bShouldValidate)
    {
        VerifyAmmoTransaction(((ValidationIDOverride == 0) ? GenerateUniqueAmmoValidationId() : ValidationIDOverride), AmmoCount - (GetCurrentAmmoAmount()), AmmoCount == r_nMaxAmmoClipCount);
    }
    // End:0x152
    if(((UsesSimulatedAmmo()) && int(Role) < int(ROLE_Authority)) && ((Instigator != none) && Instigator.IsLocallyControlled()) || Instigator == none)
    {
        UpdateLocalAmmoCount(AmmoCount);        
    }
    else
    {
        r_nAmmoClipCount = AmmoCount;
        ReplicatePlayerDeviceAmmo();
    }
    //return;    
}

simulated function UpdateLocalAmmoCount(int nNewAmmoAmt)
{
    local TgPlayerController TgPC;

    // End:0xB0
    if(c_nSimLocalAmmoClipCount != nNewAmmoAmt)
    {
        c_nSimLocalAmmoClipCount = nNewAmmoAmt;
        // End:0xB0
        if(int(r_eEquippedAt) == int(1))
        {
            TgPC = TgPlayerController(Instigator.Controller);
            // End:0xB0
            if(TgPC != none)
            {
                TgPC.NotifyUpdatedInhandAmmoCount(c_nSimLocalAmmoClipCount, self, r_nDeviceId);
            }
        }
    }
    //return;    
}

simulated event ConsumeAmmo(optional int Amount = 1, optional bool bShouldValidate = false)
{
    // End:0x64
    if(((!bShouldValidate && !HasAmmo()) || !RequiresAmmoToFire()) || !UsesSimulatedAmmo() && int(Role) < int(ROLE_Authority))
    {
        return;
    }
    SetAmmo((GetCurrentAmmoAmount()) - Amount,, bShouldValidate);
    //return;    
}

simulated event GiveAmmo(optional int Amount = 1, optional bool bShouldValidate = false)
{
    // End:0x1B
    if(!RequiresAmmoToFire())
    {
        return;
    }
    SetAmmo((GetCurrentAmmoAmount()) + Amount,, bShouldValidate);
    //return;    
}

event GiveAmmoWithClientSync(optional int Amount = 1)
{
    SetAmmo((GetCurrentAmmoAmount()) + Amount);
    // End:0x72
    if((UsesSimulatedAmmo()) && int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ClientSyncAmmoGivenFromServer(Amount);
    }
    // End:0x8E
    if(m_bFirstAmmoWasGiven)
    {
        m_bAmmoWasGiven = true;        
    }
    else
    {
        m_bFirstAmmoWasGiven = true;
    }
    //return;    
}

reliable client simulated function ClientSyncAmmoGivenFromServer(int Amount)
{
    // End:0x2F
    if(UsesSimulatedAmmo())
    {
        SetAmmo((GetCurrentAmmoAmount()) + Amount);
    }
    //return;    
}

simulated event ReloadAmmo(optional bool bToFull, optional bool bShouldValidate = false)
{
    // End:0x2D
    if(!UsesSimulatedAmmo() && int(Role) < int(ROLE_Authority))
    {
        return;
    }
    // End:0x5C
    if(bToFull)
    {
        SetAmmo(r_nMaxAmmoClipCount,, bShouldValidate);        
    }
    else
    {
        SetAmmo(r_nAmmoClipCount + 1,, bShouldValidate);
    }
    FlashUpdateAmmoOnPawn();
    //return;    
}

simulated function ReloadAmmoWithSynchronization()
{
    ReloadAmmo(true);
    // End:0x44
    if(!UsesSimulatedAmmo() || (int(Role) == int(ROLE_Authority)) && !HasRemoteOwner())
    {
        return;
    }
    // End:0xF6
    if(((int(Role) < int(ROLE_Authority)) && Instigator != none) && Instigator.IsLocallyControlled())
    {
        ServerSyncAmmoTransactionID(m_UniqueAmmoValidationId);
        m_DelayedAmmoTransactions.Length = 0;
        m_DelayedAmmoTransactionRegen.Length = 0;
        m_AmmoTransactions.Length = 0;
        s_RecievedUnverifiedDelayedAmmoTransactions.Length = 0;
        // End:0xF6
        if(m_fAmmoRegenPerSec >= float(0))
        {
            m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
        }
    }
    //return;    
}

reliable server function ServerSyncAmmoTransactionID(int nNewID)
{
    m_UniqueAmmoValidationId = nNewID;
    m_DelayedAmmoTransactions.Length = 0;
    m_DelayedAmmoTransactionRegen.Length = 0;
    m_AmmoTransactions.Length = 0;
    s_RecievedUnverifiedDelayedAmmoTransactions.Length = 0;
    // End:0x76
    if(UsesSimulatedAmmo())
    {
        // End:0x76
        if(m_fAmmoRegenPerSec >= float(0))
        {
            m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
        }
    }
    //return;    
}

simulated event ResetAmmoTransactions()
{
    m_UniqueAmmoValidationId = 0;
    m_DelayedAmmoTransactions.Length = 0;
    m_DelayedAmmoTransactionRegen.Length = 0;
    m_AmmoTransactions.Length = 0;
    s_RecievedUnverifiedDelayedAmmoTransactions.Length = 0;
    // End:0x6E
    if(UsesSimulatedAmmo())
    {
        // End:0x6E
        if(m_fAmmoRegenPerSec >= float(0))
        {
            m_nPendingRegenAmmoTransactionID = GiveAmmoDelayedWithValidationRegen(0);
        }
    }
    //return;    
}

event FlashUpdateAmmoOnPawn()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x4A
    if(TgP != none)
    {
        TgP.ForceUpdateAmmoAnim();
    }
    //return;    
}

reliable server function ServerStartReload()
{
    // End:0x55
    if(!StartReload())
    {
        SetAmmo(GetCurrentAmmoAmount(),, true);
        // End:0x55
        if(!IsReloading())
        {
            ClientInterruptReload((GetCurrentAmmoAmount()) >= r_nMaxAmmoClipCount);
        }
    }
    //return;    
}

reliable client simulated function ClientForceReload()
{
    StartReload(true);
    //return;    
}

simulated event bool StartReload(optional bool bIgnoreCurrentAmmo = false)
{
    local TgDeviceFire FireMode;
    local TgPawn TgP;
    local float ReloadScale;

    // End:0x4B
    if(((IsReloading()) || Instigator == none) || !Instigator.IsAliveAndWell())
    {
        return false;
    }
    TgP = TgPawn(Instigator);
    // End:0x92
    if(!bIgnoreCurrentAmmo && (GetCurrentAmmoAmount()) >= r_nMaxAmmoClipCount)
    {
        return false;
    }
    FireMode = GetCurrentFire();
    // End:0xB7
    if(FireMode == none)
    {
        return false;
    }
    ReloadScale = ((TgP != none) ? TgP.GetReloadScale() : 1.0000000);
    m_nPendingReloadAmmoTransactionID = SetAmmoDelayedWithValidation(r_nMaxAmmoClipCount, FireMode.m_fAmmoClipPreReloadTime * ReloadScale);
    // End:0x15A
    if(int(Role) < int(ROLE_Authority))
    {
        ServerStartReload();
    }
    m_fTotalReloadTime = ((FireMode.m_fAmmoClipPreReloadTime + FireMode.m_fAmmoClipPostReloadTime) + ((int(Role) < int(ROLE_Authority)) ? 0.1000000 : 0.0000000)) * ReloadScale;
    // End:0x322
    if(m_fTotalReloadTime > float(0))
    {
        // End:0x275
        if((TgP != none) && TgP.m_WeaponMesh != none)
        {
            TgP.m_WeaponMesh.PlayReload(int(self.r_eEquippedAt), m_fTotalReloadTime, GetCurrentAmmoAmount());
        }
        SetTimer(m_fTotalReloadTime, false, 'FullReloadTimer');
        // End:0x2F9
        if((FireMode.m_fAmmoClipPreReloadTime * ReloadScale) > 0.0000000)
        {
            SetTimer(FireMode.m_fAmmoClipPreReloadTime * ReloadScale, false, 'PreReloadTimer');            
        }
        else
        {
            PreReloadTimer();
        }
        PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStartReload,, ReloadScale);
    }
    // End:0x381
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x381
        if(TgP != none)
        {
            TgP.FlashReload(r_nDeviceInstanceId, m_fTotalReloadTime, GetCurrentAmmoAmount());
        }
    }
    NotifyDeviceEvent(1);
    return true;
    //return ReturnValue;    
}

simulated function FullReloadTimer()
{
    //return;    
}

simulated function PreReloadTimer()
{
    local TgDeviceFire FireMode;
    local TgPawn_Character TgP;
    local float fReloadTimeRemaining;

    FireMode = GetCurrentFire();
    PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStopReload);
    // End:0x104
    if(FireMode != none)
    {
        // End:0x99
        if(int(Role) == int(ROLE_Authority))
        {
            TgP = TgPawn_Character(Instigator);
            // End:0x99
            if(TgP != none)
            {
                TgP.DeviceOnReload(self);
            }
        }
        fReloadTimeRemaining = GetTimerRate('FullReloadTimer') - GetTimerCount('FullReloadTimer');
        // End:0xFA
        if(fReloadTimeRemaining > 0.0000000)
        {
            SetTimer(fReloadTimeRemaining, false, 'PostReloadTimer');            
        }
        else
        {
            PostReloadTimer();
        }
    }
    //return;    
}

simulated function PostReloadTimer()
{
    PlayNextSimulatedForceFeedbackWaveform(m_ForceFeedbackStartReload, none);
    FlashUpdateAmmoOnPawn();
    //return;    
}

simulated event InterruptReload()
{
    // End:0x0D
    if(LogDebugInfo())
    {
    }
    // End:0xC1
    if(IsTimerActive('PreReloadTimer') || IsTimerActive('PostReloadTimer'))
    {
        ClearTimer('PreReloadTimer');
        ClearTimer('PostReloadTimer');
        ClearTimer('FullReloadTimer');
        CancelSetAmmoDelayed(m_nPendingReloadAmmoTransactionID);
        // End:0xC1
        if(int(Role) == int(ROLE_Authority))
        {
            FlashUpdateAmmoOnPawn();
            ClientInterruptReload();
            bNetDirty = true;
        }
    }
    //return;    
}

reliable client simulated function ClientInterruptReload(optional bool bAllowAmmoFill = false)
{
    // End:0x12
    if(LogDebugInfo())
    {
    }
    ClearTimer('PreReloadTimer');
    ClearTimer('PostReloadTimer');
    ClearTimer('FullReloadTimer');
    // End:0x70
    if(!bAllowAmmoFill)
    {
        CancelSetAmmoDelayed(m_nPendingReloadAmmoTransactionID);
    }
    SendImmediateSetAmmoDelayed(m_nPendingReloadAmmoTransactionID);
    //return;    
}

event OnDeployableDestroyed(TgDeployable deployable)
{
    // End:0x3B
    if(deployable == r_Deployable)
    {
        r_Deployable = none;
        // End:0x3B
        if(m_bCooldownAfterDeployDeath)
        {
            StartCooldown();
        }
    }
    //return;    
}

simulated event OnDeployableSpawned(TgDeployable deployable)
{
    //return;    
}

simulated event float GetRefirePercent()
{
    // End:0x5F
    if(GetTimerRate('FirePostHitDelay') > 0.0000000)
    {
        return (GetTimerRate('FirePostHitDelay') - GetTimerCount('FirePostHitDelay')) / GetTimerRate('FirePostHitDelay');
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated event float GetRefireRate()
{
    return GetTimerRate('FirePostHitDelay');
    //return ReturnValue;    
}

simulated event Vector GetProjectileSpawnOffset()
{
    return m_vProjectileSpawnOffset;
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return true;
    //return ReturnValue;    
}

simulated function bool RegisterDelegate(TgDevice.ENotifyDelegateEvents ndeType, delegate<DeviceEvent> DeviceEventDelegate)
{
    switch(ndeType)
    {
        // End:0x53
        case 0:
            // End:0x50
            if(m_OnFiredDelegates.Find(__DeviceEvent__Delegate) == -1)
            {
                m_OnFiredDelegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0x93
        case 1:
            // End:0x90
            if(m_OnReloadDelegates.Find(DeviceEventDelegate) == -1)
            {
                m_OnReloadDelegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0xD3
        case 2:
            // End:0xD0
            if(m_OnStartFireDelegates.Find(DeviceEventDelegate) == -1)
            {
                m_OnStartFireDelegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0x113
        case 3:
            // End:0x110
            if(m_OnStopFireDelegates.Find(DeviceEventDelegate) == -1)
            {
                m_OnStopFireDelegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0x153
        case 4:
            // End:0x150
            if(m_Generic1Delegates.Find(DeviceEventDelegate) == -1)
            {
                m_Generic1Delegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0x193
        case 5:
            // End:0x190
            if(m_Generic2Delegates.Find(DeviceEventDelegate) == -1)
            {
                m_Generic2Delegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0x1D3
        case 6:
            // End:0x1D0
            if(m_Generic3Delegates.Find(DeviceEventDelegate) == -1)
            {
                m_Generic3Delegates.AddItem(DeviceEventDelegate);
                return true;
            }
            // End:0x1D6
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool UnregisterDelegate(TgDevice.ENotifyDelegateEvents ndeType, delegate<DeviceEvent> DeviceEventDelegate)
{
    local int FoundIndex;

    switch(ndeType)
    {
        // End:0x65
        case 0:
            FoundIndex = m_OnFiredDelegates.Find(DeviceEventDelegate);
            // End:0x62
            if(FoundIndex != -1)
            {
                m_OnFiredDelegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0xB7
        case 1:
            FoundIndex = m_OnReloadDelegates.Find(DeviceEventDelegate);
            // End:0xB4
            if(FoundIndex != -1)
            {
                m_OnReloadDelegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0x109
        case 2:
            FoundIndex = m_OnStartFireDelegates.Find(DeviceEventDelegate);
            // End:0x106
            if(FoundIndex != -1)
            {
                m_OnStartFireDelegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0x15B
        case 3:
            FoundIndex = m_OnStopFireDelegates.Find(DeviceEventDelegate);
            // End:0x158
            if(FoundIndex != -1)
            {
                m_OnStopFireDelegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0x1AD
        case 4:
            FoundIndex = m_Generic1Delegates.Find(DeviceEventDelegate);
            // End:0x1AA
            if(FoundIndex != -1)
            {
                m_Generic1Delegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0x1FF
        case 5:
            FoundIndex = m_Generic2Delegates.Find(DeviceEventDelegate);
            // End:0x1FC
            if(FoundIndex != -1)
            {
                m_Generic2Delegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0x251
        case 6:
            FoundIndex = m_Generic3Delegates.Find(DeviceEventDelegate);
            // End:0x24E
            if(FoundIndex != -1)
            {
                m_Generic3Delegates.Remove(FoundIndex, 1);
                return true;
            }
            // End:0x254
            break;
        // End:0xFFFF
        default:
            break;
    }
    return false;
    //return ReturnValue;    
}

simulated function NotifyDeviceEvent(TgDevice.ENotifyDelegateEvents ndeType)
{
    local delegate<DeviceEvent> onEventDelegate;

    switch(ndeType)
    {
        // End:0x47
        case 0:
            // End:0x43
            foreach m_OnFiredDelegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0x7B
        case 1:
            // End:0x77
            foreach m_OnReloadDelegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0xAF
        case 2:
            // End:0xAB
            foreach m_OnStartFireDelegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0xE3
        case 3:
            // End:0xDF
            foreach m_OnStopFireDelegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0x117
        case 4:
            // End:0x113
            foreach m_Generic1Delegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0x14B
        case 5:
            // End:0x147
            foreach m_Generic2Delegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0x17F
        case 6:
            // End:0x17B
            foreach m_Generic3Delegates(onEventDelegate)
            {
                DeviceEvent();                
            }            
            // End:0x182
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    //return;    
}

event OnLinkDevice(TgPawn TgP)
{
    //return;    
}

event OnUnlinkDevice(TgPawn TgP)
{
    //return;    
}

reliable client simulated event ClientDeviceFirePropertyChange(int nMode, int nPropertyId, float fNewValue)
{
    local TgDeviceFire FireMode;

    // End:0x2B
    if((nMode < 0) || nMode >= m_FireMode.Length)
    {
        return;
    }
    FireMode = m_FireMode[nMode];
    // End:0x59
    if(FireMode == none)
    {
        return;
    }
    FireMode.SetProperty(nPropertyId, fNewValue);
    //return;    
}

function OnCripple()
{
    // End:0x24
    if(CanBeCrippled())
    {
        // End:0x24
        if(CanBeInterrupted())
        {
            InterruptFiring();
        }
    }
    //return;    
}

function OnKnock()
{
    //return;    
}

reliable server event OnCanceled()
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x5A
    if((TgP != none) && m_bCancelingShouldInterruptStealth)
    {
        TgP.InterruptStealth(self);
    }
    //return;    
}

simulated function OnCanceledClient()
{
    //return;    
}

simulated event bool PlayHitReactionOverride()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldStopActionOnOffhandSlotReleased()
{
    return int(r_eEquippedAt) == int(16);
    //return ReturnValue;    
}

simulated exec function DesyncAmmoTransactionID(optional int Amt = 1)
{
    m_UniqueAmmoValidationId += Amt;
    //return;    
}

reliable client simulated function ClientSetAimAssistValues(float MagnetScaleX, float MagnetScaleY, float FrictionScaleX, float FrictionScaleY, float TrackingScaleX, float TrackingScaleY)
{
    local TgDevice TgDevice;

    // End:0x17C
    foreach AllActors(Class'TgGame.TgDevice', TgDevice)
    {
        TgDevice.m_AimAssistMagnetScale.X = MagnetScaleX;
        TgDevice.m_AimAssistMagnetScale.Y = MagnetScaleY;
        TgDevice.m_AimAssistFrictionScale.X = FrictionScaleX;
        TgDevice.m_AimAssistFrictionScale.Y = FrictionScaleY;
        TgDevice.m_AimAssistTrackingScale.X = TrackingScaleX;
        TgDevice.m_AimAssistTrackingScale.Y = TrackingScaleY;        
    }    
    DisplayMessage(((((("ClientSetAimAssistValues" @ string(MagnetScaleX)) @ string(MagnetScaleY)) @ string(FrictionScaleX)) @ string(FrictionScaleY)) @ string(TrackingScaleX)) @ string(TrackingScaleY));
    //return;    
}

reliable client simulated function ClientSetAimVectorAssistValues(float BoundsScaleX, float BoundsScaleY, float MaxAngleX, float MaxAngleY)
{
    local TgDevice TgDevice;

    // End:0x106
    foreach AllActors(Class'TgGame.TgDevice', TgDevice)
    {
        TgDevice.m_AimVectorAssistMaxBoundsScale.X = BoundsScaleX;
        TgDevice.m_AimVectorAssistMaxBoundsScale.Y = BoundsScaleY;
        TgDevice.m_AimVectorAssistMaxAssistanceDegrees.X = MaxAngleX;
        TgDevice.m_AimVectorAssistMaxAssistanceDegrees.Y = MaxAngleY;        
    }    
    DisplayMessage(((("ClientSetAimVectorAssistValues" @ string(BoundsScaleX)) @ string(BoundsScaleY)) @ string(MaxAngleX)) @ string(MaxAngleY));
    //return;    
}

simulated function bool CanToggleTargetingOff()
{
    return m_bCanToggleTargeting;
    //return ReturnValue;    
}

simulated function bool ReleaseHoldOnRightMouseReleased()
{
    return true;
    //return ReturnValue;    
}

simulated function OnOwnerRespawn()
{
    // End:0x17
    if(m_bHandDevice)
    {
        ReloadAmmoWithSynchronization();
    }
    // End:0x36
    if(int(Role) == int(ROLE_Authority))
    {
        r_nProjectiles = 0;
    }
    //return;    
}

simulated event PlayNextSimulatedForceFeedbackWaveform(ForceFeedbackWaveform Prev, ForceFeedbackWaveform Next, optional float fScaleMagnitude = 1.0000000, optional float fScaleDuration = 1.0000000, optional bool bFromPawnPosition)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(Instigator.Controller);
    // End:0xED
    if(TgPC != none)
    {
        // End:0x8A
        if(Prev != none)
        {
            TgPC.StopForceFeedbackWaveform(Prev);
        }
        // End:0xED
        if(Next != none)
        {
            TgPC.PlayForceFeedbackWaveform(Next, ((bFromPawnPosition) ? Instigator : none), fScaleMagnitude, fScaleDuration);
        }
    }
    //return;    
}

simulated function int GetAimAssistPriority()
{
    // End:0x19
    if(int(r_eEquippedAt) == int(1))
    {
        return 1;        
    }
    else
    {
        // End:0x30
        if(NativeIsFiring())
        {
            return m_nAimAssistPriorityWhileFiring;
        }
    }
    return 0;
    //return ReturnValue;    
}

simulated function bool RequireLookForAimAssist()
{
    return true;
    //return ReturnValue;    
}

simulated function bool RequireMovementForAimAssist()
{
    return true;
    //return ReturnValue;    
}

simulated function UpdateOutroLockoutTime()
{
    //return;    
}

simulated event RegisterAsGameplayCurveOverrideDevice(TgDevice Dev)
{
    m_GameplayCurveOverrideDevices.AddItem(Dev);
    //return;    
}

simulated event UnregisterAsGameplayCurveOverrideDevice(TgDevice Dev)
{
    m_GameplayCurveOverrideDevices.RemoveItem(Dev);
    //return;    
}

simulated event ApplyAllowUseWhileFlags(int nAllowUseWhileFlags)
{
    local TgDeviceFire pFire;

    pFire = GetCurrentFire();
    // End:0x4B
    if(pFire != none)
    {
        pFire.m_nAllowUseWhileFlags = nAllowUseWhileFlags;
    }
    //return;    
}

simulated function float GetIndividualOffhandCooldownTime()
{
    local float fMinTime;
    local TgPawn PawnOwner;

    // End:0x33
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        return m_IndividualOffhandCooldownTime;
    }
    PawnOwner = TgPawn(Owner);
    // End:0x8E
    if(PawnOwner != none)
    {
        fMinTime = PawnOwner.GetUnclampedLagPredictionTime() + 0.1000000;
    }
    // End:0xB2
    if(m_IndividualOffhandCooldownTime < fMinTime)
    {
        return fMinTime;        
    }
    else
    {
        return m_IndividualOffhandCooldownTime;
    }
    //return ReturnValue;    
}

simulated event float GetCustomTimerBarCurrentTime()
{
    return 0.0000000;
    //return ReturnValue;    
}

simulated event float GetCustomTimerBarMaxTime()
{
    return 0.0000000;
    //return ReturnValue;    
}

auto simulated state Active
{    stop;    
}

simulated state DeviceBuildup
{
    simulated function DeviceBuildupTimer()
    {
        GotoState('DeviceFiring');
        //return;        
    }

    simulated event bool IsFiring()
    {
        return true;
        //return ReturnValue;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        local float fBuildupTime;
        local TgPawn PawnOwner;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        PawnOwner = TgPawn(Owner);
        // End:0x1DC
        if(PawnOwner != none)
        {
            // End:0xCB
            if((((PawnOwner != none) && int(PawnOwner.r_eIsStealthed) != int(0)) && int(PawnOwner.r_eIsStealthed) != int(4)) && ShouldCancelStealth())
            {
                PawnOwner.RemoveStealthEffects();
            }
            // End:0x16D
            if(((PawnOwner != none) && PawnOwner.r_EffectManager != none) && PawnOwner.r_EffectManager.IsSpawnGuarded())
            {
                PawnOwner.r_EffectManager.RemoveSpawnGuard();
            }
            // End:0x199
            if(ShouldInterruptInhand())
            {
                PawnOwner.InterruptInhand();
            }
            PawnOwner.DeviceOnStartBuildup(self);
            SendCombatLogEvent(1);
            PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStartBuildup);
        }
        // End:0x1F4
        if(m_bLockInputDuringFire)
        {
            LockInput(true);
        }
        // End:0x20C
        if(m_bLockCameraDuringFire)
        {
            LockCamera(true);
        }
        fBuildupTime = GetBuildupTime();
        // End:0x39E
        if(fBuildupTime > 0.0000000)
        {
            TgPawn(Instigator).FlashBuildUp(r_nDeviceInstanceId, int(CurrentFireMode), int(r_eEquippedAt), m_nSocketIndex, fBuildupTime);
            // End:0x2E2
            if(c_DeviceForm != none)
            {
                c_DeviceForm.BuildUp(int(CurrentFireMode), int(r_eEquippedAt), m_nSocketIndex, fBuildupTime);
            }
            // End:0x33A
            if(int(Role) == int(ROLE_Authority))
            {
                GetCurrentFire().ApplyEffectType(Instigator, 262);
                s_WhileFiringDeviceMode = GetCurrentFire();
            }
            m_fFiringTimer = WorldInfo.TimeSeconds + (fBuildupTime / CustomTimeDilation);
            SetTimer(fBuildupTime, false, 'DeviceBuildupTimer');
            SendDeviceChangeEvent(8);            
        }
        else
        {
            GotoState('DeviceFiring');
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn PawnOwner;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        PawnOwner = TgPawn(Owner);
        // End:0x41
        if(m_bLockInputDuringFire)
        {
            LockInput(false);
        }
        // End:0x59
        if(m_bLockCameraDuringFire)
        {
            LockCamera(false);
        }
        // End:0xB8
        if((int(Role) == int(ROLE_Authority)) && s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 262);
            s_WhileFiringDeviceMode = none;
        }
        // End:0x225
        if(NextStateName != 'DeviceFiring')
        {
            TgPawn(Instigator).FlashStopFire(r_nDeviceInstanceId, int(CurrentFireMode));
            // End:0x144
            if(c_DeviceForm != none)
            {
                c_DeviceForm.StopFire(int(CurrentFireMode));
            }
            NotifyDeviceEvent(3);
            TgPawn(Instigator).FlashCooldownDone(r_nDeviceInstanceId, 0);
            // End:0x1C6
            if((int(Role) == int(ROLE_Authority)) && c_DeviceForm != none)
            {
                c_DeviceForm.CooldownComplete();
            }
            PawnOwner.DeviceOnStopBuildup(self, true);
            SendCombatLogEvent(3);
            // End:0x222
            if(m_IsPendingSetFireMode)
            {
                SetFireMode(int(m_PendingFireMode), true);
                m_IsPendingSetFireMode = false;
            }            
        }
        else
        {
            PawnOwner.DeviceOnStopBuildup(self, false);
        }
        PlayNextSimulatedForceFeedbackWaveform(m_ForceFeedbackStartBuildup, m_ForceFeedbackStopBuildup);
        ClearTimer('DeviceBuildupTimer');
        SendDeviceChangeEvent(8);
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    ignores AlternateStartCooldown;

    simulated function RestartFireLoop(bool bRefire)
    {
        local AimData Aim;
        local float fTimingError, fPreHitDelay, fRefireTime;
        local TgDeviceFire FireMode;
        local TgPawn PawnOwner;

        ChangeFireModeOnRefire();
        PawnOwner = TgPawn(Owner);
        // End:0xB9
        if((((PawnOwner != none) && int(PawnOwner.r_eIsStealthed) != int(0)) && int(PawnOwner.r_eIsStealthed) != int(4)) && ShouldCancelStealth())
        {
            PawnOwner.RemoveStealthEffects();
        }
        FireMode = GetCurrentFire();
        // End:0xDA
        if(LogDebugInfo())
        {
        }
        ClearTimer('FirePreHitDelay');
        ClearTimer('FirePostHitDelay');
        fPreHitDelay = GetFiringPreHitDelay();
        CacheFiringPostHitDelay();
        fTimingError = WorldInfo.TimeSeconds - m_fFiringTimer;
        m_fFiringTimer = (WorldInfo.TimeSeconds + (fPreHitDelay / CustomTimeDilation)) - fTimingError;
        m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
        m_fTimeAccountedFor = 0.0000000;
        fPreHitDelay = FMax(0.0000000, fPreHitDelay - (fTimingError * CustomTimeDilation));
        // End:0x211
        if(LogDebugInfo())
        {
        }
        GetCachedAim(Aim);
        // End:0x27E
        if(IsTimerActive('FirePreHitDelay'))
        {
            ClearTimer('FirePreHitDelay');
            FireMode.RemoveEffectType(Instigator, false, 10455);
        }
        // End:0x2BC
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.ApplyEffectType(Instigator, 10455);
        }
        c_fCachedManaAtStartFire = ((PawnOwner != none) ? PawnOwner.GetMana() : 0.0000000);
        // End:0x397
        if(!bRefire || !IsToggleDevice())
        {
            fRefireTime = GetRefireTime();
            TgPawn(Instigator).DeviceOnStartFire(self);
            HandleDeviceFormStartFire(int(CurrentFireMode), fRefireTime, Aim);
            PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStartFire);
        }
        // End:0x3B5
        if(m_bIsFireHoldDevice && StartFireHold())
        {
            return;
        }
        // End:0x413
        if(m_bUsesBurstFire)
        {
            // End:0x406
            if((m_nBurstShotsRemaining == m_nBurstTotalShots) && fPreHitDelay > float(0))
            {
                SetTimer(fPreHitDelay, false, 'FirePreHitDelay');                
            }
            else
            {
                FirePreHitDelay();
            }            
        }
        else
        {
            // End:0x43E
            if(fPreHitDelay > float(0))
            {
                SetTimer(fPreHitDelay, false, 'FirePreHitDelay');                
            }
            else
            {
                FirePreHitDelay();
            }
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        local AimData DefaultAim;
        local float fPostHitDelay, fTimingError;

        // End:0x29
        if(m_bUsesBurstFire && m_nBurstTotalShots > 0)
        {
            m_nBurstShotsRemaining--;
        }
        // End:0x67
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10455);
        }
        // End:0x74
        if(LogDebugInfo())
        {
        }
        // End:0x101
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0x101
            if((((GetCurrentFire()) != none) && int(GetCurrentFire().m_nFireType) == int(1)) && (GetFiringPreHitDelay()) > 0.0000000)
            {
                s_ReceivedAim = DefaultAim;
                UpdateAimWhileFiring(m_CachedAim);
            }
        }
        FireAmmunition();
        HasAlreadyFiredOnce = true;
        // End:0x182
        if(IsTimerActive('FirePostHitDelay') && s_WhileFiringDeviceMode != none)
        {
            ClearTimer('FirePostHitDelay');
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10456);
        }
        // End:0x1ED
        if(m_bCarryPreFireToPostFire || m_bUsesBurstFire && m_nBurstShotsRemaining == m_nBurstTotalShots)
        {
            fTimingError = WorldInfo.TimeSeconds - m_fFiringTimer;            
        }
        else
        {
            fTimingError = 0.0000000;
        }
        fPostHitDelay = GetCachedFiringPostHitDelay();
        m_fFiringTimer = (WorldInfo.TimeSeconds + (fPostHitDelay / CustomTimeDilation)) - fTimingError;
        m_fTimeStampAccountedFor = WorldInfo.TimeSeconds;
        m_fTimeAccountedFor = 0.0000000;
        fPostHitDelay = FMax(0.0000000, fPostHitDelay - (fTimingError * CustomTimeDilation));
        // End:0x2CD
        if(LogDebugInfo())
        {
        }
        // End:0x30B
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.ApplyEffectType(Instigator, 10456);
        }
        // End:0x338
        if(fPostHitDelay > 0.0000000)
        {
            SetTimer(fPostHitDelay, false, 'FirePostHitDelay');            
        }
        else
        {
            FirePostHitDelay();
        }
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        local AimData Aim;
        local TgDeviceFire FireMode;
        local TgRepInfo_Game GRI;
        local bool bUseLagCompensation;
        local AimData DefaultAim;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        m_fAccumulatedFiringTime += (GetCachedFiringPostHitDelay());
        // End:0x60
        if(s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10456);
        }
        FireMode = GetCurrentFire();
        // End:0xA4
        if(!FireMode.m_bContinuousFire)
        {
            bPendingFire = false;
        }
        GRI = TgRepInfo_Game(WorldInfo.GRI);
        bUseLagCompensation = ((GRI != none) && GRI.r_bAllowWeaponLagPrediction) && CanAllowLagCompensation();
        // End:0x189
        if(!bUseLagCompensation || Instigator.IsLocallyControlled() && !HasRemoteOwner())
        {
            s_ReceivedAim = DefaultAim;
            UpdateAimWhileFiring(m_CachedAim);
        }
        GetCachedAim(Aim);
        // End:0x1DD
        if(TgPawn(Owner) != none)
        {
            TgPawn(Owner).DeviceOnPostHit(self);
        }
        PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackPostFire);
        // End:0x37F
        if(ShouldRefire(FireMode, Aim))
        {
            // End:0x367
            if(bUseLagCompensation)
            {
                // End:0x2A6
                if(Instigator.IsLocallyControlled() && !HasRemoteOwner())
                {
                    UpdateDesiredFireMode();
                    // End:0x298
                    if(int(Role) < int(ROLE_Authority))
                    {
                        m_CachedFireRequestId = GenerateUniqueFireRequestId();
                        CallServerRestartFireLoop(Aim);
                    }
                    RestartFireLoop(true);                    
                }
                else
                {
                    s_nNumServerRefires++;
                    // End:0x364
                    if(s_QueuedRefireRequests.Length > 0)
                    {
                        m_CachedFireRequestId = s_QueuedRefireRequests[0].ClientFireRequestId;
                        m_nDesiredFireMode = s_QueuedRefireRequests[0].DesiredFireMode;
                        s_ReceivedAim = s_QueuedRefireRequests[0].Aim;
                        UpdateAimWhileFiring(m_CachedAim);
                        s_QueuedRefireRequests.Remove(0, 1);
                        RestartFireLoop(true);
                    }
                }                
            }
            else
            {
                UpdateDesiredFireMode();
                RestartFireLoop(true);
            }            
        }
        else
        {
            // End:0x3D3
            if(((int(Role) == int(ROLE_Authority)) && bPendingFire) && FireMode.m_bContinuousFire)
            {
                InterruptFiring();                
            }
            else
            {
                GotoState('Active');
            }
        }
        SendDeviceChangeEvent(6);
        //return;        
    }

    reliable server function ServerRestartFireLoop(float MovementTimeStamp, Vector MovementInAccel, Vector MovementClientLoc, byte MovementNewFlags, byte MovementClientRoll, int MovementView, int ClientFireRequestId, byte ClientFireMode, Actor HitActor, float StartTraceX, float StartTraceY, float StartTraceZ, float EndTraceX, float EndTraceY, float EndTraceZ, int nCompressedAimVector, bool bFirstBurstShot)
    {
        local TgRepInfo_Game GRI;
        local bool bUseLagCompensation;
        local TgQueuedRefire NewEntry;
        local AimData ReceivedAim;
        local Rotator AimRotation;
        local TgPawn OwningPawn;
        local TgPlayerController OwningPlayerController;

        GRI = TgRepInfo_Game(WorldInfo.GRI);
        bUseLagCompensation = ((GRI != none) && GRI.r_bAllowWeaponLagPrediction) && CanAllowLagCompensation();
        // End:0x8C
        if(!bUseLagCompensation)
        {
            return;
        }
        // End:0xC6
        if(m_bUsesBurstFire && s_bInBurstRecovery)
        {
            // End:0xC4
            if(bFirstBurstShot)
            {
                s_bInBurstRecovery = false;                
            }
            else
            {
                return;
            }
        }
        OwningPawn = TgPawn(Instigator);
        // End:0x122
        if(OwningPawn != none)
        {
            OwningPlayerController = TgPlayerController(OwningPawn.Controller);
        }
        // End:0x19B
        if((MovementTimeStamp > 0.0000000) && OwningPlayerController != none)
        {
            OwningPlayerController.ServerMove(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView);
        }
        s_nNumClientRefires++;
        ReceivedAim.HitActor = HitActor;
        ReceivedAim.StartTrace.X = StartTraceX;
        ReceivedAim.StartTrace.Y = StartTraceY;
        ReceivedAim.StartTrace.Z = StartTraceZ;
        ReceivedAim.EndTrace.X = EndTraceX;
        ReceivedAim.EndTrace.Y = EndTraceY;
        ReceivedAim.EndTrace.Z = EndTraceZ;
        ReceivedAim.ClientMovementTimeStamp = MovementTimeStamp;
        AimRotation.Yaw = nCompressedAimVector & 65535;
        AimRotation.Pitch = (nCompressedAimVector >> 16) & 65535;
        ReceivedAim.AimVector = Vector(AimRotation);
        ReceivedAim = ValidateReceivedAim(MovementTimeStamp, ReceivedAim);
        // End:0x465
        if(s_nNumClientRefires <= s_nNumServerRefires)
        {
            m_CachedFireRequestId = ClientFireRequestId;
            m_nDesiredFireMode = ClientFireMode;
            s_ReceivedAim = ReceivedAim;
            UpdateAimWhileFiring(m_CachedAim);
            RestartFireLoop(true);            
        }
        else
        {
            // End:0x483
            if(s_QueuedRefireRequests.Length > 32)
            {
                s_QueuedRefireRequests.Remove(0, 1);
            }
            NewEntry.ClientFireRequestId = ClientFireRequestId;
            NewEntry.DesiredFireMode = ClientFireMode;
            NewEntry.Aim = ReceivedAim;
            s_QueuedRefireRequests.AddItem(NewEntry);
        }
        //return;        
    }

    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        local bool bWantsRefire;
        local TgObject.EDeviceFailType failType;

        bWantsRefire = ((bPendingFire || s_nNumClientRefires > s_nNumServerRefires) && FireMode.m_bContinuousFire) && CanDeviceFireNow(CurrentFireMode, Aim, LogDebugInfo(), failType);
        // End:0x1AC
        if(m_bUsesBurstFire && m_nBurstTotalShots > 0)
        {
            // End:0x153
            if(Instigator.IsLocallyControlled() && !HasRemoteOwner())
            {
                // End:0xF8
                if(m_bCanEndBurstEarly && c_bBurstPendingStopFire)
                {
                    return false;                    
                }
                else
                {
                    // End:0x10C
                    if(m_nBurstShotsRemaining > 0)
                    {
                        return true;                        
                    }
                    else
                    {
                        // End:0x14E
                        if(bWantsRefire && !c_bBurstPendingStopFire)
                        {
                            m_bIsFirstBurstShot = true;
                            m_nBurstShotsRemaining = m_nBurstTotalShots;
                            return true;                            
                        }
                        else
                        {
                            return false;
                        }
                    }
                }                
            }
            else
            {
                // End:0x190
                if((m_nBurstShotsRemaining <= 0) && bWantsRefire)
                {
                    m_bIsFirstBurstShot = true;
                    m_nBurstShotsRemaining = m_nBurstTotalShots;
                }
                return bWantsRefire || m_nBurstShotsRemaining > 0;
            }
        }
        return bWantsRefire;
        //return ReturnValue;        
    }

    simulated event bool IsFiring()
    {
        return true;
        //return ReturnValue;        
    }

    event ForceCooldownIfFiring()
    {
        HasAlreadyFiredOnce = true;
        //return;        
    }

    simulated function StartFiringLogic()
    {
        local TgPawn PawnOwner;
        local TgDeviceFire FireMode;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        m_fStartFiringTimestamp = WorldInfo.TimeSeconds;
        m_fAccumulatedFiringTime = 0.0000000;
        // End:0xC7
        if(m_bUsesBurstFire && m_nBurstTotalShots > 0)
        {
            // End:0x96
            if(m_bOnlyFirstBurstCostsAmmo || !RequiresAmmoToFire())
            {
                m_nBurstShotsRemaining = m_nBurstTotalShots;                
            }
            else
            {
                m_nBurstShotsRemaining = int(FMin(float(GetCurrentAmmoAmount()), float(m_nBurstTotalShots)));
            }
            m_bIsFirstBurstShot = true;
        }
        PawnOwner = TgPawn(Owner);
        // End:0x133
        if(PawnOwner != none)
        {
            // End:0x133
            if(int(Role) == int(ROLE_Authority))
            {
                PawnOwner.r_ReplicatedDeviceState[int(r_eEquippedAt)] = 1;
            }
        }
        // End:0x14B
        if(m_bLockInputDuringFire)
        {
            LockInput(true);
        }
        // End:0x163
        if(m_bLockCameraDuringFire)
        {
            LockCamera(true);
        }
        FireMode = GetCurrentFire();
        // End:0x1CD
        if(int(Role) == int(ROLE_Authority))
        {
            FireMode.ApplyEffectType(Instigator, 263);
            s_WhileFiringDeviceMode = FireMode;
        }
        // End:0x22C
        if(ShouldConsumePowerPoolOnStartFire())
        {
            c_fCachedManaAtStartFire = ((PawnOwner != none) ? PawnOwner.GetMana() : 0.0000000);
            DeviceConsumePowerPool(CurrentFireMode);
        }
        RestartFireLoop(false);
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        HasAlreadyFiredOnce = false;
        SetRandomShotSpreadSeed(m_CachedFireRequestId);
        // End:0x2C
        if(LogDebugInfo())
        {
        }
        // End:0x90
        if(((GetCurrentFire()) == none) || GetCurrentFire().GetBuildupTime() <= 0.0000000)
        {
            m_fFiringTimer = WorldInfo.TimeSeconds;
        }
        StartFiringLogic();
        s_nNumServerRefires = 0;
        s_nNumClientRefires = 0;
        s_QueuedRefireRequests.Length = 0;
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn PawnOwner;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        m_nBurstShotsRemaining = 0;
        PawnOwner = TgPawn(Owner);
        // End:0x84
        if(PawnOwner != none)
        {
            // End:0x84
            if(int(Role) == int(ROLE_Authority))
            {
                PawnOwner.r_ReplicatedDeviceState[int(r_eEquippedAt)] = 0;
            }
        }
        // End:0x9C
        if(m_bLockInputDuringFire)
        {
            LockInput(false);
        }
        // End:0xB4
        if(m_bLockCameraDuringFire)
        {
            LockCamera(false);
        }
        // End:0x171
        if((int(Role) == int(ROLE_Authority)) && s_WhileFiringDeviceMode != none)
        {
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10455, 0);
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 10456, 0);
            s_WhileFiringDeviceMode.RemoveEffectType(Instigator, false, 263, 0);
            s_WhileFiringDeviceMode = none;
        }
        // End:0x197
        if(r_bConsumedOnUse && HasAlreadyFiredOnce)
        {
            ConsumeDevice();
        }
        TgPawn(Instigator).FlashStopFire(r_nDeviceInstanceId, int(CurrentFireMode));
        TgPawn(Instigator).DeviceOnStopFire(self, m_IsBeingInterrupted);
        SendCombatLogEvent(((m_IsBeingInterrupted) ? 3 : 2));
        PlayNextSimulatedForceFeedbackWaveform(m_ForceFeedbackStartFire, m_ForceFeedbackStopFire);
        // End:0x27B
        if(c_DeviceForm != none)
        {
            c_DeviceForm.StopFire(int(CurrentFireMode));
        }
        NotifyDeviceEvent(3);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x0D
        if(LogDebugInfo())
        {
        }
        StopFiringLogic();
        // End:0x69
        if(ShouldCooldownAfterFire())
        {
            ClearTimer('AlternateStartCooldown');
            m_bIgnoreSecondaryFireLogic = false;
            m_bIsSecondaryFire = false;
            StartCooldown(int(CurrentFireMode));            
        }
        else
        {
            // End:0xE2
            if(!m_bIgnoreSecondaryFireLogic)
            {
                // End:0xC2
                if((r_fCooldownDelay > 0.0000000) && !m_bIsSecondaryFire)
                {
                    m_bIsSecondaryFire = true;
                    SetTimer(r_fCooldownDelay, false, 'AlternateStartCooldown');                    
                }
                else
                {
                    ClearTimer('AlternateStartCooldown');
                    m_bIsSecondaryFire = false;
                }
            }
        }
        // End:0x111
        if(m_IsPendingSetFireMode)
        {
            SetFireMode(int(m_PendingFireMode), true);
            m_IsPendingSetFireMode = false;
        }
        m_EndOfLastFireTimeStamp = WorldInfo.TimeSeconds;
        m_fFiringTimer = 0.0000000;
        HasAlreadyFiredOnce = false;
        ClearTimer('FirePreHitDelay');
        ClearTimer('FirePostHitDelay');
        ClearTimer('CheckQueuedRefires');
        UpdateOutroLockoutTime();
        // End:0x1D3
        if(m_bUsesOutroLockout && m_fOutroLockoutTime > 0.0000000)
        {
            SetTimer(m_fOutroLockoutTime, false, 'OutroLockoutTime');
        }
        // End:0x296
        if(GetCurrentFire().m_bTreatAmmoAsCharges)
        {
            // End:0x278
            if(int(Role) == int(ROLE_Authority))
            {
                // End:0x257
                if(r_nAmmoClipCount <= 0)
                {
                    StartCooldown(int(CurrentFireMode), FMax(m_fMinTimeBetweenAmmoCharges, (1.0000000 / m_fAmmoRegenPerSec) - m_fAmmoRegenCounter));                    
                }
                else
                {
                    StartCooldown(int(CurrentFireMode), m_fMinTimeBetweenAmmoCharges);
                }                
            }
            else
            {
                StartCooldown(int(CurrentFireMode), m_fMinTimeBetweenAmmoCharges);
            }
        }
        //return;        
    }

    simulated function ChangeFireModeOnRefire()
    {
        // End:0x14F
        if((int(m_nDesiredFireMode) != int(255)) && int(m_nDesiredFireMode) != int(CurrentFireMode))
        {
            // End:0xD8
            if(s_WhileFiringDeviceMode != none)
            {
                s_WhileFiringDeviceMode.RemoveEffectType(Instigator, true, 263, 0);
                s_WhileFiringDeviceMode.RemoveEffectType(Instigator, true, 10455, 0);
                s_WhileFiringDeviceMode.RemoveEffectType(Instigator, true, 10456, 0);
                s_WhileFiringDeviceMode = none;
            }
            SetFireMode(int(m_nDesiredFireMode), true);
            s_WhileFiringDeviceMode = GetCurrentFire();
            // End:0x14F
            if((s_WhileFiringDeviceMode != none) && IsFiring())
            {
                s_WhileFiringDeviceMode.ApplyEffectType(Instigator, 263);
            }
        }
        //return;        
    }
    stop;    
}

simulated state WeaponEquipping
{
    simulated event bool IsEquipping()
    {
        return true;
        //return ReturnValue;        
    }

    simulated function WeaponEquipped()
    {
        GotoState('Active');
        // End:0x1B
        if(LogDebugInfo())
        {
        }
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        AltUse(false);
        // End:0x18
        if(LogDebugInfo())
        {
        }
        // End:0x76
        if(EquipTime > 0.0000000)
        {
            TgPawn(Instigator).DisplayWeaponSwitchProgressBar(EquipTime);
            SetTimer(EquipTime, false, 'WeaponEquipped');            
        }
        else
        {
            WeaponEquipped();
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x0D
        if(LogDebugInfo())
        {
        }
        TgPawn(Instigator).HideWeaponSwitchProgressBar();
        ClearTimer('WeaponEquipped');
        //return;        
    }
    stop;    
}

simulated state WeaponUnequipping
{
    simulated function BeginState(name PreviousStateName)
    {
        AltUse(false);
        super(Object).BeginState(PreviousStateName);
        StopFire();
        SetTimer(m_fUnequipTime, false, 'WeaponIsDown');
        //return;        
    }

    simulated function bool TryUnequipping()
    {
        return false;
        //return ReturnValue;        
    }

    simulated function bool IsUnEquipping()
    {
        return true;
        //return ReturnValue;        
    }

    simulated function WeaponIsDown()
    {
        GotoState('Inactive');
        InvManager.ChangedWeapon();
        //return;        
    }

    simulated function CancelUnequip()
    {
        ClearTimer('WeaponIsDown');
        GotoState('WeaponEquipping');
        //return;        
    }
    stop;    
}

simulated state Inactive
{
    ignores StartFire;

    simulated function BeginState(name PreviousStateName)
    {
        AltUse(false);
        super(Object).BeginState(PreviousStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nDesiredFireMode=255
    m_ReticuleType=EReticuleType.RETICULE_Circle
    m_ZoomedReticuleType=EReticuleType.RETICULE_Circle
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
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor'
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