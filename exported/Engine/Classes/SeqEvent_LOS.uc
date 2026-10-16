class SeqEvent_LOS extends SequenceEvent
    hidecategories(Object);

var() float ScreenCenterDistance;
var() float TriggerDistance;
var() bool bCheckForObstructions;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    ScreenCenterDistance=50.0000000
    TriggerDistance=2048.0000000
    bCheckForObstructions=true
    OutputLinks[0]=(Links=none,LinkDesc="Look",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Stop Look",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Line Of Sight"
}