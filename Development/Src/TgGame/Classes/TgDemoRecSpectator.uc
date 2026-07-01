class TgDemoRecSpectator extends TgSpectatorController
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

// Export UTgDemoRecSpectator::execGetSpectatorTaskforceNumber(FFrame&, void* const)
native function int GetSpectatorTaskforceNumber();

simulated event ReceivedPlayer(){}
simulated event PostBeginPlay(){}