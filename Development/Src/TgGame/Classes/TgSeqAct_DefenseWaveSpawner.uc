class TgSeqAct_DefenseWaveSpawner extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var int m_nRoundNumber;
var float m_fSpawnFrequency;
var transient float m_fNextSpawnTime;

defaultproperties
{
    bCallHandler=false
    bAutoActivateOutputLinks=false
    InputLinks=none
    OutputLinks[0]=(Links=none,LinkDesc="Activated",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Int',LinkedVariables=none,LinkDesc="Round Number",LinkVar="None",PropertyName="m_nRoundNumber",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Float',LinkedVariables=none,LinkDesc="Spawn Frequency",LinkVar="None",PropertyName="m_fSpawnFrequency",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Bot Factories",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Defense Wave Spawner"
}
