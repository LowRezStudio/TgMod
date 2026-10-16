class SeqAct_PlayAgentAnimation extends SeqAct_Latent
    native
    forcescriptorder(true)
    hidecategories(Object);

var() array<name> AnimationList;
var() float BlendInTime;
var() float BlendOutTime;
var() bool bUseRootMotion;
var() bool bFaceActionTargetFirst;
var() bool bLooping;
var() bool bBlendBetweenAnims;
var() int LoopIndex;
var() float LoopTime;
var Actor ActionTarget;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

function SetCurrentAnimationActionFor(GameCrowdAgentSkeletal Agent)
{
    local GameCrowdBehavior_PlayAnimation AnimBehavior;
    local int I;

    AnimBehavior = new (Agent) Class'GameFramework.GameCrowdBehavior_PlayAnimation';
    AnimBehavior.AnimSequence = self;
    AnimBehavior.BlendInTime = BlendInTime;
    AnimBehavior.BlendOutTime = BlendOutTime;
    AnimBehavior.bUseRootMotion = bUseRootMotion;
    AnimBehavior.bFaceActionTargetFirst = bFaceActionTargetFirst;
    AnimBehavior.bLooping = bLooping;
    AnimBehavior.LoopIndex = LoopIndex;
    AnimBehavior.LoopTime = LoopTime;
    AnimBehavior.bBlendBetweenAnims = bBlendBetweenAnims;
    AnimBehavior.CustomActionTarget = ActionTarget;
    I = 0;
    J0x1BB:

    // End:0x21D [Loop If]
    if(I < AnimationList.Length)
    {
        AnimBehavior.AnimationList[I] = AnimationList[I];
        I++;
        // [Loop Continue]
        goto J0x1BB;
    }
    Agent.ActivateInstancedBehavior(AnimBehavior);
    //return;    
}

defaultproperties
{
    BlendInTime=0.2000000
    BlendOutTime=0.2000000
    LoopTime=-1.0000000
    bAutoActivateOutputLinks=false
    InputLinks[0]=(LinkDesc="Play",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    OutputLinks[0]=(Links=none,LinkDesc="Finished",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Stopped",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Started",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Action Focus",LinkVar="None",PropertyName="ActionTarget",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Out Agent",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Play Agent Animation"
}