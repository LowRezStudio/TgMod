class CloudSaveSystem extends Object
    native;

const NUM_SAVE_SLOTS_KEY = "NumSaveSlots";
const DATA_STORE_ID_KEY = "DataStoreID";
const SAVE_DATA_BLOB_NAME_KEY = "DataBlobName";
const SAVE_SYSTEM_VERSION_KEY = "CloudSaveSystemVersion";
const COMMON_DATA_SAVE_SLOT_INDEX = -1;
const GET_SAVE_SLOT_ERROR = -2;
const GET_SAVE_SLOT_INVALID = -1;

enum SaveDataVersionSupport
{
    SaveDataVersionSupportLessThenEqual,// 0
    SaveDataVersionSupportEqual,    // 1
    SaveDataVersionSupportAny,      // 2
    SaveDataVersionSupport_MAX      // 3
};

enum SaveSlotOperationEnum
{
    SSO_SET,                        // 0
    SSO_GET,                        // 1
    SSO_DELETE,                     // 2
    SSO_MAX                         // 3
};

struct native GetSaveDataCallbackStruct
{
    var int SlotIndex;
    var delegate<OnGetSaveDataCallback> Callback;

    structdefaultproperties
    {
        SlotIndex=0
        Callback=None
    }
};

struct native SetSaveDataCallbackStruct
{
    var int SlotIndex;
    var delegate<SaveSystemCallback> Callback;

    structdefaultproperties
    {
        SlotIndex=0
        Callback=None
    }
};

struct native SaveSlotOperation
{
    var int SlotIndex;
    var CloudSaveSystem.SaveSlotOperationEnum SlotOperation;

    structdefaultproperties
    {
        SlotIndex=0
        SlotOperation=SaveSlotOperationEnum.SSO_SET
    }
};

var private transient CloudSaveSystemKVSInterface KeyValueStore;
var private transient CloudSaveSystemDataBlobStoreInterface DataBlobStore;
var private transient array<GetSaveDataCallbackStruct> OnGetSaveDataCallbacks;
var private transient array<SetSaveDataCallbackStruct> OnSetSaveDataCallbacks;
var private transient delegate<SaveSystemCallback> DeleteSaveDataCallback;
var private transient int ActiveSlotForDelete;
var private transient array<SaveSlotOperation> ActiveSaveSlotOperations;
//var delegate<OnGetSaveDataCallback> __OnGetSaveDataCallback__Delegate;
//var delegate<SaveSystemCallback> __SaveSystemCallback__Delegate;

delegate OnGetSaveDataCallback(bool bWasSuccessful, int SaveSlot, out array<byte> DataBlob, string Error)
{
    //return;    
}

delegate SaveSystemCallback(bool bWasSuccessful, int SaveSlot, string Error)
{
    //return;    
}

final function bool GetNumberOfSaveSlots(out int NumSaveSlots)
{
    local PlatformInterfaceDelegateResult KVRes;
    local bool RValue;

    RValue = false;
    // End:0xF1
    if(NotEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)) && NotEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none)))
    {
        KeyValueStore.ReadKeyValue(-1, "NumSaveSlots", 1, KVRes);
        // End:0xF1
        if(KVRes.bSuccessful)
        {
            RValue = true;
            NumSaveSlots = KVRes.Data.IntValue;
        }
    }
    return RValue;
    //return ReturnValue;    
}

private final function int DoesSaveSlotKeyValueDataAlreadyExist(string DataStoreID, string DataBlobName)
{
    local int SaveSlotScan, NumSaveSlots;
    local string CompareDataStoreID, CompareDataBlobName;
    local int RValue;

    RValue = -1;
    // End:0x11C
    if((NotEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)) && NotEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none))) && GetNumberOfSaveSlots(NumSaveSlots))
    {
        SaveSlotScan = 0;
        J0x74:

        // End:0x119 [Loop If]
        if(SaveSlotScan < NumSaveSlots)
        {
            // End:0xFC
            if(GetDataStoreIDAndBlobNameForSaveSlot(SaveSlotScan, CompareDataStoreID, CompareDataBlobName))
            {
                // End:0xF9
                if((DataStoreID == CompareDataStoreID) && DataBlobName == CompareDataBlobName)
                {
                    RValue = SaveSlotScan;
                    // [Explicit Break]
                    goto J0x119;
                }                
            }
            else
            {
                RValue = -2;
            }
            ++SaveSlotScan;
            // [Loop Continue]
            goto J0x74;
        }
        J0x119:
        
    }
    else
    {
        RValue = -2;
    }
    return RValue;
    //return ReturnValue;    
}

