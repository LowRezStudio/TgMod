class TgAIBehaviorComposite_Parallel extends TgAIBehaviorComposite_Sequence
    native(AI)
    hidecategories(Object,TgAIBehaviorComposite)
    config(Engine);

defaultproperties
{
    bStopOnRunningChild=false
    bFailsOnAll=true
    TitleName="Parallel"
}
