class TgDeviceForm_ShellShield extends TgDeviceForm
    native(ChampMakoa)
    config(Engine);

var bool m_bShouldBeActive;
var float m_fShieldActivationTime;
var float m_fShieldActivationPercent;

native function UpdateShieldParameters(float DeltaSeconds);  // Export UTgDeviceForm_ShellShield::execUpdateShieldParameters(FFrame&, void* const)

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event Generic1(optional byte byExtraData) { }

defaultproperties
{
    m_fShieldActivationTime=0.5000000
}
