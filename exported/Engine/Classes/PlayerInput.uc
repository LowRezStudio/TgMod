class PlayerInput extends Input within PlayerController
    transient
    native(UserInterface)
    config(Input)
    hidecategories(Object,UIRoot);

var const bool bUsingGamepad;
var globalconfig bool bInvertMouse;
var globalconfig bool bInvertTurn;
var bool bWasForward;
var bool bWasBack;
var bool bWasLeft;
var bool bWasRight;
var bool bEdgeForward;
var bool bEdgeBack;
var bool bEdgeLeft;
var bool bEdgeRight;
var globalconfig bool bEnableMouseSmoothing;
var bool bEnableFOVScaling;
var transient bool bLockTurnUntilRelease;
var const name LastAxisKeyName;
var float DoubleClickTimer;
var globalconfig float DoubleClickTime;
var globalconfig float MouseSensitivity;
var globalconfig float m_fLookSensitivity;
var globalconfig float m_fLookSensitivityY;
var input float aBaseX;
var input float aBaseY;
var input float aBaseZ;
var input float aMouseX;
var input float aMouseY;
var input float aForward;
var input float aTurn;
var input float aStrafe;
var input float aUp;
var input float aLookUp;
var input float aRightAnalogTrigger;
var input float aLeftAnalogTrigger;
var input float aPS3AccelX;
var input float aPS3AccelY;
var input float aPS3AccelZ;
var input float aPS3Gyro;
var input float aWiiUPointerX;
var input float aWiiUPointerY;
var input Vector aTilt;
var input Vector aRotationRate;
var input Vector aGravity;
var input Vector aAcceleration;
var input Vector aTouch[5];
var input Vector aBackTouch[5];
var transient float RawJoyUp;
var transient float RawJoyRight;
var transient float RawJoyLookRight;
var transient float RawJoyLookUp;
var() config float MoveForwardSpeed;
var() config float MoveStrafeSpeed;
var() config float LookRightScale;
var() config float LookUpScale;
var input byte bStrafe;
var input byte bXAxis;
var input byte bYAxis;
var float ZeroTime[2];
var float SmoothedMouse[2];
var int MouseSamples;
var float MouseSamplingTotal;
var transient float AutoUnlockTurnTime;

// Export UPlayerInput::execCancelMobileInput(FFrame&, void* const)
native function CancelMobileInput();

exec function bool InvertMouse()
{
    bInvertMouse = !bInvertMouse;
    SaveConfig();
    return bInvertMouse;
    //return ReturnValue;    
}

exec function bool InvertTurn()
{
    bInvertTurn = !bInvertTurn;
    SaveConfig();
    return bInvertTurn;
    //return ReturnValue;    
}

exec function SetSensitivity(float F)
{
    MouseSensitivity = F;
    //return;    
}

function DrawHUD(HUD H)
{
    //return;    
}

function PreProcessInput(float DeltaTime)
{
    //return;    
}

function PostProcessInput(float DeltaTime)
{
    //return;    
}

