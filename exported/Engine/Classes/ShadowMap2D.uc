class ShadowMap2D extends Object
    native
    noexport;

var private const ShadowMapTexture2D Texture;
var private const Vector2D CoordinateScale;
var private const Vector2D CoordinateBias;
var private const Guid LightGuid;
var private const bool bIsShadowFactorTexture;
var private export editinline transient InstancedStaticMeshComponent Component;
var private transient int InstanceIndex;

defaultproperties
{
    bIsShadowFactorTexture=true
}