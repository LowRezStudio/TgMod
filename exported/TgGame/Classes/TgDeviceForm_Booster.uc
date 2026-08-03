class TgDeviceForm_Booster extends TgDeviceForm;

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

    // End:0xA4 [Loop If]
    if(I < m_FlyingBlendList1P.Length)
    {
        // End:0x96
        if(m_FlyingBlendList1P[I] != none)
        {
            m_FlyingBlendList1P[I].StartedBooster();
        }
        I++;
        // [Loop Continue]
        goto J0x3C;
    }
    I = 0;
    J0xAF:

    // End:0x117 [Loop If]
    if(I < m_FlyingBlendList3P.Length)
    {
        // End:0x109
        if(m_FlyingBlendList3P[I] != none)
        {
            m_FlyingBlendList3P[I].StartedBooster();
        }
        I++;
        // [Loop Continue]
        goto J0xAF;
    }
    // End:0x153
    if(c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('Drogoz_Thruster', 0);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    local int I;

    super.StopFire(nFireModeNum);
    I = 0;
    J0x1E:

    // End:0x86 [Loop If]
    if(I < m_FlyingBlendList1P.Length)
    {
        // End:0x78
        if(m_FlyingBlendList1P[I] != none)
        {
            m_FlyingBlendList1P[I].StoppedBooster();
        }
        I++;
        // [Loop Continue]
        goto J0x1E;
    }
    I = 0;
    J0x91:

    // End:0xF9 [Loop If]
    if(I < m_FlyingBlendList3P.Length)
    {
        // End:0xEB
        if(m_FlyingBlendList3P[I] != none)
        {
            m_FlyingBlendList3P[I].StoppedBooster();
        }
        I++;
        // [Loop Continue]
        goto J0x91;
    }
    // End:0x133
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Drogoz_Thruster', 0);
    }
    //return;    
}
