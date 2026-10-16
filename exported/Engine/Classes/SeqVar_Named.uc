class SeqVar_Named extends SequenceVariable
    native(Sequence)
    hidecategories(Object,SequenceVariable);

var() Class<SequenceVariable> ExpectedType;
var() name FindVarName;
var transient bool bStatusIsOk;

defaultproperties
{
    ObjName="Named Variable"
}