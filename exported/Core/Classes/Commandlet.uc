class Commandlet extends Object
    abstract
    transient
    native;

var const localized string HelpDescription;
var const localized string HelpUsage;
var const localized string HelpWebLink;
var const localized array<localized string> HelpParamNames;
var const localized array<localized string> HelpParamDescriptions;
var bool IsServer;
var bool IsClient;
var bool IsEditor;
var bool LogToConsole;
var bool ShowErrorCount;

event int Main(string Params)
{
    //return ReturnValue;    
}

defaultproperties
{
    IsServer=true
    IsClient=true
    IsEditor=true
    ShowErrorCount=true
}