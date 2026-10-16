class TgDevice_Leap extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

var bool m_bLeapInLookDirection;
var bool m_bDidJustLeap;

native function float GetFiringPreHitDelay(optional int nMode=-1);  // Export UTgDevice_Leap::execGetFiringPreHitDelay(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Leap::execMustBeOnGroundToFire(FFrame&, void* const)

simulated event bool CanBeCanceled() { }

simulated function SetLeapParams(out float scaleLateral, out float scaleVertical, out float additiveLateral, out float additiveVertical) { }

state DeviceFiring {}

defaultproperties
{
    m_bLeapInLookDirection=true
    m_bCarryPreFireToPostFire=false
    m_bForce3PViewWhileFiring=true
}
