class PBRuleNodeWindowWall extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() float CellMaxSizeX;
var() float CellMaxSizeZ;
var() float WindowSizeX;
var() float WindowSizeZ;
var() float WindowPosX;
var() float WindowPosZ;
var() bool bScaleWindowWithCell;
var() float YOffset;
var() MaterialInterface Material;

defaultproperties
{
    CellMaxSizeX=512.0000000
    CellMaxSizeZ=512.0000000
    WindowSizeX=128.0000000
    WindowSizeZ=232.0000000
    WindowPosX=0.5000000
    WindowPosZ=0.5000000
}