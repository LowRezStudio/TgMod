class TgWeaponMeshActor_Lance extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    m_WeaponMesh1PClass=Class'TgGame.TgSkeletalMeshComponent_WeaponFirstPersonLance'
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_Lance.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}