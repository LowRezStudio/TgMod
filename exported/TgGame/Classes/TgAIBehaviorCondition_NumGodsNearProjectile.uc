class TgAIBehaviorCondition_NumGodsNearProjectile extends TgAIBehaviorCondition_DistanceBase
    hidecategories(Object);

var() bool bMustBeEnemy;
var() int ProjectileId;
var() int GodThreshold;

defaultproperties
{
    TitleName="NumGodsNearProjectile"
    NodeToken=439
}