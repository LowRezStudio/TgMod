class TgAIBehaviorAction_MoveToDamagingDeployable extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine);

var () bool bMustBeEnemy;
var () bool bIgnoreInsideCollision;
var () bool bMoveAway;

defaultproperties
{
    bMoveAway=true
    TitleName="MoveToDamagingDeployable"
    NodeToken=1048711
}
