class TgGameDC_Tower extends TgGameDC_MapEntity within GFxMoviePlayer
    native(GameUI);

// Export UTgGameDC_Tower::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);
