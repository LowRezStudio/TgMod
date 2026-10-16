class McpIdMappingBase extends McpServiceBase
    abstract
    config(Engine);

struct McpIdMapping
{
    var string McpId;
    var string ExternalId;
    var string ExternalType;

    structdefaultproperties
    {
        McpId=""
        ExternalId=""
        ExternalType=""
    }
};

var config string McpIdMappingClassName;
//var delegate<OnAddMappingComplete> __OnAddMappingComplete__Delegate;
//var delegate<OnQueryMappingsComplete> __OnQueryMappingsComplete__Delegate;

static final function McpIdMappingBase CreateInstance()
{
    local Class<McpIdMappingBase> McpIdMappingBaseClass;
    local McpIdMappingBase NewInstance;

    McpIdMappingBaseClass = Class<McpIdMappingBase>(DynamicLoadObject(default.McpIdMappingClassName, Class'Core.Class'));
    // End:0x76
    if(McpIdMappingBaseClass != none)
    {
        NewInstance = new McpIdMappingBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function AddMapping(string McpId, string ExternalId, string ExternalType)
{
    //return;    
}

delegate OnAddMappingComplete(string McpId, string ExternalId, string ExternalType, bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryMappings(const out array<string> ExternalIds, string ExternalType)
{
    //return;    
}

delegate OnQueryMappingsComplete(string ExternalType, bool bWasSuccessful, string Error)
{
    //return;    
}

function GetIdMappings(string ExternalType, out array<McpIdMapping> IDMappings)
{
    //return;    
}

defaultproperties
{
    McpIdMappingClassName="IpDrv.McpIdMappingManager"
}