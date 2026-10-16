class Goal_Null extends PathGoalEvaluator
    native(AI);

static function bool GoUntilBust(Pawn P, optional int InMaxPathVisits = -1)
{
    local Goal_Null Eval;

    // End:0xC3
    if(P != none)
    {
        Eval = Goal_Null(P.CreatePathGoalEvaluator(default.Class));
        // End:0xC3
        if(Eval != none)
        {
            // End:0x99
            if(InMaxPathVisits > 0)
            {
                Eval.MaxPathVisits = InMaxPathVisits;
            }
            P.AddGoalEvaluator(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    super.Recycle();
    MaxPathVisits = default.MaxPathVisits;
    //return;    
}

defaultproperties
{
    CacheIdx=5
}