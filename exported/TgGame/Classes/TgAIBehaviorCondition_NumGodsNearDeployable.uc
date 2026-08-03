class TgAIBehaviorCondition_NumGodsNearDeployable extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object);

var() bool bMustBeEnemy;
var() int DeployableId;
var() int GodThreshold;

defaultproperties
{
    TitleName="NumGodsNearDeployable"
    NodeToken=438
}