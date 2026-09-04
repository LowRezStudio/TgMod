class PBRuleNodeComment extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() int SizeX;
var() int SizeY;
var() int BorderWidth;
var() Color BorderColor;
var() bool bFilled;
var() Color FillColor;

defaultproperties
{
    SizeX=128
    SizeY=64
    BorderWidth=1
    BorderColor=(R=0,G=0,B=0,A=255)
    bFilled=true
    FillColor=(R=255,G=255,B=255,A=16)
    NextRules=none
}