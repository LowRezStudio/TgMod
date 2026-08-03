class TgDeviceForm_ViktorInhand extends TgDeviceForm;

event SetAmmoBlendNodesAmount(int nAmmoAmt, optional bool bTickOnly = false)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.SetAmmoBlendNodesAmount(nAmmoAmt, bTickOnly);
    // End:0x1F4
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        I = 0;
        J0x9D:

        // End:0x1F4 [Loop If]
        if(I < PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials.Length)
        {
            MIC = MaterialInstanceConstant(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.Materials[I]);
            // End:0x1E6
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('Percent', float(nAmmoAmt) / 30.0000000);
                MIC.SetScalarParameterValue('LowAmmo', ((nAmmoAmt <= 10) ? 1.0000000 : 0.0000000));
            }
            I++;
            // [Loop Continue]
            goto J0x9D;
        }
    }
    //return;    
}
