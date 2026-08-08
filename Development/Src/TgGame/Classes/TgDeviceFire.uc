class TgDeviceFire extends Object
    native(Devices)
    config(Engine)
    dependson(TgDevice, TgObject);

const TGTT_ATTACK_NA = 83;

const TGTT_ATTACK_INSTANT_RANGED = 85;

const TGTT_ATTACK_PROJECTILE_RANGED = 177;

const TGTT_ATTACK_TELEPORT_TO_SPAWN = 1442;

const TGTT_ATTACK_GROUND_TARGET = 10032;

const TGTT_ATTACK_GROUND_TARGET_DEPLOYABLE = 10011;

const TGTT_ATTACK_GROUND_TARGET_BOT = 10382;

const TGTT_ATTACK_INSTANT_LINE = 10015;

const TGTT_ATTACK_GROUND_TARGET_PROJECTILE = 10251;

const TGTT_ATTACK_GROUND_TARGET_TELEPORT = 10636;

const TGTT_ATTACK_MAP_TELEPORT = 10657;

const TGTT_ATTACK_ATTACHED_DEPLOYABLE = 10670;

const TGTT_ATTACK_FORWARD_TELEPORT = 15034;

const TGTT_TARGET_SELF = 214;

const TGTT_TARGET_FRIEND = 10184;

const TGTT_TARGET_ENEMY = 212;

const TGTT_TARGET_ALL = 703;

const TGTT_TARGET_OWNPET = 15006;

const TGTT_TARGET_ENEMY_AND_SELF = 10805;

const TGTT_TARGET_FRIEND_ONLY = 884;

const TGTT_TARGET_FRIEND_AND_ENEMY = 10029;

const TGTT_TARGET_NOT_SELF = 10587;

const TGTT_TARGET_PET_OWNER = 15030;

const TGMT_MOVEMENT = 10583;

const TGDT_None = 112;

const TGDT_Physical = 113;

const TGDT_Magical = 10057;

const TGDT_AoE = 15207;

const TGDT_Direct = 15206;

const TGAUF_ALLOW_NONE = 0;

const TGAUF_ALLOW_STUN = 1;

const TGAUF_ALLOW_SILENCE = 2;

const TGAUF_ALLOW_GRAB = 4;

const TGAUF_ALLOW_CRIPPLE = 8;

const TGAUF_ALLOW_ALL = 15;

enum DeviceTargeterType {
    TGDTT_None,  // 0
    TGDTT_Self,  // 1
    TGDTT_Friend,  // 2
    TGDTT_Enemy,  // 3
    TGDTT_OwnPet,  // 4
    TGDTT_Enemy_And_Self,  // 5
    TGDTT_Friend_Only,  // 6
    TGDTT_Pet_Owner,  // 7
    TGDTT_Not_Self,  // 8
    TGDTT_All,  // 9
};

enum HeadShotResult {
    HEADSHOT_SuccessfulMeshTrace,  // 0
    HEADSHOT_FailedMeshTrace,  // 1
    HEADSHOT_CannotMeshTrace,  // 2
    HEADSHOT_Failure,  // 3
};

enum TargetSelectionType {
    TGTST_Default,  // 0
    TGTST_Random,  // 1
    TGTST_Closest,  // 2
    TGTST_ClosestAimCenter,  // 3
    TGTST_LowestHealthPercent,  // 4
};

struct WeaponFireResults {
    var bool bDidServerValidation;
    var ImpactInfo Impact;
    structdefaultproperties {}
};

struct AoeActorInRangeData {
    var Actor Actor;
    var Vector Location;
    structdefaultproperties {}
};

