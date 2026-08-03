class SeqVar_External extends SequenceVariable within Sequence
    native(Sequence)
    hidecategories(Object);

var() Class<SequenceVariable> ExpectedType;
var() string VariableLabel;

defaultproperties
{
    VariableLabel="Default Var"
    ObjName="External Variable"
}