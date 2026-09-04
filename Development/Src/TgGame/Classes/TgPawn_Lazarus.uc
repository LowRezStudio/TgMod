class TgPawn_Lazarus extends TgPawn_Character
    native(ChampLazarus)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var TgDevice_SelfResurrection m_SelfResurrectionDevice;
var TgDevice_AbsorptionField m_AbsorptionFieldDevice;
var TgDevice_ChargeBurst m_ChargeBurstDevice;
var Controller m_Killer;
var repnotify bool r_bShouldRez;
var bool m_bHasAppliedUltimate;
var repnotify float r_fEnergy;
var repnotify float r_fAccumulatedDamage;
var int m_nChargeNumber;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_bShouldRez, r_fAccumulatedDamage, r_fEnergy;
}

simulated event ReplicatedEvent(name VarName) { }

native function PawnOnDamaged(out OnDamagedParams Params);  // Export UTgPawn_Lazarus::execPawnOnDamaged(FFrame&, void* const)

native function bool HasCachedResurrectionDevice();  // Export UTgPawn_Lazarus::execHasCachedResurrectionDevice(FFrame&, void* const)

native function bool HasCachedAbsorptionDevice();  // Export UTgPawn_Lazarus::execHasCachedAbsorptionDevice(FFrame&, void* const)

native function bool HasCachedChargeBurstDevice();  // Export UTgPawn_Lazarus::execHasCachedChargeBurstDevice(FFrame&, void* const)

native function bool ShouldBeFirstPersonThisTick();  // Export UTgPawn_Lazarus::execShouldBeFirstPersonThisTick(FFrame&, void* const)

native function IncrementDamageCharge(float pDamageAmt);  // Export UTgPawn_Lazarus::execIncrementDamageCharge(FFrame&, void* const)

native function UpdateChargeNumber();  // Export UTgPawn_Lazarus::execUpdateChargeNumber(FFrame&, void* const)

native function OnPawnDied();  // Export UTgPawn_Lazarus::execOnPawnDied(FFrame&, void* const)

native function OnDismount();  // Export UTgPawn_Lazarus::execOnDismount(FFrame&, void* const)

event bool ShouldScoreKill() { }

simulated event FakeDeath(Controller Killer) { }

defaultproperties
{}