var Actor m_Owner;
var TgDevice.EWeaponFireType m_nFireType;
var TgObject.DeviceTargetMode m_eTargetingMode;
var TgDeviceFire.DeviceTargeterType m_eTargeterType;
var TgDeviceFire.TargetSelectionType m_eTargetSelectionTypeOverride;
var bool m_bIsAOE;
var bool m_bIsCone;
var bool m_bIsLinear;
var bool m_bContinuousFire;
var bool m_bRequireLOS;
var bool m_bVerifyTargetPlacement;
var bool m_bAllowMultiplePets;
var const bool m_bUseAccurateEncroachment;
var const bool m_bUseTargetingEncroachmentActor;
var const bool m_bScaleEncroachmentWithRangeMod;
var const bool m_bPassThroughShield;
var const bool m_bPassThroughDeployWalls;
var const bool m_bIgnoreDeployablesForBlocking;
var bool m_bAdjustDeployHeightToExtent;
var bool m_bDeployOnOwnerLocation;
var bool m_bSpawnPetOnOwnerLocation;
var bool m_bCanTriggerCounter;
var bool m_bEnchroachmentFireLOSCheck;
var bool m_bTreatAmmoAsCharges;
var bool m_bMaintainBurstTarget;
var bool m_bCanTargetStealthedTargets;
var array<TgEffectGroup> s_EffectGroupList;
var array<TgProperty> m_Properties;
var native Pointer m_pAmSetup;
var native Pointer m_pFireModeSetup;
var int m_nId;
var int m_nAttackType;
var int m_nMovementType;
var name m_nmOffhandAnimationType;
var int m_nTargetAffectsType;
var int m_nAllowUseWhileFlags;
var int m_nDamageType;
var int m_nArcingJumps;
var native Map_Mirror m_PropertyIndexMap;
var float m_fHealthCost;
var float m_fManaCost;
var float m_fEnergyCost;
var float m_fFireTime;
var float m_fBuildupTime;
var float m_fFirePreHitDelay;
var float m_fFirePostHitDelay;
var int m_nShotsPerFire;
var name m_nmDamageTypeClass;
var Class<TgDamageType> m_DamageTypeClass;
var int m_nMaxTargetCount;
var float m_fFireLockTime;
var int m_nAmmoClipSize;
var float m_fAmmoClipPreReloadTime;
var float m_fAmmoClipPostReloadTime;
var int m_nAmmoCostPerShot;
var const float m_fEncroachmentRayCastVerticalOffset;
var const int m_nTargetingEncroachmentActorOverride;
var transient Actor m_TargetingEncroachmentActor;
var const Vector m_vActorEncroachmentBaseScale;
var name m_nmWhileFiringCameraAnim;
var float m_CachedRechargeBonusFlat;
var float m_CachedRechargeBonusPercent;
var array<TgEffect> m_ModifiedEffects;
var array<float> m_BaseValues;
var array<TgEffectGroup> m_ModifiedEGLifetimes;
var array<float> m_BaseLifetimes;
var array<TgEffectGroup> m_ModifiedEGAppValues;
var array<float> m_BaseAppValues;
var array<TgEffectGroup> m_ModifiedEGMaxStacks;
var array<float> m_BaseMaxStacks;
var array<Actor> m_CachedTargetList;
var float m_fSelectTargetsExtent;
var TgGameplayCurves m_GameplayCurves;

native function SpecialShieldDestroyed();  // Export UTgDeviceFire::execSpecialShieldDestroyed(FFrame&, void* const)

native function Class<Projectile> GetProjectileClass();  // Export UTgDeviceFire::execGetProjectileClass(FFrame&, void* const)

native function InitializeProjectile(Projectile Proj);  // Export UTgDeviceFire::execInitializeProjectile(FFrame&, void* const)

native function DeployAtActor(Actor TargetActor);  // Export UTgDeviceFire::execDeployAtActor(FFrame&, void* const)

native function DeployAtLocation(Vector SpawnLocation, Rotator SpawnRotation);  // Export UTgDeviceFire::execDeployAtLocation(FFrame&, void* const)

native function Deploy();  // Export UTgDeviceFire::execDeploy(FFrame&, void* const)

native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation);  // Export UTgDeviceFire::execGetDeployLocationAndRotation(FFrame&, void* const)

native function Actor GetDeployableBase();  // Export UTgDeviceFire::execGetDeployableBase(FFrame&, void* const)

native function TgPawn SpawnPet(bool bPet);  // Export UTgDeviceFire::execSpawnPet(FFrame&, void* const)

native function bool GetPetLocationAndRotation(out Vector OutLocation, out Rotator OutRotation, Pointer botSetup);  // Export UTgDeviceFire::execGetPetLocationAndRotation(FFrame&, void* const)

native function CustomFire();  // Export UTgDeviceFire::execCustomFire(FFrame&, void* const)

