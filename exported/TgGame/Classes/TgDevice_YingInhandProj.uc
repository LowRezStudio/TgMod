class TgDevice_YingInhandProj extends TgDevice
    native(ChampYing)
    hidecategories(Navigation);

// Export UTgDevice_YingInhandProj::execCanReload(FFrame&, void* const)
native function bool CanReload(optional bool bIsAutoReload = false);

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    local float totalBurstTime;

    // End:0xF9
    if(m_bIsFirstBurstShot)
    {
        totalBurstTime = GetEstimatedTotalBurstTime(m_nBurstShotsRemaining);
        TgPawn(Instigator).FlashStartFire(r_nDeviceInstanceId, nDeviceModeNum, totalBurstTime, Aim.HitActor, GetCurrentAmmoAmount());
        // End:0xF9
        if(c_DeviceForm != none)
        {
            c_DeviceForm.StartFire(nDeviceModeNum, totalBurstTime, Aim.HitActor, GetCurrentAmmoAmount());
        }
    }
    //return;    
}

simulated function float GetEstimatedTotalBurstTime(int nShotsRemaining)
{
    return (FMax(0.0000000, float(nShotsRemaining - 1)) * GetCurrentFire().GetCustomValue1()) + GetCurrentFire().m_fFirePostHitDelay;
    //return ReturnValue;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bUsesBurstFire=true
    m_bOnlyFirstBurstCostsAmmo=true
    m_bDoNotAllowHeadShots=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=55.0000000,Y=10.0000000,Z=-15.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_nBurstTotalShots=3
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_YingInhandProj'
}