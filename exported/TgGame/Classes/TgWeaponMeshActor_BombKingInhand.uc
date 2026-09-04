class TgWeaponMeshActor_BombKingInhand extends TgWeaponMeshActor
    native
    notplaceable
    hidecategories(Navigation);

var bool m_bPlayPoppyDetonateAnimation;

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_BombKingInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}