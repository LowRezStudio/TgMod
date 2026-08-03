class FogVolumeConeDensityComponent extends FogVolumeDensityComponent
    native(FogVolume)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() interp float MaxDensity;
var() interp Vector ConeVertex;
var() interp float ConeRadius;
var() interp Vector ConeAxis;
var() interp float ConeMaxAngle;
var const export editinline DrawLightConeComponent PreviewCone;

defaultproperties
{
    MaxDensity=0.0020000
    ConeRadius=600.0000000
    ConeAxis=(X=0.0000000,Y=0.0000000,Z=-1.0000000)
    ConeMaxAngle=30.0000000
}