class MorphNodePose extends MorphNodeBase
    native(Anim)
    hidecategories(Object,Object,Object);

var transient MorphTarget Target;
var() name MorphName;
var() float Weight;

// Export UMorphNodePose::execSetMorphTarget(FFrame&, void* const)
native final function SetMorphTarget(name MorphTargetName);

defaultproperties
{
    Weight=1.0000000
}