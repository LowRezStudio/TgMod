class TgSeqAct_ForceClientTutorialAction extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

enum eForcedClientTutorialAction
{
    FCTA_BlockAvl,                  // 0
    FCTA_UnblockAvl,                // 1
    FCTA_Open,                      // 2
    FCTA_Close,                     // 3
    FCTA_MAX                        // 4
};

var() TgSeqAct_ForceClientTutorialAction.eForcedClientTutorialAction ForcedAction;
var() TgObject.eTutorialForceableElements GameUIElement;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Targets",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Force Client Tutorial Action"
}