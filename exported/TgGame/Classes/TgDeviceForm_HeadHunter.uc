class TgDeviceForm_HeadHunter extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPawn_Kinessa Kinessa;

    Kinessa = TgPawn_Kinessa(PawnOwner);
    // End:0xF3
    if(Kinessa != none)
    {
        Kinessa.c_bHeadHunterFiring = true;
        // End:0xF3
        if(Kinessa.Mesh != none)
        {
            Kinessa.Mesh.FxActivateIndependant('UltimateActivated', 0, Kinessa.Location, Vector(Kinessa.Rotation));
        }
    }
    // End:0x1BA
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('KinessaUltActive', 0);
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    local TgPawn_Kinessa Kinessa;

    Kinessa = TgPawn_Kinessa(PawnOwner);
    // End:0x4C
    if(Kinessa != none)
    {
        Kinessa.c_bHeadHunterFiring = false;
    }
    // End:0x111
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('KinessaUltActive', 0);
    }
    super.StopFire(nFireModeNum);
    //return;    
}
