class TgDeviceForm_RendSoul extends TgDeviceForm;

simulated function ActivateFx(TgSpecialFx Fx, float fHealStacks)
{
    local int I;

    // End:0x11A
    if(Fx != none)
    {
        Fx.Activate();
        I = 0;
        J0x3B:

        // End:0x11A [Loop If]
        if(I < Fx.c_PSCList.Length)
        {
            // End:0x10C
            if(Fx.c_PSCList[I].c_PSC != none)
            {
                Fx.c_PSCList[I].c_PSC.SetFloatParameter('HealStacks', fHealStacks);
            }
            I++;
            // [Loop Continue]
            goto J0x3B;
        }
    }
    //return;    
}

event Generic1(optional byte byExtraData)
{
    local int I;
    local array<Object> FxList;

    // End:0x22A
    if(PawnOwner != none)
    {
        // End:0x22A
        if(PawnOwner.m_WeaponMesh != none)
        {
            // End:0x12F
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                FxList = PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGetAll('Generic1', 0);
                I = 0;
                J0xD8:

                // End:0x12F [Loop If]
                if(I < FxList.Length)
                {
                    ActivateFx(TgSpecialFx(FxList[I]), float(byExtraData));
                    I++;
                    // [Loop Continue]
                    goto J0xD8;
                }
            }
            // End:0x22A
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                FxList = PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxGetAll('Generic1', 0);
                I = 0;
                J0x1D3:

                // End:0x22A [Loop If]
                if(I < FxList.Length)
                {
                    ActivateFx(TgSpecialFx(FxList[I]), float(byExtraData));
                    I++;
                    // [Loop Continue]
                    goto J0x1D3;
                }
            }
        }
    }
    //return;    
}
