class MaterialExpressionRotator extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var ExpressionInput Coordinate;
var ExpressionInput Time;
var() float CenterX;
var() float CenterY;
var() float Speed;

defaultproperties
{
    CenterX=0.5000000
    CenterY=0.5000000
    Speed=0.2500000
    MenuCategories[0]="Coordinates"
    MenuCategories[1]="WorldPosOffset"
}