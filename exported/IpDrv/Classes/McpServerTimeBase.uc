class McpServerTimeBase extends McpServiceBase
    abstract
    config(Engine);

var config string McpServerTimeClassName;
//var delegate<OnQueryServerTimeComplete> __OnQueryServerTimeComplete__Delegate;

static final function McpServerTimeBase CreateInstance()
{
    local Class<McpServerTimeBase> McpServerTimeBaseClass;
    local McpServerTimeBase NewInstance;

    McpServerTimeBaseClass = Class<McpServerTimeBase>(DynamicLoadObject(default.McpServerTimeClassName, Class'Core.Class'));
    // End:0x76
    if(McpServerTimeBaseClass != none)
    {
        NewInstance = new McpServerTimeBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function QueryServerTime()
{
    //return;    
}

delegate OnQueryServerTimeComplete(bool bWasSuccessful, string DateTimeStr, string Error)
{
    //return;    
}

function string GetLastServerTime()
{
    //return ReturnValue;    
}

defaultproperties
{
    McpServerTimeClassName="IpDrv.McpServerTimeManager"
}