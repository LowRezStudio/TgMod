class TgPawn_Illusion extends TgPawn_Ying
    native(ChampYing)
    config(Game)
    hidecategories(Navigation)
    implements(TgInterface_YingIllusion);

function TgPawn_Ying GetOwningYing(){}
// Export UTgPawn_Illusion::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();