native simulated function TeleportFire();  // Export UTgDeviceFire::execTeleportFire(FFrame&, void* const)

native function TgProperty GetProperty(int nPropertyId);  // Export UTgDeviceFire::execGetProperty(FFrame&, void* const)

native function SetProperty(int nPropertyId, float fNewValue);  // Export UTgDeviceFire::execSetProperty(FFrame&, void* const)

native function float GetPropertyValue(int nPropertyId);  // Export UTgDeviceFire::execGetPropertyValue(FFrame&, void* const)

native function float GetPropertyValueById(int nPropertyId, int nPropertyIndex);  // Export UTgDeviceFire::execGetPropertyValueById(FFrame&, void* const)

native function TgEffectGroup GetEffectGroup(int nType, out int nIndex);  // Export UTgDeviceFire::execGetEffectGroup(FFrame&, void* const)

native function name QueryClass(int nMode);  // Export UTgDeviceFire::execQueryClass(FFrame&, void* const)

native function bool IsBlockedByGeometry(Actor SourceActor, Actor TargetActor);  // Export UTgDeviceFire::execIsBlockedByGeometry(FFrame&, void* const)

native function VerifyProjectile();  // Export UTgDeviceFire::execVerifyProjectile(FFrame&, void* const)

native function bool LogDebugInfo();  // Export UTgDeviceFire::execLogDebugInfo(FFrame&, void* const)

native function float GetDamageRadius();  // Export UTgDeviceFire::execGetDamageRadius(FFrame&, void* const)

native function float GetAIRange();  // Export UTgDeviceFire::execGetAIRange(FFrame&, void* const)

native function float GetAIRadius();  // Export UTgDeviceFire::execGetAIRadius(FFrame&, void* const)

native function float GetRemoteActivationTime();  // Export UTgDeviceFire::execGetRemoteActivationTime(FFrame&, void* const)

native function float GetPostLandDuration();  // Export UTgDeviceFire::execGetPostLandDuration(FFrame&, void* const)

native function float GetEffectiveRadius();  // Export UTgDeviceFire::execGetEffectiveRadius(FFrame&, void* const)

native function float GetPersistTime();  // Export UTgDeviceFire::execGetPersistTime(FFrame&, void* const)

native function float GetPersistPulse();  // Export UTgDeviceFire::execGetPersistPulse(FFrame&, void* const)

native function float GetPetLifeSpan();  // Export UTgDeviceFire::execGetPetLifeSpan(FFrame&, void* const)

native function float GetFireAngle();  // Export UTgDeviceFire::execGetFireAngle(FFrame&, void* const)

native function float GetDeployTime();  // Export UTgDeviceFire::execGetDeployTime(FFrame&, void* const)

native function float GetProjectileSpeed();  // Export UTgDeviceFire::execGetProjectileSpeed(FFrame&, void* const)

native function float GetVisionRange();  // Export UTgDeviceFire::execGetVisionRange(FFrame&, void* const)

native function float GetProximityDistance();  // Export UTgDeviceFire::execGetProximityDistance(FFrame&, void* const)

native function float GetRange();  // Export UTgDeviceFire::execGetRange(FFrame&, void* const)

native function float GetMinRange();  // Export UTgDeviceFire::execGetMinRange(FFrame&, void* const)

native function float GetEffectiveRange();  // Export UTgDeviceFire::execGetEffectiveRange(FFrame&, void* const)

native function float GetMinimumRadius();  // Export UTgDeviceFire::execGetMinimumRadius(FFrame&, void* const)

native function float GetMaxDeployableCount();  // Export UTgDeviceFire::execGetMaxDeployableCount(FFrame&, void* const)

native function float GetHeadShotDamage();  // Export UTgDeviceFire::execGetHeadShotDamage(FFrame&, void* const)

native function float GetBonusShieldDamagePerc();  // Export UTgDeviceFire::execGetBonusShieldDamagePerc(FFrame&, void* const)

native function bool IsWithinRange(float fDistance);  // Export UTgDeviceFire::execIsWithinRange(FFrame&, void* const)

native function bool IsWithinEffectiveRange(float fDistance);  // Export UTgDeviceFire::execIsWithinEffectiveRange(FFrame&, void* const)

native function float GetCustomValue1();  // Export UTgDeviceFire::execGetCustomValue1(FFrame&, void* const)

