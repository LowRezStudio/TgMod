class NavMeshGoal_WithinDistanceEnvelope extends NavMeshPathGoalEvaluator
    native(AI);

var() float MaxDistance;
var() float MinDistance;
var() float MinTraversalDist;
var() Vector EnvelopeTestPoint;

static function bool GoalWithinEnvelopeToLoc(NavigationHandle NavHandle, Vector InEnvelopeTestPoint, float InMaxDistance, float InMinDistance, optional float InMinTraversalDist)
{
    local NavMeshGoal_WithinDistanceEnvelope Eval;

    // End:0x124
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_WithinDistanceEnvelope(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0x124
        if(Eval != none)
        {
            Eval.EnvelopeTestPoint = InEnvelopeTestPoint;
            Eval.MaxDistance = InMaxDistance;
            Eval.MinDistance = InMinDistance;
            Eval.MinTraversalDist = InMinTraversalDist;
            NavHandle.AddGoalEvaluator(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    super.Recycle();
    MaxDistance = default.MaxDistance;
    MinDistance = default.MinDistance;
    MinTraversalDist = default.MinTraversalDist;
    EnvelopeTestPoint = default.EnvelopeTestPoint;
    //return;    
}
