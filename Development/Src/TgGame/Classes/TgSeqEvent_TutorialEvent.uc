class TgSeqEvent_TutorialEvent extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

enum TUTORIAL_EVENT {
    TUTEVT_OPENED_ITEM_SHOP,  // 0
    TUTEVT_BOUGHT_ITEM,  // 1
    TUTEVT_CLOSED_ITEM_SHOP,  // 2
    TUTEVT_OPENED_SKILLS,  // 3
    TUTEVT_BOUGHT_SKILL,  // 4
    TUTEVT_CLOSED_SKILLS,  // 5
    TUTEVT_USED_ABILITY,  // 6
    TUTEVT_USED_RECALL,  // 7
    TUTEVT_TARGETED,  // 8
    TUTEVT_OPENED_INTRO,  // 9
    TUTEVT_CLOSED_INTRO,  // 10
    TUTEVT_USED_ACTIVE_ITEM,  // 11
    TUTEVT_SELECTED_SHOP_ITEM,  // 12
    TUTEVT_SELECTED_SHOP_ITEM2,  // 13
    TUTEVT_SELECTED_SHOP_ITEM3,  // 14
    TUTEVT_USED_CONSUMABLE_ITEM,  // 15
    TUTEVT_SELECTED_ALL_ITEMS,  // 16
};

enum TUTORIAL_TARGET_TYPE {
    TUT_TARGET_TOWER,  // 0
    TUT_TARGET_PHOENIX,  // 1
    TUT_TARGET_GUARDIAN,  // 2
};

var () TgSeqEvent_TutorialEvent.TUTORIAL_EVENT TutEvent;
var int EventData;

static event int GetObjClassVersion() { }

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="EventData",LinkVar="None",PropertyName="EventData",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Smite Tutorial Events"
}
