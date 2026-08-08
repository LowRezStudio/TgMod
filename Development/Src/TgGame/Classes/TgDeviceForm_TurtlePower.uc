class TgDeviceForm_TurtlePower extends TgDeviceForm
    native(ChampMakoa)
    config(Engine);

var bool m_bShouldBeActive;
var float m_fRageActivationTime;
var float m_fRageActivationPercent;

native function UpdateRageMeshVisibility(float DeltaSeconds);  // Export UTgDeviceForm_TurtlePower::execUpdateRageMeshVisibility(FFrame&, void* const)

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_fRageActivationTime=0.5000000
}
