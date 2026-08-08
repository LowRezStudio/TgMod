class TgDeviceForm_RuckusInhand extends TgDeviceForm
    native(ChampRuckus)
    config(Engine);

var bool m_bFiredFromLeftGun;
var bool m_bFiredFromTopBarrel;
var bool m_bPlayingSpinnerSound;
var bool m_bPlayingFireLoopSound;
var bool m_bIsFiring;
var TgSkelCon_Spinner m_SpinnerSkelControl1P;
var TgSkelCon_Spinner m_SpinnerSkelControl3P;
var name c_nmSocketLeft;
var name c_nmSocketRight;
var () float m_fLoopingSoundThreshold;
var float m_fLastSpinConfirmationTimestamp;
var float m_fSpinConfirmationCooldown;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel3P;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function CacheAnimNodesHelper(TgSkeletalMeshComponent SkelComp, out TgSkelControlSingleBone_PistonBarrel LowerRightBarrel, out TgSkelControlSingleBone_PistonBarrel UpperRightBarrel, out TgSkelControlSingleBone_PistonBarrel LowerLeftBarrel, out TgSkelControlSingleBone_PistonBarrel UpperLeftBarrel, out TgSkelCon_Spinner Spinner) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Vector GetTracerSocketLocation() { }

defaultproperties
{
    m_bFiredFromTopBarrel=true
    c_nmSocketLeft="WSO_Emit_02"
    c_nmSocketRight="WSO_Emit_01"
    m_fLoopingSoundThreshold=0.9500000
    m_fSpinConfirmationCooldown=1.0000000
}
