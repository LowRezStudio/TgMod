class TgAIController_BehaviorAerialDrone extends TgAIController_Behavior
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    BlackboardType=4
    WalkingPhysics=EPhysics.PHYS_Flying
}