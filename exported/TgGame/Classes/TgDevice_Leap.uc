class TgDevice_Leap extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var bool m_bLeapInLookDirection;
var bool m_bDidJustLeap;

// Export UTgDevice_Leap::execGetFiringPreHitDelay(FFrame&, void* const)
native function float GetFiringPreHitDelay(optional int nMode = -1);

// Export UTgDevice_Leap::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated function SetLeapParams(out float scaleLateral, out float scaleVertical, out float additiveLateral, out float additiveVertical)
{
    local TgDeviceFire deviceFire;

    deviceFire = GetCurrentFire();
    // End:0x25
    if(deviceFire == none)
    {
        return;
    }
    scaleLateral = deviceFire.GetCustomValue4();
    scaleVertical = deviceFire.GetCustomValue3();
    additiveLateral = deviceFire.GetCustomValue2();
    additiveVertical = deviceFire.GetCustomValue1();
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local Rotator JumpRotator;
        local Vector JumpVelocity, PawnRotation;
        local TgPawn TgInstigator;
        local float scaleLateral, scaleVertical, additiveLateral, additiveVertical;

        super.StartFiringLogic();
        TgInstigator = TgPawn(Instigator);
        // End:0x37
        if(TgInstigator == none)
        {
            return;
        }
        // End:0x73
        if(ShouldInterruptLift())
        {
            // End:0x73
            if(TgInstigator != none)
            {
                TgInstigator.InterruptLift();
            }
        }
        SetLeapParams(scaleLateral, scaleVertical, additiveLateral, additiveVertical);
        // End:0x243
        if(m_bLeapInLookDirection && (scaleLateral != float(0)) || scaleVertical != float(0))
        {
            JumpRotator = Instigator.GetAdjustedAimFor(self, TgInstigator.GetWeaponStartTraceLocation(self));
            JumpRotator.Pitch = Clamp(NormalizeRotAxis(JumpRotator.Pitch), 4096, 16383);
            JumpRotator.Pitch += int(float(16383 - JumpRotator.Pitch) * 0.3000000);
            JumpVelocity = Vector(JumpRotator);
            JumpVelocity.X *= scaleLateral;
            JumpVelocity.Y *= scaleLateral;
            JumpVelocity.Z *= scaleVertical;
        }
        PawnRotation = Vector(Instigator.Rotation);
        JumpVelocity.X += (PawnRotation.X * additiveLateral);
        JumpVelocity.Y += (PawnRotation.Y * additiveLateral);
        JumpVelocity.Z += additiveVertical;
        // End:0x3AB
        if((int(TgInstigator.Physics) == int(2)) && TgInstigator.r_bIsJumping)
        {
            TgInstigator.r_bIsJumping = false;
            TgInstigator.ClientCancelJump();
        }
        // End:0x3EF
        if(TgInstigator.r_bIsKnockedBack)
        {
            TgInstigator.Knock(false);
        }
        TgInstigator.SetPhysics(2);
        TgInstigator.m_bIsLeaping = true;
        TgInstigator.Velocity = JumpVelocity;
        m_bDidJustLeap = true;
        SetTimer(0.2000000, false, 'EndLeapDelay');
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        super(Actor).Tick(DeltaSeconds);
        // End:0xBA
        if((!m_bDidJustLeap && self.IsTimerActive('FirePreHitDelay')) && int(Instigator.Physics) == int(1))
        {
            TgPawn(Instigator).m_bIsLeaping = false;
            SetTimer(0.0000000, false, 'FirePreHitDelay');
            FirePreHitDelay();
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        m_bDidJustLeap = false;
        SetTimer(0.0000000, false, 'EndLeapDelay');
        //return;        
    }

    simulated function EndLeapDelay()
    {
        m_bDidJustLeap = false;
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bLeapInLookDirection=true
    m_bCarryPreFireToPostFire=false
    m_bForce3PViewWhileFiring=true
}