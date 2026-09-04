class FracturedSkinnedMeshComponent extends FracturedBaseComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object);

var protected native const transient Pointer ComponentSkinResources;
var protected const transient array<Matrix> FragmentTransforms;
var protected const export editinline transient array<export editinline FracturedStaticMeshComponent> DependentComponents;
var protected const transient bool bBecameVisible;
var protected const transient bool bFragmentTransformsChanged;

defaultproperties
{
    bInitialVisibilityValue=false
    ReplacementPrimitive=none
    bAllowCullDistanceVolume=false
    bAllowApproximateOcclusion=true
    bAcceptsDynamicDecals=false
    CastShadow=false
    bCastDynamicShadow=false
    CollideActors=false
    BlockActors=false
    BlockZeroExtent=false
    BlockNonZeroExtent=false
    BlockRigidBody=false
}