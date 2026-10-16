class Goal_AtActor extends PathGoalEvaluator
    native(AI);

var Actor GoalActor;
var float GoalDist;
var bool bKeepPartial;

static function bool AtActor(Pawn P, Actor Goal, optional float Dist, optional bool bReturnPartial)
{
    local Goal_AtActor Eval;
    local Pawn GoalPawn;
    local Controller GoalController;
    local float AnchorDist;

    // End:0x32D
    if(P != none)
    {
        GoalPawn = Pawn(Goal);
        GoalController = Controller(Goal);
        // End:0xB2
        if(GoalController != none)
        {
            // End:0xA7
            if(GoalController.Pawn != none)
            {
                GoalPawn = GoalController.Pawn;                
            }
            else
            {
                Goal = none;
            }
        }
        // End:0x1AE
        if(GoalPawn != none)
        {
            // End:0x150
            if(GoalPawn.ValidAnchor() && GoalPawn.Anchor.IsUsableAnchorFor(P))
            {
                Goal = GoalPawn.Anchor;                
            }
            else
            {
                Goal = P.GetBestAnchor(GoalPawn, GoalPawn.Location, false, false, AnchorDist);
            }            
        }
        else
        {
            // End:0x230
            if(NavigationPoint(Goal) == none)
            {
                Goal = P.GetBestAnchor(Goal, Goal.Location, false, false, AnchorDist);
                // End:0x230
                if(Goal == none)
                {
                }
            }
        }
        // End:0x32D
        if(Goal != none)
        {
            Eval = Goal_AtActor(P.CreatePathGoalEvaluator(default.Class));
            // End:0x32D
            if(Eval != none)
            {
                Eval.GoalActor = Goal;
                Eval.GoalDist = Dist;
                Eval.bKeepPartial = bReturnPartial;
                P.AddGoalEvaluator(Eval);
                return true;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    GoalActor = none;
    GoalDist = default.GoalDist;
    bKeepPartial = default.bKeepPartial;
    super.Recycle();
    //return;    
}

defaultproperties
{
    MaxPathVisits=1024
    CacheIdx=0
}