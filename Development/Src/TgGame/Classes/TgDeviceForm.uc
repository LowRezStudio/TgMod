class TgDeviceForm extends Object
    native(Devices)
    config(Engine)
    dependson(TgDevice, TgObject, TgPawn);

const DEFAULT_FX_RADIUS = 240.0f;

struct transient ModeData {
    var init float c_fBuildupTime;
    var init bool c_bContinuousFire;
    var init bool c_FxInstantFire;
    var init name c_nmOffhandAnimationType;
    var init bool c_bScaleFireAnimsWithRefire;
    var init bool c_bInterruptAnimOnRefire;
    var init float c_fEffectRadius;
    var init float c_fMaxRange;
    var init CameraAnim c_WhileFiringCameraAnim;
    structdefaultproperties {}
};

var TgPawn PawnOwner;
var EquipDeviceInfo c_EquipDeviceInfo;
var int m_nDeviceType;
var TgObject.DeviceTargetMode m_eTargetingMode;
var TgDevice.ETargetingModeStatus c_eTargetingModeStatus;
var bool c_bDeployed;
var bool c_bHandDevice;
var bool c_bDisableDefaultTimelapseRecovery;
var bool c_bIsTransitioningToNewMode;
var bool c_bTargetingModeEnabled;
var bool c_bTargeterInitializedThisTick;
var bool c_bTargeterIsInWorldDPG;
var bool c_bUseInstigatorMesh;
var bool c_bIsInHand;
var bool m_bInitializingAssets;
var bool m_bLoopWhileFiringCameraAnim;
var bool m_bUseImpactFXOverride;
var bool m_bRecoilTimerActive;
var array<AnimSet> c_PawnAnimSetOverrideList;
var array<ModeData> ModeDatas;
var native Pointer m_pAmSetup;
var export editinline MeshComponent c_Mesh;
var export editinline MeshComponent c_AttachedMesh;
var protected export editinline MeshComponent c_ThirdPersonMesh;
var protected export editinline TgSkeletalMeshComponent c_FirstPersonMesh;
var name c_nmMountPoint;
var name FormState;
var int c_nFireMode;
var int c_nEquipSlot;
var float c_fLastReceivedRefireTime;
var int c_nLastFxMode;
var TgSkeletalMeshActor c_TargetingModeMeshIndicator;
var TgSpecialFx c_TargetingModeFx;
var AimData c_TargetingAim;
var int c_nTargetingModeFxId;
var float c_fRemainingTransitionTime;
var float c_fTotalTransitionTime;
var Actor m_LockedTarget;
var ObjectReferencer m_AssetReference;
var Actor m_OwnerActor;
var array<TgAnimNodeBlendByAbilitySimple> m_AbilityBlendList1P;
var array<TgAnimNodeBlendByAbilitySimple> m_AbilityBlendList3P;
var array<TgAnimNodeChannelFire> m_ChannelFireBlendList1P;
var array<TgAnimNodeChannelFire> m_ChannelFireBlendList3P;
var array<TgAnimNodeTargeting> m_TargetingBlendList1P;
var array<TgAnimNodeTargeting> m_TargetingBlendList3P;
var array<TgAnimNodeToggleWithTransition> m_ToggleTransitionNodes1P;
var array<TgAnimNodeToggleWithTransition> m_ToggleTransitionNodes3P;
var array<TgAnimBlendByAmmo> m_AmmoBlendList1P;
var array<TgAnimBlendByAmmo> m_AmmoBlendList3P;
var CameraAnimInst m_WhileFiringCameraAnimInst;
var float m_fWhileFiringCameraAnimBlendInTime;
var float m_fWhileFiringCameraAnimBlendOutTime;
var native const transient Pointer m_RandomShotSpreadStream;
var int m_nLastSetShotSpreadSeed;
var TgGameplayCurves m_GameplayCurves;
var float m_fRecoilTimer;

native function SetFireMode(int nMode);  // Export UTgDeviceForm::execSetFireMode(FFrame&, void* const)

native function AttachDevice_DA(SkeletalMeshComponent ParentMesh, MeshComponent AttachedMesh, optional name nmSocket);  // Export UTgDeviceForm::execAttachDevice_DA(FFrame&, void* const)

native function bool AttachInHandDevice_DA(bool bFirstPerson);  // Export UTgDeviceForm::execAttachInHandDevice_DA(FFrame&, void* const)

native function DetachDevice_DA(SkeletalMeshComponent ParentMesh, MeshComponent AttachedMesh);  // Export UTgDeviceForm::execDetachDevice_DA(FFrame&, void* const)

native function DetachInHandDevice_DA();  // Export UTgDeviceForm::execDetachInHandDevice_DA(FFrame&, void* const)

native function InitCameraViewpoint();  // Export UTgDeviceForm::execInitCameraViewpoint(FFrame&, void* const)

native function bool LogDebugInfo();  // Export UTgDeviceForm::execLogDebugInfo(FFrame&, void* const)

native function ActivateFxGroup(name nmGroup);  // Export UTgDeviceForm::execActivateFxGroup(FFrame&, void* const)

native function TgSpecialFx ActivateFxIndependent(name nmGroup, optional bool bSkipActivate, optional ParticleChannelContainer PSysChannels);  // Export UTgDeviceForm::execActivateFxIndependent(FFrame&, void* const)

native function DeactivateFxGroup(name nmGroup);  // Export UTgDeviceForm::execDeactivateFxGroup(FFrame&, void* const)

