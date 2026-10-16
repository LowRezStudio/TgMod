class TgDataHandler extends GFxObject within GFxMoviePlayer
    native
    config(Engine);

var UIMoviePlayer m_MP;
var array<TgDataChunk> m_DataChunkList;

native function InitializeDataHandler(UIMoviePlayer mp);  // Export UTgDataHandler::execInitializeDataHandler(FFrame&, void* const)

native function Update(float DeltaTime);  // Export UTgDataHandler::execUpdate(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgDataHandler::execNotifyMapChange(FFrame&, void* const)
