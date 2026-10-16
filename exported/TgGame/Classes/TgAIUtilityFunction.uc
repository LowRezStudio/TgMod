class TgAIUtilityFunction extends TgAIUtility
    abstract
    hidecategories(Object);

var() float MinInput;
var() float MaxInput;
var() TgAIUtility.EGraphType FunctionType;
var() float DesiredValue;
var() float UtilityScale;
var() bool bInvert;

defaultproperties
{
    UtilityScale=1.0000000
}