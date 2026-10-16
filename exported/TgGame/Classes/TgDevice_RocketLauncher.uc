class TgDevice_RocketLauncher extends TgDevice
    native(ChampRuckus)
    hidecategories(Navigation);

var() Vector m_vProjectileSpawnOffset2;
var int m_nFireCount;

// Export UTgDevice_RocketLauncher::execGetAdjustedAim(FFrame&, void* const)
native function GetAdjustedAim(out AimData Aim, out float UsedRandomValue1, out float UsedRandomValue2, optional float RandomValueOverride1 = -1.0000000, optional float RandomValueOverride2 = -1.0000000);

simulated event Vector GetProjectileSpawnOffset()
{
    // End:0x1C
    if(m_nFireCount <= 0)
    {
        return m_vProjectileSpawnOffset2;        
    }
    else
    {
        return m_vProjectileSpawnOffset;
    }
    //return ReturnValue;    
}

simulated function Projectile ProjectileFire(optional int ProjectileIndex = 0)
{
    local Projectile pProjectile;

    pProjectile = super.ProjectileFire(ProjectileIndex);
    m_nFireCount++;
    return pProjectile;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn pPawn;

        m_nFireCount = 0;
        pPawn = TgPawn(Instigator);
        // End:0x9C
        if(pPawn != none)
        {
            pPawn.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true, 1);
            // End:0x9C
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1(1);
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        local TgPawn pPawn;

        pPawn = TgPawn(Instigator);
        // End:0x91
        if(pPawn != none)
        {
            pPawn.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true, 1);
            // End:0x91
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1(0);
            }
        }
        super.FirePreHitDelay();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=0.0000000,Y=-25.0000000,Z=48.0000000)
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=0.0000000,Y=25.0000000,Z=48.0000000)
}