class SeqAct_Interp extends SeqAct_Latent
    native(Sequence)
    config(Engine)
    hidecategories(Object);

struct native export SavedTransform
{
    var Vector Location;
    var Rotator Rotation;

    structdefaultproperties
    {
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Rotation=(Pitch=0,Yaw=0,Roll=0)
    }
};

struct native CameraCutInfo
{
    var Vector Location;
    var float TimeStamp;

    structdefaultproperties
    {
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        TimeStamp=0.0000000
    }
};

var private noimport native const transient map{VOID,VOID} SavedActorTransforms;
var private noimport native const transient map{VOID,VOID} SavedActorVisibilities;
var() float PlayRate;
var float Position;
var() float ForceStartPosition;
var bool bIsPlaying;
var bool bPaused;
var transient bool bIsBeingEdited;
var() bool bLooping;
var() bool bRewindOnPlay;
var() bool bNoResetOnRewind;
var() bool bRewindIfAlreadyPlaying;
var bool bReversePlayback;
var() bool bInterpForPathBuilding;
var() bool bForceStartPos;
var() bool bDisableRadioFilter;
var() bool bClientSideOnly;
var() bool bSkipUpdateIfNotVisible;
var() bool bIsSkippable;
var transient bool bShouldShowGore;
var() array<CoverLink> LinkedCover;
var export InterpData InterpData;
var array<InterpGroupInst> GroupInst;
var const Class<MatineeActor> ReplicatedActorClass;
var const transient MatineeActor ReplicatedActor;
var() int PreferredSplitScreenNum;
var transient array<CameraCutInfo> CameraCuts;
var float TerminationTime;
var() globalconfig RenderingPerformanceOverrides RenderingOverrides;
var(ConstantCameraAnim) byte ConstantCameraAnim;
var(ConstantCameraAnim) float ConstantCameraAnimRate;

// Export USeqAct_Interp::execSetPosition(FFrame&, void* const)
native final function SetPosition(float NewPosition, optional bool bJump = false);

// Export USeqAct_Interp::execStop(FFrame&, void* const)
native final function Stop();

// Export USeqAct_Interp::execAddPlayerToDirectorTracks(FFrame&, void* const)
native final function AddPlayerToDirectorTracks(PlayerController PC);

function Reset()
{
    SetPosition(0.0000000, false);
    // End:0x3F
    if(bActive)
    {
        InputLinks[2].bHasImpulse = true;
    }
    //return;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    PlayRate=1.0000000
    ReplicatedActorClass=Class'Engine.MatineeActor'
    RenderingOverrides=(bAllowAmbientOcclusion=false,bAllowDominantWholeSceneDynamicShadows=false,bAllowMotionBlurSkinning=false,bAllowTemporalAA=true,bAllowLightShafts=true)
    ConstantCameraAnimRate=4.0000000
    InputLinks[0]=(LinkDesc="Play",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Reverse",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[2]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[3]=(LinkDesc="Pause",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[4]=(LinkDesc="Change Dir",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    OutputLinks[0]=(Links=none,LinkDesc="Completed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Reversed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.InterpData',LinkedVariables=none,LinkDesc="Data",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Matinee"
}