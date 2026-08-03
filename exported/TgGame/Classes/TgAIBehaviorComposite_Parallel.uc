class TgAIBehaviorComposite_Parallel extends TgAIBehaviorComposite_Sequence
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite);

defaultproperties
{
    bStopOnRunningChild=false
    bFailsOnAll=true
    TitleName="Parallel"
}