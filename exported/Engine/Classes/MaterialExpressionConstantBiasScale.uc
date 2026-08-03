class MaterialExpressionConstantBiasScale extends MaterialExpression
    native(Material)
    hidecategories(Object);

var ExpressionInput Input;
var() float Bias;
var() float Scale;

defaultproperties
{
    Bias=1.0000000
    Scale=0.5000000
    MenuCategories[0]="Utility"
}