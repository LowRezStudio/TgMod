class MaterialFunction extends Object
    native(Material)
    hidecategories(Object);

var duplicatetransient Guid StateId;
var() string Description;
var() bool bExposeToLibrary;
var private const transient bool bReentrantFlag;
var() array<string> LibraryCategories;
var array<MaterialExpression> FunctionExpressions;

defaultproperties
{
    LibraryCategories[0]="Misc"
}