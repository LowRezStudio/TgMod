class TgWeaponMeshActor_BarrierTankInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool m_bHasFinishedBurst;

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime) { }

simulated function StopFireEffects(int nEquipSlot) { }

defaultproperties
{}
