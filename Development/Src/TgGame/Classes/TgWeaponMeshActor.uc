class TgWeaponMeshActor extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

const TG_EQP_POINT_MAX = 33;

enum TG_PLAY_FIRE_EFFECT_ON {
    START_FIRE,  // 0
    Fire,  // 1
    NEVER,  // 2
};

enum EFirstPersonWeaponAttachState {
    FPAS_NeedsUpdate,  // 0
    FPAS_Attached,  // 1
    FPAS_Detached,  // 2
};

struct QueuedImpactEffect {
    var Vector HitLocation;
    var bool bSuccessfulHit;
    var Actor HitActor;
    var Vector HitNormal;
    var Vector FireOrigin;
    var int nEquipSlot;
    structdefaultproperties {}
};

var TgPawn m_OwningPawn;
var const Class<TgSkeletalMeshComponent_Weapon> m_WeaponMesh1PClass;
var export editinline TgSkeletalMeshComponent_Weapon m_WeaponMesh1P;
var const Class<TgSkeletalMeshComponent_Weapon> m_WeaponMesh3PClass;
var export editinline TgSkeletalMeshComponent_Weapon m_WeaponMesh3P;
var array<TgAnimNodeSimpleTransitioner> m_SimpleTransitionerNodes1P;
var array<TgAnimBlendByFireMode> m_DeviceModeBlendNodes;
var array<TgAnimNodeFitToDuration> m_FitToDurationNodes;
var array<TgAnimBlendByPaladinsCharacter> m_PaladinsCharacterNodes;
var array<TgAnimNodeTriggerCameraAnim> m_TriggerCameraAnimNodes;
var TgAnimNodeSlot PoseTransitioner;
var array<TgAnimNodeSimpleTransitioner> m_PawnMeshSimpleTransitionerNodes;
var array<TgAnimNodeFitToDuration> m_PawnMeshFitToDurationNodes;
var array<TgAnimBlendByPaladinsCharacter> m_PawnMeshPaladinsCharacterNodes;
var array<TgAnimNodeTriggerCameraAnim> m_PawnMeshTriggerCameraAnimNodes;
var int m_nEquipSlot;
var int m_nDeviceId;
var int m_MeshAsmId1P;
var int m_MeshAsmId3P;
var Class<TgDevice> m_WeaponClass;
var TgWeaponMeshActor.TG_PLAY_FIRE_EFFECT_ON m_PlayFireEffectsOn[33];
var TgObject.TG_EQUIP_POINT m_ActiveEquipPoint;
var transient TgWeaponMeshActor.EFirstPersonWeaponAttachState Current1pAttachState;
var bool m_bShouldLoopingMuzzleTrace;
var bool m_bUseSocketForCameraAttach;
var bool m_bProceduralBob;
var protected bool m_bIsFOVZoomed;
var bool m_bFlourishBlocked;
var transient bool m_bIsHoldingBeacon;
var bool m_bWasViewTargetLastTick;
var bool m_bUseCameraAnims;
var bool c_bEnemyMatLoaded;
var export editinline TgSkeletalMeshComponent m_HandsMesh;
var export editinline TgSkeletalMeshComponent m_HeadMesh1P;
var Vector2D m_v2WeaponLagAimOffset;
var (WeaponLag) Vector2D m_nMaxWeaponLag;
var (WeaponLag) Vector2D m_v2WeaponLagInterpSpeed;
var (WeaponLag) Vector2D m_v2WeaponLagSmoothingFactor;
var Rotator m_rLastRotation;
var () editinline TgCameraShake m_FireCameraShake;
var int m_nTracerCounter;
var () int m_nTracerFrequency;
var name m_TracerName;
var float m_fTracerLifetime;
var name m_HitTargetName;
var name m_HitWallName;
var () float m_BeamEmitterEndPointOffset;
var const int m_nBeaconMeshId;
var array<TgSkelCon_HitReaction> m_HitReactionSkelControls;
var array<QueuedImpactEffect> m_QueuedImpactEffects;

native function GetMeshAsmIds(int DeviceID, out int MeshId1P, out int MeshId3P);  // Export UTgWeaponMeshActor::execGetMeshAsmIds(FFrame&, void* const)

native function string GetWeaponClassById(int DeviceID);  // Export UTgWeaponMeshActor::execGetWeaponClassById(FFrame&, void* const)

native function UpdateReticule();  // Export UTgWeaponMeshActor::execUpdateReticule(FFrame&, void* const)

native function UpdateHandsMesh();  // Export UTgWeaponMeshActor::execUpdateHandsMesh(FFrame&, void* const)

native function UpdateHeadMesh1P();  // Export UTgWeaponMeshActor::execUpdateHeadMesh1P(FFrame&, void* const)

native function NativeInit(byte EquipPoint, int DeviceID);  // Export UTgWeaponMeshActor::execNativeInit(FFrame&, void* const)

native function TgDevice GetDefaultDevice();  // Export UTgWeaponMeshActor::execGetDefaultDevice(FFrame&, void* const)

native function bool IsFriendlyWithLocalPawn();  // Export UTgWeaponMeshActor::execIsFriendlyWithLocalPawn(FFrame&, void* const)

native function ForceRecalculateMaterial();  // Export UTgWeaponMeshActor::execForceRecalculateMaterial(FFrame&, void* const)

native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);  // Export UTgWeaponMeshActor::execRecalculateMaterial(FFrame&, void* const)