private final function bool WriteNumSaveSlots(int NumSaveSlots)
{
    local PlatformInterfaceData KVSet;

    KVSet.IntValue = NumSaveSlots;
    KVSet.Type = 1;
    // End:0x86
    if(KeyValueStore.WriteKeyValue(-1, "NumSaveSlots", KVSet))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

final function bool IsOperationActiveForSlot(int SlotIndex)
{
    local int Index;

    Index = ActiveSaveSlotOperations.Find('SlotIndex', SlotIndex);
    // End:0x41
    if(Index == -1)
    {
        return false;        
    }
    else
    {
        return true;
    }
    //return ReturnValue;    
}

final function bool IsDeleteOperationActive()
{
    // End:0x18
    if(ActiveSlotForDelete == -1)
    {
        return false;        
    }
    else
    {
        return true;
    }
    //return ReturnValue;    
}

final function bool AreAnySlotOperationsActive()
{
    // End:0x15
    if(ActiveSaveSlotOperations.Length > 0)
    {
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

// Export UCloudSaveSystem::execSerializeObject(FFrame&, void* const)
native final function SerializeObject(Object ObjectToSerialize, out array<byte> Data, int DataVersion);

// Export UCloudSaveSystem::execDeserializeObject(FFrame&, void* const)
native final function Object DeserializeObject(Class ObjectClass, out array<byte> Data, CloudSaveSystem.SaveDataVersionSupport VersionSupport, int DataVersion);

final function Init(CloudSaveSystemKVSInterface InKeyValueStore, CloudSaveSystemDataBlobStoreInterface InDataBlobStore, int VersionNumber)
{
    local PlatformInterfaceDelegateResult SaveSystemVersionNumber;
    local PlatformInterfaceData SaveSystemVersionNumberSet;

    KeyValueStore = InKeyValueStore;
    DataBlobStore = InDataBlobStore;
    GetKeyValue(-1, "CloudSaveSystemVersion", 1, SaveSystemVersionNumber);
    // End:0x139
    if(!SaveSystemVersionNumber.bSuccessful || SaveSystemVersionNumber.Data.IntValue != VersionNumber)
    {
        SaveSystemVersionNumberSet.IntValue = VersionNumber;
        SaveSystemVersionNumberSet.Type = 1;
        SetKeyValue(-1, "CloudSaveSystemVersion", SaveSystemVersionNumberSet);
        WriteNumSaveSlots(0);
    }
    //return;    
}

final function GetSaveData(int SaveSlot, delegate<OnGetSaveDataCallback> OnGetSaveDataCallback)
{
    local string DataStoreID;
    local GetSaveDataCallbackStruct CallbackStruct;
    local SaveSlotOperation SlotOperation;
    local array<byte> EmptyBuffer;
    local string BlobName;
    local bool ErrorOccured;
    local string Error;

    ErrorOccured = true;
    // End:0x6D
    if(EqualEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)))
    {
        Error = "GetSaveData::KeyValueStore instance cannot be None";        
    }
    else
    {
        // End:0xCE
        if(EqualEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none)))
        {
            Error = "GetSaveData::DataBlobStore instance cannot be None";            
        }
        else
        {
            // End:0x146
            if(OnGetSaveDataCallbacks.Find('SlotIndex', SaveSlot) != -1)
            {
                Error = "GetSaveData::OnGetSaveDataCallback already present for save slot";                
            }
            else
            {
                // End:0x1BD
                if(ActiveSaveSlotOperations.Find('SlotIndex', SaveSlot) != -1)
                {
                    Error = "GetSaveData::Save System operation already active for save slot";                    
                }
                else
                {
                    // End:0x210
                    if(IsDeleteOperationActive())
                    {
                        Error = "GetSaveData::Delete Operation active cannot GetSaveData";                        
                    }
                    else
                    {
                        // End:0x28D
                        if(!GetDataStoreIDAndBlobNameForSaveSlot(SaveSlot, DataStoreID, BlobName))
                        {
                            Error = "GetSaveData::Failed to get store id and data blob name for save slot";                            
                        }
                        else
                        {
                            CallbackStruct.SlotIndex = SaveSlot;
                            CallbackStruct.Callback = OnGetSaveDataCallback;
                            OnGetSaveDataCallbacks.AddItem(CallbackStruct);
                            SlotOperation.SlotIndex = SaveSlot;
                            SlotOperation.SlotOperation = 1;
                            ActiveSaveSlotOperations.AddItem(SlotOperation);
                            DataBlobStore.GetDataBlob(DataStoreID, BlobName, OnGetSaveDataComplete);
                            ErrorOccured = false;
                        }
                    }
                }
            }
        }
    }
    // End:0x3E6
    if(ErrorOccured && OnGetSaveDataCallback != none)
    {
        OnGetSaveDataCallback(false, SaveSlot, EmptyBuffer, Error);
    }
    //return;    
}

