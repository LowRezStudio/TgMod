interface TgInterface_YingIllusion extends Interface
    abstract
    native;

delegate DestroyedEvent(Actor destroyedActor)
{
    //return;    
}

function AddOnDestroyDelegate(delegate<DestroyedEvent> delDestroy)
{
    //return;    
}

simulated function TriggerShatter(float fDelay)
{
    //return;    
}

event Shatter()
{
    //return;    
}

simulated function PlayDimensionalLinkFX()
{
    //return;    
}

// Export UTgInterface_YingIllusion::execIsNotDestroyed(FFrame&, void* const)
native function bool IsNotDestroyed();

// Export UTgInterface_YingIllusion::execGetActorFromInterface(FFrame&, void* const)
native function Actor GetActorFromInterface();

function TgPawn_Ying GetOwningYing()
{
    //return ReturnValue;    
}
