class TgDeployable extends Actor
    native(Deployable)
    nativereplication
    notplaceable
    hidecategories(Navigation)
    implements(TgSkinnableInterface,TgCombatActor,TgObserver_ViewTargetChanged,TgInteractiveAudio,TgGameplayCurveOwner)
    config(Engine)
    dependson(TgCombatActor, TgGameplayCurvesSet, TgObject);

enum AdvancedCollisionMode {
    ACM_None,  // 0
    ACM_Shield,  // 1
    ACM_Geometry,  // 2
};

struct CollisionSettingsDeployable {
    var const TgDeployable.AdvancedCollisionMode mCollisionMode;
    var const bool bUseMeshForCollision;
    var const bool bPawnsCanBaseOnMe;
    var bool bAutoRegisterObstacle;
    var bool bHasRegisteredObstacle;
    var bool bOnlyBlockShotsFromFront;
    var bool bBlockFriendlyFire;
    var float fProjectileAllowanceRadius;
    var float fExplosionAllowanceRadius;
    structdefaultproperties {}
};

var repnotify int r_nDeployableId;
var int r_nSkinId;
var int r_nWeaponSkinId;
var bool c_bInitialized;
var bool m_bConsumedOnFire;
var bool m_bFireOnDeploy;
var bool m_bHasAlreadyFiredOnce;
var bool m_bInstantFire;
var bool c_bMinimapOnlyOwnerSee;
var bool r_bTakeDamage;
var bool m_bInDestroyedState;
var bool s_bDestroyedThisTick;
var bool m_bIsDeployed;
var bool c_bEnemyMatLoaded;
var bool m_bDestroyOnOwnerDeathFlag;
var bool m_bDestroyAfterRoundEnds;
var bool m_bAdjustMeshToGround;
var const bool m_bIsVisionBlocker;
var const bool m_bIsAIVisionBlocker;
var const bool m_bMovableProjBlocker;
var const bool m_bDeviceUsedIsHandDevice;
var bool m_bUseSilhouettesOverride;
var (TagetComponent) bool m_bOverrideTargetComponentHeight;
var repnotify bool r_bInitialIsEnemy;
var protected transient bool c_bIsSpectateToggleActive;
var bool m_bUseRangeFalloffCurve;
var int m_nDeployableType;
var int r_nPhysicalType;
var repnotify int r_nHealth;
var TgEffectManager r_EffectManager;
var array<TgEffectGroup> m_EquipEffects;
var array<TgProperty> s_Properties;
var TgDeviceForm c_Form;
var TgSpecialFx c_FireFx;
var export editinline MeshComponent c_Mesh;
var repnotify Vector r_vFlashLocation;
var repnotify byte r_nFlashCount;
var repnotify byte r_nFlashFireCount;
var byte c_nPreviousFlashFireCount;
var const TgObject.DeployableOverlayIcon m_InitHUDOverlayIcon;
var const TgObject.DeployableOverlayState m_InitHUDOverlayState;
var TgDeviceFire m_FireMode;
var float m_fStateTime;
var int c_nVisibleToLocalPlayer[2];
var TgActorFactory s_DeployFactory;
var int m_TimeCreated;
var export editinline MeshComponent m_DestroyedMesh;
var float m_fLifeAfterDeathSecs;
var repnotify int r_nReplicateDestroyIt;
var TgInteractiveAudio m_AsInteractiveAudio;
var float s_fPersistTime;
var const export editinline DynamicLightEnvironmentComponent LightEnvironment;
var repnotify float r_fTimeToDeploySecs;
var repnotify float r_fInitDeployTime;
var float m_fCurrentDeployPercentage;
var float r_fCurrentDeployTime;
var float m_fDamagedDuringDeploy;
var TgDeviceFire s_SpawnerDeviceMode;
var TgDevice r_Owner;
var int r_nOwnerFireMode;
var float AlwaysRelevantDistanceSquared;
var float m_fMaxAimAssistStacks;
var CollisionSettingsDeployable m_CollisionSettings;
var array<TgPawn> m_PawnsBasedOnMe;
var TgSilhouetteManager m_SilhouetteManager;
var const int m_nInitHUDOverlayDisplayMask;
var const float m_InitHUDOverlayEnemyViewDist;
var () float m_fHUDOverlayZOffset;
var native const Pointer m_pAmSkin;
var native const Pointer m_pAmWeaponSkin;
var (TargetComponent) export editinline CylinderComponent m_TargetComponent;
var (TargetComponent) float m_TargetCollisionTraceDistance;
var (TagetComponent) float m_fOverriddenTargetComponentHeight;
var TgPawn m_LastDamager;
var int m_LastDamagerTimeStamp;
var repnotify TgRepInfo_Deployable r_DRI;
var TgPlayerController c_LocalPC;
var Class<Actor> m_DRIClass;
var float m_fDisableSpectatorFxTime;
var transient float m_fDisableSpectatorFxTimeRemaining;
var TgGameplayCurves m_GameplayCurves;
var TgAkActorUnoccluded m_AkActorUnoccluded;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_EffectManager, r_fInitDeployTime, r_fTimeToDeploySecs, r_nFlashCount, r_nFlashFireCount, r_nHealth, r_vFlashLocation;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nReplicateDestroyIt;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_bTakeDamage;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_DRI, r_bInitialIsEnemy, r_fCurrentDeployTime, r_nDeployableId, r_nPhysicalType, r_nSkinId;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetOwner) r_Owner, r_nOwnerFireMode;
}