private final function OnGetSaveDataComplete(bool bWasSuccessful, string StorageID, string BlobName, out array<byte> DataBlob, string Error)
{
    local int SaveSlotIndex, Index;
    local delegate<OnGetSaveDataCallback> LocalCallback;

    SaveSlotIndex = DoesSaveSlotKeyValueDataAlreadyExist(StorageID, BlobName);
    // End:0x2BD
    if(SaveSlotIndex >= 0)
    {
        Index = ActiveSaveSlotOperations.Find('SlotIndex', SaveSlotIndex);
        // End:0x163
        if(Index != -1)
        {
            // End:0x14B
            if(int(ActiveSaveSlotOperations[Index].SlotOperation) != int(1))
            {
                bWasSuccessful = false;
                Error = "CloudSaveSystem in corrupt stat GetSaveData request finished but active slot operation should have been" @ string(ActiveSaveSlotOperations[Index].SlotOperation);
            }
            ActiveSaveSlotOperations.Remove(Index, 1);            
        }
        else
        {
            bWasSuccessful = false;
            Error = "CloudSaveSystem in corrupt state GetData request finished but was not correctly internally tracked.";
        }
        Index = OnGetSaveDataCallbacks.Find('SlotIndex', SaveSlotIndex);
        // End:0x2BA
        if(Index != -1)
        {
            LocalCallback = OnGetSaveDataCallbacks[Index].Callback;
            OnGetSaveDataCallback(bWasSuccessful, SaveSlotIndex, DataBlob, "Unknown Error loading data blob from Cloud");
            OnGetSaveDataCallbacks.Remove(Index, 1);
        }        
    }
    //return;    
}

final function SetSaveData(int SaveSlot, delegate<SaveSystemCallback> InSetSaveDataCallback, const out array<byte> SaveDataBlob)
{
    local SetSaveDataCallbackStruct CallbackStruct;
    local SaveSlotOperation SlotOperation;
    local string DataStoreID, BlobName;
    local bool ErrorOccured;
    local string Error;

    ErrorOccured = true;
    // End:0x6D
    if(EqualEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)))
    {
        Error = "SetSaveData::KeyValueStore instance cannot be None";        
    }
    else
    {
        // End:0xCE
        if(EqualEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none)))
        {
            Error = "SetSaveData::DataBlobStore instance cannot be None";            
        }
        else
        {
            // End:0x146
            if(OnSetSaveDataCallbacks.Find('SlotIndex', SaveSlot) != -1)
            {
                Error = "SetSaveData::OnSetSaveDataCallback already present for save slot";                
            }
            else
            {
                // End:0x1BD
                if(ActiveSaveSlotOperations.Find('SlotIndex', SaveSlot) != -1)
                {
                    Error = "SetSaveData::Save System operation already active for save slot";                    
                }
                else
                {
                    // End:0x210
                    if(IsDeleteOperationActive())
                    {
                        Error = "SetSaveData::Delete Operation active cannot SetSaveData";                        
                    }
                    else
                    {
                        // End:0x28D
                        if(!GetDataStoreIDAndBlobNameForSaveSlot(SaveSlot, DataStoreID, BlobName))
                        {
                            Error = "SetSaveData::Failed to get store id and data blob name for save slot";                            
                        }
                        else
                        {
                            CallbackStruct.SlotIndex = SaveSlot;
                            CallbackStruct.Callback = InSetSaveDataCallback;
                            OnSetSaveDataCallbacks.AddItem(CallbackStruct);
                            SlotOperation.SlotIndex = SaveSlot;
                            SlotOperation.SlotOperation = 0;
                            ActiveSaveSlotOperations.AddItem(SlotOperation);
                            ErrorOccured = false;
                            DataBlobStore.SetDataBlob(DataStoreID, BlobName, SaveDataBlob, OnSetSaveDataComplete);
                        }
                    }
                }
            }
        }
    }
    // End:0x3E6
    if(ErrorOccured && InSetSaveDataCallback != none)
    {
        SaveSystemCallback(false, SaveSlot, Error);
    }
    //return;    
}

