class TgAIBehaviorAction_MoveToAvoidableProjectile extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object);

var() bool bMustBeEnemy;
var() bool bIgnoreInsideCollision;
var() bool bMoveAway;

defaultproperties
{
    bMoveAway=true
    TitleName="MoveToAvoidableProjectile"
    NodeToken=1048712
}