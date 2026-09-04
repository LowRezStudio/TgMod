class TgDeviceForm_Hover extends TgDeviceForm;

var TgAnimNodeBlendList m_HoverBlendList1P;
var TgAnimNodeBlendList m_HoverBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_HoverBlendList3P = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_HoverBlendList3P = TgAnimNodeBlendList(SkelComp.FindAnimNode('Hover'));
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    m_HoverBlendList1P = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_HoverBlendList1P = TgAnimNodeBlendList(SkelComp.FindAnimNode('Hover'));
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x211
    if((PawnOwner != none) && PawnOwner.Mesh != none)
    {
        // End:0xC5
        if(m_HoverBlendList3P == none)
        {
            m_HoverBlendList3P = TgAnimNodeBlendList(PawnOwner.Mesh.FindAnimNode('Hover'));
        }
        // End:0xF9
        if(m_HoverBlendList3P != none)
        {
            m_HoverBlendList3P.SetActiveChild(1, 0.2000000);
        }
        // End:0x1DD
        if(m_HoverBlendList1P == none)
        {
            // End:0x1DD
            if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_HoverBlendList1P = TgAnimNodeBlendList(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FindAnimNode('Hover'));
            }
        }
        // End:0x211
        if(m_HoverBlendList1P != none)
        {
            m_HoverBlendList1P.SetActiveChild(1, 0.2000000);
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x47
    if(m_HoverBlendList3P != none)
    {
        m_HoverBlendList3P.SetActiveChild(0, 0.2000000);
    }
    // End:0x7B
    if(m_HoverBlendList1P != none)
    {
        m_HoverBlendList1P.SetActiveChild(0, 0.2000000);
    }
    //return;    
}
