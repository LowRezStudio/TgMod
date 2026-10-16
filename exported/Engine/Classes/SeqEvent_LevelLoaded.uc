class SeqEvent_LevelLoaded extends SequenceEvent
    native(Sequence)
    hidecategories(Object);

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 2;
    //return ReturnValue;    
}

defaultproperties
{
    bPlayerOnly=false
    OutputLinks[0]=(Links=none,LinkDesc="Loaded and Visible",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Beginning of Level",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Level Reset",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks=none
    ObjName="Level Loaded"
}