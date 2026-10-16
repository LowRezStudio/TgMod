class SavedMove extends Object
    native;

var SavedMove NextMove;
var float TimeStamp;
var float Delta;
var bool bRun;
var bool bDuck;
var bool bPressedJump;
var bool bDoubleJump;
var bool bPreciseDestination;
var bool bForceRMVelocity;
var bool bForceMaxAccel;
var bool bRootMotionFromInterpCurve;
var Actor.EDoubleClickDir DoubleClickMove;
var Actor.EPhysics SavedPhysics;
var SkeletalMeshComponent.ERootMotionMode RootMotionMode;
var Vector StartLocation;
var Vector StartRelativeLocation;
var Vector StartVelocity;
var Vector StartFloor;
var Vector SavedLocation;
var Vector SavedVelocity;
var Vector SavedRelativeLocation;
var Vector RMVelocity;
var Vector Acceleration;
var Rotator Rotation;
var Actor StartBase;
var Actor EndBase;
var float CustomTimeDilation;
var float AccelDotThreshold;
var float RootMotionInterpCurrentTime;
var Vector RootMotionInterpCurveLastValue;

function Clear()
{
    TimeStamp = 0.0000000;
    Delta = 0.0000000;
    DoubleClickMove = 0;
    Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    StartVelocity = vect(0.0000000, 0.0000000, 0.0000000);
    bRun = false;
    bDuck = false;
    bPressedJump = false;
    bDoubleJump = false;
    bPreciseDestination = false;
    bForceRMVelocity = false;
    CustomTimeDilation = 1.0000000;
    //return;    
}

function PostUpdate(PlayerController P)
{
    bDoubleJump = P.bDoubleJump || bDoubleJump;
    // End:0x1E3
    if(P.Pawn != none)
    {
        RMVelocity = P.Pawn.RMVelocity;
        SavedLocation = P.Pawn.Location;
        SavedVelocity = P.Pawn.Velocity;
        EndBase = P.Pawn.Base;
        // End:0x1E3
        if((EndBase != none) && !EndBase.bWorldGeometry)
        {
            SavedRelativeLocation = P.Pawn.Location - EndBase.Location;
        }
    }
    Rotation = P.Rotation;
    //return;    
}

function bool IsImportantMove(Vector CompareAccel)
{
    local Vector AccelNorm;

    // End:0x60
    if((bPressedJump || bDoubleJump) || ((int(DoubleClickMove) != int(0)) && int(DoubleClickMove) != int(5)) && int(DoubleClickMove) != int(6))
    {
        return true;
    }
    // End:0x6F
    if(bRootMotionFromInterpCurve)
    {
        return true;
    }
    AccelNorm = Normal(Acceleration);
    return (CompareAccel != AccelNorm) && (CompareAccel Dot AccelNorm) < AccelDotThreshold;
    //return ReturnValue;    
}

function Vector GetStartLocation()
{
    // End:0x5F
    if((StartBase != none) && !StartBase.bWorldGeometry)
    {
        return StartBase.Location + StartRelativeLocation;
    }
    return StartLocation;
    //return ReturnValue;    
}

function SetInitialPosition(Pawn P)
{
    SavedPhysics = P.Physics;
    StartLocation = P.Location;
    StartVelocity = P.Velocity;
    StartBase = P.Base;
    StartFloor = P.Floor;
    CustomTimeDilation = P.CustomTimeDilation;
    // End:0x16D
    if((StartBase != none) && !StartBase.bWorldGeometry)
    {
        StartRelativeLocation = P.Location - StartBase.Location;
    }
    bRootMotionFromInterpCurve = P.bRootMotionFromInterpCurve;
    // End:0x231
    if(bRootMotionFromInterpCurve)
    {
        RootMotionInterpCurrentTime = P.RootMotionInterpCurrentTime;
        RootMotionInterpCurveLastValue = P.RootMotionInterpCurveLastValue;
        RootMotionMode = P.Mesh.RootMotionMode;
    }
    //return;    
}

function bool CanCombineWith(SavedMove NewMove, Pawn inPawn, float MaxDelta)
{
    // End:0x11
    if(inPawn == none)
    {
        return false;
    }
    // End:0x20
    if(bRootMotionFromInterpCurve)
    {
        return false;
    }
    // End:0x6A
    if((inPawn.Base != none) && inPawn.bHardAttach)
    {
        return false;
    }
    // End:0x2F1
    if(NewMove.Acceleration == vect(0.0000000, 0.0000000, 0.0000000))
    {
        return ((((((((((((((Acceleration == vect(0.0000000, 0.0000000, 0.0000000)) && StartVelocity == vect(0.0000000, 0.0000000, 0.0000000)) && NewMove.StartVelocity == vect(0.0000000, 0.0000000, 0.0000000)) && int(SavedPhysics) == int(inPawn.Physics)) && !bPressedJump) && !NewMove.bPressedJump) && bRun == NewMove.bRun) && bDuck == NewMove.bDuck) && bPreciseDestination == NewMove.bPreciseDestination) && bDoubleJump == NewMove.bDoubleJump) && (int(DoubleClickMove) == int(0)) || int(DoubleClickMove) == int(5)) && int(NewMove.DoubleClickMove) == int(DoubleClickMove)) && !bForceRMVelocity) && !NewMove.bForceRMVelocity) && CustomTimeDilation == NewMove.CustomTimeDilation;        
    }
    else
    {
        return ((((((((((((((inPawn != none) && (NewMove.Delta + Delta) < MaxDelta) && int(SavedPhysics) == int(inPawn.Physics)) && !bPressedJump) && !NewMove.bPressedJump) && bRun == NewMove.bRun) && bDuck == NewMove.bDuck) && bDoubleJump == NewMove.bDoubleJump) && bPreciseDestination == NewMove.bPreciseDestination) && (int(DoubleClickMove) == int(0)) || int(DoubleClickMove) == int(5)) && int(NewMove.DoubleClickMove) == int(DoubleClickMove)) && (Normal(Acceleration) Dot Normal(NewMove.Acceleration)) > 0.9900000) && !bForceRMVelocity) && !NewMove.bForceRMVelocity) && CustomTimeDilation == NewMove.CustomTimeDilation;
    }
    //return ReturnValue;    
}

