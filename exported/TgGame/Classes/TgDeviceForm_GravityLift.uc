class TgDeviceForm_GravityLift extends TgDeviceForm
    native(ChampAstro);

event SetLockedForBlendNodes(bool bLocked)
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
