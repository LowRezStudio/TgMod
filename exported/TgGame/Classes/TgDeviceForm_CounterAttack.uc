class TgDeviceForm_CounterAttack extends TgDeviceForm
    native(ChampDarklord);

var array<TgAnimBlendByPaladinsCharacter> m_DarklordNodes3p;
var array<TgAnimBlendByPaladinsCharacter> m_DarklordNodes1p;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimBlendByPaladinsCharacter AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_DarklordNodes3p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPaladinsCharacter', AnimNode)
    {
        m_DarklordNodes3p.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimBlendByPaladinsCharacter AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_DarklordNodes1p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByPaladinsCharacter', AnimNode)
    {
        m_DarklordNodes1p.AddItem(AnimNode);        
    }    
    //return;    
}

event Generic1(optional byte byExtraData)
{
    local int I;
    local bool bPlayCounterToIdleAnim;
    local TgAnimBlendByPaladinsCharacter_Darklord darklordAnimNode;

    bPlayCounterToIdleAnim = int(byExtraData) == int(1);
    I = 0;
    J0x28:

    // End:0x109 [Loop If]
    if(I < m_DarklordNodes3p.Length)
    {
        // End:0xFB
        if(m_DarklordNodes3p[I] != none)
        {
            darklordAnimNode = TgAnimBlendByPaladinsCharacter_Darklord(m_DarklordNodes3p[I]);
            // End:0xBA
            if(darklordAnimNode != none)
            {
                darklordAnimNode.PlayCounterAttackAnim(bPlayCounterToIdleAnim);                
            }
            else
            {
                // End:0xFB
                if(bPlayCounterToIdleAnim)
                {
                    m_DarklordNodes3p[I].OnDeviceStartFire(18, c_fLastReceivedRefireTime);
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x28;
    }
    I = 0;
    J0x114:

    // End:0x1F5 [Loop If]
    if(I < m_DarklordNodes1p.Length)
    {
        // End:0x1E7
        if(m_DarklordNodes1p[I] != none)
        {
            darklordAnimNode = TgAnimBlendByPaladinsCharacter_Darklord(m_DarklordNodes1p[I]);
            // End:0x1A6
            if(darklordAnimNode != none)
            {
                darklordAnimNode.PlayCounterAttackAnim(bPlayCounterToIdleAnim);                
            }
            else
            {
                // End:0x1E7
                if(bPlayCounterToIdleAnim)
                {
                    m_DarklordNodes1p[I].OnDeviceStartFire(18, c_fLastReceivedRefireTime);
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x114;
    }
    super.Generic1(byExtraData);
    //return;    
}
