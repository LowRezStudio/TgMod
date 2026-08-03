class DrawBoxComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    noexport
    hidecategories(Object);

var() Color BoxColor;
var() Material BoxMaterial;
var() Vector BoxExtent;
var() bool bDrawWireBox;
var() bool bDrawLitBox;
var() bool bDrawOnlyIfSelected;

defaultproperties
{
    BoxColor=(R=255,G=0,B=0,A=255)
    BoxExtent=(X=200.0000000,Y=200.0000000,Z=200.0000000)
    bDrawWireBox=true
    ReplacementPrimitive=none
    HiddenGame=true
}