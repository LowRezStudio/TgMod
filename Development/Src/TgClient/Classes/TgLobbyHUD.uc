class TgLobbyHUD extends TgClientHUD
    transient
    native(LobbyUI)
    config(Game)
    hidecategories(Navigation);

// Export UTgLobbyHUD::execTriggerLazyPrecache(FFrame&, void* const)
native function TriggerLazyPrecache();