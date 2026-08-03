class TgDataHandler extends GFxObject within GFxMoviePlayer
    native;

var UIMoviePlayer m_MP;
var array<TgDataChunk> m_DataChunkList;

// Export UTgDataHandler::execInitializeDataHandler(FFrame&, void* const)
native function InitializeDataHandler(UIMoviePlayer mp);

// Export UTgDataHandler::execUpdate(FFrame&, void* const)
native function Update(float DeltaTime);

// Export UTgDataHandler::execNotifyMapChange(FFrame&, void* const)
native function NotifyMapChange();
