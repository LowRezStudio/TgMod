class TgDevice_PrincessF extends TgDevice_Charge
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_cachedSupportDevice;
var (dash) int m_nEyeheightAdjustmentWhileSliding;
var float m_fEyeHeightSmoothFactor;

simulated function bool HasCachedSupportDevice() { }

simulated function Rotator GetChargeDirection() { }

state DeviceFiring {}

defaultproperties
{
    m_fEyeHeightSmoothFactor=4.0000000
    m_bCanLeftClickCancel=false
}
