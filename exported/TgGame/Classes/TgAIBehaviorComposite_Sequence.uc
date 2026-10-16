class TgAIBehaviorComposite_Sequence extends TgAIBehaviorComposite
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite);

var bool bStopOnRunningChild;

defaultproperties
{
    bStopOnRunningChild=true
    TitleName="Sequence"
    NodeToken=1
}