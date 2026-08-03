class ImageReflectionShadowPlaneComponent extends PrimitiveComponent
    native(Mesh)
    editinlinenew;

var() bool bEnabled;
var Plane ReflectionPlane;

// Export UImageReflectionShadowPlaneComponent::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bSetEnabled);

defaultproperties
{
    bEnabled=true
    ReflectionPlane=(W=86.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000)
    ReplacementPrimitive=none
    HiddenGame=true
    bAcceptsDynamicDecals=false
    bCastDynamicShadow=false
    bAcceptsDynamicLights=false
}