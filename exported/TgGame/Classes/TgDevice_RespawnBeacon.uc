class TgDevice_RespawnBeacon extends TgDevice
    hidecategories(Navigation);

var TgRespawnBeaconExit s_BeaconExit;
var repnotify bool r_bHasBeacon;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasBeacon;
}

simulated event ReplicatedEvent(name VarName)
{
    local TgPawn TgP;
    local WeaponMeshSwapStrategy SwapStrategy;

    // End:0x9A
    if(VarName == 'r_bHasBeacon')
    {
        TgP = TgPawn(Instigator);
        // End:0x9A
        if(TgP != none)
        {
            TgP.SetTargetingDevice(((r_bHasBeacon) ? self : TgP.GetDeviceByEqPoint(1)), SwapStrategy);
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x0F
    if(IsFiring())
    {
        return true;
    }
    // End:0x59
    if(r_bHasBeacon)
    {
        // End:0x57
        if((Current != none) && Current.m_nDeviceType == 11077)
        {
            return false;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    super.InterceptLeftMousePressed(TgController);
    // End:0x52
    if(r_bHasBeacon && TgController != none)
    {
        TgController.OnRespawnBeaconButtonPressed();
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController)
{
    super.InterceptLeftMouseReleased(TgController);
    // End:0x52
    if(r_bHasBeacon && TgController != none)
    {
        TgController.OnRespawnBeaconButtonReleased();
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptMount()
{
    return r_bHasBeacon;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    local TgPawn TgP;

    super.FireAmmunition();
    // End:0xD8
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xCD
        if(!r_bHasBeacon)
        {
            TgP = TgPawn(Instigator);
            // End:0x5A
            if(TgP == none)
            {
                return;
            }
            s_BeaconExit = TgP.GetTouchingRespawnBeacon();
            // End:0x94
            if(s_BeaconExit == none)
            {
                return;
            }
            // End:0xCA
            if(s_BeaconExit.Pickup(TgP))
            {
                HandlePickUpAndDrop(true);
            }            
        }
        else
        {
            HandlePickUpAndDrop(false);
        }
    }
    //return;    
}

function HandlePickUpAndDrop(bool bPickedUp)
{
    local TgPawn TgP;

    r_OverrideUsesTargetingModeAsFalse = !bPickedUp;
    r_bHasBeacon = bPickedUp;
    SetFireMode(((bPickedUp) ? 1 : 0));
    ((bPickedUp) ? EnterTargetingMode() : ExitTargetingMode());
    TgP = TgPawn(Instigator);
    // End:0xBF
    if(TgP != none)
    {
        TgP.UpdateHasRespawnBeacon(r_bHasBeacon);
    }
    //return;    
}

simulated function bool ShouldSwitchBackToBasicAttackTargeting(TgClientSettings.ECastMode CastMode)
{
    return !r_bHasBeacon;
    //return ReturnValue;    
}

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns)
{
    super.DeviceShutDown(bDeactiveMode, bResetCooldowns);
    // End:0x8A
    if(((int(Role) == int(ROLE_Authority)) && r_bHasBeacon) && s_BeaconExit != none)
    {
        s_BeaconExit.DestroyIt();
        s_BeaconExit = none;
        HandlePickUpAndDrop(false);
    }
    //return;    
}

defaultproperties
{
    r_OverrideUsesTargetingModeAsFalse=true
    m_bDisableLagCompensation=true
    m_fBottomlessPitCheck=48.0000000
}