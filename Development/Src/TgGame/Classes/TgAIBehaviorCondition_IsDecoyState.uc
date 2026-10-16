class TgAIBehaviorCondition_IsDecoyState extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgPawn_Illusion);

var () TgPawn_Illusion.EDecoyAIState DecoyState;

defaultproperties
{
    TitleName="IsDecoyState"
    NodeToken=335
}
