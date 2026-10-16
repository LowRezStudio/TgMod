class FracturedStaticMeshComponent extends FracturedBaseComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object);

struct native FragmentGroup
{
    var array<int> FragmentIndices;
    var bool bGroupIsRooted;

    structdefaultproperties
    {
        FragmentIndices=none
        bGroupIsRooted=false
    }
};

var protected const transient array<byte> FragmentNeighborsVisible;
var protected const Box VisibleBox;
var protected const bool bUseSkinnedRendering;
var bool bUseVisibleVertsForBounds;
var() bool bTopFragmentsRootNonDestroyable;
var() bool bBottomFragmentsRootNonDestroyable;
var() float TopBottomFragmentDistThreshold;
var() MaterialInterface LoseChunkOutsideMaterialOverride;
var float FragmentBoundsMaxZ;
var float FragmentBoundsMinZ;
var export editinline transient FracturedSkinnedMeshComponent SkinnedComponent;

// Export UFracturedStaticMeshComponent::execSetVisibleFragments(FFrame&, void* const)
native final function SetVisibleFragments(array<byte> VisibilityFactors);

// Export UFracturedStaticMeshComponent::execIsFragmentDestroyable(FFrame&, void* const)
native final function bool IsFragmentDestroyable(int FragmentIndex);

// Export UFracturedStaticMeshComponent::execIsRootFragment(FFrame&, void* const)
native final function bool IsRootFragment(int FragmentIndex);

// Export UFracturedStaticMeshComponent::execIsNoPhysFragment(FFrame&, void* const)
native final function bool IsNoPhysFragment(int FragmentIndex);

// Export UFracturedStaticMeshComponent::execGetFragmentBox(FFrame&, void* const)
native final function Box GetFragmentBox(int FragmentIndex);

// Export UFracturedStaticMeshComponent::execGetFragmentAverageExteriorNormal(FFrame&, void* const)
native final function Vector GetFragmentAverageExteriorNormal(int FragmentIndex);

// Export UFracturedStaticMeshComponent::execGetCoreFragmentIndex(FFrame&, void* const)
native final function int GetCoreFragmentIndex();

// Export UFracturedStaticMeshComponent::execGetFragmentGroups(FFrame&, void* const)
native final function array<FragmentGroup> GetFragmentGroups(array<int> IgnoreFragments, float MinConnectionArea);

// Export UFracturedStaticMeshComponent::execGetBoundaryHiddenFragments(FFrame&, void* const)
native final function array<int> GetBoundaryHiddenFragments(array<int> AdditionalVisibleFragments);

// Export UFracturedStaticMeshComponent::execRecreatePhysState(FFrame&, void* const)
native final function RecreatePhysState();

// Export UFracturedStaticMeshComponent::execGetFracturedMeshPhysMaterial(FFrame&, void* const)
native final function PhysicalMaterial GetFracturedMeshPhysMaterial();

defaultproperties
{
    TopBottomFragmentDistThreshold=0.1000000
    ReplacementPrimitive=none
    bUsePrecomputedShadows=true
}