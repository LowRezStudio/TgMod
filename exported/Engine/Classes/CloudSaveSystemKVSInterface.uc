interface CloudSaveSystemKVSInterface extends Interface
    abstract;

function bool ReadKeyValue(int SaveSlotIndex, string KeyName, PlatformInterfaceBase.EPlatformInterfaceDataType Type, out PlatformInterfaceDelegateResult Value)
{
    //return ReturnValue;    
}

function bool WriteKeyValue(int SaveSlotIndex, string KeyName, const out PlatformInterfaceData Value)
{
    //return ReturnValue;    
}
