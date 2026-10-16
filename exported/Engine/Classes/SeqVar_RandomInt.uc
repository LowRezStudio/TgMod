class SeqVar_RandomInt extends SeqVar_Int
    native(Sequence)
    hidecategories(Object);

var() int Min;
var() int Max;

defaultproperties
{
    Max=100
    ObjName="Random Int"
}