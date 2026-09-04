class WebApplication extends Object;

var WorldInfo WorldInfo;
var WebServer WebServer;
var string Path;

function Init()
{
    //return;    
}

final function Cleanup()
{
    //return;    
}

function CleanupApp()
{
    // End:0x1A
    if(WorldInfo != none)
    {
        WorldInfo = none;
    }
    // End:0x34
    if(WebServer != none)
    {
        WebServer = none;
    }
    //return;    
}

function bool PreQuery(WebRequest Request, WebResponse Response)
{
    return true;
    //return ReturnValue;    
}

function Query(WebRequest Request, WebResponse Response)
{
    //return;    
}

function PostQuery(WebRequest Request, WebResponse Response)
{
    //return;    
}
