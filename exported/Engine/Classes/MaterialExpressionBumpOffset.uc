class MaterialExpressionBumpOffset extends MaterialExpression
    native(Material)
    collapsecategories
    hidecategories(Object,Object);

var ExpressionInput Coordinate;
var ExpressionInput Height;
var ExpressionInput HeightRatioInput;
var() float HeightRatio;
var() float ReferencePlane;

defaultproperties
{
    HeightRatio=0.0500000
    ReferencePlane=0.5000000
    MenuCategories[0]="Utility"
}