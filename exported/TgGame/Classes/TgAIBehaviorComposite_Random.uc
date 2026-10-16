class TgAIBehaviorComposite_Random extends TgAIBehaviorComposite
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite);

var() editfixedsize editinline array<editinline float> ChildWeights;
var() float ChildFreezeTime;
var() bool bRandomizeOnComplete;

defaultproperties
{
    bCompleteOnAll=false
    TitleName="Random"
    NodeToken=3
}