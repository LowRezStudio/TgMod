class SeqAct_AndGate extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var transient bool bOpen;
var transient array<bool> LinkedOutputFiredStatus;
var native transient array<Pointer> LinkedOutputs;

defaultproperties
{
    bOpen=true
    bAutoActivateOutputLinks=false
    VariableLinks=none
    ObjName="AND Gate"
}