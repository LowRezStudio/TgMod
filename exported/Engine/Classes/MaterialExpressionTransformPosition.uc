class MaterialExpressionTransformPosition extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

enum EMaterialPositionTransformSource
{
    TRANSFORMPOSSOURCE_Local,       // 0
    TRANSFORMPOSSOURCE_PostProjection,// 1
    TRANSFORMPOSSOURCE_MAX          // 2
};

enum EMaterialPositionTransform
{
    TRANSFORMPOS_World,             // 0
    TRANSFORMPOS_MAX                // 1
};

var ExpressionInput Input;
var() const MaterialExpressionTransformPosition.EMaterialPositionTransformSource TransformSourceType;
var() const MaterialExpressionTransformPosition.EMaterialPositionTransform TransformType;

defaultproperties
{
    TransformSourceType=EMaterialPositionTransformSource.TRANSFORMPOSSOURCE_PostProjection
    MenuCategories[0]="VectorOps"
}