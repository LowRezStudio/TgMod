class FogVolumeSphericalDensityComponent extends FogVolumeDensityComponent
    native(FogVolume)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() interp float MaxDensity;
var Vector SphereCenter;
var float SphereRadius;
var const export editinline DrawLightRadiusComponent PreviewSphereRadius;

defaultproperties
{
    MaxDensity=0.0020000
    SphereRadius=600.0000000
}