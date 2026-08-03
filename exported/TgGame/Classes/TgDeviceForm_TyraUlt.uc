class TgDeviceForm_TyraUlt extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x26F
    if((PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
    {
        PawnOwner.m_WeaponMesh.m_TracerName = 'TracerBeamA';
        // End:0x189
        if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('FireUlt');
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetFireLoopDisplayGroup('FireLoopB', 'FireLoopTailSound');
        }
        // End:0x26F
        if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.SetFireDisplayGroup('FireUlt');
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.SetFireLoopDisplayGroup('FireLoopB', 'FireLoopTailSound');
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x251
    if((PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
    {
        PawnOwner.m_WeaponMesh.m_TracerName = 'TracerBeam';
        // End:0x16B
        if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetFireDisplayGroup('Fire');
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetFireLoopDisplayGroup('FireLoop', 'FireLoopTailSound');
        }
        // End:0x251
        if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.SetFireDisplayGroup('Fire');
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.SetFireLoopDisplayGroup('FireLoop', 'FireLoopTailSound');
        }
    }
    //return;    
}
