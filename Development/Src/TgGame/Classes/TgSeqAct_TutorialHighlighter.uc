class TgSeqAct_TutorialHighlighter extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

enum eTutorialHighlighterElement {
    THE_Ability1,  // 0
    THE_ActiveItem,  // 1
    THE_ConsumableItem,  // 2
    THE_Gold,  // 3
    THE_ItemShop_Gold,  // 4
    THE_ItemShop_Item,  // 5
    THE_ItemShop_Item2,  // 6
    THE_ItemShop_Item3,  // 7
    THE_ItemShop_Purchase,  // 8
    THE_ItemShop_AllItems,  // 9
    THE_ItemShop_RemoveOverlay,  // 10
    THE_ItemShop_AddBlocker,  // 11
    THE_Stats_Display,  // 12
};

var () TgSeqAct_TutorialHighlighter.eTutorialHighlighterElement GameUIElement;

defaultproperties
{
    InputLinks[0]=(LinkDesc="Show",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Hide",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Targets",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Tutorial Highlighter"
}
