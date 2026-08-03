class TgSeqCond_HasCondition extends SequenceCondition
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

enum ConditionType
{
    TGCT_POISON,                    // 0
    TGCT_DISEASE,                   // 1
    TGCT_REGENERATION,              // 2
    TGCT_STUN,                      // 3
    TGCT_STEALTH,                   // 4
    TGCT_EMP_STUN,                  // 5
    TGCT_IGNITE,                    // 6
    TGCT_INVULNERABLE,              // 7
    TGCT_SLOW,                      // 8
    TGCT_MAX                        // 9
};

var() TgSeqCond_HasCondition.ConditionType ConditionList;

defaultproperties
{
    OutputLinks[0]=(Links=none,LinkDesc="True",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="False",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Players",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Has Condition"
}