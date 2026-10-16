class SpotLightComponent extends PointLightComponent
    native(Light)
    editinlinenew
    hidecategories(Object,Object);

var() float InnerConeAngle;
var() float OuterConeAngle;
var(LightShafts) float LightShaftConeAngle;
var const export editinline DrawLightConeComponent PreviewInnerCone;
var const export editinline DrawLightConeComponent PreviewOuterCone;
var() const Rotator Rotation;

// Export USpotLightComponent::execSetRotation(FFrame&, void* const)
native final function SetRotation(Rotator NewRotation);

defaultproperties
{
    OuterConeAngle=44.0000000
    LightShaftConeAngle=89.0000000
}