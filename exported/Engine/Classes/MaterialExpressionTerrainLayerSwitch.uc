class MaterialExpressionTerrainLayerSwitch extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var native const transient Pointer InstanceOverride;
var ExpressionInput LayerUsed;
var ExpressionInput LayerNotUsed;
var() name ParameterName;
var() bool PreviewUsed;
var const Guid ExpressionGUID;

defaultproperties
{
    PreviewUsed=true
    bIsParameterExpression=true
    bUsedByStaticParameterSet=true
    MenuCategories[0]="Terrain"
    MenuCategories[1]="WorldPosOffset"
}