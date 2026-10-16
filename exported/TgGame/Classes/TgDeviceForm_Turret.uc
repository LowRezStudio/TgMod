class TgDeviceForm_Turret extends TgDeviceForm;

var SkelControlBase m_SKCTurretScale;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_SKCTurretScale = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_SKCTurretScale = SkelComp.FindSkelControl('Turret_Scale');
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x60
    if(m_SKCTurretScale != none)
    {
        m_SKCTurretScale.SetSkelControlActive(true);
    }
    //return;    
}

event CooldownComplete()
{
    super.CooldownComplete();
    // End:0x39
    if(m_SKCTurretScale != none)
    {
        m_SKCTurretScale.SetSkelControlActive(false);
    }
    //return;    
}
