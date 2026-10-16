class TgGameDC_Target extends TgDataChunk within GFxMoviePlayer
    native(GameUI);

// Export UTgGameDC_Target::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgGameDC_Target::execUpdateTarget(FFrame&, void* const)
native function bool UpdateTarget(Actor NewTarget, bool bHovered);
