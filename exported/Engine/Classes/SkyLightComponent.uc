class SkyLightComponent extends LightComponent
    native(Light)
    editinlinenew
    hidecategories(Object);

var() const float LowerBrightness;
var() const Color LowerColor;

defaultproperties
{
    LowerColor=(R=255,G=255,B=255,A=0)
    CastShadows=false
}