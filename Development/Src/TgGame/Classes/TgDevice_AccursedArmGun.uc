class TgDevice_AccursedArmGun extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation)
    config(Engine);

var TgDevice_AccursedArm m_AccursedArm;

native function bool RequiresAmmoToFire();  // Export UTgDevice_AccursedArmGun::execRequiresAmmoToFire(FFrame&, void* const)

native function bool ShouldTreatAmmoAsCharges();  // Export UTgDevice_AccursedArmGun::execShouldTreatAmmoAsCharges(FFrame&, void* const)

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_AccursedArmGun::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated function FireAmmunition() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated event OnLinkDevice(TgPawn TgP) { }

simulated event OnUnlinkDevice(TgPawn TgP) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=13254
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceAccursedArm'
}
