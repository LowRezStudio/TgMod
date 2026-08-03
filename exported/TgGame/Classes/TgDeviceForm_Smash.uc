class TgDeviceForm_Smash extends TgDeviceForm;

var array<TgAnimNodeBlendByAbilitySmash> m_SmashBlendList1P;
var array<TgAnimNodeBlendByAbilitySmash> m_SmashBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilitySmash AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_SmashBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilitySmash', AnimNode)
    {
        m_SmashBlendList3P.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilitySmash AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_SmashBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilitySmash', AnimNode)
    {
        m_SmashBlendList1P.AddItem(AnimNode);        
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
    if(I < m_SmashBlendList1P.Length)
    {
        // End:0x96
        if(m_SmashBlendList1P[I] != none)
        {
            m_SmashBlendList1P[I].BeginChargeUp();
        }
        I++;
        // [Loop Continue]
        goto J0x3C;
    }
    I = 0;
    J0xAF:

    // End:0x117 [Loop If]
    if(I < m_SmashBlendList3P.Length)
    {
        // End:0x109
        if(m_SmashBlendList3P[I] != none)
        {
            m_SmashBlendList3P[I].BeginChargeUp();
        }
        I++;
        // [Loop Continue]
        goto J0xAF;
    }
    // End:0x153
    if(c_Mesh != none)
    {
        c_Mesh.FxActivateGroup('Generic1', 0);
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local int I;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    I = 0;
    J0x5C:

    // End:0xC4 [Loop If]
    if(I < m_SmashBlendList1P.Length)
    {
        // End:0xB6
        if(m_SmashBlendList1P[I] != none)
        {
            m_SmashBlendList1P[I].Attack();
        }
        I++;
        // [Loop Continue]
        goto J0x5C;
    }
    I = 0;
    J0xCF:

    // End:0x137 [Loop If]
    if(I < m_SmashBlendList3P.Length)
    {
        // End:0x129
        if(m_SmashBlendList3P[I] != none)
        {
            m_SmashBlendList3P[I].Attack();
        }
        I++;
        // [Loop Continue]
        goto J0xCF;
    }
    // End:0x171
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('Generic1', 0);
    }
    //return;    
}
