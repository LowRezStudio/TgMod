class TgSpectatorInput extends TgPlayerInput within TgPlayerController
    transient
    native(Pawns)
    config(Input)
    hidecategories(Object,UIRoot);

var config float SpectatorSensitivity;

// Export UTgSpectatorInput::execCheckIdleBreak(FFrame&, void* const)
native function CheckIdleBreak();

function AdjustMouseSensitivity(float FOVScale)
{
    aMouseX *= (SpectatorSensitivity * FOVScale);
    aMouseY *= (SpectatorSensitivity * FOVScale);
    //return;    
}

event PlayerInput(float DeltaTime)
{
    local float FOVScale, TimeScale;

    RawJoyUp = aBaseY;
    RawJoyRight = aStrafe;
    RawJoyLookRight = aTurn;
    RawJoyLookUp = aLookUp;
    DeltaTime = Outer.WorldInfo.m_fRealDeltaSeconds;
    PreProcessInput(DeltaTime);
    TimeScale = 100.0000000 * DeltaTime;
    aBaseY *= (TimeScale * MoveForwardSpeed);
    aStrafe *= (TimeScale * MoveStrafeSpeed);
    aUp *= (TimeScale * MoveStrafeSpeed);
    aTurn *= (TimeScale * LookRightScale);
    aLookUp *= (TimeScale * LookUpScale);
    PostProcessInput(DeltaTime);
    ProcessInputMatching(DeltaTime);
    CatchDoubleClickInput();
    // End:0x1C1
    if(bEnableFOVScaling)
    {
        FOVScale = Outer.GetFOVAngle() * 0.0166660;        
    }
    else
    {
        FOVScale = 1.0000000;
    }
    AdjustMouseSensitivity(FOVScale);
    aMouseX = SmoothMouse(aMouseX, DeltaTime, bXAxis, 0);
    aMouseY = SmoothMouse(aMouseY, DeltaTime, bYAxis, 1);
    aLookUp *= FOVScale;
    aTurn *= FOVScale;
    // End:0x2A1
    if(int(bStrafe) > int(0))
    {
        aStrafe += (aBaseX + aMouseX);        
    }
    else
    {
        aTurn += (aBaseX + aMouseX);
    }
    aLookUp += aMouseY;
    // End:0x2F1
    if(bInvertMouse)
    {
        aLookUp *= -1.0000000;
    }
    // End:0x30E
    if(bInvertTurn)
    {
        aTurn *= -1.0000000;
    }
    aForward += aBaseY;
    Outer.HandleWalking();
    // End:0x3C3
    if(bLockTurnUntilRelease)
    {
        // End:0x3B7
        if(RawJoyLookRight != float(0))
        {
            aTurn = 0.0000000;
            // End:0x3B4
            if(AutoUnlockTurnTime > 0.0000000)
            {
                AutoUnlockTurnTime -= DeltaTime;
                // End:0x3B4
                if(AutoUnlockTurnTime < 0.0000000)
                {
                    bLockTurnUntilRelease = false;
                }
            }            
        }
        else
        {
            bLockTurnUntilRelease = false;
        }
    }
    // End:0x412
    if(Outer.IsMoveInputIgnored())
    {
        aForward = 0.0000000;
        aStrafe = 0.0000000;
        aUp = 0.0000000;
    }
    // End:0x452
    if(Outer.IsLookInputIgnored())
    {
        aTurn = 0.0000000;
        aLookUp = 0.0000000;
    }
    CheckIdleBreak();
    //return;    
}

defaultproperties
{
    SpectatorSensitivity=5.0000000
    c_bUseServerBindings=false
    m_nKeybindConfigSet=2
    Bindings=/* Array type was not detected. */
}