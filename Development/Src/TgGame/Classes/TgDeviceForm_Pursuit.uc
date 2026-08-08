class TgDeviceForm_Pursuit extends TgDeviceForm
    config(Engine);

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

function bool HasCachedLex() { }

simulated event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

simulated event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_LeftSlideSkelControlName1P="L_Slider"
    m_RightSlideSkelControlName1P="R_Slider"
    m_LeftSlideSkelControlName3P="L_Slider"
    m_RightSlideSkelControlName3P="R_Slider"
}
