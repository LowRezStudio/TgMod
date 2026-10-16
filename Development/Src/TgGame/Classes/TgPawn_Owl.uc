class TgPawn_Owl extends TgPawn_Character
    native(ChampOwl)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var bool m_bUseSecondWeapon;
var bool m_bSwappingWeapons;
var bool c_bUseSecondDeathAnim;
var const int m_nAltInhandSlot;
var const int m_nAltAltfireSlot;
var float m_fOwlStealthJuice;
var float m_fMaxOwlStealthJuice;
var TgDevice_OwlStealth m_CachedOwlStealth;

native function TgDevice GetCurrentInhandDevice();  // Export UTgPawn_Owl::execGetCurrentInhandDevice(FFrame&, void* const)

native function int GetUISkillEqpSlotOverride(int nEquipSlot, optional bool bAltSlot=false);  // Export UTgPawn_Owl::execGetUISkillEqpSlotOverride(FFrame&, void* const)

native function bool IsInScope();  // Export UTgPawn_Owl::execIsInScope(FFrame&, void* const)

native function OnPawnDied();  // Export UTgPawn_Owl::execOnPawnDied(FFrame&, void* const)

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc) { }

simulated event name GetDeathAnimName() { }

simulated function SwapToSecondWeapon(bool bSecondWeaponActive) { }

simulated function FinishedWeaponSwap() { }

simulated function ShowReticle(bool bShow) { }

simulated event SetTargetingDevice(TgDevice Dev, WeaponMeshSwapStrategy SwapStrategy) { }

simulated event InterruptInhandReload() { }

simulated event bool StartAction(TgDevice Dev, optional out TgObject.EDeviceFailType failType, optional bool bUpdateTimeStamp=true) { }

event InterruptStealth(optional TgDevice OriginatingDevice) { }

event ApplyStealthServer(TgPawn.STEALTH_TYPE eStealthed, optional float fRate=9999.0000000, optional bool bForce=false) { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

event ModifyStealthJuice(int nAmtModified, optional bool bSendToClient=false) { }

reliable client simulated function ClientModifyStealthJuice(int nAmtModified) { }

simulated function bool ShouldUseScopeSensitivity() { }

native function UpdateOwlStealthFX(float fPrevStealthJuice, float fCurrentStealthJuice);  // Export UTgPawn_Owl::execUpdateOwlStealthFX(FFrame&, void* const)

defaultproperties
{}
