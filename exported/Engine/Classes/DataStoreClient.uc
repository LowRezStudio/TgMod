class DataStoreClient extends UIRoot
    native(UserInterface)
    config(Engine)
    hidecategories(Object,UIRoot);

struct native transient PlayerDataStoreGroup
{
    var init const transient LocalPlayer PlayerOwner;
    var init const transient array<UIDataStore> DataStores;

    structdefaultproperties
    {
        PlayerOwner=none
        DataStores=none
    }
};

var config array<config string> GlobalDataStoreClasses;
var const array<UIDataStore> GlobalDataStores;
var config array<config string> PlayerDataStoreClassNames;
var private const array< Class<UIDataStore> > PlayerDataStoreClasses;
var const array<PlayerDataStoreGroup> PlayerDataStores;

// Export UDataStoreClient::execFindDataStore(FFrame&, void* const)
native final function UIDataStore FindDataStore(name DataStoreTag, optional LocalPlayer PlayerOwner);

// Export UDataStoreClient::execCreateDataStore(FFrame&, void* const)
native final function UIDataStore CreateDataStore(Class<UIDataStore> DataStoreClass);

// Export UDataStoreClient::execRegisterDataStore(FFrame&, void* const)
native final function bool RegisterDataStore(UIDataStore DataStore, optional LocalPlayer PlayerOwner);

// Export UDataStoreClient::execUnregisterDataStore(FFrame&, void* const)
native final function bool UnregisterDataStore(UIDataStore DataStore);

// Export UDataStoreClient::execFindPlayerDataStoreIndex(FFrame&, void* const)
native final function int FindPlayerDataStoreIndex(LocalPlayer PlayerOwner);

final function GetPlayerDataStoreClasses(out array< Class<UIDataStore> > out_DataStoreClasses)
{
    out_DataStoreClasses = PlayerDataStoreClasses;
    //return;    
}

final function Class<UIDataStore> FindDataStoreClass(Class<UIDataStore> RequiredMetaClass)
{
    local int I;
    local Class<UIDataStore> Result;

    I = 0;
    J0x0B:

    // End:0xA8 [Loop If]
    if(I < GlobalDataStores.Length)
    {
        // End:0x9A
        if(GlobalDataStores[I].IsA(RequiredMetaClass.Name))
        {
            Result = GlobalDataStores[I].Class;
            // [Explicit Break]
            goto J0xA8;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    J0xA8:

    // End:0x12A
    if(Result == none)
    {
        I = 0;
        J0xC2:

        // End:0x12A [Loop If]
        if(I < PlayerDataStoreClasses.Length)
        {
            // End:0x11C
            if(ClassIsChildOf(PlayerDataStoreClasses[I], RequiredMetaClass))
            {
                Result = PlayerDataStoreClasses[I];
                // [Explicit Break]
                goto J0x12A;
            }
            I++;
            // [Loop Continue]
            goto J0xC2;
        }
    }
    J0x12A:

    return Result;
    //return ReturnValue;    
}

final event NotifyGameSessionEnded()
{
    local int I, DataStoreIndex;
    local array<UIDataStore> DataStoreArray;

    DataStoreArray = GlobalDataStores;
    DataStoreIndex = 0;
    J0x1E:

    // End:0x8D [Loop If]
    if(DataStoreIndex < DataStoreArray.Length)
    {
        // End:0x7F
        if(DataStoreArray[DataStoreIndex].NotifyGameSessionEnded())
        {
            UnregisterDataStore(DataStoreArray[DataStoreIndex]);
        }
        DataStoreIndex++;
        // [Loop Continue]
        goto J0x1E;
    }
    I = PlayerDataStores.Length - 1;
    J0xA4:

    // End:0x168 [Loop If]
    if(I >= 0)
    {
        DataStoreArray = PlayerDataStores[I].DataStores;
        DataStoreIndex = 0;
        J0xEE:

        // End:0x15A [Loop If]
        if(DataStoreIndex < DataStoreArray.Length)
        {
            DataStoreArray[DataStoreIndex].NotifyGameSessionEnded();
            UnregisterDataStore(DataStoreArray[DataStoreIndex]);
            DataStoreIndex++;
            // [Loop Continue]
            goto J0xEE;
        }
        I--;
        // [Loop Continue]
        goto J0xA4;
    }
    //return;    
}

final function DebugDumpDataStoreInfo(bool bVerbose)
{
    //return;    
}

defaultproperties
{
    GlobalDataStoreClasses[0]="Engine.UIDataStore_GameResource"
    GlobalDataStoreClasses[1]="Engine.UIDataStore_Fonts"
    GlobalDataStoreClasses[2]="Engine.UIDataStore_Registry"
    GlobalDataStoreClasses[3]="Engine.UIDataStore_InputAlias"
}