private final function OnSetSaveDataComplete(bool bWasSucessfull, string StorageID, string BlobName, string Error)
{
    local int SaveSlotIndex, Index;
    local delegate<SaveSystemCallback> LocalCallback;

    SaveSlotIndex = DoesSaveSlotKeyValueDataAlreadyExist(StorageID, BlobName);
    // End:0x28F
    if(SaveSlotIndex >= 0)
    {
        Index = ActiveSaveSlotOperations.Find('SlotIndex', SaveSlotIndex);
        // End:0x160
        if(Index != -1)
        {
            // End:0x148
            if(int(ActiveSaveSlotOperations[Index].SlotOperation) != int(0))
            {
                Error = "CloudSaveSystem in corrupt stat Set Data request finished but active slot operation should have been" @ string(ActiveSaveSlotOperations[Index].SlotOperation);
                bWasSucessfull = false;
            }
            ActiveSaveSlotOperations.Remove(Index, 1);            
        }
        else
        {
            bWasSucessfull = false;
            Error = "CloudSaveSystem in corrupt state Set Data request finished but was not correctly internally tracked.";
        }
        Index = OnSetSaveDataCallbacks.Find('SlotIndex', SaveSlotIndex);
        // End:0x28C
        if(Index != -1)
        {
            LocalCallback = OnSetSaveDataCallbacks[Index].Callback;
            SaveSystemCallback(bWasSucessfull, SaveSlotIndex, Error);
            OnSetSaveDataCallbacks.Remove(Index, 1);
        }        
    }
    //return;    
}

final function bool DeleteSaveData(int SaveSlot, delegate<SaveSystemCallback> InDeleteSaveDataCallback)
{
    local string DataStoreID, BlobName;
    local SaveSlotOperation SlotOperation;
    local bool RValue;

    RValue = false;
    // End:0x185
    if((((NotEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)) && NotEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none))) && DeleteSaveDataCallback == none) && !AreAnySlotOperationsActive()) && !IsDeleteOperationActive())
    {
        // End:0x185
        if(GetDataStoreIDAndBlobNameForSaveSlot(SaveSlot, DataStoreID, BlobName))
        {
            RValue = DataBlobStore.DeleteDataBlob(DataStoreID, BlobName, OnDeleteSaveDataComplete);
            // End:0x185
            if(RValue)
            {
                DeleteSaveDataCallback = InDeleteSaveDataCallback;
                ActiveSlotForDelete = SaveSlot;
                SlotOperation.SlotIndex = SaveSlot;
                SlotOperation.SlotOperation = 2;
                ActiveSaveSlotOperations.AddItem(SlotOperation);
            }
        }
    }
    return RValue;
    //return ReturnValue;    
}

final function OnDeleteSaveDataComplete(bool bWasSucessfull, string StorageID, string BlobName, string Error)
{
    local delegate<SaveSystemCallback> Callback;
    local int Scan, Index, SlotDeleted, NumSaveSlots;
    local string DataStoreID, DataBlobName;

    // End:0x2B2
    if(bWasSucessfull)
    {
        // End:0x9B
        if(!GetNumberOfSaveSlots(NumSaveSlots))
        {
            bWasSucessfull = false;
            Error = "Could not retrieve number of save slots during slot deletion. Save system in corrupt state.";            
        }
        else
        {
            Scan = ActiveSlotForDelete + 1;
            J0xB1:

            // End:0x23C [Loop If]
            if((Scan < NumSaveSlots) && bWasSucessfull)
            {
                // End:0x17D
                if(!GetDataStoreIDAndBlobNameForSaveSlot(Scan, DataStoreID, DataBlobName))
                {
                    bWasSucessfull = false;
                    Error = "Error retrieving DataStoreID and DataBlobName during slot deletion. Save system in corrupt state.";                    
                }
                else
                {
                    // End:0x22E
                    if(!InternalSetSaveSlotKeyValues(Scan - 1, DataStoreID, DataBlobName))
                    {
                        bWasSucessfull = false;
                        Error = "Error migrating DataStoreID and DataBlobName to new slot during slot deletion. Save system in corrupt state.";
                    }
                }
                ++Scan;
                // [Loop Continue]
                goto J0xB1;
            }
            // End:0x2B2
            if(bWasSucessfull)
            {
                NumSaveSlots--;
                // End:0x2B2
                if(!WriteNumSaveSlots(NumSaveSlots))
                {
                    bWasSucessfull = false;
                    Error = "Error writing number of save slot to Cloud KVS";
                }
            }
        }
    }
    SlotDeleted = ActiveSlotForDelete;
    ActiveSlotForDelete = -1;
    Index = ActiveSaveSlotOperations.Find('SlotIndex', SlotDeleted);
    // End:0x359
    if(Index != -1)
    {
        // End:0x341
        if(int(ActiveSaveSlotOperations[Index].SlotOperation) != int(2))
        {
        }
        ActiveSaveSlotOperations.Remove(Index, 1);        
    }
    // End:0x3C5
    if(DeleteSaveDataCallback != none)
    {
        Callback = DeleteSaveDataCallback;
        DeleteSaveDataCallback = None;
        SaveSystemCallback(bWasSucessfull, SlotDeleted, Error);
    }
    //return;    
}

