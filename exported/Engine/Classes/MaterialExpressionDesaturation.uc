class MaterialExpressionDesaturation extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var ExpressionInput Input;
var ExpressionInput Percent;
var() LinearColor LuminanceFactors;

defaultproperties
{
    LuminanceFactors=(R=0.3000000,G=0.5900000,B=0.1100000,A=0.0000000)
    MenuCategories[0]="Color"
    MenuCategories[1]="Utility"
}