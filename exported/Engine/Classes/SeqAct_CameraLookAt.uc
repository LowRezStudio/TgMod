class SeqAct_CameraLookAt extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() bool bAffectCamera;
var() bool bAlwaysFocus;
var deprecated bool bAdjustCamera;
var() bool bTurnInPlace;
var() bool bIgnoreTrace;
var() bool bAffectHead;
var() bool bRotatePlayerWithCamera;
var() bool bToggleGodMode;
var() bool bLeaveCameraRotation;
var() bool bDisableInput;
var bool bUsedTimer;
var() bool bCheckLineOfSight;
var() Vector2D InterpSpeedRange;
var() Vector2D InFocusFOV;
var() name FocusBoneName;
var() string TextDisplay;
var() float TotalTime;
var() float CameraFOV;
var transient float RemainingTime;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 3;
    //return ReturnValue;    
}

defaultproperties
{
    bAffectCamera=true
    bTurnInPlace=true
    bDisableInput=true
    InterpSpeedRange=(X=3.0000000,Y=3.0000000)
    InFocusFOV=(X=1.0000000,Y=1.0000000)
    CameraFOV=-1.0000000
    bLatentExecution=true
    OutputLinks[0]=(Links=none,LinkDesc="Out",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Finished",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Succeeded",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="Failed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Focus",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Look At"
}