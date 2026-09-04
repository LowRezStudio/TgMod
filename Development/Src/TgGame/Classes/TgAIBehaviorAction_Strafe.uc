class TgAIBehaviorAction_Strafe extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine);

var () float StrafeUpdateTime;
var () float DistanceMultiplier;

defaultproperties
{
    StrafeUpdateTime=1.0000000
    DistanceMultiplier=1.0000000
    TitleName="Strafe"
    NodeToken=1048621
}
