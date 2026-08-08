class TgDeviceForm_HeatHaze extends TgDeviceForm
    native(ChampLongbow)
    config(Engine);

var bool m_bShouldBeActive;
var float m_fUltActivationTime;
var float m_fUltActivationPercent;

native function UpdateUltMeshVisibility(float DeltaSeconds);  // Export UTgDeviceForm_HeatHaze::execUpdateUltMeshVisibility(FFrame&, void* const)

native function UpdateMeshMICValue(MeshComponent MeshComp);  // Export UTgDeviceForm_HeatHaze::execUpdateMeshMICValue(FFrame&, void* const)

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_fUltActivationTime=0.5000000
}
