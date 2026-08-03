class PlatformInterfaceBase extends Object
    transient
    native(PlatformInterface);

enum EPlatformInterfaceDataType
{
    PIDT_None,                      // 0
    PIDT_Int,                       // 1
    PIDT_Float,                     // 2
    PIDT_String,                    // 3
    PIDT_Object,                    // 4
    PIDT_Custom,                    // 5
    PIDT_MAX                        // 6
};

struct native PlatformInterfaceData
{
    var name DataName;
    var PlatformInterfaceBase.EPlatformInterfaceDataType Type;
    var int IntValue;
    var float FloatValue;
    var init string StringValue;
    var init string StringValue2;
    var Object ObjectValue;

    structdefaultproperties
    {
        DataName="None"
        Type=EPlatformInterfaceDataType.PIDT_None
        IntValue=0
        FloatValue=0.0000000
        StringValue=""
        StringValue2=""
        ObjectValue=none
    }
};

struct native PlatformInterfaceDelegateResult
{
    var bool bSuccessful;
    var PlatformInterfaceData Data;

    structdefaultproperties
    {
        bSuccessful=false
        Data=(DataName="None",Type=EPlatformInterfaceDataType.PIDT_None,IntValue=0,FloatValue=0.0000000,StringValue="",StringValue2="",ObjectValue=none)
    }
};

struct native DelegateArray
{
    var array< delegate<PlatformInterfaceDelegate> > Delegates;

    structdefaultproperties
    {
        Delegates=none
    }
};

var array<DelegateArray> AllDelegates;
//var delegate<PlatformInterfaceDelegate> __PlatformInterfaceDelegate__Delegate;

delegate PlatformInterfaceDelegate(const out PlatformInterfaceDelegateResult Result)
{
    //return;    
}

// Export UPlatformInterfaceBase::execCallDelegates(FFrame&, void* const)
native function CallDelegates(int DelegateType, out PlatformInterfaceDelegateResult DelegateResult);

// Export UPlatformInterfaceBase::execGetCloudStorageInterface(FFrame&, void* const)
native static function CloudStorageBase GetCloudStorageInterface();

// Export UPlatformInterfaceBase::execGetLocalStorageInterface(FFrame&, void* const)
native static function CloudStorageBase GetLocalStorageInterface();

// Export UPlatformInterfaceBase::execGetFacebookIntegration(FFrame&, void* const)
native static function FacebookIntegration GetFacebookIntegration();

// Export UPlatformInterfaceBase::execGetInGameAdManager(FFrame&, void* const)
native static function InGameAdManager GetInGameAdManager();

// Export UPlatformInterfaceBase::execGetMicroTransactionInterface(FFrame&, void* const)
native static function MicroTransactionBase GetMicroTransactionInterface();

// Export UPlatformInterfaceBase::execGetAnalyticEventsInterface(FFrame&, void* const)
native static function AnalyticEventsBase GetAnalyticEventsInterface();

// Export UPlatformInterfaceBase::execGetTwitterIntegration(FFrame&, void* const)
native static function TwitterIntegrationBase GetTwitterIntegration();

// Export UPlatformInterfaceBase::execGetAppNotificationsInterface(FFrame&, void* const)
native static function AppNotificationsBase GetAppNotificationsInterface();

// Export UPlatformInterfaceBase::execGetInAppMessageInterface(FFrame&, void* const)
native static function InAppMessageBase GetInAppMessageInterface();

function AddDelegate(int DelegateType, delegate<PlatformInterfaceDelegate> InDelegate)
{
    // End:0x32
    if(AllDelegates.Length < (DelegateType + 1))
    {
        AllDelegates.Length = DelegateType + 1;
    }
    // End:0xA2
    if(AllDelegates[DelegateType].Delegates.Find(InDelegate) == -1)
    {
        AllDelegates[DelegateType].Delegates.AddItem(InDelegate);
    }
    //return;    
}

function ClearDelegate(int DelegateType, delegate<PlatformInterfaceDelegate> InDelegate)
{
    local int RemoveIndex;

    // End:0x9A
    if(DelegateType < AllDelegates.Length)
    {
        RemoveIndex = AllDelegates[DelegateType].Delegates.Find(InDelegate);
        // End:0x9A
        if(RemoveIndex != -1)
        {
            AllDelegates[DelegateType].Delegates.Remove(RemoveIndex, 1);
        }
    }
    //return;    
}
