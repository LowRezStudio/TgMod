class SplineAudioComponent extends AudioComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,ActorComponent,Object,ActorComponent);

struct InterpPointOnSpline
{
    var() Vector Position;
    var() float InVal;
    var() float Length;

    structdefaultproperties
    {
        Position=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        InVal=0.0000000
        Length=0.0000000
    }
};

var() float ListenerScopeRadius;
var int ClosestPointOnSplineIndex;
var init array<init InterpPointOnSpline> Points;

defaultproperties
{
    ListenerScopeRadius=1200.0000000
}