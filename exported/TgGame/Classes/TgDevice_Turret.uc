class TgDevice_Turret extends TgDevice_Pet
    native(ChampBarik)
    hidecategories(Navigation);

var int m_FlameTurretID;
var int m_MegaTurretID;
var int m_LockdownTurretID;
var Vector m_SpawnLocationOverride;
var bool m_bLockdownIsOn;
var bool m_bHasFlamethrowerTurret;
var bool m_bHasMegaTurret;

// Export UTgDevice_Turret::execUpgradeActiveTurrets(FFrame&, void* const)
native function UpgradeActiveTurrets();

// Export UTgDevice_Turret::execToggleLockdownMode(FFrame&, void* const)
native function ToggleLockdownMode();

// Export UTgDevice_Turret::execGetCachedAim(FFrame&, void* const)
native function GetCachedAim(out AimData Aim);

// Export UTgDevice_Turret::execGetPetIDOverride(FFrame&, void* const)
native function int GetPetIDOverride(int PetIndex);

simulated function InterruptOtherDevices(TgPawn TgP)
{
    super(TgDevice).InterruptOtherDevices(TgP);
    // End:0x5F
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x5F
        if(TgP != none)
        {
            TgP.InterruptDeviceFiringByClass(Class'TgGame.TgDevice_RocketBoots');
        }
    }
    //return;    
}

simulated event ArmFlamethrowerMode(bool bEnable)
{
    // End:0x1E
    if(m_bLockdownIsOn || m_bHasMegaTurret)
    {
        return;
    }
    // End:0x3A
    if(bEnable)
    {
        SetFireMode(1);        
    }
    else
    {
        RevertFiremode();
    }
    UpgradeActiveTurrets();
    //return;    
}

simulated event ArmMegaTurretMode(bool bEnable)
{
    // End:0x0F
    if(m_bLockdownIsOn)
    {
        return;
    }
    // End:0x2C
    if(bEnable)
    {
        SetFireMode(2);        
    }
    else
    {
        RevertFiremode();
    }
    UpgradeActiveTurrets();
    //return;    
}

simulated event ArmLockdownMode(bool bEnable)
{
    m_bLockdownIsOn = bEnable;
    // End:0x32
    if(m_bLockdownIsOn)
    {
        SetFireMode(3);        
    }
    else
    {
        RevertFiremode();
    }
    // End:0x62
    if(m_bHasFlamethrowerTurret || m_bHasMegaTurret)
    {
        UpgradeActiveTurrets();
    }
    ToggleLockdownMode();
    //return;    
}

simulated function RevertFiremode()
{
    // End:0x1D
    if(m_bLockdownIsOn)
    {
        SetFireMode(3);        
    }
    else
    {
        // End:0x3A
        if(m_bHasMegaTurret)
        {
            SetFireMode(2);            
        }
        else
        {
            // End:0x56
            if(m_bHasFlamethrowerTurret)
            {
                SetFireMode(1);                
            }
            else
            {
                SetFireMode(0);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_FlameTurretID=2230
    m_MegaTurretID=2260
    m_LockdownTurretID=2151
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=70.0000000
}