native function float GetCustomValue2();  // Export UTgDeviceFire::execGetCustomValue2(FFrame&, void* const)

native function float GetCustomValue3();  // Export UTgDeviceFire::execGetCustomValue3(FFrame&, void* const)

native function float GetCustomValue4();  // Export UTgDeviceFire::execGetCustomValue4(FFrame&, void* const)

native function float GetCustomValue5();  // Export UTgDeviceFire::execGetCustomValue5(FFrame&, void* const)

native function bool CheckTeamPassThrough(Actor HitActor, Vector aimDirection);  // Export UTgDeviceFire::execCheckTeamPassThrough(FFrame&, void* const)

native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType=0, optional bool bIgnoreHealth, optional bool bInvertTeam);  // Export UTgDeviceFire::execIsValidTarget(FFrame&, void* const)

native function bool IsSelfOrOwner(Actor Target);  // Export UTgDeviceFire::execIsSelfOrOwner(FFrame&, void* const)

native function bool IsEnemy(Actor TargetActor);  // Export UTgDeviceFire::execIsEnemy(FFrame&, void* const)

native function ImpactInfo GetTraceImpact(Vector StartTrace, Vector EndTrace, Vector Extent, bool bIgnoreWorld, bool bCheckLockOn, bool bForceNoBodyShotCheck, optional float RewindTime=0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate, optional int nShotIndex);  // Export UTgDeviceFire::execGetTraceImpact(FFrame&, void* const)

native function bool IsArcingAttack();  // Export UTgDeviceFire::execIsArcingAttack(FFrame&, void* const)

native function bool UsesActorEncroachmentForCalcTargetingFire();  // Export UTgDeviceFire::execUsesActorEncroachmentForCalcTargetingFire(FFrame&, void* const)

native function float GetShotPowerCost(int nPacingType);  // Export UTgDeviceFire::execGetShotPowerCost(FFrame&, void* const)

native function AddEffectiveRangeReduction(out ImpactInfo Impact, Actor DamageInstigator, Vector OriginLocation, optional bool bUseRadius=false);  // Export UTgDeviceFire::execAddEffectiveRangeReduction(FFrame&, void* const)

native function TgObject.DeviceTargetMode GetTargetingMode();  // Export UTgDeviceFire::execGetTargetingMode(FFrame&, void* const)

native function Actor IsBlockedByBlocker(Actor DamageInstigator, Actor Target, optional Vector OriginLocation, optional Vector TargetLocation);  // Export UTgDeviceFire::execIsBlockedByBlocker(FFrame&, void* const)

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire::execIgnoreTargetForBlocking(FFrame&, void* const)

native function Vector GetHitLocationFlat(const out Vector StartTrace, const out Vector TargetLocation, const out Vector targetExtent);  // Export UTgDeviceFire::execGetHitLocationFlat(FFrame&, void* const)

native function Vector GetHitLocationToCenter(const out Vector StartTrace, const out Vector TargetLocation, const out Vector targetExtent);  // Export UTgDeviceFire::execGetHitLocationToCenter(FFrame&, void* const)

native function bool ShouldAddToImpactList(Actor HitActor, array<ImpactInfo> ImpactList);  // Export UTgDeviceFire::execShouldAddToImpactList(FFrame&, void* const)

native function bool IsInSlice(const Actor SourceActor, const Actor TargetActor, Vector StartCone, Vector ConeDir, float ConeAngle, optional float ConeRadius);  // Export UTgDeviceFire::execIsInSlice(FFrame&, void* const)

native function bool IsInCone(Actor SourceActor, Actor TargetActor, Vector StartCone, Vector ConeDir, float ConeAngle);  // Export UTgDeviceFire::execIsInCone(FFrame&, void* const)

native function bool CheckValidTarget(Actor Target, bool bPredicting);  // Export UTgDeviceFire::execCheckValidTarget(FFrame&, void* const)

native function WeaponFireResults CalcWeaponModeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional bool bNoBodyShotCheck=false, optional float RewindTime=0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);  // Export UTgDeviceFire::execCalcWeaponModeFire(FFrame&, void* const)

native function ImpactInfo CalcConeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bUseRange=false, optional bool bPredicting=false);  // Export UTgDeviceFire::execCalcConeFire(FFrame&, void* const)

