class TgDeviceForm_MendingSpirits extends TgDeviceForm;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local TgSpecialFx Fx;
    local int I;

    // End:0x254
    if((((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && c_Mesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        Fx = TgSpecialFx(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGet(((bSuccessfulHit) ? 'ContinuousHit' : 'ContinuousFire'), 0));
        // End:0x254
        if(Fx != none)
        {
            I = 0;
            J0x12C:

            // End:0x20B [Loop If]
            if(I < Fx.c_PSCList.Length)
            {
                // End:0x1FD
                if(Fx.c_PSCList[I].c_PSC != none)
                {
                    Fx.c_PSCList[I].c_PSC.SetVectorParameter('beamEnd', HitLocation);
                }
                I++;
                // [Loop Continue]
                goto J0x12C;
            }
            Fx.Activate();
            Fx.PlaySoundAt(HitLocation);
        }
    }
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}
