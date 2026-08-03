class SeqCond_SwitchBase extends SequenceCondition
    abstract
    native(Sequence)
    hidecategories(Object);

event VerifyDefaultCaseValue()
{
    //return;    
}

event bool IsFallThruEnabled(int ValueIndex)
{
    return false;
    //return ReturnValue;    
}

event InsertValueEntry(int InsertIndex)
{
    //return;    
}

event RemoveValueEntry(int RemoveIndex)
{
    //return;    
}

defaultproperties
{
    OutputLinks[0]=(Links=none,LinkDesc="Default",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
}