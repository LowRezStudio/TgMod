class TgAIBehaviorComposite_SequenceScripted extends TgAIBehaviorComposite
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite);

var() bool bFreezeOnLast;
var() bool bIsLooping;
var(Reset) bool bFirstChildIsResetTest;
var(Reset) bool bResetSequenceOnFailure;

defaultproperties
{
    TitleName="ScriptedSequence"
    NodeToken=2
}