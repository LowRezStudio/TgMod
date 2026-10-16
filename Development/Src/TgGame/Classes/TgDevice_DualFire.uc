class TgDevice_DualFire extends TgDevice_ToggleWithLockout
    hidecategories(Navigation)
    config(Engine);

simulated delegate InterruptFiringDelegate();

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=13218
}
