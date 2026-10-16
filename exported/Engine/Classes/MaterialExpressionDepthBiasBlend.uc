class MaterialExpressionDepthBiasBlend extends MaterialExpressionTextureSample
    native(Material)
    collapsecategories
    hidecategories(Object,Object,Object);

var() bool bNormalize;
var() float BiasScale;
var ExpressionInput Bias;

defaultproperties
{
    BiasScale=1.0000000
    MenuCategories[0]="Obsolete"
}