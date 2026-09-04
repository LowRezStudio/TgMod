class TgDeviceForm_Disengage extends TgDeviceForm;

var array<TgAnimNodeStanceTransitionerSynchronized> m_STSNodes3p;
var array<TgAnimNodeStanceTransitionerSynchronized> m_STSNodes1p;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeStanceTransitionerSynchronized AnimNode;

    super.Cache3PAnimNodes(SkelComp);
    m_STSNodes3p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeStanceTransitionerSynchronized', AnimNode)
    {
        m_STSNodes3p.AddItem(AnimNode);        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeStanceTransitionerSynchronized AnimNode;

    super.Cache1PAnimNodes(SkelComp);
    m_STSNodes1p.Length = 0;
    // End:0x56
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xA1
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeStanceTransitionerSynchronized', AnimNode)
    {
        m_STSNodes1p.AddItem(AnimNode);        
    }    
    //return;    
}

function SetStance(bool bActivated)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x8F [Loop If]
    if(I < m_STSNodes1p.Length)
    {
        // End:0x81
        if(m_STSNodes1p[I] != none)
        {
            m_STSNodes1p[I].ChangeStance(((bActivated) ? 1 : 0), false, bActivated);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x9A:

    // End:0x11E [Loop If]
    if(I < m_STSNodes3p.Length)
    {
        // End:0x110
        if(m_STSNodes3p[I] != none)
        {
            m_STSNodes3p[I].ChangeStance(((bActivated) ? 1 : 0), false, bActivated);
        }
        I++;
        // [Loop Continue]
        goto J0x9A;
    }
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    SetStance(true);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    SetStance(false);
    //return;    
}
