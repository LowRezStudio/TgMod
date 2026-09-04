class TgAIUtilitySet extends TgAIBehaviorNode
    native(AI)
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.EAIAnnotationType AnnotationType;
var init editfixedsize editinline array<init editinline TgAIUtility> Functions;
var init editfixedsize editinline array<init editinline TgAIUtility> Filters;

defaultproperties
{
    InvTickFrequency=1.0000000
    TitleName="UtilitySet"
}
