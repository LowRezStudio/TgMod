class AnimNodeFrame extends AnimObject
    native(Anim)
    hidecategories(Object);

var() int SizeX;
var() int SizeY;
var() int BorderWidth;
var() bool bDrawBox;
var() bool bFilled;
var() bool bTileFill;
var() Color BorderColor;
var() Color FillColor;

defaultproperties
{
    SizeX=128
    SizeY=64
    BorderWidth=1
    bDrawBox=true
    bFilled=true
    BorderColor=(R=0,G=0,B=0,A=255)
    FillColor=(R=255,G=255,B=255,A=16)
}