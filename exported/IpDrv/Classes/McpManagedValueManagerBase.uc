class McpManagedValueManagerBase extends McpServiceBase
    abstract
    config(Engine);

struct ManagedValue
{
    var name ValueId;
    var int Value;

    structdefaultproperties
    {
        ValueId="None"
        Value=0
    }
};

struct ManagedValueSaveSlot
{
    var string OwningMcpId;
    var string SaveSlot;
    var array<ManagedValue> Values;

    structdefaultproperties
    {
        OwningMcpId=""
        SaveSlot=""
        Values=none
    }
};

var config string McpManagedValueManagerClassName;
//var delegate<OnCreateSaveSlotComplete> __OnCreateSaveSlotComplete__Delegate;
//var delegate<OnReadSaveSlotComplete> __OnReadSaveSlotComplete__Delegate;
//var delegate<OnUpdateValueComplete> __OnUpdateValueComplete__Delegate;
//var delegate<OnDeleteValueComplete> __OnDeleteValueComplete__Delegate;

static final function McpManagedValueManagerBase CreateInstance()
{
    local Class<McpManagedValueManagerBase> McpManagedValueManagerBaseClass;
    local McpManagedValueManagerBase NewInstance;

    McpManagedValueManagerBaseClass = Class<McpManagedValueManagerBase>(DynamicLoadObject(default.McpManagedValueManagerClassName, Class'Core.Class'));
    // End:0x76
    if(McpManagedValueManagerBaseClass != none)
    {
        NewInstance = new McpManagedValueManagerBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function CreateSaveSlot(string McpId, string SaveSlot)
{
    //return;    
}

delegate OnCreateSaveSlotComplete(string McpId, string SaveSlot, bool bWasSuccessful, string Error)
{
    //return;    
}

function ReadSaveSlot(string McpId, string SaveSlot)
{
    //return;    
}

delegate OnReadSaveSlotComplete(string McpId, string SaveSlot, bool bWasSuccessful, string Error)
{
    //return;    
}

function array<ManagedValue> GetValues(string McpId, string SaveSlot)
{
    //return ReturnValue;    
}

function int GetValue(string McpId, string SaveSlot, name ValueId)
{
    //return ReturnValue;    
}

function UpdateValue(string McpId, string SaveSlot, name ValueId, int Value)
{
    //return;    
}

delegate OnUpdateValueComplete(string McpId, string SaveSlot, name ValueId, int Value, bool bWasSuccessful, string Error)
{
    //return;    
}

function DeleteValue(string McpId, string SaveSlot, name ValueId)
{
    //return;    
}

delegate OnDeleteValueComplete(string McpId, string SaveSlot, name ValueId, bool bWasSuccessful, string Error)
{
    //return;    
}

defaultproperties
{
    McpManagedValueManagerClassName="IpDrv.McpManagedValueManager"
}