function SetMoveFor(PlayerController P, float DeltaTime, Vector newAccel, Actor.EDoubleClickDir InDoubleClick)
{
    Delta = DeltaTime;
    // End:0x48
    if(VSize(newAccel) > float(26214))
    {
        newAccel = float(26214) * Normal(newAccel);
    }
    // End:0x94
    if(P.Pawn != none)
    {
        SetInitialPosition(P.Pawn);
    }
    Acceleration = newAccel;
    DoubleClickMove = InDoubleClick;
    bRun = int(P.bRun) > int(0);
    bDuck = int(P.bDuck) > int(0);
    bPressedJump = P.bPressedJump;
    bDoubleJump = P.bDoubleJump;
    bPreciseDestination = P.bPreciseDestination;
    bForceRMVelocity = P.bPreciseDestination || (((P.Pawn != none) && P.Pawn.Mesh != none) && !P.Pawn.bRootMotionFromInterpCurve) && (int(P.Pawn.Mesh.RootMotionMode) == int(3)) || int(P.Pawn.Mesh.RootMotionMode) == int(1);
    bForceMaxAccel = (P.Pawn != none) && P.Pawn.bForceMaxAccel;
    TimeStamp = P.WorldInfo.TimeSeconds;
    //return;    
}

function PrepMoveFor(Pawn P)
{
    // End:0x146
    if(P != none)
    {
        P.bForceRMVelocity = bForceRMVelocity;
        P.bForceMaxAccel = bForceMaxAccel;
        P.bRootMotionFromInterpCurve = bRootMotionFromInterpCurve;
        // End:0x146
        if(P.bRootMotionFromInterpCurve)
        {
            P.Mesh.RootMotionMode = RootMotionMode;
            P.RootMotionInterpCurveLastValue = RootMotionInterpCurveLastValue;
            P.SetRootMotionInterpCurrentTime(RootMotionInterpCurrentTime, Delta, true);
        }
    }
    //return;    
}

function ResetMoveFor(Pawn P)
{
    // End:0x125
    if(P != none)
    {
        SavedLocation = P.Location;
        SavedVelocity = P.Velocity;
        EndBase = P.Base;
        // End:0x104
        if((EndBase != none) && !EndBase.bWorldGeometry)
        {
            SavedRelativeLocation = P.Location - EndBase.Location;
        }
        P.bForceRMVelocity = false;
    }
    //return;    
}

function byte CompressedFlags()
{
    local byte Result;

    Result = DoubleClickMove;
    // End:0x2D
    if(bRun)
    {
        Result += 8;
    }
    // End:0x47
    if(bDuck)
    {
        Result += 16;
    }
    // End:0x61
    if(bPressedJump)
    {
        Result += 32;
    }
    // End:0x7B
    if(bDoubleJump)
    {
        Result += 64;
    }
    // End:0x95
    if(bPreciseDestination)
    {
        Result += 128;
    }
    return Result;
    //return ReturnValue;    
}

static function Actor.EDoubleClickDir SetFlags(byte Flags, PlayerController PC)
{
    // End:0x3B
    if((int(Flags) & int(8)) != 0)
    {
        PC.bRun = 1;        
    }
    else
    {
        PC.bRun = 0;
    }
    // End:0x97
    if((int(Flags) & int(16)) != 0)
    {
        PC.bDuck = 1;        
    }
    else
    {
        PC.bDuck = 0;
    }
    PC.bPreciseDestination = (int(Flags) & int(128)) != 0;
    PC.bDoubleJump = (int(Flags) & int(64)) != 0;
    PC.bPressedJump = (int(Flags) & int(32)) != 0;
    switch(int(Flags) & int(7))
    {
        // End:0x179
        case 0:
            return 0;
            // End:0x1A7
            break;
        // End:0x183
        case 1:
            return 1;
            // End:0x1A7
            break;
        // End:0x18E
        case 2:
            return 2;
            // End:0x1A7
            break;
        // End:0x199
        case 3:
            return 3;
            // End:0x1A7
            break;
        // End:0x1A4
        case 4:
            return 4;
            // End:0x1A7
            break;
        // End:0xFFFF
        default:
            break;
    }
    return 0;
    //return ReturnValue;    
}

function string GetDebugString()
{
    local string Str;

    Str = (((((((((((((((((((((((((((((string(self) @ "Delta:'") $ string(Delta)) $ "'") @ "SavedPhysics:'") $ string(SavedPhysics)) $ "'") @ "StartLocation:'") $ string(StartLocation)) $ "'") @ "StartVelocity:'") $ string(StartVelocity)) $ "'") @ "SavedLocation:'") $ string(SavedLocation)) $ "'") @ "SavedVelocity:'") $ string(SavedVelocity)) $ "'") @ "RMVelocity:'") $ string(RMVelocity)) $ "'") @ "Acceleration:'") $ string(Acceleration)) $ "'") @ "bRootMotionFromInterpCurve:'") $ string(bRootMotionFromInterpCurve)) $ "'") @ "RootMotionInterpCurrentTime:'") $ string(RootMotionInterpCurrentTime)) $ "'";
    return Str;
    //return ReturnValue;    
}

defaultproperties
{
    AccelDotThreshold=0.9000000
}