native function bool ApplyDeployableSetup();  // Export UTgDeployable::execApplyDeployableSetup(FFrame&, void* const)

native function InitializeDefaultProps();  // Export UTgDeployable::execInitializeDefaultProps(FFrame&, void* const)

native function AddProperty(int nPropId, float fBase, float fRaw, float FMin, float FMax);  // Export UTgDeployable::execAddProperty(FFrame&, void* const)

native function TgProperty GetProperty(int nPropertyId);  // Export UTgDeployable::execGetProperty(FFrame&, void* const)

native function SetProperty(int nPropertyId, float fNewValue);  // Export UTgDeployable::execSetProperty(FFrame&, void* const)

native function ResetProperties();  // Export UTgDeployable::execResetProperties(FFrame&, void* const)

native function SwapMeshToDestroyed();  // Export UTgDeployable::execSwapMeshToDestroyed(FFrame&, void* const)

native function DeployableDestroyed();  // Export UTgDeployable::execDeployableDestroyed(FFrame&, void* const)

native function int GetMaxDeployHealth();  // Export UTgDeployable::execGetMaxDeployHealth(FFrame&, void* const)

native function NotifyGroupChanged();  // Export UTgDeployable::execNotifyGroupChanged(FFrame&, void* const)

native function ForceRecalculateMaterial();  // Export UTgDeployable::execForceRecalculateMaterial(FFrame&, void* const)

native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);  // Export UTgDeployable::execRecalculateMaterial(FFrame&, void* const)

native function AdjustMeshToGround();  // Export UTgDeployable::execAdjustMeshToGround(FFrame&, void* const)

native function float CalcMeshOffset();  // Export UTgDeployable::execCalcMeshOffset(FFrame&, void* const)

native function UpdateTargetCylinder();  // Export UTgDeployable::execUpdateTargetCylinder(FFrame&, void* const)

native function UpdateDamagers(TgPawn Damager);  // Export UTgDeployable::execUpdateDamagers(FFrame&, void* const)

native function SetInitialHealthPercent(float fPercent);  // Export UTgDeployable::execSetInitialHealthPercent(FFrame&, void* const)

native function TgRepInfo_TaskForce GetTaskForce();  // Export UTgDeployable::execGetTaskForce(FFrame&, void* const)

