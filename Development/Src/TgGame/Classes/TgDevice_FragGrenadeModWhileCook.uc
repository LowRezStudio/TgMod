class TgDevice_FragGrenadeModWhileCook extends TgDevice
    hidecategories(Navigation)
    config(Engine);

function ApplyHitSpecial() { }

function RemoveHitSpecial() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14149
}
