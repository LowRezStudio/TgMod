class TgDeviceForm_BarrageFire extends TgDeviceForm
    native(ChampViktor)
    config(Engine);

var Actor m_LastTargetedActor;
var TgPlayerController m_CachedActiveOverlayController;
var float m_fIncomingTime;
var int m_nActiveShotNum;
var float m_fIncomingTimeCurrentShot;
var float m_fRemainingDurationPct;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

simulated event EnterTargetingMode() { }

simulated event ExitTargetingMode() { }

native function UpdateBinocularSettings();  // Export UTgDeviceForm_BarrageFire::execUpdateBinocularSettings(FFrame&, void* const)

native function bool UsesTargetingMode();  // Export UTgDeviceForm_BarrageFire::execUsesTargetingMode(FFrame&, void* const)

defaultproperties
{
    m_fIncomingTime=1.0000000
}