native function int GetTaskForceNumber();  // Export UTgDeployable::execGetTaskForceNumber(FFrame&, void* const)

native function SetTaskForceNumber(int nTaskForceId);  // Export UTgDeployable::execSetTaskForceNumber(FFrame&, void* const)

native function int GetSpawnerDeviceInstanceId();  // Export UTgDeployable::execGetSpawnerDeviceInstanceId(FFrame&, void* const)

native function int GetSpawnerDeviceId();  // Export UTgDeployable::execGetSpawnerDeviceId(FFrame&, void* const)

native function bool IsFriendlyWithLocalPawn();  // Export UTgDeployable::execIsFriendlyWithLocalPawn(FFrame&, void* const)

native function UpdateHealth();  // Export UTgDeployable::execUpdateHealth(FFrame&, void* const)

native function bool IsInvisibleToAI(optional Actor TestActor);  // Export UTgDeployable::execIsInvisibleToAI(FFrame&, void* const)

native function bool IsHittable();  // Export UTgDeployable::execIsHittable(FFrame&, void* const)

native function Vector GetHudOverlayLocation(optional bool bCentered=false);  // Export UTgDeployable::execGetHudOverlayLocation(FFrame&, void* const)

native function AdjustHeal(const out ImpactInfo Impact, out float fHeal, int nPropertyId);  // Export UTgDeployable::execAdjustHeal(FFrame&, void* const)

native function PostAkEvent(AkEvent InAkEvent);  // Export UTgDeployable::execPostAkEvent(FFrame&, void* const)

native function RegisterObstacle();  // Export UTgDeployable::execRegisterObstacle(FFrame&, void* const)

native function UnRegisterObstacle();  // Export UTgDeployable::execUnRegisterObstacle(FFrame&, void* const)

native function float GetHealth();  // Export UTgDeployable::execGetHealth(FFrame&, void* const)

native function float GetMaxHealth();  // Export UTgDeployable::execGetMaxHealth(FFrame&, void* const)

native function float GetHealthPercent();  // Export UTgDeployable::execGetHealthPercent(FFrame&, void* const)

native function float GetMana();  // Export UTgDeployable::execGetMana(FFrame&, void* const)

native function float GetMaxMana();  // Export UTgDeployable::execGetMaxMana(FFrame&, void* const)

native function float GetShieldHealth();  // Export UTgDeployable::execGetShieldHealth(FFrame&, void* const)

native function float GetMaxShield();  // Export UTgDeployable::execGetMaxShield(FFrame&, void* const)

native function bool CanTakeHealthDamage();  // Export UTgDeployable::execCanTakeHealthDamage(FFrame&, void* const)

native function bool CanDealHeadShots();  // Export UTgDeployable::execCanDealHeadShots(FFrame&, void* const)

native function bool CanTakeHeadShots();  // Export UTgDeployable::execCanTakeHeadShots(FFrame&, void* const)

native function bool OnlyTakeHeadShots();  // Export UTgDeployable::execOnlyTakeHeadShots(FFrame&, void* const)

native function bool IsImmuneToDamage();  // Export UTgDeployable::execIsImmuneToDamage(FFrame&, void* const)

native function bool CanBeExecuted();  // Export UTgDeployable::execCanBeExecuted(FFrame&, void* const)

native function bool IsImmuneToHealing();  // Export UTgDeployable::execIsImmuneToHealing(FFrame&, void* const)

native function BuffDamage(Actor Target, TgEffectDamage Effect, ImpactInfo Impact, float fBaseDamage, out float fProratedAmount, out ExtraDamageInfo ExtraInfo);  // Export UTgDeployable::execBuffDamage(FFrame&, void* const)

native function float GetSpecialDamageDealtPercentAI();  // Export UTgDeployable::execGetSpecialDamageDealtPercentAI(FFrame&, void* const)

