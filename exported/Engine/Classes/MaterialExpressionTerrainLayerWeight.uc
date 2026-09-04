class MaterialExpressionTerrainLayerWeight extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var native const transient Pointer InstanceOverride;
var ExpressionInput Base;
var ExpressionInput Layer;
var() name ParameterName;
var() float PreviewWeight;
var const Guid ExpressionGUID;

defaultproperties
{
    bIsParameterExpression=true
    bUsedByStaticParameterSet=true
    MenuCategories[0]="Terrain"
    MenuCategories[1]="WorldPosOffset"
}