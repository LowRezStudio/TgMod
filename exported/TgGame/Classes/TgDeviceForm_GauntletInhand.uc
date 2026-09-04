class TgDeviceForm_GauntletInhand extends TgDeviceForm_SpinnerWhileFiring;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    SetSpinnersRotationSpeedState(((bSuccessfulHit) ? 1 : 0));
    super(TgDeviceForm).Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    SetLockedForBlendNodes(bSuccessfulHit);
    // End:0x28E
    if(!bSuccessfulHit)
    {
        // End:0x28E
        if((PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
        {
            // End:0x1A9
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('FireFailed', 0);
                PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('FireFailed', 0);
            }
            // End:0x28E
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('FireFailed', 0);
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('FireFailed', 0);
            }
        }
    }
    //return;    
}

function SetLockedForBlendNodes(bool bLocked)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x7D [Loop If]
    if(I < m_ChannelFireBlendList1P.Length)
    {
        // End:0x6F
        if(m_ChannelFireBlendList1P[I] != none)
        {
            m_ChannelFireBlendList1P[I].SetLockedBase(bLocked);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x88:

    // End:0xFA [Loop If]
    if(I < m_ChannelFireBlendList3P.Length)
    {
        // End:0xEC
        if(m_ChannelFireBlendList3P[I] != none)
        {
            m_ChannelFireBlendList3P[I].SetLockedBase(bLocked);
        }
        I++;
        // [Loop Continue]
        goto J0x88;
    }
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super(TgDeviceForm).StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    SetSpinnersActive(true);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    SetSpinnersActive(false);
    //return;    
}

defaultproperties
{
    m_SpinnerName="Stones"
}