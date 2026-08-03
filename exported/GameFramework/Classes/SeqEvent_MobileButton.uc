class SeqEvent_MobileButton extends SeqEvent_MobileZoneBase
    native
    hidecategories(Object);

var bool bWasActiveLastFrame;
var() bool bSendPressedOnlyOnTouchDown;
var() bool bSendPressedOnlyOnTouchUp;

defaultproperties
{
    OutputLinks[0]=(Links=none,LinkDesc="Input Pressed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Input Not Pressed",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Mobile Button Access"
}