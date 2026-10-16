class TgGameDataHandler extends TgDataHandler within GFxMoviePlayer
    native(GameUI);

var TgDataGroup_Game m_Game;

// Export UTgGameDataHandler::execInitializeDataHandler(FFrame&, void* const)
native function InitializeDataHandler(UIMoviePlayer mp);
