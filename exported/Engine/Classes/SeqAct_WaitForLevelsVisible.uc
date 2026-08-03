class SeqAct_WaitForLevelsVisible extends SeqAct_Latent
    native(Sequence)
    hidecategories(Object);

var() array<name> LevelNames;
var() bool bShouldBlockOnLoad;

// Export USeqAct_WaitForLevelsVisible::execCheckLevelsVisible(FFrame&, void* const)
native final function bool CheckLevelsVisible();

event Activated()
{
    local PlayerController PC;

    // End:0xB2
    foreach GetWorldInfo().AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0xB1
        if((NetConnection(PC.Player) != none) && ChildConnection(PC.Player) == none)
        {
            PC.ClientWaitForLevelsVisible(self);
        }        
    }    
    //return;    
}

defaultproperties
{
    bShouldBlockOnLoad=true
    InputLinks[0]=(LinkDesc="Wait",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    OutputLinks[0]=(Links=none,LinkDesc="Finished",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks=none
    ObjName="Wait for Levels to be visible"
}