class TgDevice_Emote extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var TgPawn m_CachedPawnOwner;
var bool m_bAccelerationInterruptsDevice;
var bool m_bJumpingInterruptsDevice;
var Class<TgCameraModule> m_DefaultCameraModuleClass;
var Class<TgCameraModule_ThirdPersonVariableHeight> m_FiringCameraModuleClass;
var TgCameraModule m_FiringCameraModule;
var float m_fCameraTweenInTime;
var float m_fCameraTweenOutTime;
var Vector m_vFiringCameraOffset;

// Export UTgDevice_Emote::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

// Export UTgDevice_Emote::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

// Export UTgDevice_Emote::execCanFiringBeLocked(FFrame&, void* const)
native function bool CanFiringBeLocked();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3C
    if((Current != none) && int(Current.r_eEquippedAt) == int(23))
    {
        return false;
    }
    return IsInState('DeviceBuildup') || IsInState('DeviceFiring') && IsTimerActive('FirePreHitDelay');
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return super.CanJumpWhileFiring();
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByRightMouse()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeFiredWhileTweening()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptMount()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptReloadOnFire()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return true;
    //return ReturnValue;    
}

simulated function TurnOnSpecialCamera()
{
    local TgPlayerController PC;
    local TgPlayerCamera Cam;
    local Vector NewOffset;

    // End:0xF2
    if((m_vFiringCameraOffset == vect(0.0000000, 0.0000000, 0.0000000)) && (GetCurrentFire()) != none)
    {
        m_vFiringCameraOffset.X = -80.0000000 + GetCurrentFire().GetCustomValue1();
        m_vFiringCameraOffset.Y = GetCurrentFire().GetCustomValue2();
        m_vFiringCameraOffset.Z = -43.0000000 + GetCurrentFire().GetCustomValue3();
    }
    // End:0x2E2
    if((m_FiringCameraModuleClass != none) && Instigator != none)
    {
        PC = TgPlayerController(Instigator.Controller);
        Cam = ((PC != none) ? TgPlayerCamera(PC.PlayerCamera) : none);
        // End:0x2E2
        if(((PC != none) && PC.IsLocalPlayerController()) && Cam != none)
        {
            m_DefaultCameraModuleClass = Cam.CurrentCameraMod.Class;
            NewOffset = TgCameraModule_ThirdPerson(Cam.CurrentCameraMod).CameraOffset;
            NewOffset += m_vFiringCameraOffset;
            m_FiringCameraModule = Cam.SwitchCameras(m_FiringCameraModuleClass, m_fCameraTweenInTime);
            TgCameraModule_ThirdPerson(Cam.CurrentCameraMod).CameraOffset = NewOffset;
        }
    }
    //return;    
}

simulated function TurnOffSpecialCamera()
{
    local TgPlayerController PC;
    local TgPlayerCamera Cam;

    // End:0x153
    if(((m_FiringCameraModule != none) && m_DefaultCameraModuleClass != none) && Instigator != none)
    {
        PC = TgPlayerController(Instigator.Controller);
        Cam = ((PC != none) ? TgPlayerCamera(PC.PlayerCamera) : none);
        // End:0x153
        if((((PC != none) && PC.IsLocalPlayerController()) && Cam != none) && Cam.CurrentCameraMod == m_FiringCameraModule)
        {
            Cam.SwitchCameras(m_DefaultCameraModuleClass, m_fCameraTweenOutTime);
            m_DefaultCameraModuleClass = none;
        }
    }
    //return;    
}

simulated function TgPawn GetCachedPawnOwner()
{
    local TgPawn PawnOwner;

    // End:0x4D
    if(m_CachedPawnOwner == none)
    {
        PawnOwner = TgPawn(Instigator);
        // End:0x4D
        if(PawnOwner != none)
        {
            m_CachedPawnOwner = PawnOwner;
        }
    }
    return m_CachedPawnOwner;
    //return ReturnValue;    
}

simulated function Tick(float DeltaSeconds)
{
    super(Actor).Tick(DeltaSeconds);
    // End:0xC9
    if(((int(Role) == int(ROLE_Authority)) && IsFiring()) && !IsTimerActive('FirePreHitDelay'))
    {
        // End:0xC9
        if((m_bAccelerationInterruptsDevice && VSizeSq(GetCachedPawnOwner().Acceleration) >= 0.5000000) || m_bJumpingInterruptsDevice && GetCachedPawnOwner().r_bIsJumping)
        {
            InterruptFiring();
        }
    }
    //return;    
}

simulated state DeviceBuildup
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        LockRotation(true);
        TurnOnSpecialCamera();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        LockRotation(false);
        TurnOffSpecialCamera();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bAccelerationInterruptsDevice=true
    m_bJumpingInterruptsDevice=true
    m_FiringCameraModuleClass=Class'TgGame.TgCameraModule_ThirdPersonVariableHeight'
    m_fCameraTweenInTime=0.1000000
    m_fCameraTweenOutTime=0.1000000
    m_bForce3PViewWhileFiring=true
}