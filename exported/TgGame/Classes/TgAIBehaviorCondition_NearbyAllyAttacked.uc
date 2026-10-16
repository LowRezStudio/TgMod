class TgAIBehaviorCondition_NearbyAllyAttacked extends TgAIBehaviorCondition
    hidecategories(Object);

var() float TimeThreshold;
var() float AllyDistanceThreshold;
var() float AttackerDistanceThreshold;

defaultproperties
{
    TitleName="NearbyAllyAttacked"
    NodeToken=446
}