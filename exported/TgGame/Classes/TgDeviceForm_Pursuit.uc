class TgDeviceForm_Pursuit extends TgDeviceForm;

var TgPawn_Lex m_CachedLex;
var name m_LeftSlideSkelControlName1P;
var name m_RightSlideSkelControlName1P;
var name m_LeftSlideSkelControlName3P;
var name m_RightSlideSkelControlName3P;
var SkelControlBase m_LeftSlideSkelControl1P;
var SkelControlBase m_RightSlideSkelControl1P;
var SkelControlBase m_LeftSlideSkelControl3P;
var SkelControlBase m_RightSlideSkelControl3P;
var float c_fPreviousLeftSlideStrength;
var float c_fPreviousRightSlideStrength;
var bool m_bCachedDualFireParity;

function bool HasCachedLex()
{
    // End:0x3A
    if(m_CachedLex == none)
    {
        // End:0x3A
        if(PawnOwner != none)
        {
            m_CachedLex = TgPawn_Lex(PawnOwner);
        }
    }
    return m_CachedLex != none;
    //return ReturnValue;    
}

simulated event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_LeftSlideSkelControl1P = SkelComp.FindSkelControl(m_LeftSlideSkelControlName1P);
    m_RightSlideSkelControl1P = SkelComp.FindSkelControl(m_RightSlideSkelControlName1P);
    //return;    
}

simulated event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    // End:0x4A
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_LeftSlideSkelControl3P = SkelComp.FindSkelControl(m_LeftSlideSkelControlName3P);
    m_RightSlideSkelControl3P = SkelComp.FindSkelControl(m_RightSlideSkelControlName3P);
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x1F5
    if(HasCachedLex())
    {
        m_bCachedDualFireParity = m_CachedLex.m_bFireLeftWeapon;
        m_CachedLex.c_bPursuitFiring = true;
        // End:0xE4
        if(m_LeftSlideSkelControl1P != none)
        {
            c_fPreviousLeftSlideStrength = m_LeftSlideSkelControl1P.ControlStrength;
            m_LeftSlideSkelControl1P.ControlStrength = 0.0000000;
        }
        // End:0x13F
        if(m_LeftSlideSkelControl3P != none)
        {
            c_fPreviousLeftSlideStrength = m_LeftSlideSkelControl3P.ControlStrength;
            m_LeftSlideSkelControl3P.ControlStrength = 0.0000000;
        }
        // End:0x19A
        if(m_RightSlideSkelControl1P != none)
        {
            c_fPreviousRightSlideStrength = m_RightSlideSkelControl1P.ControlStrength;
            m_RightSlideSkelControl1P.ControlStrength = 0.0000000;
        }
        // End:0x1F5
        if(m_RightSlideSkelControl3P != none)
        {
            c_fPreviousRightSlideStrength = m_RightSlideSkelControl3P.ControlStrength;
            m_RightSlideSkelControl3P.ControlStrength = 0.0000000;
        }
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x147
    if(HasCachedLex())
    {
        m_CachedLex.c_bPursuitFiring = false;
        m_CachedLex.m_bFireLeftWeapon = m_bCachedDualFireParity;
        // End:0xA2
        if(m_LeftSlideSkelControl1P != none)
        {
            m_LeftSlideSkelControl1P.ControlStrength = c_fPreviousLeftSlideStrength;
        }
        // End:0xD9
        if(m_LeftSlideSkelControl3P != none)
        {
            m_LeftSlideSkelControl3P.ControlStrength = c_fPreviousLeftSlideStrength;
        }
        // End:0x110
        if(m_RightSlideSkelControl1P != none)
        {
            m_RightSlideSkelControl1P.ControlStrength = c_fPreviousRightSlideStrength;
        }
        // End:0x147
        if(m_RightSlideSkelControl3P != none)
        {
            m_RightSlideSkelControl3P.ControlStrength = c_fPreviousRightSlideStrength;
        }
    }
    //return;    
}

defaultproperties
{
    m_LeftSlideSkelControlName1P="L_Slider"
    m_RightSlideSkelControlName1P="R_Slider"
    m_LeftSlideSkelControlName3P="L_Slider"
    m_RightSlideSkelControlName3P="R_Slider"
}