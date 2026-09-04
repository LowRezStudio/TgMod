class MaterialExpressionConstantClamp extends MaterialExpression
    native(Material)
    hidecategories(Object);

var ExpressionInput Input;
var() float Min;
var() float Max;

defaultproperties
{
    Max=1.0000000
    MenuCategories[0]="Utility"
    MenuCategories[1]="WorldPosOffset"
}