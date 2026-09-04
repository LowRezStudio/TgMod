class TgAIBehaviorCondition_NumGodsInLanePusherRadius extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object);

var() bool bGodsMustBeEnemy;
var() int GodThreshold;

defaultproperties
{
    TitleName="NumGodsInLanePusherRadius"
    NodeToken=435
}