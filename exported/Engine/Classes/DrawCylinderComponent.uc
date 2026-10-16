class DrawCylinderComponent extends PrimitiveComponent
    native
    editinlinenew
    collapsecategories
    noexport
    hidecategories(Object);

var() Color CylinderColor;
var() Material CylinderMaterial;
var() float CylinderRadius;
var() float CylinderTopRadius;
var() float CylinderHeight;
var() float CylinderHeightOffset;
var() int CylinderSides;
var() bool bDrawWireCylinder;
var() bool bDrawLitCylinder;
var() bool bDrawOnlyIfSelected;

defaultproperties
{
    CylinderColor=(R=255,G=0,B=0,A=255)
    CylinderRadius=100.0000000
    CylinderTopRadius=100.0000000
    CylinderHeight=100.0000000
    CylinderSides=16
    bDrawWireCylinder=true
    ReplacementPrimitive=none
    HiddenGame=true
}