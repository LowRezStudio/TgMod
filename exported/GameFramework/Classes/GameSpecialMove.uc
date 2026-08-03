class GameSpecialMove extends Object
    abstract
    native(SpecialMoves);

var GamePawn PawnOwner;
var name Handle;
var transient float LastCanDoSpecialMoveTime;
var private bool bLastCanDoSpecialMove;
var const bool bReachPreciseDestination;
var const bool bReachedPreciseDestination;
var const bool bReachPreciseRotation;
var const bool bReachedPreciseRotation;
var bool bForcePrecisePosition;
var const Vector PreciseDestination;
var const Actor PreciseDestBase;
var const Vector PreciseDestRelOffset;
var const float PreciseRotationInterpolationTime;
var const Rotator PreciseRotation;

function InitSpecialMove(GamePawn inPawn, name InHandle)
{
    PawnOwner = inPawn;
    Handle = InHandle;
    //return;    
}

function InitSpecialMoveFlags(out int out_Flags)
{
    //return;    
}

function ExtractSpecialMoveFlags(int Flags)
{
    //return;    
}

function bool CanChainMove(name NextMove)
{
    return false;
    //return ReturnValue;    
}

function bool CanOverrideMoveWith(name NewMove)
{
    return false;
    //return ReturnValue;    
}

function bool CanOverrideSpecialMove(name InMove)
{
    return false;
    //return ReturnValue;    
}

final function bool CanDoSpecialMove(optional bool bForceCheck)
{
    // End:0xBD
    if(PawnOwner != none)
    {
        // End:0xB2
        if(bForceCheck || PawnOwner.WorldInfo.TimeSeconds != LastCanDoSpecialMoveTime)
        {
            bLastCanDoSpecialMove = InternalCanDoSpecialMove();
            LastCanDoSpecialMoveTime = PawnOwner.WorldInfo.TimeSeconds;
        }
        return bLastCanDoSpecialMove;
    }
    return false;
    //return ReturnValue;    
}

protected function bool InternalCanDoSpecialMove()
{
    return true;
    //return ReturnValue;    
}

function SpecialMoveStarted(bool bForced, name PrevMove)
{
    //return;    
}

function SpecialMoveEnded(name PrevMove, name NextMove)
{
    //return;    
}

function Tick(float DeltaTime)
{
    //return;    
}

function SpecialMoveFlagsUpdated()
{
    //return;    
}

function bool ShouldReplicate()
{
    return true;
    //return ReturnValue;    
}

// Export UGameSpecialMove::execSetReachPreciseDestination(FFrame&, void* const)
native final function SetReachPreciseDestination(Vector DestinationToReach, optional bool bCancel);

// Export UGameSpecialMove::execSetFacePreciseRotation(FFrame&, void* const)
native final function SetFacePreciseRotation(Rotator RotationToFace, float InterpolationTime);

event ReachedPrecisePosition()
{
    //return;    
}

// Export UGameSpecialMove::execResetFacePreciseRotation(FFrame&, void* const)
native final function ResetFacePreciseRotation();

function bool MessageEvent(name EventName, Object Sender)
{
    ScriptTrace();
    return false;
    //return ReturnValue;    
}

// Export UGameSpecialMove::execForcePawnRotation(FFrame&, void* const)
native final function ForcePawnRotation(Pawn P, Rotator NewRotation);

// Export UGameSpecialMove::execWorldToRelativeOffset(FFrame&, void* const)
native final function Vector WorldToRelativeOffset(Rotator InRotation, Vector WorldSpaceOffset);

// Export UGameSpecialMove::execRelativeToWorldOffset(FFrame&, void* const)
native final function Vector RelativeToWorldOffset(Rotator InRotation, Vector RelativeSpaceOffset);
