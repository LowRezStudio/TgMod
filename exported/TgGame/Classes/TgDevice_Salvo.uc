class TgDevice_Salvo extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation);

var TgDevice_DrogozInhand m_CachedInhand;

// Export UTgDevice_Salvo::execShouldInterruptStealth(FFrame&, void* const)
native function bool ShouldInterruptStealth();

// Export UTgDevice_Salvo::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3B
    if((Current != none) && Current.m_nDeviceType == 11070)
    {
        return false;
    }
    // End:0x54
    if(IsTimerActive('FirePreHitDelay'))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return !IsTimerActive('FirePreHitDelay');
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return m_CachedInhand.m_bStartedSalvo;
    //return ReturnValue;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    local int inhandAmmo;

    inhandAmmo = 0;
    // End:0x43
    if(m_CachedInhand != none)
    {
        inhandAmmo = m_CachedInhand.GetCurrentAmmoAmount();
    }
    TgPawn(Instigator).FlashStartFire(r_nDeviceInstanceId, nDeviceModeNum, fRefireTime, Aim.HitActor, inhandAmmo);
    // End:0x110
    if(c_DeviceForm != none)
    {
        c_DeviceForm.StartFire(nDeviceModeNum, fRefireTime, Aim.HitActor, inhandAmmo);
    }
    //return;    
}

simulated function EndSalvo()
{
    // End:0x55
    if((IsFiring()) && !IsTimerActive('FirePostHitDelay'))
    {
        SetTimer(GetCurrentFire().m_fAmmoClipPreReloadTime, false, 'FirePostHitDelay');
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0xA4
        case 10828:
            m_CachedInhand = TgDevice_DrogozInhand(Dev);
            Dev.RegisterDelegate(4, EndSalvo);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x93
        case 10828:
            m_CachedInhand = none;
            Dev.UnregisterDelegate(4, EndSalvo);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        PlayClientFireFx(Owner.Location, 0, false, 0.0000000);
        ClearTimer('FirePostHitDelay');
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=10828
}