class TgDevice_BarricadeDome extends TgDevice
    native(ChampBarik)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var Vector m_TurretSpawnLocation;
var int m_FlameTurretID;

native function GetCachedAim(out AimData Aim);  // Export UTgDevice_BarricadeDome::execGetCachedAim(FFrame&, void* const)

native function int GetPetIDOverride(int PetIndex);  // Export UTgDevice_BarricadeDome::execGetPetIDOverride(FFrame&, void* const)

function InitMaxHealth() { }

simulated function InterruptOtherDevices(TgPawn TgP) { }

state DeviceFiring {}

defaultproperties
{
    m_FlameTurretID=2230
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=5000.0000000
}
