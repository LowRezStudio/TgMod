class TgDeviceForm_Scout extends TgDeviceForm;

var SkelControlBase m_SKCBirdScale;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_SKCBirdScale = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_SKCBirdScale = SkelComp.FindSkelControl('Bird_Scale');
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x60
    if(m_SKCBirdScale != none)
    {
        m_SKCBirdScale.SetSkelControlActive(true);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x42
    if(m_SKCBirdScale != none)
    {
        m_SKCBirdScale.SetSkelControlActive(false);
    }
    //return;    
}
