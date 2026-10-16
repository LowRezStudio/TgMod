class TgAIBehaviorCondition_CombatTargetHasEffectCategory extends TgAIBehaviorCondition
    native(AI)
    hidecategories(Object);

var() bool bEffectGroupCategoryCheckInstigator;
var() int EffectCategoryId;
var() int EffectGroupId;

defaultproperties
{
    TitleName="CombatTargetHasEffectCategory"
    NodeToken=306
}