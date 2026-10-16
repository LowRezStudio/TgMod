class TgAIBehaviorCondition_NumGodsNearDeployable extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object)
    config(Engine);

var () bool bMustBeEnemy;
var () int DeployableId;
var () int GodThreshold;

defaultproperties
{
    TitleName="NumGodsNearDeployable"
    NodeToken=438
}
