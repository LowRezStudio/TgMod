class CloudStorageBaseCloudSaveSystemKVS extends Object
    implements(CloudSaveSystemKVSInterface);

var private transient CloudStorageBase CloudStorage;

final function Init(CloudStorageBase InCloudStorage)
{
    CloudStorage = InCloudStorage;
    //return;    
}

function bool ReadKeyValue(int SaveSlotIndex, string KeyName, PlatformInterfaceBase.EPlatformInterfaceDataType Type, out PlatformInterfaceDelegateResult Value)
{
    local string SaveSlotKeyName;

    // End:0x11
    if(CloudStorage == none)
    {
        return false;
    }
    SaveSlotKeyName = GenerateKeyNameForSaveSlot(SaveSlotIndex, KeyName);
    return CloudStorage.ReadKeyValue(SaveSlotKeyName, Type, Value);
    //return ReturnValue;    
}

function bool WriteKeyValue(int SaveSlotIndex, string KeyName, const out PlatformInterfaceData Value)
{
    local string SaveSlotKeyName;

    // End:0x11
    if(CloudStorage == none)
    {
        return false;
    }
    SaveSlotKeyName = GenerateKeyNameForSaveSlot(SaveSlotIndex, KeyName);
    return CloudStorage.WriteKeyValue(SaveSlotKeyName, Value);
    //return ReturnValue;    
}

private final function string GenerateKeyNameForSaveSlot(int SaveSlotIndex, string KeyName)
{
    return string(SaveSlotIndex) $ KeyName;
    //return ReturnValue;    
}
