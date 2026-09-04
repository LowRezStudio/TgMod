class TgSeqEvent_SpectatorReady extends SequenceEvent
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

function bool TriggerGlobal(TgSpectatorController InInstigator) { }

defaultproperties
{
    MaxTriggerCount=0
    OutputLinks[0]=(Links=none,LinkDesc="Ready",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Spectator Ready"
}