native function ImpactInfo CalcSliceFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bUseRange=false, optional bool bPredicting=false);  // Export UTgDeviceFire::execCalcSliceFire(FFrame&, void* const)

native function ImpactInfo CalcAoeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional float RewindTime=0.0000000);  // Export UTgDeviceFire::execCalcAoeFire(FFrame&, void* const)

native function WeaponFireResults CalcInstantFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional bool bNoBodyShotCheck=false, optional float RewindTime=0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);  // Export UTgDeviceFire::execCalcInstantFire(FFrame&, void* const)

native function ImpactInfo CalcArcingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false);  // Export UTgDeviceFire::execCalcArcingFire(FFrame&, void* const)

native function ImpactInfo CalcLinearFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false);  // Export UTgDeviceFire::execCalcLinearFire(FFrame&, void* const)

native function ImpactInfo CalcDeployableTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, int nDeployableId, optional bool bPredicting=false);  // Export UTgDeviceFire::execCalcDeployableTargetingFire(FFrame&, void* const)

native function ImpactInfo CalcChargeTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false);  // Export UTgDeviceFire::execCalcChargeTargetingFire(FFrame&, void* const)

native function WeaponFireResults CalcActorEncroachmentTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional float RewindTime=0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);  // Export UTgDeviceFire::execCalcActorEncroachmentTargetingFire(FFrame&, void* const)

native function Vector GetAlternateAOEStartTrace(Actor DamageInstigator, const out Vector Center, float Radius);  // Export UTgDeviceFire::execGetAlternateAOEStartTrace(FFrame&, void* const)

native function TgGameplayCurves GetCurrentGameplayCurves();  // Export UTgDeviceFire::execGetCurrentGameplayCurves(FFrame&, void* const)

simulated event ApplyEquipEffects() { }

simulated event RemoveEquipEffects() { }

event SubmitEffect(ImpactInfo Impact, TgEffectGroup EffectGroup, optional bool bRemove, optional int StackCount=1, optional Actor InstigatorOverride) { }

function ApplyModifyEffects(TgEffectGroup EffectGroup) { }

function RemoveModifyEffects() { }

simulated function DisplayMessage(string sMessage) { }

event ApplyEffectType(Actor Target, int nEffectGroupType, optional ImpactInfo Impact, optional int StackCount=1) { }

event RemoveEffectType(Actor Target, bool bForceRemove, int nEffectGroupType, optional int StackCount=1) { }

event ApplyHitSpecial(Actor Target, optional ImpactInfo Impact, optional int nHitSpecialSituationalType=0, optional int StackCount=1) { }

event RemoveHitSpecial(Actor Target, bool bForceRemove, optional int nHitSpecialSituationalType=0, optional int StackCount=1) { }

function TrackDeviceModeHit(TgPawn Hitter, float fDistance, bool bHitPlayer) { }

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator) { }

function HandleMiss() { }

function HandleSuccessfulHit(Actor DamageInstigator, Pawn OwnerInstigator, ImpactInfo Impact) { }

function SubmitHitEffects(Actor DamageInstigator, ImpactInfo Impact, int nType) { }

event SubmitFinalBlowEffects(Actor DamageInstigator, ImpactInfo Impact) { }

simulated event float GetRefireTime() { }

simulated event float GetBuildupTime() { }

simulated event float GetPreHitDelay() { }

simulated event float GetPostHitDelay() { }

simulated event float GetFireLockTime() { }

simulated event float GetCooldownTime() { }

simulated event float GetMinCooldownTime() { }

simulated event float GetContagiousRadius() { }

simulated event float GetConeAttackAngle() { }

simulated event float GetSignedConeAttackAngle() { }

simulated event float GetConeAttackAngleOffset() { }

event int GetNumArcJumps() { }

simulated function bool CanSimulateTeleportFire() { }

defaultproperties
{
    m_bCanTriggerCounter=true
    m_bEnchroachmentFireLOSCheck=true
    m_bCanTargetStealthedTargets=true
    m_nShotsPerFire=1
    m_nAmmoCostPerShot=1
    m_vActorEncroachmentBaseScale=(X=1.0000000,Y=1.0000000,Z=1.0000000)
}
