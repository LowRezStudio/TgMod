class MaterialExpressionTextureSampleParameter extends MaterialExpressionTextureSample
    abstract
    native(Material)
    collapsecategories
    hidecategories(Object,Object,Object);

var() name ParameterName;
var const Guid ExpressionGUID;
var() name Group;

defaultproperties
{
    bIsParameterExpression=true
    MenuCategories[0]="Obsolete"
}