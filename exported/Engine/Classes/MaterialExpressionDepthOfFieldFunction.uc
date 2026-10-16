class MaterialExpressionDepthOfFieldFunction extends MaterialExpression
    native(Material)
    hidecategories(Object);

enum EDepthOfFieldFunctionValue
{
    TDOF_NearAndFarMask,            // 0
    TDOF_NearMask,                  // 1
    TDOF_FarMask,                   // 2
    TDOF_MAX                        // 3
};

var() MaterialExpressionDepthOfFieldFunction.EDepthOfFieldFunctionValue FunctionValue;
var ExpressionInput Depth;

defaultproperties
{
    MenuCategories[0]="Utility"
}