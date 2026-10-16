class GameAICmd_Hover_MoveToGoal_Mesh extends GameAICommand within GameAIController;

var transient Actor Find;
var float Radius;
var transient bool bWasFiring;
var bool bFinalApproach;
var bool bFallbackMoveToMesh;
var float DesiredHoverHeight;
var transient float CurrentHoverHeight;
var float SubGoalReachDist;
var transient float GoalDistance;
var transient Vector IntermediatePoint;
var transient Vector LastMovePoint;
var transient int NumMovePointFails;
var int MaxMovePointFails;
var transient Vector FallbackDest;
var transient Actor MoveToActor;
var BasedPosition LastMoveTargetPathLocation;
var transient Vector InitialFinalDestination;

static function bool HoverToGoal(GameAIController AI, Actor InGoal, float InGoalDistance, float InHoverHeight)
{
    local GameAICmd_Hover_MoveToGoal_Mesh Cmd;

    // End:0x1AE
    if(((AI != none) && AI.Pawn != none) && AI.Pawn.bCanFly)
    {
        Cmd = new (AI) Class'GameFramework.GameAICmd_Hover_MoveToGoal_Mesh';
        // End:0x1AE
        if(Cmd != none)
        {
            Cmd.GoalDistance = InGoalDistance;
            Cmd.MoveToActor = InGoal;
            Cmd.InitialFinalDestination = InGoal.GetDestination(AI);
            Cmd.DesiredHoverHeight = InHoverHeight;
            Cmd.CurrentHoverHeight = InHoverHeight;
            AI.PushCommand(Cmd);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

static function bool HoverToPoint(GameAIController AI, Vector InPoint, float InGoalDistance, float InHoverHeight)
{
    local GameAICmd_Hover_MoveToGoal_Mesh Cmd;

    // End:0x187
    if(((AI != none) && AI.Pawn != none) && AI.Pawn.bCanFly)
    {
        Cmd = new (AI) Class'GameFramework.GameAICmd_Hover_MoveToGoal_Mesh';
        // End:0x187
        if(Cmd != none)
        {
            Cmd.GoalDistance = InGoalDistance;
            Cmd.MoveToActor = none;
            Cmd.InitialFinalDestination = InPoint;
            Cmd.DesiredHoverHeight = InHoverHeight;
            Cmd.CurrentHoverHeight = InHoverHeight;
            AI.PushCommand(Cmd);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

static function bool HoverBackToMesh(GameAIController AI)
{
    local GameAICmd_Hover_MoveToGoal_Mesh Cmd;

    // End:0xE8
    if(((AI != none) && AI.Pawn != none) && AI.Pawn.bCanFly)
    {
        Cmd = new (AI) Class'GameFramework.GameAICmd_Hover_MoveToGoal_Mesh';
        // End:0xE8
        if(Cmd != none)
        {
            Cmd.bFallbackMoveToMesh = true;
            AI.PushCommand(Cmd);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Pushed()
{
    super.Pushed();
    // End:0x27
    if(bFallbackMoveToMesh)
    {
        GotoState('Fallback_Breadcrumbs');
        return;
    }
    // End:0x7A
    if(!Outer.NavigationHandle.ComputeValidFinalDestination(InitialFinalDestination))
    {
        GotoState('DelayFailure');        
    }
    else
    {
        // End:0xCE
        if(!Outer.NavigationHandle.SetFinalDestination(InitialFinalDestination))
        {
            GotoState('DelayFailure');            
        }
        else
        {
            GotoState('Moving');
        }
    }
    //return;    
}

function Popped()
{
    super.Popped();
    Outer.ClearLatentAction(Class'Engine.SeqAct_AIMoveToActor', Status != 'Success');
    Outer.NavigationHandle.PathCache_Empty();
    // End:0x10C
    if(Outer.Pawn != none)
    {
        Outer.Pawn.ZeroMovementVariables();
        Outer.Pawn.DestinationOffset = 0.0000000;
    }
    Outer.ReachedMoveGoal();
    //return;    
}

function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
    // End:0x87
    if(ShouldUpdateBreadCrumbs())
    {
        Outer.NavigationHandle.UpdateBreadCrumbs(Outer.Pawn.Location);
    }
    Outer.NavigationHandle.DrawBreadCrumbs();
    //return;    
}

function bool HandlePathObstruction(Actor BlockedBy)
{
    Outer.MoveTimer = -1.0000000;
    GotoState('Fallback_Breadcrumbs');
    return false;
    //return ReturnValue;    
}

function ReEvaluatePath()
{
    //return;    
}

function bool HasReachedGoal()
{
    // End:0x26
    if(Outer.Pawn == none)
    {
        return true;
    }
    // End:0x82
    if(bFinalApproach && MoveToActor != none)
    {
        return Outer.Pawn.ReachedDestination(MoveToActor);
    }
    // End:0x207
    if(Outer.BP2Vect(Outer.NavigationHandle.FinalDestination) != vect(0.0000000, 0.0000000, 0.0000000))
    {
        // End:0x17F
        if(VSize(Outer.BP2Vect(Outer.NavigationHandle.FinalDestination) - Outer.Pawn.Location) < GoalDistance)
        {
            return true;
        }
        return Outer.Pawn.ReachedPoint(Outer.BP2Vect(Outer.NavigationHandle.FinalDestination), none);
    }
    return false;
    //return ReturnValue;    
}

function bool ShouldUpdateBreadCrumbs()
{
    return true;
    //return ReturnValue;    
}

function bool IsEnemyBasedOnInterpActor(Pawn InEnemy)
{
    return false;
    //return ReturnValue;    
}

event DrawDebug(HUD H, name Category)
{
    super.DrawDebug(H, Category);
    // End:0x35
    if(Category != 'Pathing')
    {
        return;
    }
    Outer.DrawDebugLine(Outer.Pawn.Location, Outer.GetDestinationPosition(), 0, 0, 255);
    Outer.DrawDebugLine(Outer.Pawn.Location, Outer.BP2Vect(Outer.NavigationHandle.FinalDestination), 0, 255, 0);
    Outer.NavigationHandle.DrawPathCache(vect(0.0000000, 0.0000000, 15.0000000));
    //return;    
}

state DelayFailure
{
    ignores HandlePathObstruction;
Begin:

    Outer.Sleep(0.5000000);
    Status = 'Failure';
    Outer.PopCommand(self);
    stop;                
}

state MoveDown
{
    function Vector GetMoveDest()
    {
        local Vector HitLocation, HitNormal, Dest;
        local Actor HitActor;

        // End:0x1BB
        if(Outer.NavigationHandle.LineCheck(Outer.Pawn.Location, Outer.Pawn.Location + vect(0.0000000, 0.0000000, -4096.0000000), vect(5.0000000, 5.0000000, 5.0000000), HitLocation, HitNormal))
        {
            HitActor = Outer.Trace(HitLocation, HitNormal, Outer.Pawn.Location + vect(0.0000000, 0.0000000, -4096.0000000), Outer.Pawn.Location);
            // End:0x1BB
            if(HitActor == none)
            {
                return Outer.Pawn.Location;
            }
        }
        Dest = HitLocation;
        Dest.Z += (Outer.Pawn.GetCollisionHeight() * 1.5000000);
        return Dest;
        //return ReturnValue;        
    }
Begin:

    Outer.MoveTo(GetMoveDest());
    Outer.Sleep(1.0000000);
    GotoState('Moving');
    stop;                
}

state Moving
{
    final function float GetMoveDestinationOffset()
    {
        // End:0x1A
        if(bFinalApproach)
        {
            return GoalDistance;            
        }
        else
        {
            return SubGoalReachDist - Outer.Pawn.GetCollisionRadius();
        }
        //return ReturnValue;        
    }
CheckMove:

    // End:0x17
    if(HasReachedGoal())
    {
        goto 'ReachedGoal';
    }
Begin:


    // End:0xAF
    if(Outer.Enemy != none)
    {
        Radius = Outer.Pawn.GetCollisionRadius() + Outer.Enemy.GetCollisionRadius();
    }
    Radius = FMax(Radius, GoalDistance);
    Outer.NavigationHandle.SetFinalDestination(InitialFinalDestination);
    // End:0x1F5
    if(Outer.NavigationHandle.PointReachable(Outer.BP2Vect(Outer.NavigationHandle.FinalDestination)))
    {
        IntermediatePoint = Outer.BP2Vect(Outer.NavigationHandle.FinalDestination);        
    }
    else
    {
        // End:0x270
        if(MoveToActor != none)
        {
            // End:0x270
            if(!Outer.NavigationHandle.SetFinalDestination(MoveToActor.GetDestination(Outer)))
            {
                goto 'FailedMove';
            }
        }
        // End:0x2FE
        if(!Outer.GeneratePathToLocation(Outer.BP2Vect(Outer.NavigationHandle.FinalDestination), GoalDistance, true))
        {
            GotoState('Fallback_Breadcrumbs');
        }
        // End:0x353
        if(!Outer.NavigationHandle.GetNextMoveLocation(IntermediatePoint, SubGoalReachDist))
        {
            goto 'FailedMove';
        }
    }
    // End:0x3B3
    if(MoveToActor != none)
    {
        Outer.Vect2BP(LastMoveTargetPathLocation, MoveToActor.GetDestination(Outer));
    }
    J0x3B3:

    // End:0x963 [Loop If]
    if(true)
    {
        bFinalApproach = VSizeSq(IntermediatePoint - Outer.BP2Vect(Outer.NavigationHandle.FinalDestination)) < 1.0000000;
        // End:0x542
        if(bFinalApproach && MoveToActor != none)
        {
            Outer.Vect2BP(LastMoveTargetPathLocation, MoveToActor.GetDestination(Outer));
            Outer.NavigationHandle.SetFinalDestination(MoveToActor.GetDestination(Outer));
            Outer.MoveToward(MoveToActor, Outer.Enemy, GetMoveDestinationOffset(), false);            
        }
        else
        {
            // End:0x58F
            if(Outer.Enemy == none)
            {
                Outer.SetFocalPoint(IntermediatePoint);
            }
            Outer.MoveTo(IntermediatePoint, Outer.Enemy, GetMoveDestinationOffset());
        }
        // End:0x5F3
        if(HasReachedGoal())
        {
            goto 'CheckMove';            
        }
        else
        {
            // End:0x6C0
            if((MoveToActor != none) && VSize(MoveToActor.GetDestination(Outer) - Outer.BP2Vect(LastMoveTargetPathLocation)) > 512.0000000)
            {
                Outer.Vect2BP(LastMoveTargetPathLocation, MoveToActor.GetDestination(Outer));
                goto 'CheckMove';                
            }
            else
            {
                // End:0x8A9
                if(!Outer.NavigationHandle.GetNextMoveLocation(IntermediatePoint, SubGoalReachDist))
                {
                    // End:0x87F
                    if(!bFinalApproach && ((MoveToActor != none) ? Outer.ActorReachable(MoveToActor) : Outer.PointReachable(Outer.BP2Vect(Outer.NavigationHandle.FinalDestination))))
                    {
                        IntermediatePoint = ((MoveToActor != none) ? MoveToActor.GetDestination(Outer) : Outer.BP2Vect(Outer.NavigationHandle.FinalDestination));
                        Outer.Sleep(RandRange(0.1000000, 0.1750000));                        
                    }
                    else
                    {
                        Outer.Sleep(0.1000000);
                        goto 'FailedMove';
                    }                    
                }
                else
                {
                    // End:0x90D
                    if(VSize(IntermediatePoint - LastMovePoint) < (Outer.Pawn.GetCollisionRadius() * 0.1000000))
                    {
                        NumMovePointFails++;                        
                    }
                    else
                    {
                        NumMovePointFails = 0;
                    }
                    LastMovePoint = IntermediatePoint;
                    // End:0x960
                    if((NumMovePointFails >= MaxMovePointFails) && MaxMovePointFails >= 0)
                    {
                        goto 'FailedMove';                        
                    }
                }
            }
        }
        // [Loop Continue]
        goto J0x3B3;
    }
    goto 'CheckMove';
FailedMove:


    Outer.MoveTo(Outer.Pawn.Location);
    Outer.Pawn.ZeroMovementVariables();
    GotoState('DelayFailure');
ReachedGoal:


    Status = 'Success';
    Outer.PopCommand(self);
    stop;                
}

state Fallback_Breadcrumbs
{
    function bool ShouldUpdateBreadCrumbs()
    {
        return false;
        //return ReturnValue;        
    }

    function bool HandlePathObstruction(Actor BlockedBy)
    {
        Outer.Pawn.SetLocation(IntermediatePoint);
        Outer.MoveTimer = -1.0000000;
        GotoState('Fallback_Breadcrumbs', 'Begin');
        return true;
        //return ReturnValue;        
    }
Begin:

    // End:0xDC
    if(Outer.NavigationHandle.GetNextBreadCrumb(IntermediatePoint))
    {
        Outer.MoveToDirectNonPathPos(IntermediatePoint);
        // End:0xB2
        if(!Outer.NavigationHandle.IsAnchorInescapable())
        {
            GotoState('Moving');
        }
        Outer.Sleep(0.1000000);
        goto 'Begin';        
    }
    else
    {
        // End:0x12E
        if(!Outer.NavigationHandle.IsAnchorInescapable())
        {
            GotoState('Moving', 'Begin');            
        }
        else
        {
            GotoState('Fallback_FindNearbyMeshPoint');
        }
    }
    stop;                
}

state Fallback_FindNearbyMeshPoint
{
    function bool FindAPointWhereICanHoverTo(out Vector out_FallbackDest, float Inradius, optional float MinRadius = 0.0000000, optional float entityRadius = 32.0000000, optional bool bDirectOnly = true, optional int MaxPoints = -1, optional float ValidHitBoxSize)
    {
        local Vector Retval;
        local array<Vector> poses;
        local Vector Extent, validhitbox;

        Extent.X = entityRadius;
        Extent.Y = entityRadius;
        Extent.Z = entityRadius;
        validhitbox = vect(1.0000000, 1.0000000, 1.0000000) * ValidHitBoxSize;
        Outer.NavigationHandle.GetValidPositionsForBox(Outer.Pawn.Location, Inradius, Extent, bDirectOnly, poses, MaxPoints, MinRadius, validhitbox);
        // End:0x1CF
        if(poses.Length > 0)
        {
            Retval = poses[Rand(poses.Length)];
            // End:0x1BA
            if(VSize(Retval) == 0.0000000)
            {
                out_FallbackDest = vect(0.0000000, 0.0000000, 0.0000000);
                return false;
            }
            out_FallbackDest = Retval;
            return true;
        }
        out_FallbackDest = vect(0.0000000, 0.0000000, 0.0000000);
        return false;
        //return ReturnValue;        
    }

    function bool ShouldUpdateBreadCrumbs()
    {
        return false;
        //return ReturnValue;        
    }
Begin:

    // End:0x33
    if(!FindAPointWhereICanHoverTo(FallbackDest, 2048.0000000))
    {
        GotoState('MoveDown');        
    }
    else
    {
        Outer.MoveToDirectNonPathPos(FallbackDest,, SubGoalReachDist);
        Outer.Sleep(0.5000000);
        // End:0xA1
        if(bFallbackMoveToMesh)
        {
            GotoState('DelaySuccess');            
        }
        else
        {
            GotoState('Moving', 'Begin');
        }
    }
    stop;                    
}

defaultproperties
{
    SubGoalReachDist=128.0000000
    MaxMovePointFails=5
}