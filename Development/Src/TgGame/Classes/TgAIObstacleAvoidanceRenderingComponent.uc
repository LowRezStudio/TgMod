class TgAIObstacleAvoidanceRenderingComponent extends PrimitiveComponent
    native(AI)
    config(Engine);

var transient TgAIObstacleAvoidance ObstacleAvoidance;

defaultproperties
{
    ReplacementPrimitive=none
    bIgnoreOwnerHidden=true
    AlwaysLoadOnClient=false
    AlwaysLoadOnServer=false
    TranslucencySortPriority=1
}
