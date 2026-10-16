class MaterialExpressionFunctionOutput extends MaterialExpression
    native(Material)
    hidecategories(Object,Object);

var() string OutputName;
var() string Description;
var() int SortPriority;
var ExpressionInput A;
var bool bLastPreviewed;
var const Guid Id;

defaultproperties
{
    OutputName="Result"
    bShowOutputs=false
    BorderColor=(R=255,G=155,B=0,A=0)
    MenuCategories[0]="Functions"
}