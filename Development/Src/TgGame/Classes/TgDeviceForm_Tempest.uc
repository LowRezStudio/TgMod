class TgDeviceForm_Tempest extends TgDeviceForm
    native(ChampGrohk)
    config(Engine);

var Actor m_BeamTarget1;
var Actor m_BeamTarget2;
var bool m_bBeamActive1;
var bool m_bBeamActive2;
var bool m_bBeamDirty1;
var bool m_bBeamDirty2;
var float m_fBeamStartTime1;
var float m_fBeamStartTime2;
var const float m_fBeamOnTime;

event StopFire(int nFireModeNum) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event SetTargetArcingBeamEffect(Actor Target) { }

function StopArcingBeamEffects() { }

defaultproperties
{
    m_fBeamOnTime=0.2000000
}
