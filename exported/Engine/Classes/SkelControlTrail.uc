class SkelControlTrail extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

var(Trail) int ChainLength;
var(Trail) Object.EAxis ChainBoneAxis;
var(Trail) bool bInvertChainBoneAxis;
var(Trail) bool bLimitStretch;
var(Trail) bool bActorSpaceFakeVel;
var bool bHadValidStrength;
var(Trail) float TrailRelaxation;
var(Trail) float StretchLimit;
var(Trail) Vector FakeVelocity;
var float ThisTimstep;
var transient array<Vector> TrailBoneLocations;
var transient Matrix OldLocalToWorld;

defaultproperties
{
    ChainLength=2
    ChainBoneAxis=EAxis.AXIS_X
    TrailRelaxation=10.0000000
}