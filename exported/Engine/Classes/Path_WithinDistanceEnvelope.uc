class Path_WithinDistanceEnvelope extends PathConstraint
    native(AI);

var() float MaxDistance;
var() float MinDistance;
var() bool bSoft;
var() bool bOnlyThrowOutNodesThatLeaveEnvelope;
var() float SoftStartPenalty;
var() Vector EnvelopeTestPoint;

static function bool StayWithinEnvelopeToLoc(Pawn P, Vector InEnvelopeTestPoint, float InMaxDistance, float InMinDistance, optional bool bInSoft = true, optional float InSoftStartPenalty = -1.0000000, optional bool bOnlyTossOutSpecsThatLeave)
{
    local Path_WithinDistanceEnvelope Con;

    // End:0x199
    if(P != none)
    {
        Con = Path_WithinDistanceEnvelope(P.CreatePathConstraint(default.Class));
        // End:0x199
        if(Con != none)
        {
            Con.EnvelopeTestPoint = InEnvelopeTestPoint;
            Con.bSoft = bInSoft;
            Con.MaxDistance = InMaxDistance;
            Con.MinDistance = InMinDistance;
            Con.bOnlyThrowOutNodesThatLeaveEnvelope = bOnlyTossOutSpecsThatLeave;
            // End:0x16F
            if(InSoftStartPenalty > -1.0000000)
            {
                Con.SoftStartPenalty = InSoftStartPenalty;
            }
            P.AddPathConstraint(Con);
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
    bSoft = default.bSoft;
    SoftStartPenalty = default.SoftStartPenalty;
    EnvelopeTestPoint = default.EnvelopeTestPoint;
    bOnlyThrowOutNodesThatLeaveEnvelope = default.bOnlyThrowOutNodesThatLeaveEnvelope;
    //return;    
}

defaultproperties
{
    bSoft=true
    SoftStartPenalty=320.0000000
    CacheIdx=3
}