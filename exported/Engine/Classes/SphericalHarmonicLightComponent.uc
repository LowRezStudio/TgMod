class SphericalHarmonicLightComponent extends LightComponent
    native(Light)
    editinlinenew
    hidecategories(Object);

var() SHVectorRGB WorldSpaceIncidentLighting;
var bool bRenderBeforeModShadows;

defaultproperties
{
    CastShadows=false
}