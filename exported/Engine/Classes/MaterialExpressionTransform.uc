class MaterialExpressionTransform extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

enum EMaterialVectorCoordTransformSource
{
    TRANSFORMSOURCE_World,          // 0
    TRANSFORMSOURCE_Local,          // 1
    TRANSFORMSOURCE_Tangent,        // 2
    TRANSFORMSOURCE_View,           // 3
    TRANSFORMSOURCE_MAX             // 4
};

enum EMaterialVectorCoordTransform
{
    TRANSFORM_World,                // 0
    TRANSFORM_View,                 // 1
    TRANSFORM_Local,                // 2
    TRANSFORM_Tangent,              // 3
    TRANSFORM_MAX                   // 4
};

var ExpressionInput Input;
var() const MaterialExpressionTransform.EMaterialVectorCoordTransformSource TransformSourceType;
var() const MaterialExpressionTransform.EMaterialVectorCoordTransform TransformType;

defaultproperties
{
    TransformSourceType=EMaterialVectorCoordTransformSource.TRANSFORMSOURCE_Tangent
    MenuCategories[0]="VectorOps"
}