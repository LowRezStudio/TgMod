class TgDeviceForm_HexaFireGuns extends TgDeviceForm
    config(Engine);

var TgSkelCon_Spinner m_SpinnerSkelControl1P;
var TgSkelCon_Spinner m_SpinnerSkelControl3P;
var int m_nNextGunFired;
var name c_nmSocket1;
var name c_nmSocket2;
var name c_nmSocket3;
var name c_nmSocket4;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel3P;

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function CacheAnimNodesHelper(TgSkeletalMeshComponent SkelComp, out TgSkelControlSingleBone_PistonBarrel LowerRightBarrel, out TgSkelControlSingleBone_PistonBarrel UpperRightBarrel, out TgSkelControlSingleBone_PistonBarrel LowerLeftBarrel, out TgSkelControlSingleBone_PistonBarrel UpperLeftBarrel, out TgSkelCon_Spinner Spinner) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Vector GetTracerSocketLocation() { }

defaultproperties
{
    m_nNextGunFired=1
    c_nmSocket1="WSO_Emit_01"
    c_nmSocket2="WSO_Emit_02"
    c_nmSocket3="WSO_Emit_03"
    c_nmSocket4="WSO_Emit_04"
    m_bUseImpactFXOverride=true
}
