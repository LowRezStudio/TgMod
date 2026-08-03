class TgDeviceForm_FragGrenade extends TgDeviceForm;

var array<TgAnimNodeBlendByAbilityFragGrenade> m_FragGrenadeBlendList1P;
var array<TgAnimNodeBlendByAbilityFragGrenade> m_FragGrenadeBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityFragGrenade AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_FragGrenadeBlendList3P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityFragGrenade', AnimNode)
    {
        m_FragGrenadeBlendList3P.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilityFragGrenade AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_FragGrenadeBlendList1P.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilityFragGrenade', AnimNode)
    {
        m_FragGrenadeBlendList1P.AddItem(AnimNode);        
    }    
    //return;    
}

event Generic1(optional byte byExtraData)
{
    local int I;

    I = 0;
    J0x0C:

    // End:0x74 [Loop If]
    if(I < m_FragGrenadeBlendList1P.Length)
    {
        // End:0x66
        if(m_FragGrenadeBlendList1P[I] != none)
        {
            m_FragGrenadeBlendList1P[I].StartThrow();
        }
        I++;
        // [Loop Continue]
        goto J0x0C;
    }
    I = 0;
    J0x7F:

    // End:0xE7 [Loop If]
    if(I < m_FragGrenadeBlendList3P.Length)
    {
        // End:0xD9
        if(m_FragGrenadeBlendList3P[I] != none)
        {
            m_FragGrenadeBlendList3P[I].StartThrow();
        }
        I++;
        // [Loop Continue]
        goto J0x7F;
    }
    //return;    
}

event DoInterrupt()
{
    local int I;

    super.DoInterrupt();
    I = 0;
    J0x15:

    // End:0x7D [Loop If]
    if(I < m_FragGrenadeBlendList1P.Length)
    {
        // End:0x6F
        if(m_FragGrenadeBlendList1P[I] != none)
        {
            m_FragGrenadeBlendList1P[I].OnInterrupt();
        }
        I++;
        // [Loop Continue]
        goto J0x15;
    }
    I = 0;
    J0x88:

    // End:0xF0 [Loop If]
    if(I < m_FragGrenadeBlendList3P.Length)
    {
        // End:0xE2
        if(m_FragGrenadeBlendList3P[I] != none)
        {
            m_FragGrenadeBlendList3P[I].OnInterrupt();
        }
        I++;
        // [Loop Continue]
        goto J0x88;
    }
    //return;    
}
