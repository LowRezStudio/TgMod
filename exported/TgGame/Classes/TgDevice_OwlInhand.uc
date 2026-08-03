class TgDevice_OwlInhand extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation);

var TgDevice m_CachedSwapDevice;
var TgDevice m_CachedScopeDevice;
var bool bUsePerfectAccuracy;

// Export UTgDevice_OwlInhand::execGetAccuracy(FFrame&, void* const)
native function float GetAccuracy(optional int nMode = -1);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x37
    if(((IsFiring()) || IsReloading()) && Current == m_CachedScopeDevice)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function ShowReticle(bool bShow)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(Instigator.Controller);
    // End:0x6A
    if(TgPC != none)
    {
        TgPC.SetReticleVisibility(bShow, true);
    }
    //return;    
}

simulated function ApplyScopeEffects()
{
    ClearTimer('RemoveAccuracyDelayed');
    bUsePerfectAccuracy = true;
    ShowReticle(true);
    //return;    
}

simulated function RemoveScopeEffects()
{
    SetTimer(0.1000000, false, 'RemoveAccuracyDelayed');
    // End:0x53
    if((m_CachedSwapDevice != none) && !m_CachedSwapDevice.IsFiring())
    {
        ShowReticle(false);
    }
    //return;    
}

simulated function RemoveAccuracyDelayed()
{
    bUsePerfectAccuracy = false;
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
        // End:0x129
        case 11041:
            // End:0xF1
            if(Dev.IsA('TgDevice_Scope'))
            {
                m_CachedScopeDevice = Dev;
                Dev.RegisterDelegate(0, ApplyScopeEffects);
                Dev.RegisterDelegate(3, RemoveScopeEffects);                
            }
            else
            {
                // End:0x127
                if(Dev.IsA('TgDevice_WeaponSwap'))
                {
                    m_CachedSwapDevice = Dev;
                }
            }
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
        // End:0x119
        case 11041:
            // End:0xE9
            if(Dev.IsA('TgDevice_Scope'))
            {
                m_CachedScopeDevice = none;
                Dev.UnregisterDelegate(0, ApplyScopeEffects);
                Dev.UnregisterDelegate(3, RemoveScopeEffects);                
            }
            else
            {
                // End:0x117
                if(Dev.IsA('TgDevice_WeaponSwap'))
                {
                    m_CachedSwapDevice = none;
                }
            }
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bPostFireShouldInterruptStealth=false
    m_bReloadingShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_OwlInhand'
    m_nLinkedDeviceTypes[0]=11041
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
}