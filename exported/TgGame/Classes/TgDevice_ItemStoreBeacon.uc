class TgDevice_ItemStoreBeacon extends TgDevice_TeamDevice
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_ItemStoreBeacon::execGetBeaconExit(FFrame&, void* const)
native final function TgRespawnBeaconExit GetBeaconExit();

// Export UTgDevice_ItemStoreBeacon::execIsBeaconEnabled(FFrame&, void* const)
native final function bool IsBeaconEnabled();

// Export UTgDevice_ItemStoreBeacon::execIsTeamBeaconActive(FFrame&, void* const)
native final function bool IsTeamBeaconActive();

// Export UTgDevice_ItemStoreBeacon::execIsTargetingModeReady(FFrame&, void* const)
native function bool IsTargetingModeReady(optional out TgObject.EDeviceFailType failType);

// Export UTgDevice_ItemStoreBeacon::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function CustomFire()
{
    local AimData Aim;
    local TgRespawnBeaconExit Exit;

    // End:0xF2
    if(int(Role) == int(ROLE_Authority))
    {
        GetCachedAim(Aim);
        Exit = GetBeaconExit();
        // End:0xF2
        if(Aim.bResult && Exit != none)
        {
            // End:0x99
            if(IsTeamBeaconActive())
            {
                Exit.DestroyIt(false);
            }
            Exit.PlaceAtLocation(Aim.EndTrace, Rotator(Aim.AimVector));
        }
    }
    //return;    
}

defaultproperties
{
    m_fBottomlessPitCheck=48.0000000
}