class SeqAct_PrepareMapChange extends SeqAct_Latent
    native(Sequence)
    hidecategories(Object);

var() name MainLevelName;
var() array<name> InitiallyLoadedSecondaryLevelNames;
var() bool bIsHighPriority;
var transient bool bStatusIsOk;

defaultproperties
{
    InputLinks[0]=(LinkDesc="PrepareLoad",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    OutputLinks[0]=(Links=none,LinkDesc="Finished",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks=none
    ObjName="Prepare Map Change"
}