class TgDeviceForm_Lockdown extends TgDeviceForm;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0x1D2
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        I = 0;
        J0xCC:

        // End:0x1D2 [Loop If]
        if(I < PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials.Length)
        {
            MIC = MaterialInstanceConstant(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials[I]);
            // End:0x1C4
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('Percent', 1.0000000);
            }
            I++;
            // [Loop Continue]
            goto J0xCC;
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.StopFire(nFireModeNum);
    // End:0x194
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        I = 0;
        J0x8E:

        // End:0x194 [Loop If]
        if(I < PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials.Length)
        {
            MIC = MaterialInstanceConstant(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials[I]);
            // End:0x186
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('Percent', 0.0000000);
            }
            I++;
            // [Loop Continue]
            goto J0x8E;
        }
    }
    //return;    
}
