class SeqAct_SetSoundMode extends SequenceAction
    hidecategories(Object);

var() SoundMode SoundMode;
var() bool bTopPriority;

event Activated()
{
    local PlayerController PC;

    PC = GetWorldInfo().GetALocalPlayerController();
    // End:0x59
    if(PC != none)
    {
        PC.OnSetSoundMode(self);
    }
    //return;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 3;
    //return ReturnValue;    
}

defaultproperties
{
    bCallHandler=false
    InputLinks[0]=(LinkDesc="Start",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks=none
    ObjName="Set Sound Mode"
}