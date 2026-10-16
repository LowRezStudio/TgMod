class TgGameDC_Tower extends TgGameDC_MapEntity within GFxMoviePlayer
    native(GameUI)
    config(Engine);

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgGameDC_Tower::execInitializeData(FFrame&, void* const)
