class McpMessageBase extends McpServiceBase
    abstract
    native
    config(Engine);

enum EMcpMessageCompressionType
{
    MMCT_NONE,                      // 0
    MMCT_LZO,                       // 1
    MMCT_ZLIB,                      // 2
    MMCT_MAX                        // 3
};

struct native McpMessage
{
    var string MessageId;
    var string TitleId;
    var string ToUniqueUserId;
    var string FromUniqueUserId;
    var string FromFriendlyName;
    var string MessageType;
    var string ValidUntil;
    var McpMessageBase.EMcpMessageCompressionType MessageCompressionType;

    structdefaultproperties
    {
        MessageId=""
        TitleId=""
        ToUniqueUserId=""
        FromUniqueUserId=""
        FromFriendlyName=""
        MessageType=""
        ValidUntil=""
        MessageCompressionType=EMcpMessageCompressionType.MMCT_NONE
    }
};

struct native McpMessageList
{
    var string ToUniqueUserId;
    var array<McpMessage> Messages;

    structdefaultproperties
    {
        ToUniqueUserId=""
        Messages=none
    }
};

struct native McpMessageContents
{
    var string MessageId;
    var array<byte> MessageContents;

    structdefaultproperties
    {
        MessageId=""
        MessageContents=none
    }
};

var config string McpMessageManagerClassName;
var config McpMessageBase.EMcpMessageCompressionType CompressionType;
var array<McpMessageContents> MessageContentsList;
var array<McpMessageList> MessageLists;
//var delegate<OnCreateMessageComplete> __OnCreateMessageComplete__Delegate;
//var delegate<OnDeleteMessageComplete> __OnDeleteMessageComplete__Delegate;
//var delegate<OnQueryMessagesComplete> __OnQueryMessagesComplete__Delegate;
//var delegate<OnQueryMessageContentsComplete> __OnQueryMessageContentsComplete__Delegate;

static final function McpMessageBase CreateInstance()
{
    local Class<McpMessageBase> McpMessageBaseClass;
    local McpMessageBase NewInstance;

    McpMessageBaseClass = Class<McpMessageBase>(DynamicLoadObject(default.McpMessageManagerClassName, Class'Core.Class'));
    // End:0x76
    if(McpMessageBaseClass != none)
    {
        NewInstance = new McpMessageBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function CreateMessage(const out array<string> ToUniqueUserIds, string FromUniqueUserId, string FromFriendlyName, string MessageType, string TitleId, string PushMessage, string ValidUntil, const out array<byte> MessageContents)
{
    //return;    
}

delegate OnCreateMessageComplete(McpMessage Message, bool bWasSuccessful, string Error)
{
    //return;    
}

function DeleteMessage(string MessageId)
{
    //return;    
}

delegate OnDeleteMessageComplete(string MessageId, bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryMessages(string ToUniqueUserId, string TitleId)
{
    //return;    
}

delegate OnQueryMessagesComplete(string UserId, bool bWasSuccessful, string Error)
{
    //return;    
}

function GetMessageList(string ToUniqueUserId, out McpMessageList MessageList)
{
    //return;    
}

function QueryMessageContents(string MessageId)
{
    //return;    
}

delegate OnQueryMessageContentsComplete(string MessageId, bool bWasSuccessful, string Error)
{
    //return;    
}

function bool GetMessageContents(string MessageId, out array<byte> MessageContents)
{
    //return ReturnValue;    
}

function CacheMessage(McpMessage Message)
{
    //return;    
}

function bool CacheMessageContents(const out array<byte> MessageContents, string MessageId)
{
    //return ReturnValue;    
}

defaultproperties
{
    McpMessageManagerClassName="IpDrv.McpMessageManager"
}