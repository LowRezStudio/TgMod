class TgDeviceForm_HexaFire extends TgDeviceForm;

var TgAnimNodeBlendList m_LeftRocket1p;
var TgAnimNodeBlendList m_LeftRocket3p;
var TgAnimNodeBlendList m_RightRocket1p;
var TgAnimNodeBlendList m_RightRocket3p;
var bool m_bFiringRightRocket;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_LeftRocket3p = none;
    m_RightRocket3p = none;
    // End:0x60
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_LeftRocket3p = TgAnimNodeBlendList(SkelComp.FindAnimNode('LeftRocket'));
    m_RightRocket3p = TgAnimNodeBlendList(SkelComp.FindAnimNode('RightRocket'));
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    m_LeftRocket1p = none;
    m_RightRocket1p = none;
    // End:0x60
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_LeftRocket1p = TgAnimNodeBlendList(SkelComp.FindAnimNode('LeftRocket'));
    m_RightRocket1p = TgAnimNodeBlendList(SkelComp.FindAnimNode('RightRocket'));
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0x101
    if(!m_bFiringRightRocket)
    {
        // End:0xAF
        if(m_LeftRocket1p != none)
        {
            m_LeftRocket1p.SetActiveChild(1, m_LeftRocket1p.GetBlendTime(1));
        }
        // End:0xFE
        if(m_LeftRocket3p != none)
        {
            m_LeftRocket3p.SetActiveChild(1, m_LeftRocket3p.GetBlendTime(1));
        }        
    }
    else
    {
        // End:0x150
        if(m_RightRocket1p != none)
        {
            m_RightRocket1p.SetActiveChild(1, m_RightRocket1p.GetBlendTime(1));
        }
        // End:0x19F
        if(m_RightRocket3p != none)
        {
            m_RightRocket3p.SetActiveChild(1, m_RightRocket3p.GetBlendTime(1));
        }
    }
    m_bFiringRightRocket = !m_bFiringRightRocket;
    //return;    
}

function SetAllInactive()
{
    // End:0x4F
    if(m_LeftRocket1p != none)
    {
        m_LeftRocket1p.SetActiveChild(0, m_LeftRocket1p.GetBlendTime(0));
    }
    // End:0x9E
    if(m_LeftRocket3p != none)
    {
        m_LeftRocket3p.SetActiveChild(0, m_LeftRocket3p.GetBlendTime(0));
    }
    // End:0xED
    if(m_RightRocket1p != none)
    {
        m_RightRocket1p.SetActiveChild(0, m_RightRocket1p.GetBlendTime(0));
    }
    // End:0x13C
    if(m_RightRocket3p != none)
    {
        m_RightRocket3p.SetActiveChild(0, m_RightRocket3p.GetBlendTime(0));
    }
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    SetAllInactive();
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    DeactivateFxGroup('UltimateActivated');
    ActivateFxGroup('UltimateActivated');
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    SetAllInactive();
    //return;    
}

defaultproperties
{
    m_bFiringRightRocket=true
}