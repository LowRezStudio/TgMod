interface TgInterface_YingIllusion extends Interface;

delegate DestroyedEvent(Actor destroyedActor);

function AddOnDestroyDelegate(delegate<DestroyedEvent> delDestroy);

simulated function TriggerShatter(float fDelay);

event Shatter();

simulated function PlayDimensionalLinkFX();

function bool IsNotDestroyed();  // Export UTgInterface_YingIllusion::execIsNotDestroyed(FFrame&, void* const)

function Actor GetActorFromInterface();  // Export UTgInterface_YingIllusion::execGetActorFromInterface(FFrame&, void* const)

function TgPawn_Ying GetOwningYing();
