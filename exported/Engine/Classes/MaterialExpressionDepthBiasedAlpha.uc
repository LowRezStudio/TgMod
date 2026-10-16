class MaterialExpressionDepthBiasedAlpha extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var() bool bNormalize;
var() float BiasScale;
var ExpressionInput Alpha;
var ExpressionInput Bias;

defaultproperties
{
    BiasScale=1.0000000
    MenuCategories[0]="Depth"
}