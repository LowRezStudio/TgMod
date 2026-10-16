class TgGameDC_MapEntity extends TgDataChunk within GFxMoviePlayer
    native(GameUI);

var int m_nPawnId;

// Export UTgGameDC_MapEntity::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgGameDC_MapEntity::execUpdateActorMapPosition(FFrame&, void* const)
native function UpdateActorMapPosition(Actor gameActor);

// Export UTgGameDC_MapEntity::execUpdateMapPosition(FFrame&, void* const)
native function UpdateMapPosition(Vector Location, Rotator Rotation);

// Export UTgGameDC_MapEntity::execNotifyMapChange(FFrame&, void* const)
native function NotifyMapChange();
