class MorphNodeMultiPose extends MorphNodeBase
    native(Anim)
    hidecategories(Object,Object,Object);

var transient array<MorphTarget> Targets;
var() array<name> MorphNames;
var() array<float> Weights;

// Export UMorphNodeMultiPose::execAddMorphTarget(FFrame&, void* const)
native final function bool AddMorphTarget(name MorphTargetName, optional float InWeight = 1.0000000);

// Export UMorphNodeMultiPose::execRemoveMorphTarget(FFrame&, void* const)
native final function RemoveMorphTarget(name MorphTargetName);

// Export UMorphNodeMultiPose::execUpdateMorphTarget(FFrame&, void* const)
native final function bool UpdateMorphTarget(MorphTarget Target, float InWeight);
