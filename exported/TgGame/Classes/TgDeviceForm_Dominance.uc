class TgDeviceForm_Dominance extends TgDeviceForm
    native(ChampFlak);

var SkelControlBase m_SKCFlagScale;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_SKCFlagScale = SkelComp.FindSkelControl('FlagScale');
    //return;    
}

simulated event HideFlag()
{
    // End:0x2F
    if(m_SKCFlagScale != none)
    {
        m_SKCFlagScale.SetSkelControlActive(true);
    }
    //return;    
}

simulated event ShowFlag()
{
    // End:0x2F
    if(m_SKCFlagScale != none)
    {
        m_SKCFlagScale.SetSkelControlActive(false);
    }
    //return;    
}
