class TgWeaponMeshActor_Sniper extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

simulated function SetLoopingMuzzleEffects(bool bSetActive, optional int nEquipSlot = 1)
{
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_Sniper.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}