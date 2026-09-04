class TgSeqAct_RequestMission extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

enum EMissionDifficultyLevel
{
    DL_Easy,                        // 0
    DL_Medium,                      // 1
    DL_Hard,                        // 2
    DL_MAX                          // 3
};

var() int m_nMapGameId;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Player",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Request Mission"
}