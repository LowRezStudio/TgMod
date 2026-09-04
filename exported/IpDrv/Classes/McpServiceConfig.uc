class McpServiceConfig extends Object
    config(Engine);

var config string Protocol;
var config string Domain;
var config string TitleId;
var string AppKey;
var string AppSecret;

function string GetUserAuthTicket(string McpId)
{
    //return ReturnValue;    
}

defaultproperties
{
    Protocol="http"
    Domain="localhost:8888"
}