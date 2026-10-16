class PhysicsAsset extends Object
    native(Physics)
    hidecategories(Object);

var const export editinline array<export editinline RB_BodySetup> BodySetup;
var native const Map_Mirror BodySetupIndexMap;
var const array<int> BoundsBodies;
var const export editinline array<export editinline RB_ConstraintSetup> ConstraintSetup;
var const export editinline PhysicsAssetInstance DefaultInstance;

// Export UPhysicsAsset::execFindBodyIndex(FFrame&, void* const)
native final function int FindBodyIndex(name BodyName);
