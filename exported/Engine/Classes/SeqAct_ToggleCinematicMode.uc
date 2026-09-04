class SeqAct_ToggleCinematicMode extends SequenceAction
    hidecategories(Object);

var() bool bDisableMovement;
var() bool bDisableTurning;
var() bool bHidePlayer;
var() bool bDisableInput;
var() bool bHideHUD;
var() bool bDeadBodies;
var() bool bDroppedPickups;

event Activated()
{
    local Actor A;

    // End:0x115
    if(!InputLinks[1].bHasImpulse && bDeadBodies || bDroppedPickups)
    {
        // End:0x114
        foreach GetWorldInfo().DynamicActors(Class'Engine.Actor', A)
        {
            // End:0x113
            if(((bDeadBodies && A.IsA('GamePawn')) && A.bTearOff) || bDroppedPickups && A.IsA('DroppedPickup'))
            {
                A.Destroy();
            }            
        }        
    }
    //return;    
}

defaultproperties
{
    bDisableMovement=true
    bDisableTurning=true
    bHidePlayer=true
    bDisableInput=true
    bHideHUD=true
    bDeadBodies=true
    bDroppedPickups=true
    InputLinks[0]=(LinkDesc="Enable",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Disable",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[2]=(LinkDesc="Toggle",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Toggle Cinematic Mode"
}