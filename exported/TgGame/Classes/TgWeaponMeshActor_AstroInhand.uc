class TgWeaponMeshActor_AstroInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

simulated function Initialize1P(byte EquipPoint, int DeviceID, optional int MeshAsmId1P = -1)
{
    super.Initialize1P(EquipPoint, DeviceID, MeshAsmId1P);
    // End:0x6A
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.FxActivateGroup('Generic4', 0);
    }
    //return;    
}

simulated function Initialize3P(byte EquipPoint, int DeviceID)
{
    super.Initialize3P(EquipPoint, DeviceID);
    // End:0x58
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.FxActivateGroup('Generic4', 0);
    }
    //return;    
}

simulated function PlayFireFx(int nEquipSlot, int nFireMode)
{
    // End:0x30
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.m_bDoNotPlayFireParticlesIfHidden = false;
    }
    // End:0x60
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.m_bDoNotPlayFireParticlesIfHidden = false;
    }
    super.PlayFireFx(nEquipSlot, nFireMode);
    // End:0x124
    if(((nEquipSlot == 3) || nEquipSlot == 16) || nEquipSlot == 4)
    {
        // End:0xEA
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.FxDeactivateGroup('Generic4', 0);
        }
        // End:0x124
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.FxDeactivateGroup('Generic4', 0);
        }
    }
    //return;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    // End:0x30
    if(m_WeaponMesh1P != none)
    {
        m_WeaponMesh1P.m_bDoNotPlayFireParticlesIfHidden = true;
    }
    // End:0x60
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.m_bDoNotPlayFireParticlesIfHidden = true;
    }
    super.StopFireEffects(nEquipSlot);
    // End:0x1DA
    if(((nEquipSlot == 3) || nEquipSlot == 16) || nEquipSlot == 4)
    {
        // End:0x174
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.StopFire(true);
            m_WeaponMesh1P.FxActivateGroup('Generic4', 0);
            // End:0x174
            if(nEquipSlot == 3)
            {
                m_WeaponMesh1P.StopFire(true, nEquipSlot);
                m_WeaponMesh1P.FxActivateGroup('Generic2', 0, 0, nEquipSlot);
            }
        }
        // End:0x1DA
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.StopFire(true, nEquipSlot);
            m_WeaponMesh3P.FxActivateGroup('Generic4', 0);
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_AstroInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}