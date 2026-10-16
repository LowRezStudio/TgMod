class TgAIBehaviorCondition_Energy extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () float energy;

defaultproperties
{
    energy=50.0000000
    ComparisonOperator=BEHAVIORCOMPARE_LessThanOrEqual
    TitleName="EnergyTest"
    NodeToken=303
}
