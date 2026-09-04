class MorphTargetSet extends Object
    native(Anim);

var array<MorphTarget> Targets;
var SkeletalMesh BaseSkelMesh;
var native const Array_Mirror RawWedgePointIndices;

// Export UMorphTargetSet::execFindMorphTarget(FFrame&, void* const)
native final function MorphTarget FindMorphTarget(name MorphTargetName);
