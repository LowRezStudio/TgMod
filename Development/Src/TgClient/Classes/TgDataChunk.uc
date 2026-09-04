class TgDataChunk extends GFxObject within GFxMoviePlayer
    native
    config(Engine);

struct DataField {
    var init string FieldName;
    var ASValue Value;
    var ASValue Last;
    var bool bDirty;
    structdefaultproperties {}
};

var TgDataHandler m_DataHandler;
var TgDataChunk m_ParentChunk;
var init array<init DataField> m_DataList;
var init array<init TgDataChunk> m_ChildChunks;
var bool m_bIsDirty;
var bool m_bIsSubscribed;
var bool m_bClearOnMapChange;

native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);  // Export UTgDataChunk::execInitializeData(FFrame&, void* const)

native function Update(float DeltaTime, optional bool bSkipCallback=false);  // Export UTgDataChunk::execUpdate(FFrame&, void* const)

native function DataUpdateEvent();  // Export UTgDataChunk::execDataUpdateEvent(FFrame&, void* const)

native function AddChild(TgDataChunk Child);  // Export UTgDataChunk::execAddChild(FFrame&, void* const)

native function RemoveChild(TgDataChunk Child, optional bool bClearDelegates);  // Export UTgDataChunk::execRemoveChild(FFrame&, void* const)

native function SetDelegates();  // Export UTgDataChunk::execSetDelegates(FFrame&, void* const)

native function ClearDelegates();  // Export UTgDataChunk::execClearDelegates(FFrame&, void* const)

native function AddField(string FieldName, const out ASValue NewValue);  // Export UTgDataChunk::execAddField(FFrame&, void* const)

native function bool SetField(string FieldName, const out ASValue NewValue, optional bool bCreateIfMissing=false);  // Export UTgDataChunk::execSetField(FFrame&, void* const)

native function bool GetField(string FieldName, out ASValue NewValue);  // Export UTgDataChunk::execGetField(FFrame&, void* const)

native function SetDirty();  // Export UTgDataChunk::execSetDirty(FFrame&, void* const)

native function bool IsSubscribed();  // Export UTgDataChunk::execIsSubscribed(FFrame&, void* const)

native function NotifyMapChange();  // Export UTgDataChunk::execNotifyMapChange(FFrame&, void* const)

native function TgPlayerController GetPlayerController();  // Export UTgDataChunk::execGetPlayerController(FFrame&, void* const)

delegate usc_Subscribe_Delegate();

delegate usc_Unsubscribe_Delegate();

native function usc_Subscribe();  // Export UTgDataChunk::execusc_Subscribe(FFrame&, void* const)

native function usc_Unsubscribe();  // Export UTgDataChunk::execusc_Unsubscribe(FFrame&, void* const)

defaultproperties
{
    m_bIsDirty=true
    m_bClearOnMapChange=true
}
