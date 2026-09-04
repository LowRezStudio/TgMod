class ApexComponentBase extends MeshComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object);

var protected native const transient Pointer ComponentBaseResources;
var protected native const transient RenderCommandFence_Mirror ReleaseResourcesFence;
var() const ApexAsset Asset;
var() Color WireframeColor;
var const bool bAssetChanged;

defaultproperties
{
    WireframeColor=(R=255,G=128,B=64,A=255)
    ReplacementPrimitive=none
    CollideActors=true
    BlockActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    BlockRigidBody=true
    TickGroup=ETickingGroup.TG_PreAsyncWork
}