class SeqEvent_MobileBase extends SequenceEvent
    abstract
    native
    forcescriptorder(true)
    hidecategories(Object);

event RegisterEvent()
{
    local WorldInfo WI;
    local GamePlayerController GPC;
    local MobilePlayerInput MPI;

    WI = Class'Engine.WorldInfo'.static.GetWorldInfo();
    // End:0xC4
    if(WI != none)
    {
        // End:0xC3
        foreach WI.LocalPlayerControllers(Class'GameFramework.GamePlayerController', GPC)
        {
            MPI = MobilePlayerInput(GPC.PlayerInput);
            // End:0xC2
            if(MPI != none)
            {
                AddToMobileInput(MPI);
                // End:0xC3
                break;
            }            
        }        
    }
    //return;    
}

event AddToMobileInput(MobilePlayerInput MPI)
{
    MPI.AddKismetEventHandler(self);
    //return;    
}

defaultproperties
{
    MaxTriggerCount=0
}