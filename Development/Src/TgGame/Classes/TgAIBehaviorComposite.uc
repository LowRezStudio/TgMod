class TgAIBehaviorComposite extends TgAIBehaviorNode
    abstract
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite)
    config(Engine);

var init editfixedsize editinline array<init editinline TgAIBehaviorNode> Children;
var init transient array<init int> ChildrenIndices;
var () const editconst bool bCompleteOnAll;
var () const editconst bool bFailsOnAll;
var () const editconst bool bRetryFailedChild;
var editoronly const editconst bool bFixedChildrenSize;

defaultproperties
{
    bCompleteOnAll=true
}
