class TgAIBehaviorAction_MoveToDeployable extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine);

var () int DeployableId;
var () bool bMustBeEnemy;
var () bool bIgnoreInsideCollision;
var () bool bIgnoreTaskforce;

defaultproperties
{
    TitleName="MoveToDeployable"
    NodeToken=1048628
}
