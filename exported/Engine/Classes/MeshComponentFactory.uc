class MeshComponentFactory extends PrimitiveComponentFactory
    abstract
    native;

var(Rendering) array<MaterialInterface> Materials;

defaultproperties
{
    CastShadow=true
}