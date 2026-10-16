class FogVolumeLinearHalfspaceDensityComponent extends FogVolumeDensityComponent
    native(FogVolume)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() interp float PlaneDistanceFactor;
var() interp Plane HalfspacePlane;

defaultproperties
{
    PlaneDistanceFactor=0.1000000
    HalfspacePlane=(W=-300.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000)
}