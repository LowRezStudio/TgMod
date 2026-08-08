class TgDevice_Telepunch extends TgDevice
    native(ChampDemon)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

var TgPawn_Demon m_CachedDemon;
var TgPawn_Character m_HitCharacter;
var bool m_bLiftApplied;
var bool m_bStealthApplied;
var float m_fLerpTime;
var float m_fTeleportPreferedDistance;
var float m_fTargetLockTime;

native function float GetRequiredEnergyToFire();  // Export UTgDevice_Telepunch::execGetRequiredEnergyToFire(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Telepunch::execCanDeviceFireNow(FFrame&, void* const)

native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm=false);  // Export UTgDevice_Telepunch::execShouldForce3P(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Telepunch::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

simulated function bool HasCachedDemon() { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

simulated event DeliverHit(ImpactInfo Impact) { }

simulated function float GetLerpToTargetTime(Vector vTargetLocation) { }

simulated function LerpToTarget(TgPawn_Character Target, Vector vTargetLocation, float fLerpTime) { }

simulated function FadeOutUltFx() { }

simulated function AltFirePostHitDelay() { }

reliable client simulated function ClientLerpToTarget(TgPawn_Character Target, Vector vTargetLocation, float fLerpTime) { }

simulated function ResetPostHitDelay() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool IsPostTeleportPreHitActive() { }

simulated function PostTeleportPreHit() { }

simulated function bool IsPostTeleportLockOutActive() { }

simulated function PostTeleportLockOut() { }

function ApplyLift(TgPawn_Character Target) { }

function RemoveLift(TgPawn_Character Target) { }

function ApplyStealth(TgPawn_Character Target) { }

function RemoveStealth(TgPawn_Character Target) { }

function DelayedSlam() { }

function ApplySlam(TgPawn_Character Target) { }

function ApplyHitToTarget(TgPawn_Character Target, int nHitSpecialSituationalType) { }

function RemoveHitFromTarget(TgPawn_Character Target, int nHitSpecialSituationalType) { }

simulated function ConfirmTelepunchTarget() { }

simulated function OnInterruptEvent() { }

simulated function AbortTelepunch() { }

state DeviceFiring {}

defaultproperties
{
    m_fTeleportPreferedDistance=6.0000000
    m_fTargetLockTime=0.2500000
    s_bIgnoreReceivedAim=true
    m_bDisableLagCompensation=true
}
