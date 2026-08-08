class TgDeviceForm_KineticBurst extends TgDeviceForm
    native(ChampFlak)
    config(Engine);

var float RampUpTime;
var float RampDownTime;
var MaterialInstanceConstant GlowMIC;

native function bool HasCachedMIC();  // Export UTgDeviceForm_KineticBurst::execHasCachedMIC(FFrame&, void* const)

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Cooldown(int nFireModeNum) { }

defaultproperties
{
    RampUpTime=1.0000000
    RampDownTime=0.5000000
}
