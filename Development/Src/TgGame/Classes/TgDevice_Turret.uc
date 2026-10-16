class TgDevice_Turret extends TgDevice_Pet
    native(ChampBarik)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var int m_FlameTurretID;
var int m_MegaTurretID;
var int m_LockdownTurretID;
var Vector m_SpawnLocationOverride;
var bool m_bLockdownIsOn;
var bool m_bHasFlamethrowerTurret;
var bool m_bHasMegaTurret;

native function UpgradeActiveTurrets();  // Export UTgDevice_Turret::execUpgradeActiveTurrets(FFrame&, void* const)

native function ToggleLockdownMode();  // Export UTgDevice_Turret::execToggleLockdownMode(FFrame&, void* const)

native function GetCachedAim(out AimData Aim);  // Export UTgDevice_Turret::execGetCachedAim(FFrame&, void* const)

native function int GetPetIDOverride(int PetIndex);  // Export UTgDevice_Turret::execGetPetIDOverride(FFrame&, void* const)

simulated function InterruptOtherDevices(TgPawn TgP) { }

simulated event ArmFlamethrowerMode(bool bEnable) { }

simulated event ArmMegaTurretMode(bool bEnable) { }

simulated event ArmLockdownMode(bool bEnable) { }

simulated function RevertFiremode() { }

defaultproperties
{
    m_FlameTurretID=2230
    m_MegaTurretID=2260
    m_LockdownTurretID=2151
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=70.0000000
}
