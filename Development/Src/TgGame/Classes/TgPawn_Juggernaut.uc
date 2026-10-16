class TgPawn_Juggernaut extends TgPawn_LanePusher
    native(Pawns)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var bool m_bNextLaserLeft;
var bool m_bInGenericFirePosture;

native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);  // Export UTgPawn_Juggernaut::execDeviceAdjustDamage(FFrame&, void* const)

native function bool IsDebuffImmune();  // Export UTgPawn_Juggernaut::execIsDebuffImmune(FFrame&, void* const)

native function PawnOnPreDamageMitigation(TgPawn attacker, TgEffectGroup eg, out float fDamage, int nPropertyId);  // Export UTgPawn_Juggernaut::execPawnOnPreDamageMitigation(FFrame&, void* const)

simulated event bool PostPawnSetup() { }

simulated event ChangeFirePosture() { }

simulated function OnDeviceFormStartFire(int nEquipSlot, float FireDuration, int nFireMode, optional int nAmmoRemaining) { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

defaultproperties
{}