final function bool SetSaveSlotKeyValues(string DataStoreID, string SaveDataBlobName, out int SaveSlot)
{
    local bool RValue;
    local int NumSaveSlots;
    local bool IncSlotCount;

    RValue = false;
    IncSlotCount = false;
    // End:0x153
    if((NotEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)) && NotEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none))) && GetNumberOfSaveSlots(NumSaveSlots))
    {
        SaveSlot = DoesSaveSlotKeyValueDataAlreadyExist(DataStoreID, SaveDataBlobName);
        // End:0xB0
        if(SaveSlot == -2)
        {
            return false;            
        }
        else
        {
            // End:0xE2
            if(SaveSlot == -1)
            {
                SaveSlot = NumSaveSlots;
                IncSlotCount = true;
            }
        }
        // End:0x153
        if(InternalSetSaveSlotKeyValues(SaveSlot, DataStoreID, SaveDataBlobName))
        {
            // End:0x147
            if(IncSlotCount)
            {
                NumSaveSlots++;
                // End:0x144
                if(WriteNumSaveSlots(NumSaveSlots))
                {
                    RValue = true;
                }                
            }
            else
            {
                RValue = true;
            }
        }
    }
    return RValue;
    //return ReturnValue;    
}

private final function bool InternalSetSaveSlotKeyValues(int SaveSlot, string DataStoreID, string SaveDataBlobName)
{
    local PlatformInterfaceData KVSet;
    local bool RValue;

    RValue = false;
    KVSet.StringValue = DataStoreID;
    KVSet.Type = 3;
    // End:0x127
    if(KeyValueStore.WriteKeyValue(SaveSlot, "DataStoreID", KVSet))
    {
        KVSet.StringValue = SaveDataBlobName;
        KVSet.Type = 3;
        // End:0x127
        if(KeyValueStore.WriteKeyValue(SaveSlot, "DataBlobName", KVSet))
        {
            RValue = true;
        }
    }
    return RValue;
    //return ReturnValue;    
}

final function bool SetKeyValue(int SaveSlot, string KeyName, const out PlatformInterfaceData Value)
{
    // End:0x22
    if(EqualEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)))
    {
        return false;
    }
    return KeyValueStore.WriteKeyValue(SaveSlot, KeyName, Value);
    //return ReturnValue;    
}

private final function bool GetDataStoreIDAndBlobNameForSaveSlot(int SaveSlot, out string DataStoreID, out string DataBlobName)
{
    local PlatformInterfaceDelegateResult KVRes;
    local bool RValue;

    RValue = false;
    // End:0x18F
    if(NotEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)) || NotEqual_InterfaceInterface(DataBlobStore, CloudSaveSystemDataBlobStoreInterface(none)))
    {
        KeyValueStore.ReadKeyValue(SaveSlot, "DataStoreID", 3, KVRes);
        // End:0x18F
        if(KVRes.bSuccessful)
        {
            DataStoreID = KVRes.Data.StringValue;
            KeyValueStore.ReadKeyValue(SaveSlot, "DataBlobName", 3, KVRes);
            // End:0x18F
            if(KVRes.bSuccessful)
            {
                DataBlobName = KVRes.Data.StringValue;
                RValue = true;
            }
        }
    }
    return RValue;
    //return ReturnValue;    
}

final function bool GetKeyValue(int SaveSlot, string KeyName, PlatformInterfaceBase.EPlatformInterfaceDataType Type, out PlatformInterfaceDelegateResult Value)
{
    // End:0x22
    if(EqualEqual_InterfaceInterface(KeyValueStore, CloudSaveSystemKVSInterface(none)))
    {
        return false;
    }
    return KeyValueStore.ReadKeyValue(SaveSlot, KeyName, Type, Value);
    //return ReturnValue;    
}

defaultproperties
{
    ActiveSlotForDelete=-1
}