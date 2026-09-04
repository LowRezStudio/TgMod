class TgDeviceForm_Salvo extends TgDeviceForm
    native(ChampDrogoz)
    config(Engine);

var array<TgAnimNodeBlendList> m_SalvoBlendList1P;
var array<TgAnimNodeBlendList> m_SalvoBlendList3P;
var bool m_bSalvoLightShouldBlink;
var bool m_bSalvoLightIsOn;
var float m_fLastLightChangeTime;
var float m_fMinLightChangeTime;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_fMinLightChangeTime=0.3000000
}
