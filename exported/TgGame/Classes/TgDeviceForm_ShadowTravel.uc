class TgDeviceForm_ShadowTravel extends TgDeviceForm;

event StopFire(int nFireModeNum)
{
    local int I;
    local TgSpecialFx spawnedFX;

    super.StopFire(nFireModeNum);
    // End:0x227
    if(PawnOwner != none)
    {
        // End:0x227
        if(PawnOwner.m_WeaponMesh != none)
        {
            // End:0x227
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic2', 0);
                spawnedFX = TgSpecialFx(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic2', 0));
                // End:0x227
                if(spawnedFX != none)
                {
                    I = 0;
                    J0x158:

                    // End:0x227 [Loop If]
                    if(I < spawnedFX.c_PSCList.Length)
                    {
                        // End:0x219
                        if(spawnedFX.c_PSCList[I].c_pCameraEffect != none)
                        {
                            spawnedFX.c_PSCList[I].c_pCameraEffect.m_bShowOnlyIn1P = false;
                        }
                        I++;
                        // [Loop Continue]
                        goto J0x158;
                    }
                }
            }
        }
    }
    //return;    
}
