class TgDeviceForm_MinigunSpinUp extends TgDeviceForm;

var TgSkelCon_Spinner m_SpinnerSkelControl1P;
var TgSkelCon_Spinner m_SpinnerSkelControl3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_SpinnerSkelControl3P = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_SpinnerSkelControl3P = TgSkelCon_Spinner(SkelComp.FindSkelControl('Spinner'));
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    m_SpinnerSkelControl1P = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_SpinnerSkelControl1P = TgSkelCon_Spinner(SkelComp.FindSkelControl('Spinner'));
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x60
    if(m_SpinnerSkelControl1P != none)
    {
        m_SpinnerSkelControl1P.Spin(true);
    }
    // End:0x8F
    if(m_SpinnerSkelControl3P != none)
    {
        m_SpinnerSkelControl3P.Spin(true);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x42
    if(m_SpinnerSkelControl1P != none)
    {
        m_SpinnerSkelControl1P.Spin(false);
    }
    // End:0x71
    if(m_SpinnerSkelControl3P != none)
    {
        m_SpinnerSkelControl3P.Spin(false);
    }
    //return;    
}
