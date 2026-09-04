class MaterialExpressionTextureCoordinate extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var() int CoordinateIndex;
var() float UTiling;
var() float VTiling;
var() bool UnMirrorU;
var() bool UnMirrorV;

defaultproperties
{
    UTiling=1.0000000
    VTiling=1.0000000
    MenuCategories[0]="Coordinates"
    MenuCategories[1]="WorldPosOffset"
}