function AdjustMouseSensitivity(float FOVScale)
{
    aMouseX *= (MouseSensitivity * FOVScale);
    aMouseY *= (MouseSensitivity * FOVScale);
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
    // End:0x186
    if(bUsingGamepad)
    {
        aTurn *= m_fLookSensitivity;
        aLookUp *= m_fLookSensitivityY;
    }
    PostProcessInput(DeltaTime);
    ProcessInputMatching(DeltaTime);
    CatchDoubleClickInput();
    // End:0x1F6
    if(bEnableFOVScaling)
    {
        FOVScale = Outer.GetFOVAngle() * 0.0166660;        
    }
    else
    {
        FOVScale = 1.0000000;
    }
    AdjustMouseSensitivity(FOVScale);
    // End:0x285
    if(bEnableMouseSmoothing)
    {
        aMouseX = SmoothMouse(aMouseX, DeltaTime, bXAxis, 0);
        aMouseY = SmoothMouse(aMouseY, DeltaTime, bYAxis, 1);
    }
    aLookUp *= FOVScale;
    aTurn *= FOVScale;
    // End:0x2E3
    if(int(bStrafe) > int(0))
    {
        aStrafe += (aBaseX + aMouseX);        
    }
    else
    {
        aTurn += (aBaseX + aMouseX);
    }
    aLookUp += aMouseY;
    // End:0x333
    if(bInvertMouse)
    {
        aLookUp *= -1.0000000;
    }
    // End:0x350
    if(bInvertTurn)
    {
        aTurn *= -1.0000000;
    }
    aForward += aBaseY;
    Outer.HandleWalking();
    // End:0x405
    if(bLockTurnUntilRelease)
    {
        // End:0x3F9
        if(RawJoyLookRight != float(0))
        {
            aTurn = 0.0000000;
            // End:0x3F6
            if(AutoUnlockTurnTime > 0.0000000)
            {
                AutoUnlockTurnTime -= DeltaTime;
                // End:0x3F6
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
    // End:0x454
    if(Outer.IsMoveInputIgnored())
    {
        aForward = 0.0000000;
        aStrafe = 0.0000000;
        aUp = 0.0000000;
    }
    // End:0x494
    if(Outer.IsLookInputIgnored())
    {
        aTurn = 0.0000000;
        aLookUp = 0.0000000;
    }
    //return;    
}

function CatchDoubleClickInput()
{
    // End:0x11C
    if(!Outer.IsMoveInputIgnored())
    {
        bEdgeForward = bWasForward ^^ (aBaseY > float(0));
        bEdgeBack = bWasBack ^^ (aBaseY < float(0));
        bEdgeLeft = bWasLeft ^^ (aStrafe < float(0));
        bEdgeRight = bWasRight ^^ (aStrafe > float(0));
        bWasForward = aBaseY > float(0);
        bWasBack = aBaseY < float(0);
        bWasLeft = aStrafe < float(0);
        bWasRight = aStrafe > float(0);
    }
    //return;    
}

function Actor.EDoubleClickDir CheckForDoubleClickMove(float DeltaTime)
{
    local Actor.EDoubleClickDir DoubleClickMove, OldDoubleClick;

    // End:0x38
    if(int(Outer.DoubleClickDir) == int(5))
    {
        DoubleClickMove = 5;        
    }
    else
    {
        DoubleClickMove = 0;
    }
    // End:0x49F
    if(DoubleClickTime > 0.0000000)
    {
        // End:0x117
        if(int(Outer.DoubleClickDir) == int(5))
        {
            // End:0x114
            if((Outer.Pawn != none) && int(Outer.Pawn.Physics) == int(1))
            {
                DoubleClickTimer = 0.0000000;
                Outer.DoubleClickDir = 6;
            }            
        }
        else
        {
            // End:0x35A
            if(int(Outer.DoubleClickDir) != int(6))
            {
                OldDoubleClick = Outer.DoubleClickDir;
                Outer.DoubleClickDir = 0;
                // End:0x1C9
                if(bEdgeForward && bWasForward)
                {
                    Outer.DoubleClickDir = 3;                    
                }
                else
                {
                    // End:0x209
                    if(bEdgeBack && bWasBack)
                    {
                        Outer.DoubleClickDir = 4;                        
                    }
                    else
                    {
                        // End:0x249
                        if(bEdgeLeft && bWasLeft)
                        {
                            Outer.DoubleClickDir = 1;                            
                        }
                        else
                        {
                            // End:0x286
                            if(bEdgeRight && bWasRight)
                            {
                                Outer.DoubleClickDir = 2;
                            }
                        }
                    }
                }
                // End:0x2DA
                if(int(Outer.DoubleClickDir) == int(0))
                {
                    Outer.DoubleClickDir = OldDoubleClick;                    
                }
                else
                {
                    // End:0x332
                    if(int(Outer.DoubleClickDir) != int(OldDoubleClick))
                    {
                        DoubleClickTimer = DoubleClickTime + (0.5000000 * DeltaTime);                        
                    }
                    else
                    {
                        DoubleClickMove = Outer.DoubleClickDir;
                    }
                }
            }
        }
        // End:0x3F2
        if(int(Outer.DoubleClickDir) == int(6))
        {
            DoubleClickTimer = FMin(DoubleClickTimer - DeltaTime, 0.0000000);
            // End:0x3EF
            if(DoubleClickTimer < -0.3500000)
            {
                Outer.DoubleClickDir = 0;
                DoubleClickTimer = DoubleClickTime;
            }            
        }
        else
        {
            // End:0x49F
            if((int(Outer.DoubleClickDir) != int(0)) && int(Outer.DoubleClickDir) != int(5))
            {
                DoubleClickTimer -= DeltaTime;
                // End:0x49F
                if(DoubleClickTimer < float(0))
                {
                    Outer.DoubleClickDir = 0;
                    DoubleClickTimer = DoubleClickTime;
                }
            }
        }
    }
    return DoubleClickMove;
    //return ReturnValue;    
}

final function ProcessInputMatching(float DeltaTime)
{
    local float Value;
    local int I, MatchIdx;
    local bool bMatch;

    I = 0;
    J0x0B:

    // End:0x9AE [Loop If]
    if(I < Outer.InputRequests.Length)
    {
        // End:0x9A0
        if((Outer.InputRequests[I].MatchIdx >= 0) && Outer.InputRequests[I].MatchIdx < Outer.InputRequests[I].Inputs.Length)
        {
            // End:0x17D
            if(Outer.InputRequests[I].MatchActor == none)
            {
                Outer.InputRequests[I].MatchActor = Outer;
            }
            MatchIdx = Outer.InputRequests[I].MatchIdx;
            // End:0x45A
            if(((MatchIdx != 0) && Outer.InputRequests[I].Inputs[MatchIdx].TimeDelta > 0.0000000) && (Outer.WorldInfo.TimeSeconds - Outer.InputRequests[I].LastMatchTime) >= Outer.InputRequests[I].Inputs[MatchIdx].TimeDelta)
            {
                Outer.InputRequests[I].LastMatchTime = 0.0000000;
                Outer.InputRequests[I].MatchIdx = 0;
                // End:0x457
                if(Outer.InputRequests[I].FailedFuncName != 'None')
                {
                    Outer.InputRequests[I].MatchActor.SetTimer(0.0100000, false, Outer.InputRequests[I].FailedFuncName);
                }                
            }
            else
            {
                Value = 0.0000000;
                switch(Outer.InputRequests[I].Inputs[MatchIdx].Type)
                {
                    // End:0x4E6
                    case 0:
                        Value = aStrafe;
                        // End:0x504
                        break;
                    // End:0x501
                    case 1:
                        Value = aBaseY;
                        // End:0x504
                        break;
                    // End:0xFFFF
                    default:
                        break;
                }
                switch(Outer.InputRequests[I].Inputs[MatchIdx].Action)
                {
                    // End:0x5DC
                    case 0:
                        bMatch = Value >= Outer.InputRequests[I].Inputs[MatchIdx].Value;
                        // End:0x655
                        break;
                    // End:0x652
                    case 1:
                        bMatch = Value <= Outer.InputRequests[I].Inputs[MatchIdx].Value;
                        // End:0x655
                        break;
                    // End:0xFFFF
                    default:
                        break;
                }
                // End:0x9A0
                if(bMatch)
                {
                    Outer.InputRequests[I].LastMatchTime = Outer.WorldInfo.TimeSeconds;
                    Outer.InputRequests[I].MatchIdx++;
                    // End:0x9A0
                    if(Outer.InputRequests[I].MatchIdx >= Outer.InputRequests[I].Inputs.Length)
                    {
                        // End:0x84D
                        if(Outer.InputRequests[I].MatchDelegate != none)
                        {
                            Outer.__InputMatchDelegate__Delegate = Outer.InputRequests[I].MatchDelegate;
                            Outer.InputMatchDelegate();
                        }
                        // End:0x922
                        if(Outer.InputRequests[I].MatchFuncName != 'None')
                        {
                            Outer.InputRequests[I].MatchActor.SetTimer(0.0100000, false, Outer.InputRequests[I].MatchFuncName);
                        }
                        Outer.InputRequests[I].LastMatchTime = 0.0000000;
                        Outer.InputRequests[I].MatchIdx = 0;
                    }
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

exec function Jump()
{
    // End:0x7A
    if(Outer.WorldInfo.Pauser == Outer.PlayerReplicationInfo)
    {
        Outer.SetPause(false);        
    }
    else
    {
        Outer.bPressedJump = true;
    }
    //return;    
}

exec function SmartJump()
{
    Jump();
    //return;    
}

exec function ClearSmoothing()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x5B [Loop If]
    if(I < 2)
    {
        ZeroTime[I] = 0.0000000;
        SmoothedMouse[I] = 0.0000000;
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    MouseSamplingTotal = default.MouseSamplingTotal;
    MouseSamples = default.MouseSamples;
    //return;    
}

function float SmoothMouse(float aMouse, float DeltaTime, out byte SampleCount, int Index)
{
    local float MouseSamplingTime;

    // End:0x1BB
    if(DeltaTime < 0.2500000)
    {
        MouseSamplingTime = MouseSamplingTotal / float(MouseSamples);
        // End:0xD5
        if(aMouse == float(0))
        {
            ZeroTime[Index] += DeltaTime;
            // End:0xB9
            if(ZeroTime[Index] < MouseSamplingTime)
            {
                aMouse = (SmoothedMouse[Index] * DeltaTime) / MouseSamplingTime;                
            }
            else
            {
                SmoothedMouse[Index] = 0.0000000;
            }            
        }
        else
        {
            ZeroTime[Index] = 0.0000000;
            // End:0x18E
            if(SmoothedMouse[Index] != float(0))
            {
                // End:0x16E
                if(DeltaTime < (MouseSamplingTime * float(int(SampleCount) + int(1))))
                {
                    aMouse = (aMouse * DeltaTime) / (MouseSamplingTime * float(SampleCount));                    
                }
                else
                {
                    SampleCount = byte(DeltaTime / MouseSamplingTime);
                }
            }
            SmoothedMouse[Index] = aMouse / float(SampleCount);
        }        
    }
    else
    {
        ClearSmoothing();
    }
    SampleCount = 0;
    return aMouse;
    //return ReturnValue;    
}

// Export UPlayerInput::execInitInputSystem(FFrame&, void* const)
native function InitInputSystem();

function ClientInitInputSystem()
{
    //return;    
}

function PreClientTravel(string PendingURL, Actor.ETravelType TravelType, bool bIsSeamlessTravel)
{
    //return;    
}

defaultproperties
{
    bEnableFOVScaling=true
    DoubleClickTime=0.2500000
    MouseSensitivity=50.0000000
    m_fLookSensitivity=1.0000000
    m_fLookSensitivityY=1.0000000
    MoveForwardSpeed=1200.0000000
    MoveStrafeSpeed=1200.0000000
    LookRightScale=300.0000000
    LookUpScale=-250.0000000
    MouseSamples=1
    MouseSamplingTotal=0.0083000
    Bindings[0]=(Name="Fire",Command="Button bFire | StartFire | OnRelease StopFire",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[1]=(Name="AltFire",Command="StartAltFire | OnRelease StopAltFire",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[2]=(Name="MoveForward",Command="Axis aBaseY Speed=1.0",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[3]=(Name="MoveBackward",Command="Axis aBaseY Speed=-1.0",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[4]=(Name="TurnLeft",Command="Axis aBaseX Speed=-200.0 AbsoluteAxis=100",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[5]=(Name="TurnRight",Command="Axis aBaseX  Speed=+200.0 AbsoluteAxis=100",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[6]=(Name="StrafeLeft",Command="Axis aStrafe Speed=-1.0",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[7]=(Name="StrafeRight",Command="Axis aStrafe Speed=+1.0",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[8]=(Name="Jump",Command="Jump | Axis aUp Speed=+1.0 AbsoluteAxis=100",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[9]=(Name="Duck",Command="Button bDuck | Axis aUp Speed=-1.0  AbsoluteAxis=100",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[10]=(Name="Look",Command="Button bLook",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[11]=(Name="Pause",Command="Pause",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[12]=(Name="LookToggle",Command="Toggle bLook",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[13]=(Name="LookUp",Command="Axis aLookUp Speed=+25.0 AbsoluteAxis=100",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[14]=(Name="LookDown",Command="Axis aLookUp Speed=-25.0 AbsoluteAxis=100",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[15]=(Name="CenterView",Command="Button bSnapLevel",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[16]=(Name="Walking",Command="Button bRun",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[17]=(Name="Strafe",Command="Button bStrafe",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[18]=(Name="NextWeapon",Command="NextWeapon",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[19]=(Name="ViewTeam",Command="ViewClass Pawn",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[20]=(Name="TurnToNearest",Command="Button bTurnToNearest",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[21]=(Name="Turn180",Command="Button bTurn180",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[22]=(Name="W",Command="MoveForward",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[23]=(Name="S",Command="MoveBackward",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[24]=(Name="A",Command="StrafeLeft",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[25]=(Name="D",Command="StrafeRight",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[26]=(Name="F",Command="FreezeRendering",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[27]=(Name="MouseX",Command="Count bXAxis | Axis aMouseX",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[28]=(Name="MouseY",Command="Count bYAxis | Axis aMouseY",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[29]=(Name="LeftMouseButton",Command="Fire",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[30]=(Name="RightMouseButton",Command="AltFire",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[31]=(Name="LeftControl",Command="Jump",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[32]=(Name="SpaceBar",Command="Jump",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[33]=(Name="BackSpace",Command="Jump",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[34]=(Name="Escape",Command="CloseEditorViewport | onrelease ShowMenu",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[35]=(Name="E",Command="Use",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[36]=(Name="MouseScrollUp",Command="PrevWeapon",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[37]=(Name="MouseScrollDown",Command="NextWeapon",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[38]=(Name="C",Command="DoDuck",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[39]=(Name="P",Command="TogglePhysicsMode",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[40]=(Name="B",Command="ToggleSpeaking true | OnRelease ToggleSpeaking false",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[41]=(Name="T",Command="Talk",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[42]=(Name="Up",Command="MoveForward",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[43]=(Name="Down",Command="MoveBackward",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[44]=(Name="Left",Command="TurnLeft",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[45]=(Name="Right",Command="TurnRight",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[46]=(Name="LeftShift",Command="Walking",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[47]=(Name="F1",Command="ShowMouseCursor",Control=false,Shift=true,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[48]=(Name="F1",Command="viewmode wireframe",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=true,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[49]=(Name="F2",Command="viewmode unlit",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[50]=(Name="F3",Command="viewmode lit",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[51]=(Name="F4",Command="viewmode detaillighting",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[52]=(Name="F5",Command="viewmode shadercomplexity",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[53]=(Name="F7",Command="OPENKISMETDEBUGGER SEQUENCE=PAUSEKISMETDEBUGGER",Control=false,Shift=false,Alt=true,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[54]=(Name="F9",Command="shot",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[55]=(Name="Period",Command="RECOMPILESHADERS CHANGED",Control=true,Shift=true,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[56]=(Name="Delete",Command="Camera Default",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[57]=(Name="End",Command="Camera FirstPerson",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[58]=(Name="PageDown",Command="Camera ThirdPerson",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[59]=(Name="PageUp",Command="Camera Fixed",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[60]=(Name="Home",Command="Camera FixedTracking",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[61]=(Name="Insert",Command="Camera FreeCam",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[62]=(Name="XboxTypeS_X",Command="Use",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[63]=(Name="XboxTypeS_A",Command="Jump",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[64]=(Name="XboxTypeS_B",Command="ChangePosture",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[65]=(Name="XboxTypeS_Y",Command="NextWeapon",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[66]=(Name="XboxTypeS_Back",Command="",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[67]=(Name="XboxTypeS_Start",Command="|onrelease showmenu",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[68]=(Name="XboxTypeS_LeftShoulder",Command="obj list",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[69]=(Name="XboxTypeS_RightShoulder",Command="mem",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[70]=(Name="XboxTypeS_DPad_Up",Command="MoveForward",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[71]=(Name="XboxTypeS_DPad_Down",Command="MoveBackward",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[72]=(Name="XboxTypeS_DPad_Left",Command="TurnLeft",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[73]=(Name="XboxTypeS_DPad_Right",Command="TurnRight",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[74]=(Name="XboxTypeS_RightTrigger",Command="Fire",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[75]=(Name="XboxTypeS_LeftTrigger",Command="ToggleTargetingMode",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[76]=(Name="XboxTypeS_LeftX",Command="Axis aStrafe Speed=1.0 DeadZone=0.3",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[77]=(Name="XboxTypeS_LeftY",Command="Axis aBaseY Speed=1.0 DeadZone=0.3",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[78]=(Name="XboxTypeS_RightX",Command="Axis aTurn Speed=1.0 DeadZone=0.2",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[79]=(Name="XboxTypeS_RightY",Command="Axis aLookup Speed=0.8 DeadZone=0.2",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[80]=(Name="XboxTypeS_LeftTriggerAxis",Command="Axis aLeftAnalogTrigger Speed=1.0 DeadZone=0.11",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[81]=(Name="XboxTypeS_RightTriggerAxis",Command="Axis aRightAnalogTrigger Speed=1.0 DeadZone=0.11",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[82]=(Name="MOBILE_StopMatinee",Command="ce stopmatinee | OnRelease StopUseAttractModeInputConfig",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[83]=(Name="MOBILE_StartMatinee",Command="ce playmatinee | OnRelease StartUseAttractModeInputConfig",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[84]=(Name="MOBILE_NextConfig",Command="OnRelease NextMobileInputConfig",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[85]=(Name="MOBILE_CalibrateTilt",Command="CalibrateTilt",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[86]=(Name="MOBILE_ATurn",Command="Axis aTurn DeadZone=0.05",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[87]=(Name="MOBILE_ALookup",Command="Axis aLookup Speed=-1 DeadZone=0.05",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[88]=(Name="MOBILE_AStrafe",Command="Axis aStrafe DeadZone=0.15",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[89]=(Name="MOBILE_AForward",Command="Axis aBaseY DeadZone=0.15",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[90]=(Name="MOBILE_Fire",Command="StartFire | OnRelease StopFire",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[91]=(Name="MOBILE_NextWeapon",Command="NextWeapon",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[92]=(Name="MOBILE_Jump",Command="Jump",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[93]=(Name="MOBILE_ToggleFPS",Command="OnRelease stat fps",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[94]=(Name="NumPadZero",Command="MOBILE_ResetPrimitiveTracking",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[95]=(Name="NumPadOne",Command="MOBILE_IncrementTrackedPrimitive -1",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[96]=(Name="NumPadThree",Command="MOBILE_IncrementTrackedPrimitive 1",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[97]=(Name="WiiU_PointerX",Command="Axis aWiiUPointerX Speed=1.0",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[98]=(Name="WiiU_PointerY",Command="Axis aWiiUPointerY Speed=1.0",Control=false,Shift=false,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[99]=(Name="R",Command="STARTMOVIECAPTURE",Control=false,Shift=false,Alt=true,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
    Bindings[100]=(Name="R",Command="STOPMOVIECAPTURE",Control=false,Shift=true,Alt=false,bIgnoreCtrl=false,bIgnoreShift=false,bIgnoreAlt=false,LeftShoulder=false,LeftTrigger=false,RightShoulder=false,RightTrigger=false,LeftThumbStick=false,RightThumbStick=false,bIgnorePadModifier=false)
}