native function int GetFormIndex();  // Export UTgDeviceForm::execGetFormIndex(FFrame&, void* const)

native function Destruct(Vector vLocation);  // Export UTgDeviceForm::execDestruct(FFrame&, void* const)

native function ResetAfterRagDoll();  // Export UTgDeviceForm::execResetAfterRagDoll(FFrame&, void* const)

native function TgSpecialFx SpawnSpecialFxIndependent(int nSpecialFxId, optional ParticleChannelContainer PSysChannels);  // Export UTgDeviceForm::execSpawnSpecialFxIndependent(FFrame&, void* const)

native function UpdateTargetingModeStatus(TgDevice.ETargetingModeStatus Status, const out AimData Aim);  // Export UTgDeviceForm::execUpdateTargetingModeStatus(FFrame&, void* const)

native function UpdateTargetingModeStatusForFX(TgSpecialFx Fx, TgDevice.ETargetingModeStatus Status, const out AimData Aim);  // Export UTgDeviceForm::execUpdateTargetingModeStatusForFX(FFrame&, void* const)

native function UpdateTargetingModeLocation(Vector NewLocation, Rotator NewRotation, optional float DistanceScale=1.0000000);  // Export UTgDeviceForm::execUpdateTargetingModeLocation(FFrame&, void* const)

native function UpdateTargetingList(const out array<ImpactInfo> ImpactList);  // Export UTgDeviceForm::execUpdateTargetingList(FFrame&, void* const)

native function RecalculateMaterial();  // Export UTgDeviceForm::execRecalculateMaterial(FFrame&, void* const)

native function UpdateFirstPersonWeaponFOV(optional Vector2D Resolution);  // Export UTgDeviceForm::execUpdateFirstPersonWeaponFOV(FFrame&, void* const)

native function bool UsesTargetingMode();  // Export UTgDeviceForm::execUsesTargetingMode(FFrame&, void* const)

native function bool CanPlayBasicHitFx(const TgPawn Target);  // Export UTgDeviceForm::execCanPlayBasicHitFx(FFrame&, void* const)

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

simulated function OnReload(float fReloadTime) { }

event SetAmmoBlendNodesAmount(int nAmmoAmt, optional bool bTickOnly=false) { }

function SetAbilityBlendNodesActive(bool bActive, bool bOnFire, optional bool bIsInterrupted=false) { }

function DisableChannelFireBlendNodes() { }

event Generic1(optional byte byExtraData) { }

event Generic2(optional byte byExtraData) { }

event Generic3(optional byte byExtraData) { }

event Generic4(optional byte byExtraData) { }

event Generic5(optional byte byExtraData) { }

event OnCreated() { }

event SetSourceArcingBeamEffect(Actor Source) { }

event SetTargetArcingBeamEffect(Actor Target) { }

event PlayImpactEffects(Vector HitLocation, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional Vector FireOrigin, optional float fHitTraceDistOverride=-1.0000000, optional bool bGenerateUpdatedHitLocation=false) { }

simulated function ParticleSystemDone(ParticleSystemComponent PSC) { }

event BeginActive() { }

event BeginDeviceTakingOut(optional bool PlayEquipAnim=true) { }

function EndDevicePuttingDown() { }

native function InitializeTargetingModeFX();  // Export UTgDeviceForm::execInitializeTargetingModeFX(FFrame&, void* const)

simulated event EnterTargetingMode() { }

simulated event NotifyExitTargetingMode(bool bDeployed) { }

simulated event NotifyEnterTargetingMode() { }

simulated event NotifyTargetingModeStatusChange() { }

simulated event ExitTargetingMode() { }

event EnterTargeting() { }

event InterruptTargeting() { }

event FireHoldFull(bool bIsFull) { }

event BuildUp(int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional float fBuildupTime=0.0000000) { }

simulated function TgDeviceForm InHandWeaponForm() { }

simulated event bool IsCurrentInHandWeapon() { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

function StartWhileFiringCameraAnim(PlayerController PC, optional int nFireMode=0) { }

event StopWhileFiringCameraAnim(PlayerController PC, bool bImmediate) { }

function OnEndViewTarget(PlayerController PC) { }

event StopFire(int nFireModeNum) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event FireMulti(Vector vAimStart, Vector vAimDir, int nFireMode, const out byte hitRanges[20], float fMaxRange, int nSeed, float fSpreadAngle, int nNumShots, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event FireMultiUnpacked(array<Vector> vHitLocations, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime, optional float fPackedDistanceUnit=0.0000000) { }

native function RecoverFireMultiHitLocations(out array<Vector> vHitLocations, const out Vector vAimStart, const out Vector vAimDir, const out byte hitRanges[20], float fDistUnit, int nSeed, float fSpreadAngle, int nNumShots);  // Export UTgDeviceForm::execRecoverFireMultiHitLocations(FFrame&, void* const)

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }

event Cooldown(int nFireModeNum) { }

event CooldownComplete() { }

event DoInterrupt() { }

event DeviceAnimNotify() { }

simulated event AttachAndDeploy_DA() { }

simulated function EndCurrentState() { }

simulated event GotoFormState(name NewState) { }

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive) { }

simulated event SetToggleState(bool IsActive) { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }

simulated event OnRetrieveAnimDone() { }

simulated event OnDestroyed() { }

defaultproperties
{
    c_fTotalTransitionTime=0.5000000
    m_fWhileFiringCameraAnimBlendInTime=0.2000000
    m_fWhileFiringCameraAnimBlendOutTime=0.2000000
}
