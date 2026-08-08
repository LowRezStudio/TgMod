class TgDevice_Compensator extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated function ApplyRecoilReduction(TgDevice Dev, bool bShouldApply) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14127
}