native function float GetSpecialDamageTakenPercentAI();  // Export UTgDeployable::execGetSpecialDamageTakenPercentAI(FFrame&, void* const)

native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgDeployable::execMitigateHealthDamage(FFrame&, void* const)

native function float GetDamageReductionPerc(TgDevice damageDev, TgEffectGroup eg);  // Export UTgDeployable::execGetDamageReductionPerc(FFrame&, void* const)

native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgDeployable::execTakeHealthDamage(FFrame&, void* const)

native function bool CanBeLifestealInstigator();  // Export UTgDeployable::execCanBeLifestealInstigator(FFrame&, void* const)

native function bool CanBeLifestealTarget();  // Export UTgDeployable::execCanBeLifestealTarget(FFrame&, void* const)

native function bool CanTakeManaDamage();  // Export UTgDeployable::execCanTakeManaDamage(FFrame&, void* const)

native function TakeManaDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgDeployable::execTakeManaDamage(FFrame&, void* const)

native function bool CanTakeShieldDamage();  // Export UTgDeployable::execCanTakeShieldDamage(FFrame&, void* const)

native function bool CanUsePersonalShield();  // Export UTgDeployable::execCanUsePersonalShield(FFrame&, void* const)

native function int TakePersonalShieldDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);  // Export UTgDeployable::execTakePersonalShieldDamage(FFrame&, void* const)

native function bool ShieldDamageAppliesToHealth();  // Export UTgDeployable::execShieldDamageAppliesToHealth(FFrame&, void* const)

native function TakeStealthDamage(float fDamage);  // Export UTgDeployable::execTakeStealthDamage(FFrame&, void* const)

native function float GetDamageToLeaveStealth();  // Export UTgDeployable::execGetDamageToLeaveStealth(FFrame&, void* const)

native function HandleNotificationsForAI(float fStatChange, TgPawn InstigatorPawn);  // Export UTgDeployable::execHandleNotificationsForAI(FFrame&, void* const)

native function bool LocalPlayerHasLOS();  // Export UTgDeployable::execLocalPlayerHasLOS(FFrame&, void* const)

native function Vector GetLocation();  // Export UTgDeployable::execGetLocation(FFrame&, void* const)

native function float GetPropCurrentValue(int nPropIndex);  // Export UTgDeployable::execGetPropCurrentValue(FFrame&, void* const)

native function int GetPropIndex(int nPropId);  // Export UTgDeployable::execGetPropIndex(FFrame&, void* const)

native function float GetMarkedPercent(Actor InstigatorPawn);  // Export UTgDeployable::execGetMarkedPercent(FFrame&, void* const)

native function float GetMarkedPercentInhand(Actor InstigatorPawn);  // Export UTgDeployable::execGetMarkedPercentInhand(FFrame&, void* const)

native function OnViewTargetChanged(optional Actor aNewViewTarget);  // Export UTgDeployable::execOnViewTargetChanged(FFrame&, void* const)

native function TgEffectManager GetEffectManager();  // Export UTgDeployable::execGetEffectManager(FFrame&, void* const)

native function TgCombatActor.GameplayDesignType GetDesignType();  // Export UTgDeployable::execGetDesignType(FFrame&, void* const)

native function bool IsPet();  // Export UTgDeployable::execIsPet(FFrame&, void* const)

native function Actor GetPetOwner();  // Export UTgDeployable::execGetPetOwner(FFrame&, void* const)

native function TgGameplayCurvesSet GetCurrentGameplayCurveSet(TgGameplayCurvesSet.ECurveSetTypes Type);  // Export UTgDeployable::execGetCurrentGameplayCurveSet(FFrame&, void* const)

native function bool UseRangeFalloffCurve();  // Export UTgDeployable::execUseRangeFalloffCurve(FFrame&, void* const)

simulated event PostBeginPlay() { }

simulated function NotifyLocalPlayerTeamReceived() { }

simulated event int GetDeployableUniqueId() { }

