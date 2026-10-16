class TgAIBehaviorCondition_CurrentLevel extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () int LevelThreshold;

defaultproperties
{
    ComparisonOperator=BEHAVIORCOMPARE_GreaterThanOrEqual
    TitleName="CurrentLevel"
    NodeToken=264
}
