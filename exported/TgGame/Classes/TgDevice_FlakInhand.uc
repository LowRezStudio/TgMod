class TgDevice_FlakInhand extends TgDevice
    native(ChampFlak)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgDevice_KineticBurst m_KineticDevice;

// Export UTgDevice_FlakInhand::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_FlakInhand::execHasKineticDevice(FFrame&, void* const)
native function bool HasKineticDevice();

simulated function FireAmmunition()
{
    super.FireAmmunition();
    // End:0x6B
    if(HasKineticDevice())
    {
        // End:0x6B
        if(int(CurrentFireMode) == int(1))
        {
            m_KineticDevice.InterruptFiring();
            m_KineticDevice.StartCooldown();
        }
    }
    //return;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function FirePostHitDelay()
    {
        // End:0x20
        if(int(CurrentFireMode) == int(1))
        {
            SetFireMode(0, true);
        }
        super.FirePostHitDelay();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        // End:0x2A
        if(int(CurrentFireMode) == int(1))
        {
            SetFireMode(0, true);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=15.0000000,Z=-7.5000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_FlakInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Flak.DeviceInhand'
}