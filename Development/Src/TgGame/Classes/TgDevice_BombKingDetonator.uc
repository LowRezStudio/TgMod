class TgDevice_BombKingDetonator extends TgDevice
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var bool m_bDetonatePoppyBombs;
var bool m_bInFalseFireRetryPeriod;
var float m_fFalseFireRetryStart;
var const float m_fFalseFireRetryTime;

native function TgDeviceFire GetCurrentFire();  // Export UTgDevice_BombKingDetonator::execGetCurrentFire(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_BombKingDetonator::execCanDeviceFireNow(FFrame&, void* const)

simulated function bool ShouldInterruptMount() { }

simulated event HandleFalseFireRecory() { }

state DeviceFiring {}

defaultproperties
{
    m_fFalseFireRetryTime=0.3000000
}
