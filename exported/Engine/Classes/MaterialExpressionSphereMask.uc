class MaterialExpressionSphereMask extends MaterialExpression
    native(Material)
    hidecategories(Object);

var ExpressionInput A;
var ExpressionInput B;
var ExpressionInput Radius;
var ExpressionInput Hardness;
var() float AttenuationRadius;
var() float HardnessPercent;

defaultproperties
{
    AttenuationRadius=256.0000000
    HardnessPercent=100.0000000
    MenuCategories[0]="HighLevel"
}