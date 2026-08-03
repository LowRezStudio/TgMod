class TgDevice_Blink extends TgDevice
    native(ChampEvie)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var Vector r_vPreviousLocation;
var bool c_bWaitingForServerTeleport;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_vPreviousLocation;
}

// Export UTgDevice_Blink::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_Blink::execCanBeCrippled(FFrame&, void* const)
native function bool CanBeCrippled();

// Export UTgDevice_Blink::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

// Export UTgDevice_Blink::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated function DeviceRestart()
{
    super.DeviceRestart();
    r_vPreviousLocation = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    super.AuthStartCooldown(nMode, fCooldownTimeOverride);
    r_vPreviousLocation = vect(0.0000000, 0.0000000, 0.0000000);
    bNetDirty = true;
    //return;    
}

simulated function InterruptOtherDevices(TgPawn TgP)
{
    super.InterruptOtherDevices(TgP);
    // End:0x5F
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x5F
        if(TgP != none)
        {
            TgP.InterruptDeviceFiringByClass(Class'TgGame.TgDevice_IceBlock');
        }
    }
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x4A
    if(((IsFiring()) && Current != none) && Current.m_nDeviceType == 11077)
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

function RequireHardReset()
{
    InterruptFiring();
    // End:0x41
    if(m_bIsSecondaryFire)
    {
        ClearTimer('AlternateStartCooldown');
        m_bIsSecondaryFire = false;
        AlternateStartCooldown();
    }
    c_bWaitingForServerTeleport = false;
    //return;    
}

// Export UTgDevice_Blink::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

simulated function int GetAimAssistPriority()
{
    // End:0x10
    if(IsInTargetingMode())
    {
        return 3;
    }
    return 0;
    //return ReturnValue;    
}

simulated event bool CanDeviceStartFiringNow(byte FireModeNum, AimData Aim, bool bDebugRelevant, optional out TgObject.EDeviceFailType failType)
{
    // End:0x10
    if(c_bWaitingForServerTeleport)
    {
        return false;
    }
    return super.CanDeviceStartFiringNow(FireModeNum, Aim, bDebugRelevant, failType);
    //return ReturnValue;    
}

simulated function OnServerTeleportTimeout()
{
    c_bWaitingForServerTeleport = false;
    //return;    
}

reliable client simulated event ClientOnServerTeleported()
{
    c_bWaitingForServerTeleport = false;
    ClearTimer('OnServerTeleportTimeout');
    //return;    
}

simulated state DeviceFiring
{
    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0x65
        if((int(Role) == int(ROLE_Authority)) && !IsTimerActive('AlternateStartCooldown'))
        {
            r_vPreviousLocation = vect(0.0000000, 0.0000000, 0.0000000);
            bNetDirty = true;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fDeployZForgiveness=580.0000000
    m_fBottomlessPitCheck=5000.0000000
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
}