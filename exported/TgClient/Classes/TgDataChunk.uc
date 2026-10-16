class TgDataChunk extends GFxObject within GFxMoviePlayer
    native;

struct native DataField
{
    var init string FieldName;
    var ASValue Value;
    var ASValue Last;
    var bool bDirty;

    structdefaultproperties
    {
        FieldName=""
        Value=(Type=ASType.AS_Undefined,B=false,N=0.0000000,I=0,S="")
        Last=(Type=ASType.AS_Undefined,B=false,N=0.0000000,I=0,S="")
        bDirty=false
    }
};

var TgDataHandler m_DataHandler;
var TgDataChunk m_ParentChunk;
var init array<init DataField> m_DataList;
var init array<init TgDataChunk> m_ChildChunks;
var bool m_bIsDirty;
var bool m_bIsSubscribed;
var bool m_bClearOnMapChange;
//var delegate<usc_Subscribe_Delegate> __usc_Subscribe_Delegate__Delegate;
//var delegate<usc_Unsubscribe_Delegate> __usc_Unsubscribe_Delegate__Delegate;

// Export UTgDataChunk::execInitializeData(FFrame&, void* const)
native function InitializeData(TgDataHandler Handler, TgDataChunk parentChunk);

// Export UTgDataChunk::execUpdate(FFrame&, void* const)
native function Update(float DeltaTime, optional bool bSkipCallback = false);

// Export UTgDataChunk::execDataUpdateEvent(FFrame&, void* const)
native function DataUpdateEvent();

// Export UTgDataChunk::execAddChild(FFrame&, void* const)
native function AddChild(TgDataChunk Child);

// Export UTgDataChunk::execRemoveChild(FFrame&, void* const)
native function RemoveChild(TgDataChunk Child, optional bool bClearDelegates);

// Export UTgDataChunk::execSetDelegates(FFrame&, void* const)
native function SetDelegates();

// Export UTgDataChunk::execClearDelegates(FFrame&, void* const)
native function ClearDelegates();

// Export UTgDataChunk::execAddField(FFrame&, void* const)
native function AddField(string FieldName, const out ASValue NewValue);

// Export UTgDataChunk::execSetField(FFrame&, void* const)
native function bool SetField(string FieldName, const out ASValue NewValue, optional bool bCreateIfMissing = false);

// Export UTgDataChunk::execGetField(FFrame&, void* const)
native function bool GetField(string FieldName, out ASValue NewValue);

// Export UTgDataChunk::execSetDirty(FFrame&, void* const)
native function SetDirty();

// Export UTgDataChunk::execIsSubscribed(FFrame&, void* const)
native function bool IsSubscribed();

// Export UTgDataChunk::execNotifyMapChange(FFrame&, void* const)
native function NotifyMapChange();

// Export UTgDataChunk::execGetPlayerController(FFrame&, void* const)
native function TgPlayerController GetPlayerController();

delegate usc_Subscribe_Delegate()
{
    //return;    
}

delegate usc_Unsubscribe_Delegate()
{
    //return;    
}

// Export UTgDataChunk::execusc_Subscribe(FFrame&, void* const)
native function usc_Subscribe();

// Export UTgDataChunk::execusc_Unsubscribe(FFrame&, void* const)
native function usc_Unsubscribe();

defaultproperties
{
    m_bIsDirty=true
    m_bClearOnMapChange=true
}