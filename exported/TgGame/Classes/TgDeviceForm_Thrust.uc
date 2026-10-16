class TgDeviceForm_Thrust extends TgDeviceForm;

var array<TgAnimNodeBlendByDrogozFlying> m_FlyingBlendList1P;
var array<TgAnimNodeBlendByDrogozFlying> m_FlyingBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByDrogozFlying AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_FlyingBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByDrogozFlying', AnimNode)
    {
        m_FlyingBlendList3P.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByDrogozFlying AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_FlyingBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByDrogozFlying', AnimNode)
    {
        m_FlyingBlendList1P.AddItem(AnimNode);        
    }    
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local int I;

    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    I = 0;
    J0x3C:

    // End:0xA6 [Loop If]
    if(I < m_FlyingBlendList1P.Length)
    {
        // End:0x98
        if(m_FlyingBlendList1P[I] != none)
        {
            m_FlyingBlendList1P[I].m_bInThrust = true;
        }
        I++;
        // [Loop Continue]
        goto J0x3C;
    }
    I = 0;
    J0xB1:

    // End:0x11B [Loop If]
    if(I < m_FlyingBlendList3P.Length)
    {
        // End:0x10D
        if(m_FlyingBlendList3P[I] != none)
        {
            m_FlyingBlendList3P[I].m_bInThrust = true;
        }
        I++;
        // [Loop Continue]
        goto J0xB1;
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    local int I;

    super.StopFire(nFireModeNum);
    I = 0;
    J0x1E:

    // End:0x88 [Loop If]
    if(I < m_FlyingBlendList1P.Length)
    {
        // End:0x7A
        if(m_FlyingBlendList1P[I] != none)
        {
            m_FlyingBlendList1P[I].m_bInThrust = false;
        }
        I++;
        // [Loop Continue]
        goto J0x1E;
    }
    I = 0;
    J0x93:

    // End:0xFD [Loop If]
    if(I < m_FlyingBlendList3P.Length)
    {
        // End:0xEF
        if(m_FlyingBlendList3P[I] != none)
        {
            m_FlyingBlendList3P[I].m_bInThrust = false;
        }
        I++;
        // [Loop Continue]
        goto J0x93;
    }
    //return;    
}