simulated function Actor GetActorFromCombatActor() { }

simulated function GetAimAssistBounds(const out Vector ObserverLocation, out float Width, out float Height, out Vector Center) { }

event ApplyEquipEffects() { }

simulated function OnGetTaskForceNumber(TgSeqAct_GetTaskForceNumber Action) { }

simulated event StartFire() { }

simulated event StopFire() { }

simulated function DeviceFired() { }

simulated function ImpactInfo CalcDeviceFire(Vector StartTrace, Vector EndTrace, optional out array<ImpactInfo> ImpactList) { }

function InstantFireDeployable() { }

simulated function ApplyHit(out array<ImpactInfo> ImpactList) { }

function Projectile ProjectileFireDeployable() { }

simulated function Vector GetPhysicalFireStartLoc() { }

simulated function Vector GetPhysicalFireAimDirection(Vector fireLoc, Vector TargetLocation) { }

function FireAmmunitionDeployable() { }

simulated function IncrementFlashCount() { }

simulated function ClearFlashCount() { }

function SetFlashLocation(Vector NewLoc) { }

function ClearFlashLocation() { }

simulated event PlayFireFx() { }

simulated function FlashCountUpdated() { }

simulated function FlashLocationUpdated() { }

simulated function FlashFireCountUpdated() { }

simulated function bool IsFiring() { }

simulated function TimeDeviceFiring() { }

simulated event StartDeploy() { }

simulated function RefireCheckTimer() { }

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action) { }

simulated function CalcDeployPercentage() { }

function OnPersistTimerExpire() { }

event ResetPersistTime() { }

simulated function DeployComplete() { }

function NotifyDeployed() { }

function UpdateTimeToDeploySecs(float fValue) { }

simulated function TickDeploy(float DeltaSeconds) { }

simulated event name GetWhileAliveDisplayGroup() { }

simulated event name GetDestroyedDisplayGroup() { }

simulated event ActivateWhileAliveFx(bool bOn) { }

simulated event ActivateOnWhenDeployedFx(bool bOn) { }

simulated event ReplicatedEvent(name VarName) { }

event SpawningDeviceToggledOff() { }

simulated event DestroyIt(optional bool bSkipFx) { }

event AddBasedPawn(TgPawn basedPawn) { }

event RemoveBasedPawn(TgPawn basedPawn) { }

simulated function ClearBasedPawnList() { }

simulated function Tick(float DeltaSeconds) { }

simulated function Destroyed() { }

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

native function string GetDeployableNameById(int DeployableId);  // Export UTgDeployable::execGetDeployableNameById(FFrame&, void* const)

simulated event bool CanApplyEffects() { }

simulated event bool DamageShouldEnterCombat() { }

event InitReplicationInfo() { }

simulated function bool IsBoxExtentInRange(Vector BoxCenter, Vector BoxExtent) { }

simulated function ToggleSpectateFx(optional bool bForceDisable) { }

simulated event DeactivateSpectatorFxTimer() { }

simulated function PlayGenericTakeHit(Vector HitLocation, Vector HitNormal) { }

native function bool GetDefaultDecalDimensions(int nDecalId, int nSpecialFxId, out float Height, out float Width);  // Export UTgDeployable::execGetDefaultDecalDimensions(FFrame&, void* const)

simulated function UpdateDecalScale(TgSpecialFx Fx, float radiusScale) { }

simulated event CollisionChanged() { }

simulated event SetHUDOverlayDisplayMask(int dodm) { }

simulated event AddHUDOverlayDisplayMask(int dodm) { }

simulated event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi) { }

simulated event SetHUDOverlayState(TgObject.DeployableOverlayState dos) { }

simulated event SetHUDOverlayEnemyViewDist(float enemyViewDist) { }

simulated function float GetMaxAimAssistStacks() { }

auto state PreInit {}

state Deploy {}

state Active {}

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{}
