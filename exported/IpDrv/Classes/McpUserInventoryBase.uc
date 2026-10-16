class McpUserInventoryBase extends McpServiceBase
    abstract
    config(Engine);

struct McpInventoryItemAttribute
{
    var string AttributeId;
    var int Value;

    structdefaultproperties
    {
        AttributeId=""
        Value=0
    }
};

struct McpInventoryItem
{
    var string InstanceItemId;
    var string GlobalItemId;
    var int Quantity;
    var int QuantityIAP;
    var float Scalar;
    var string LastUpdateTime;
    var array<McpInventoryItemAttribute> Attributes;

    structdefaultproperties
    {
        InstanceItemId=""
        GlobalItemId=""
        Quantity=0
        QuantityIAP=0
        Scalar=0.0000000
        LastUpdateTime=""
        Attributes=none
    }
};

struct McpInventoryItemContainer
{
    var string GlobalItemId;
    var int Quantity;

    structdefaultproperties
    {
        GlobalItemId=""
        Quantity=0
    }
};

struct McpInventorySaveSlot
{
    var string OwningMcpId;
    var string SaveSlotId;
    var array<McpInventoryItem> Items;

    structdefaultproperties
    {
        OwningMcpId=""
        SaveSlotId=""
        Items=none
    }
};

var config string McpUserInventoryClassName;
//var delegate<OnCreateSaveSlotComplete> __OnCreateSaveSlotComplete__Delegate;
//var delegate<OnDeleteSaveSlotComplete> __OnDeleteSaveSlotComplete__Delegate;
//var delegate<OnQuerySaveSlotListComplete> __OnQuerySaveSlotListComplete__Delegate;
//var delegate<OnQueryInventoryItemsComplete> __OnQueryInventoryItemsComplete__Delegate;
//var delegate<OnPurchaseItemComplete> __OnPurchaseItemComplete__Delegate;
//var delegate<OnSellItemComplete> __OnSellItemComplete__Delegate;
//var delegate<OnEarnItemComplete> __OnEarnItemComplete__Delegate;
//var delegate<OnConsumeItemComplete> __OnConsumeItemComplete__Delegate;
//var delegate<OnDeleteItemComplete> __OnDeleteItemComplete__Delegate;
//var delegate<OnRecordIapComplete> __OnRecordIapComplete__Delegate;

static final function McpUserInventoryBase CreateInstance()
{
    local Class<McpUserInventoryBase> McpUserInventoryBaseClass;
    local McpUserInventoryBase NewInstance;

    McpUserInventoryBaseClass = Class<McpUserInventoryBase>(DynamicLoadObject(default.McpUserInventoryClassName, Class'Core.Class'));
    // End:0x76
    if(McpUserInventoryBaseClass != none)
    {
        NewInstance = new McpUserInventoryBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function CreateSaveSlot(string McpId, string SaveSlotId, optional string ParentSaveSlotId)
{
    //return;    
}

delegate OnCreateSaveSlotComplete(string McpId, string SaveSlotId, bool bWasSuccessful, string Error)
{
    //return;    
}

function DeleteSaveSlot(string McpId, string SaveSlotId)
{
    //return;    
}

delegate OnDeleteSaveSlotComplete(string McpId, string SaveSlotId, bool bWasSuccessful, string Error)
{
    //return;    
}

function QuerySaveSlotList(string McpId)
{
    //return;    
}

function array<string> GetSaveSlotList(string McpId)
{
    //return ReturnValue;    
}

delegate OnQuerySaveSlotListComplete(string McpId, bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryInventoryItems(string McpId, string SaveSlotId)
{
    //return;    
}

delegate OnQueryInventoryItemsComplete(string McpId, string SaveSlotId, bool bWasSuccessful, string Error)
{
    //return;    
}

function GetInventoryItems(string McpId, string SaveSlotId, out array<McpInventoryItem> OutInventoryItems)
{
    //return;    
}

function bool GetInventoryItem(string McpId, string SaveSlotId, string InstanceItemId, out McpInventoryItem OutInventoryItem)
{
    //return ReturnValue;    
}

function PurchaseItem(string McpId, string SaveSlotId, string GlobalItemId, array<string> PurchaseItemIds, int Quantity, int StoreVersion, float Scalar)
{
    //return;    
}

delegate OnPurchaseItemComplete(string McpId, string SaveSlotId, string GlobalItemId, array<string> UpdatedItemIds, bool bWasSuccessful, string Error)
{
    //return;    
}

function SellItem(string McpId, string SaveSlotId, string InstanceItemId, int Quantity, int StoreVersion, const optional out array<McpInventoryItemContainer> ExpectedResultItems)
{
    //return;    
}

delegate OnSellItemComplete(string McpId, string SaveSlotId, string InstanceItemId, array<string> UpdatedItemIds, bool bWasSuccessful, string Error)
{
    //return;    
}

function EarnItem(string McpId, string SaveSlotId, string GlobalItemId, int Quantity, int StoreVersion)
{
    //return;    
}

delegate OnEarnItemComplete(string McpId, string SaveSlotId, string GlobalItemId, array<string> UpdatedItemIds, bool bWasSuccessful, string Error)
{
    //return;    
}

function ConsumeItem(string McpId, string SaveSlotId, string InstanceItemId, int Quantity, int StoreVersion)
{
    //return;    
}

delegate OnConsumeItemComplete(string McpId, string SaveSlotId, string InstanceItemId, array<string> UpdatedItemIds, bool bWasSuccessful, string Error)
{
    //return;    
}

function DeleteItem(string McpId, string SaveSlotId, string InstanceItemId, int StoreVersion)
{
    //return;    
}

delegate OnDeleteItemComplete(string McpId, string SaveSlotId, string InstanceItemId, bool bWasSuccessful, string Error)
{
    //return;    
}

function RecordIap(string McpId, string SaveSlotId, string Receipt)
{
    //return;    
}

delegate OnRecordIapComplete(string McpId, string SaveSlotId, array<string> UpdatedItemIds, bool bWasSuccessful, string Error)
{
    //return;    
}

defaultproperties
{
    McpUserInventoryClassName="IpDrv.McpUserInventoryManager"
}