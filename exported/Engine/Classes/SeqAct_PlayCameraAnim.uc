class SeqAct_PlayCameraAnim extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() CameraAnim CameraAnim;
var() bool bLoop;
var() bool bRandomStartTime;
var() float BlendInTime;
var() float BlendOutTime;
var() float Rate;
var() float IntensityScale;
var() Camera.ECameraAnimPlaySpace PlaySpace;
var() Actor UserDefinedSpaceActor;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    BlendInTime=0.2000000
    BlendOutTime=0.2000000
    Rate=1.0000000
    IntensityScale=1.0000000
    InputLinks[0]=(LinkDesc="Play",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Play CameraAnim"
}