class TgDeviceForm_MountMech extends TgDeviceForm_Mount;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPawn_Character TgPC;

    // End:0x117
    if(PawnOwner != none)
    {
        // End:0xBF
        if((PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.SetScale(0.0000000);
        }
        TgPC = TgPawn_Character(PawnOwner);
        // End:0x117
        if(TgPC != none)
        {
            TgPC.FxActivateGroupBody('Mount_Alt', 0);
        }
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    local TgPawn_Character TgPC;

    // End:0x114
    if(PawnOwner != none)
    {
        // End:0xBC
        if((PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.SetScale(1.0000000);
        }
        TgPC = TgPawn_Character(PawnOwner);
        // End:0x114
        if(TgPC != none)
        {
            TgPC.FxActivateGroupBody('Mount_Alt', 0);
        }
    }
    super.StopFire(nFireModeNum);
    //return;    
}
