class PointLightComponent extends LightComponent
    native(Light)
    editinlinenew
    hidecategories(Object);

var float ShadowRadiusMultiplier;
var() interp float Radius;
var() interp float FalloffExponent;
var() float ShadowFalloffExponent;
var float MinShadowFalloffRadius;
var const Matrix CachedParentToWorld;
var() const Vector Translation;
var const Plane ShadowPlane;
var const export editinline DrawLightRadiusComponent PreviewLightRadius;
var(Lightmass) LightmassPointLightSettings LightmassSettings;
var const export editinline DrawLightRadiusComponent PreviewLightSourceRadius;

// Export UPointLightComponent::execSetTranslation(FFrame&, void* const)
native final function SetTranslation(Vector NewTranslation);

function OnUpdatePropertyLightColor()
{
    UpdateColorAndBrightness();
    //return;    
}

function OnUpdatePropertyBrightness()
{
    UpdateColorAndBrightness();
    //return;    
}

defaultproperties
{
    ShadowRadiusMultiplier=1.1000000
    Radius=1024.0000000
    FalloffExponent=2.0000000
    ShadowFalloffExponent=2.0000000
    ShadowPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000)
    LightmassSettings=(LightSourceRadius=100.0000000,IndirectLightingScale=1.0000000,IndirectLightingSaturation=1.0000000,ShadowExponent=2.0000000)
}