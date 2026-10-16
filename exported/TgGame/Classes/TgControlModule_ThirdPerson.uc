class TgControlModule_ThirdPerson extends TgControlModule;

var int CameraYawOffset;
var float fRotInterpSpeed;
var Vector2D vDazedRotError;
var float fAimPitch;
var InterpCurveFloat PitchCurve;
var InterpCurveFloat AimCurve;
var CameraAnim m_StrafeCameraAnim;

function Init()
{
    super.Init();
    UpdatePitchCurve();
    //return;    
}

function OnSettingsChanged(TgClientSettings Settings)
{
    super.OnSettingsChanged(Settings);
    UpdatePitchCurve();
    //return;    
}

function UpdatePitchCurve()
{
    local InterpCurvePointFloat Point;

    PitchCurve.InterpMethod = 2;
    PitchCurve.Points.Length = 0;
    Point.InVal = -16384.0000000;
    Point.OutVal = -12000.0000000;
    Point.LeaveTangent = 0.5000000;
    Point.ArriveTangent = Point.LeaveTangent;
    Point.InterpMode = 3;
    PitchCurve.Points.AddItem(Point);
    Point.InVal = -12000.0000000;
    // End:0x1D8
    if((Controller != none) && Controller.GetClientSettings() != none)
    {
        Point.OutVal = Controller.GetClientSettings().FixedPitchLowerBoundDegrees * 182.0444000;        
    }
    else
    {
        Point.OutVal = Class'TgGame.TgClientSettings'.default.FixedPitchLowerBoundDegrees * 182.0444000;
    }
    Point.LeaveTangent = 4.0000000;
    Point.ArriveTangent = Point.LeaveTangent;
    Point.InterpMode = 3;
    PitchCurve.Points.AddItem(Point);
    Point.InVal = 0.0000000;
    // End:0x370
    if((Controller != none) && Controller.GetClientSettings() != none)
    {
        Point.OutVal = Controller.GetClientSettings().FixedPitchUpperBoundDegrees * 182.0444000;        
    }
    else
    {
        Point.OutVal = Class'TgGame.TgClientSettings'.default.FixedPitchUpperBoundDegrees * 182.0444000;
    }
    Point.LeaveTangent = 4.0000000;
    Point.ArriveTangent = Point.LeaveTangent;
    Point.InterpMode = 3;
    PitchCurve.Points.AddItem(Point);
    AimCurve.InterpMethod = 2;
    AimCurve.Points.Length = 0;
    Point.InVal = -5000.0000000;
    Point.OutVal = 1.5000000;
    Point.LeaveTangent = 0.0000000;
    Point.ArriveTangent = Point.LeaveTangent;
    Point.InterpMode = 3;
    AimCurve.Points.AddItem(Point);
    Point.InVal = -2000.0000000;
    Point.OutVal = 1.0000000;
    Point.LeaveTangent = 0.0000000;
    Point.ArriveTangent = Point.LeaveTangent;
    Point.InterpMode = 3;
    AimCurve.Points.AddItem(Point);
    //return;    
}

function OnBecomeActive(TgControlModule OldModule)
{
    super.OnBecomeActive(OldModule);
    // End:0x5C
    if(TgControlModule_ThirdPerson(OldModule) != none)
    {
        fAimPitch = TgControlModule_ThirdPerson(OldModule).fAimPitch;
    }
    //return;    
}

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock)
{
    local Rotator OutRotation;
    local TgPawn Pawn;

    // End:0x1E
    if(Controller == none)
    {
        return rot(0, 0, 0);
    }
    Pawn = TgPawn(Controller.Pawn);
    // End:0x6C
    if(Pawn == none)
    {
        return rot(0, 0, 0);
    }
    OutRotation.Yaw = Controller.Rotation.Yaw;
    OutRotation.Pitch = Controller.Rotation.Pitch;
    return OutRotation;
    //return ReturnValue;    
}

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    local TgPawn TgP;

    // End:0x26
    if(Controller.Pawn == none)
    {
        return;
    }
    // End:0x5F
    if(Controller.WorldInfo.IsPlayingTimelapse())
    {
        return;
    }
    TgP = TgPawn(Controller.Pawn);
    // End:0x17D
    if(int(Controller.Role) == int(ROLE_Authority))
    {
        Controller.Pawn.SetRemoteViewPitch(Controller.Rotation.Pitch);
        // End:0x17D
        if(TgP != none)
        {
            TgP.SetUncompressedRemoteViewPitch(Controller.Rotation.Pitch);
        }
    }
    Controller.Pawn.Acceleration = newAccel;
    // End:0x202
    if(int(TgP.Physics) != int(4))
    {
        Controller.CheckJumpOrDuck();
    }
    //return;    
}

