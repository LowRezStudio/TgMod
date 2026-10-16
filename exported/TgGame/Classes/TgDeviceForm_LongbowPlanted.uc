class TgDeviceForm_LongbowPlanted extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0xF8
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic2', 0);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0xD8
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic2', 0);
    }
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    // End:0xCF
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic2', 0);
    }
    //return;    
}
