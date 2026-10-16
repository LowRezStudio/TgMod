class TgGameDataHandler extends TgDataHandler within GFxMoviePlayer
    native(GameUI)
    config(Engine);

var TgDataGroup_Game m_Game;

native function InitializeDataHandler(UIMoviePlayer mp);  // Export UTgGameDataHandler::execInitializeDataHandler(FFrame&, void* const)