function PlayerMove(float DeltaTime)
{
    local Vector newAccel;
    local Actor.EDoubleClickDir DoubleClickMove;
    local Rotator OldRotation;
    local bool bSaveJump, bUpdateRotation, bZeroAccel;
    local TgPawn TgP;
    local bool bFixedPitchMode;

    bFixedPitchMode = IsFixedPitchMode();
    bUpdateRotation = true;
    // End:0x58
    if((Controller == none) || Controller.Pawn == none)
    {
        return;
    }
    TgP = TgPawn(Controller.Pawn);
    // End:0x9A
    if(TgP == none)
    {
        return;
    }
    // End:0xD3
    if(Controller.WorldInfo.IsPlayingTimelapse())
    {
        return;
    }
    // End:0x242
    if((Controller.Pawn.bHardAttach && Controller.Pawn.Base != none) && !Controller.Pawn.Base.bWorldGeometry)
    {
        bZeroAccel = true;
        // End:0x236
        if(TgP != none)
        {
            // End:0x233
            if(TgP.Base.IsA('TgPathfinder'))
            {
                TgP.SetRotation(TgP.Base.Rotation);
            }            
        }
        else
        {
            bUpdateRotation = false;
        }
    }
    // End:0x302
    if(bUpdateRotation)
    {
        // End:0x266
        if(bFixedPitchMode)
        {
            UpdateAimPitch();
        }
        OldRotation = Controller.Rotation;
        Controller.UpdateRotation(DeltaTime);
        // End:0x302
        if(!bFixedPitchMode)
        {
            fAimPitch = float(Controller.Rotation.Pitch);
        }
    }
    Controller.bDoubleJump = false;
    // End:0x346
    if(!bZeroAccel)
    {
        newAccel = CalcNewAccel();
    }
    // End:0x3F0
    if(Controller.PlayerInput.aStrafe > 0.0000000)
    {
        // End:0x3ED
        if(m_StrafeCameraAnim != CameraAnim'PC_Gen.cameras.StrafeRight')
        {
            Controller.PlayCameraAnim(CameraAnim'PC_Gen.cameras.StrafeRight', 1.0000000, 1.0000000, 0.2000000, 0.2000000, false, false,, true);
            m_StrafeCameraAnim = CameraAnim'PC_Gen.cameras.StrafeRight';
        }        
    }
    else
    {
        // End:0x483
        if(Controller.PlayerInput.aStrafe < 0.0000000)
        {
            Controller.PlayCameraAnim(CameraAnim'PC_Gen.cameras.StrafeLeft', 1.0000000, 1.0000000, 0.2000000, 0.2000000, false, false,, true);
            m_StrafeCameraAnim = CameraAnim'PC_Gen.cameras.StrafeLeft';            
        }
        else
        {
            // End:0x4E5
            if(Controller.PlayerCamera != none)
            {
                Controller.PlayerCamera.StopAllCameraAnimsByType(m_StrafeCameraAnim);
            }
            m_StrafeCameraAnim = none;
        }
    }
    DoubleClickMove = Controller.PlayerInput.CheckForDoubleClickMove(DeltaTime / Controller.WorldInfo.TimeDilation);
    // End:0x5F7
    if(Controller.bPressedJump && Controller.Pawn.CannotJumpNow())
    {
        bSaveJump = false;
        Controller.bPressedJump = false;        
    }
    else
    {
        bSaveJump = false;
    }
    // End:0x693
    if(int(Controller.Role) < int(ROLE_Authority))
    {
        Controller.ReplicateMove(DeltaTime, newAccel, DoubleClickMove, OldRotation - Controller.Rotation);        
    }
    else
    {
        Controller.ProcessMove(DeltaTime, newAccel, DoubleClickMove, OldRotation - Controller.Rotation);
    }
    Controller.bPressedJump = bSaveJump;
    //return;    
}

