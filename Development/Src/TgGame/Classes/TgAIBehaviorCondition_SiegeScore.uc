class TgAIBehaviorCondition_SiegeScore extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine);

var () int ScoreThreshold;
var () bool bMustBeEnemy;

defaultproperties
{
    TitleName="SiegeScore"
    NodeToken=449
}
