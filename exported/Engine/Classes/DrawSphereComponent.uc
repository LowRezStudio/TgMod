class DrawSphereComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    noexport
    hidecategories(Object);

var() Color SphereColor;
var() Material SphereMaterial;
var() float SphereRadius;
var() int SphereSides;
var() bool bDrawWireSphere;
var() bool bDrawLitSphere;
var() bool bDrawOnlyIfSelected;

defaultproperties
{
    SphereColor=(R=255,G=0,B=0,A=255)
    SphereRadius=100.0000000
    SphereSides=16
    bDrawWireSphere=true
    ReplacementPrimitive=none
    HiddenGame=true
}