function Vector CalcNewAccel()
{
    local Vector X, Y, Z, newAccel, ViewLocation, PushDir;

    local Rotator ViewRotation, flatRotation;
    local TgPawn myPawn, TgP;
    local float DazeAccel, finalStrafe;
    local bool bInputIsLocked;

    Controller.GetPlayerViewPoint(ViewLocation, ViewRotation);
    bInputIsLocked = IsInputLocked();
    flatRotation = ViewRotation;
    flatRotation.Pitch = 0;
    DazeAccel = 0.0000000;
    finalStrafe = Controller.PlayerInput.aStrafe;
    myPawn = TgPawn(Controller.Pawn);
    // End:0x1BB
    if((((myPawn != none) && myPawn.r_bIsDazed) && myPawn.IsLocallyControlled()) && !bInputIsLocked)
    {
        DazeAccel = 800.0000000 * myPawn.DazedStrafeOffset(0.0000000);
        finalStrafe = FClamp(finalStrafe + DazeAccel, -800.0000000, 800.0000000);
    }
    // End:0x1F4
    if(int(Controller.bRun) == int(1))
    {
        finalStrafe *= 0.5000000;
    }
    // End:0x235
    if((myPawn != none) && myPawn.m_bIsEnteringMount)
    {
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    GetAxes(flatRotation, X, Y, Z);
    newAccel = vect(0.0000000, 0.0000000, 0.0000000);
    // End:0x301
    if(!bInputIsLocked)
    {
        newAccel = (Controller.PlayerInput.aForward * X) + (finalStrafe * Y);
        newAccel.Z = 0.0000000;
    }
    newAccel = Controller.Pawn.AccelRate * Normal(newAccel);
    newAccel += (Y * DazeAccel);
    // End:0x4A4
    if((VSizeSq(newAccel) == float(0)) && myPawn.CanBeNudged())
    {
        // End:0x4A3
        foreach myPawn.TouchingActors(Class'TgGame.TgPawn', TgP)
        {
            // End:0x4A2
            if(TgP.ShouldNudgePlayer(myPawn))
            {
                PushDir = Normal(myPawn.Location - TgP.Location);
                PushDir.Z = 0.0000000;
                newAccel = PushDir * (myPawn.GroundSpeed / 2.0000000);
                // End:0x4A3
                break;
            }            
        }        
    }
    return newAccel;
    //return ReturnValue;    
}

function bool IsPlayingForcedViewCameraAnim()
{
    local TgPawn_Character myCharPawn;

    myCharPawn = TgPawn_Character(Controller.Pawn);
    // End:0x63
    if(myCharPawn != none)
    {
        return myCharPawn.HasForcedRotation();        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

function UpdateRotation(float DeltaTime)
{
    local Rotator NewRotation, DeltaRot;
    local Vector2D DazeRotNow, vDazedRotLast, IdealDeltaRot;
    local TgPawn myPawn;
    local TgPawn_Character myCharPawn;
    local bool bInputIsLocked, bCameraIsLocked, bRotationIsLocked, bFixedPitchMode, bYawIsLocked;

    local float fTargetPitch;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    // End:0x4A
    if(Controller.WorldInfo.IsPlayingTimelapse())
    {
        return;
    }
    myPawn = TgPawn(Controller.Pawn);
    myCharPawn = TgPawn_Character(Controller.Pawn);
    // End:0xF4
    if((myCharPawn != none) && IsPlayingForcedViewCameraAnim())
    {
        myCharPawn.UpdateForcedRotation(DeltaTime);
        return;
    }
    bInputIsLocked = IsInputLocked();
    bCameraIsLocked = IsCameraLocked();
    bRotationIsLocked = IsRotationLocked();
    bFixedPitchMode = IsFixedPitchMode();
    bYawIsLocked = IsYawLocked();
    NewRotation = Controller.Rotation;
    DeltaRot.Yaw = int(((bYawIsLocked) ? 0.0000000 : Controller.PlayerInput.aTurn));
    // End:0x25D
    if(!bFixedPitchMode && !bCameraIsLocked)
    {
        DeltaRot.Pitch = int(Controller.PlayerInput.aLookUp);
    }
    // End:0x294
    if(myPawn != none)
    {
        myPawn.InterceptInputDeltaRotation(DeltaRot);
    }
    NewRotation += DeltaRot;
    // End:0x7D5
    if(myPawn != none)
    {
        // End:0x5FA
        if(!bInputIsLocked)
        {
            // End:0x5DC
            if(myPawn.r_bIsDazed && myPawn.IsLocallyControlled())
            {
                vDazedRotLast = myPawn.DazedRotatorOffset(-DeltaTime);
                DazeRotNow = myPawn.DazedRotatorOffset(0.0000000);
                IdealDeltaRot.X = (DazeRotNow.X - vDazedRotLast.X) + vDazedRotError.X;
                IdealDeltaRot.Y = (DazeRotNow.Y - vDazedRotLast.Y) + vDazedRotError.Y;
                DeltaRot.Yaw = int(IdealDeltaRot.X);
                // End:0x4E1
                if(!bFixedPitchMode)
                {
                    DeltaRot.Pitch = int(IdealDeltaRot.Y);                    
                }
                else
                {
                    DeltaRot.Pitch = 0;
                }
                NewRotation += DeltaRot;
                vDazedRotError.X = IdealDeltaRot.X - float(DeltaRot.Yaw);
                vDazedRotError.Y = IdealDeltaRot.Y - float(DeltaRot.Pitch);
                vDazedRotLast = DazeRotNow;                
            }
            else
            {
                vDazedRotError = vect2d(0.0000000, 0.0000000);
            }
        }
        // End:0x6BD
        if(bFixedPitchMode)
        {
            fTargetPitch = EvalInterpCurveFloat(PitchCurve, fAimPitch);
            fTargetPitch = myPawn.ApplyPitchLimit(fTargetPitch);
            NewRotation.Pitch = int(FInterpTo(float(NewRotation.Pitch), fTargetPitch, DeltaTime, 500.0000000));
        }
        NewRotation.Pitch = int(myPawn.ApplyPitchLimit(float(NewRotation.Pitch)));
        // End:0x775
        if(bInputIsLocked || bRotationIsLocked)
        {
            myPawn.m_fRemainingFaceRotationInterpTime = myPawn.m_fFaceRotationInterpTime;            
        }
        else
        {
            myPawn.SetDesiredRotation(NewRotation);
            myPawn.FaceRotation(NewRotation, DeltaTime);
        }        
    }
    else
    {
        NewRotation.Pitch = int(FClamp(float(NewRotation.Pitch), -12000.0000000, 12000.0000000));
        fAimPitch = float(NewRotation.Pitch);
    }
    // End:0x876
    if(!bCameraIsLocked)
    {
        Controller.SetRotation(NewRotation);
    }
    //return;    
}

function UpdateAimPitch()
{
    local Vector PawnFootLocation;
    local Rotator PawnFootViewRotation;
    local Vector ViewLocation;
    local Rotator ViewRotation;

    Controller.GetPlayerViewPoint(ViewLocation, ViewRotation);
    fAimPitch += (Controller.PlayerInput.aLookUp * EvalInterpCurveFloat(AimCurve, fAimPitch));
    PawnFootViewRotation.Pitch = -16384;
    // End:0x175
    if(Controller.Pawn != none)
    {
        PawnFootLocation = Controller.Pawn.Location + (vect(0.0000000, 0.0000000, -1.0000000) * Controller.Pawn.GetCollisionHeight());
        PawnFootViewRotation = Rotator(PawnFootLocation - ViewLocation);
    }
    fAimPitch = FClamp(fAimPitch, float(PawnFootViewRotation.Pitch), 0.0000000);
    //return;    
}

function bool IsInputLocked()
{
    local TgPawn myPawn;

    // End:0x11
    if(Controller == none)
    {
        return false;
    }
    myPawn = TgPawn(Controller.Pawn);
    // End:0xA4
    if(myPawn != none)
    {
        return ((IsCameraLocked()) || Controller.IsDeviceLockingInput()) || myPawn.IsInputLocked();
    }
    return IsCameraLocked();
    //return ReturnValue;    
}

function bool IsRotationLocked()
{
    local TgPawn myPawn;

    // End:0x11
    if(Controller == none)
    {
        return false;
    }
    myPawn = TgPawn(Controller.Pawn);
    // End:0x71
    if(myPawn != none)
    {
        return myPawn.IsRotationLocked();
    }
    return false;
    //return ReturnValue;    
}

function bool IsCameraLocked()
{
    local TgPawn myPawn;

    // End:0x11
    if(Controller == none)
    {
        return false;
    }
    myPawn = TgPawn(Controller.Pawn);
    // End:0x77
    if((myPawn != none) && myPawn.IsCameraLocked())
    {
        return true;
    }
    return Controller.IsDeviceLockingCamera();
    //return ReturnValue;    
}

function bool IsYawLocked()
{
    local TgPawn myPawn;

    // End:0x24
    if(Controller.r_bLockYawRotation)
    {
        return true;
    }
    myPawn = TgPawn(Controller.Pawn);
    // End:0x8A
    if((myPawn != none) && myPawn.IsCameraLocked())
    {
        return true;
    }
    return Controller.r_bLockYawRotation;
    //return ReturnValue;    
}

function bool IsFixedPitchMode()
{
    return false;
    //return ReturnValue;    
}

function AdjustAimingView(out Vector ViewLocation, out Rotator ViewRotation)
{
    // End:0x59
    if(IsFixedPitchMode())
    {
        // End:0x31
        if(Controller.Pawn != none)
        {
        }
        ViewRotation.Pitch = int(fAimPitch);
    }
    //return;    
}

defaultproperties
{
    fRotInterpSpeed=16.0000000
}