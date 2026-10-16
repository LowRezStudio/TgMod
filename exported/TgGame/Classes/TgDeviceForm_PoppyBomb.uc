class TgDeviceForm_PoppyBomb extends TgDeviceForm;

var TgAnimNodeBlendList m_PoppyShakeBlendList1P;

simulated event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_PoppyShakeBlendList1P = TgAnimNodeBlendList(SkelComp.FindAnimNode('Poppy_Shake'));
    //return;    
}

simulated event EnterTargetingMode()
{
    super.EnterTargetingMode();
    // End:0x3E
    if(m_PoppyShakeBlendList1P != none)
    {
        m_PoppyShakeBlendList1P.SetActiveChild(1, 0.2000000);
    }
    //return;    
}

simulated event ExitTargetingMode()
{
    super.ExitTargetingMode();
    // End:0x3E
    if(m_PoppyShakeBlendList1P != none)
    {
        m_PoppyShakeBlendList1P.SetActiveChild(0, 0.2000000);
    }
    //return;    
}
