class SkelControl_TwistBone extends SkelControlBase
    native(Anim)
    hidecategories(Object,Object);

var() name SourceBoneName;
var() float TwistAngleScale;

defaultproperties
{
    TwistAngleScale=-0.5000000
    bIgnoreWhenNotRendered=true
}