class TgDeviceForm_HeroicLeap extends TgDeviceForm;

var TgAnimNodeBlendList m_BlendList1P;
var TgAnimNodeBlendList m_BlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_BlendList3P = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_BlendList3P = TgAnimNodeBlendList(SkelComp.FindAnimNode('Jump'));
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    m_BlendList1P = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_BlendList1P = TgAnimNodeBlendList(SkelComp.FindAnimNode('Jump'));
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x26C
    if(((PawnOwner != none) && PawnOwner.Mesh != none) && PawnOwner.Mesh != none)
    {
        // End:0x120
        if(m_BlendList3P == none)
        {
            // End:0x120
            if((PawnOwner != none) && PawnOwner.Mesh != none)
            {
                m_BlendList3P = TgAnimNodeBlendList(PawnOwner.Mesh.FindAnimNode('Jump'));
            }
        }
        // End:0x154
        if(m_BlendList3P != none)
        {
            m_BlendList3P.SetActiveChild(1, 0.2000000);
        }
        // End:0x238
        if(m_BlendList1P == none)
        {
            // End:0x238
            if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_BlendList1P = TgAnimNodeBlendList(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FindAnimNode('Jump'));
            }
        }
        // End:0x26C
        if(m_BlendList1P != none)
        {
            m_BlendList1P.SetActiveChild(1, 0.2000000);
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x47
    if(m_BlendList3P != none)
    {
        m_BlendList3P.SetActiveChild(0, 0.2000000);
    }
    // End:0x7B
    if(m_BlendList1P != none)
    {
        m_BlendList1P.SetActiveChild(0, 0.2000000);
    }
    //return;    
}
