class TgPawn_Ruckus extends TgPawn_Character
    native(ChampRuckus)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var float m_fDamageAccumulator;
var repnotify bool r_bHexaFireFiring;
var const bool bEnableHoverWallClimb;
var bool bHoverWallClimb;
var bool m_bForceHover;
var bool m_bInstancedGemArmMaterials;
var bool m_bInstancedGemBodyMaterials;
var bool m_bRegisteredAudioCallbacks;
var bool m_bHasBoltGemFX;
var float r_fBarrelSpinRate;
var float r_fBarrelSpinFactor;
var TgDevice_RuckusInhand m_cachedRuckusInhand;
var TgDevice_HexaFireGuns m_CachedHexaFireGuns;
var TgDevice_Emitter m_CachedEmitter;
var TgDevice_RepulsorField m_CachedRepulsorField;
var float m_fDesiredHeight;
var float m_fKx;
var float m_fKv;
var float m_fHoverAccelMultiplier;
var array<MaterialInstanceConstant> m_ReplacementArmMICs;
var array<MaterialInstanceConstant> m_ReplacementBodyMICs;
var dword m_dwGemFXBusID;
var float m_fVGSMatBlue;
var TgSpecialFx m_IdleFX;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHexaFireFiring;
    if(bNetDirty) r_fBarrelSpinFactor, r_fBarrelSpinRate;
}

native function PawnOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_Ruckus::execPawnOnDamaged(FFrame&, void* const)

native function bool Is1PBodyOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn_Ruckus::execIs1PBodyOverlay(FFrame&, void* const)

native function bool Is1PWeaponOverlay(TgPawn.OverlayMICType Type);  // Export UTgPawn_Ruckus::execIs1PWeaponOverlay(FFrame&, void* const)

native function UpdateSkinBlueChannel();  // Export UTgPawn_Ruckus::execUpdateSkinBlueChannel(FFrame&, void* const)

native function bool IsNearAnyObjective();  // Export UTgPawn_Ruckus::execIsNearAnyObjective(FFrame&, void* const)

native function bool InstanceBodyMaterials();  // Export UTgPawn_Ruckus::execInstanceBodyMaterials(FFrame&, void* const)

native function bool InstanceArmMaterials();  // Export UTgPawn_Ruckus::execInstanceArmMaterials(FFrame&, void* const)

simulated function bool HasCachedRuckusInhand() { }

simulated function bool HasCachedHexaFireGuns() { }

simulated function bool HasCachedEmitter() { }

simulated function bool HasCachedRepulsorField() { }

simulated event ReplicatedEvent(name VarName) { }

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp=true) { }

simulated function PlayHexaFireEffects(bool bEnabled) { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated function bool ShouldStopWeaponMeshFireEffectsOnDeviceFormStopFire(int nEquipSlot) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated event BecomeViewTarget(PlayerController PC) { }

defaultproperties
{}
