class FracturedBaseComponent extends StaticMeshComponent
    abstract
    native(Mesh)
    editinlinenew
    hidecategories(Object);

var protected native const transient Pointer ComponentBaseResources;
var protected native const transient RenderCommandFence_Mirror ReleaseResourcesFence;
var protected const transient array<byte> VisibleFragments;
var protected transient bool bVisibilityHasChanged;
var protected const transient bool bVisibilityReset;
var protected const bool bInitialVisibilityValue;
var protected const bool bUseDynamicIndexBuffer;
var protected const bool bUseDynamicIBWithHiddenFragments;
var private const int NumResourceIndices;
var protected const transient int bResetStaticMesh;

// Export UFracturedBaseComponent::execSetStaticMesh(FFrame&, void* const)
native simulated function bool SetStaticMesh(StaticMesh NewMesh, optional bool bForce);

// Export UFracturedBaseComponent::execGetVisibleFragments(FFrame&, void* const)
native simulated function array<byte> GetVisibleFragments();

// Export UFracturedBaseComponent::execIsFragmentVisible(FFrame&, void* const)
native simulated function bool IsFragmentVisible(int FragmentIndex);

// Export UFracturedBaseComponent::execGetNumFragments(FFrame&, void* const)
native function int GetNumFragments();

// Export UFracturedBaseComponent::execGetNumVisibleFragments(FFrame&, void* const)
native function int GetNumVisibleFragments();

defaultproperties
{
    bInitialVisibilityValue=true
    bUseDynamicIndexBuffer=true
    ReplacementPrimitive=none
    bAcceptsStaticDecals=false
}