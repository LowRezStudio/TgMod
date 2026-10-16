class TgAIBehaviorComposite_Random extends TgAIBehaviorComposite
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite)
    config(Engine);

var () editfixedsize editinline array<float> ChildWeights;
var () float ChildFreezeTime;
var () bool bRandomizeOnComplete;

defaultproperties
{
    bCompleteOnAll=false
    TitleName="Random"
    NodeToken=3
}
