class TgWeaponMeshActor_YingInhandProj extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint = true)
{
    super.InitializeForWeapon(EquipPoint, DeviceID, bClearEquipPoint);
    // End:0x67
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.FxActivateGroup('MirrorActive', 0);
    }
    //return;    
}

simulated function SetLoopingMuzzleEffects(bool bSetActive, optional int nEquipSlot = 1)
{
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_YingInhandProj.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}