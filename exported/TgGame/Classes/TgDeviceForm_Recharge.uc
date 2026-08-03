class TgDeviceForm_Recharge extends TgDeviceForm_SpinnerWhileFiring;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    SetSpinnersRotationSpeedState(((bSuccessfulHit) ? 1 : 0));
    SetLockedForBlendNodes(bSuccessfulHit);
    super(TgDeviceForm).Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super(TgDeviceForm).StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    SetSpinnersActive(true);
    SetSpinnersRotationSpeedState(0);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    SetSpinnersActive(false);
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

defaultproperties
{
    m_SpinnerName="RechargeCrystal"
}