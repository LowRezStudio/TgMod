class DrawFrustumComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    noexport
    hidecategories(Object);

var() Color FrustumColor;
var() float FrustumAngle;
var() float FrustumAspectRatio;
var() float FrustumStartDist;
var() float FrustumEndDist;
var() Texture Texture;

defaultproperties
{
    FrustumColor=(R=255,G=0,B=255,A=255)
    FrustumAngle=90.0000000
    FrustumAspectRatio=1.3333300
    FrustumStartDist=100.0000000
    FrustumEndDist=1000.0000000
    ReplacementPrimitive=none
    HiddenGame=true
}