native function SetLocationForWeapon(Vector NewLocation, Actor OwningPawn);  // Export UTgWeaponMeshActor::execSetLocationForWeapon(FFrame&, void* const)

native function float CheckOcclusion();  // Export UTgWeaponMeshActor::execCheckOcclusion(FFrame&, void* const)

native function int GetFxOverrideFor(int nBaseFXID);  // Export UTgWeaponMeshActor::execGetFxOverrideFor(FFrame&, void* const)

simulated event PostBeginPlay() { }

simulated function bool IsFirstPerson() { }

simulated event Destroyed() { }

simulated function ClearEquipPoint(byte EquipPoint) { }

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint=true) { }

simulated function FixUpReferencesToWeaponMesh1P(SkeletalMeshComponent WeaponMesh) { }

simulated function FixUpReferencesToPawnMesh(SkeletalMeshComponent PawnMesh) { }

simulated function Initialize1P(byte EquipPoint, int DeviceID, optional int MeshAsmId1P=-1) { }

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp) { }

simulated function Initialize3P(byte EquipPoint, int DeviceID) { }

simulated event SetActiveWeapon(byte EquipPoint, int DeviceID, Class<TgDevice> WeaponClass, WeaponMeshSwapStrategy SwapStrategy) { }

simulated function PlayPutaway(TgObject.TG_EQUIP_POINT eqp, int DeviceID, Class<TgDevice> WeaponClass) { }

simulated function PlayRetrieve(WeaponMeshSwapStrategy SwapStrategy) { }

simulated function OnBehindViewUpdated(bool bNewBehindView) { }

native simulated function Set1PAttachState(TgWeaponMeshActor.EFirstPersonWeaponAttachState NewAttachState);  // Export UTgWeaponMeshActor::execSet1PAttachState(FFrame&, void* const)

simulated function Toggle1PVisibility(bool bVisible) { }

simulated exec function PlayWeaponQuickRetrieve() { }

simulated function ToggleHoldingBeacon(bool bHolding) { }

simulated function bool CanUseCameraBone() { }

simulated function Tick(float DeltaTime) { }

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate=false) { }

simulated function Rotator ApplyRotationModifier(Rotator inRot) { }

simulated function GetAllFireLoopParticleSystemComponents(out array<ParticleSystemComponent> FireLoopParticles, optional int nEquipSlot=1) { }

simulated function UpdateBeamEffects(int nEquipSlotToUpdate) { }

simulated function bool ShouldUpdateBeamEffects(int nEquipSlot) { }

simulated function UpdateFireLoopBeamParams(bool bHasEndPoint, Vector HitLocation, optional int nEquipSlot=1) { }

simulated function bool GetAccurateBeamTarget(out Vector HitLocation, int nEquipSlot) { }

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot) { }

simulated function PlayTargetingEffects(int nEquipSlot) { }

simulated function PlayBuildupEffects(int nEquipSlot) { }

simulated function AttackComboTimeout() { }

simulated function SetLoopingMuzzleEffects(bool bSetActive, optional int nEquipSlot=1) { }

simulated function bool ShowAsLocallyOwned() { }

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function PlayFireFx(int nEquipSlot, int nFireMode) { }

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime) { }

simulated function PlayDeviceFiredEffects(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function Play3pFireAimedFX() { }

simulated function TgSkeletalMeshComponent Get3PWeaponMesh() { }

simulated function PlayTracerEffects(Vector endLocation, optional int nEquipSlot=0) { }

simulated function OverrideTracerFireLoc(out Vector fireLoc) { }

simulated function QueueInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot) { }

simulated function PlayQueuedInstantHitImpactEffects() { }

simulated function GetFiringSocketTransform(out Vector fireLoc, out Rotator FireRot) { }

simulated function TgSpecialFx GetMeshFx(name nmDisplayGroupName, optional int nEquipSlot=0) { }

simulated function PlayInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot) { }

simulated function Vector GetClampedEmitDirection(Vector vInput, Vector vReflect) { }

simulated function StopFireEffects(int nEquipSlot) { }

simulated event PlayReload(int nEqpPoint, float ReloadTime, int AmmoRemainingInClip, optional int ReloadType=0) { }

simulated event PlayFlourish() { }

simulated function BlockFlourish(bool bBlock) { }

simulated function SetFOVZoomed(bool bEnabled) { }

simulated function SetFireLoopDisplayGroup(name FireLoop, name FireLoopTailSound) { }

simulated function ResetFireLoopDisplayGroup() { }

simulated function AddWeaponLeading(Rotator NewRotation, Rotator OldRotation, float DeltaTime) { }

simulated function OnPolymorphChanged(bool bDead) { }

simulated function NotifyLocalPlayerTeamReceived() { }

native function CacheHitReactionSkelControls();  // Export UTgWeaponMeshActor::execCacheHitReactionSkelControls(FFrame&, void* const)

native function PlayHitReaction(TgObject.RecoilHitDir Dir, float DamageAmount);  // Export UTgWeaponMeshActor::execPlayHitReaction(FFrame&, void* const)

simulated function Hide3PWeaponMesh() { }

simulated function Unhide3PWeaponMesh() { }

simulated function PlayMeshTransitionAnimation(WeaponMeshSwapStrategy SwapStrategy, TgObject.TG_EQUIP_POINT eqp, TgDevice PreviousTargetingDevice, TgDevice NextTargetingDevice) { }

defaultproperties
{}
