class MaterialExpressionPanner extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var ExpressionInput Coordinate;
var ExpressionInput Time;
var() float SpeedX;
var() float SpeedY;

defaultproperties
{
    MenuCategories[0]="Coordinates"
    MenuCategories[1]="WorldPosOffset"
}