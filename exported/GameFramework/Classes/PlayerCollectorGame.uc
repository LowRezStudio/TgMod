class PlayerCollectorGame extends GameInfo
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int NumberOfClientsToWaitFor;
var string URLToLoad;

event PlayerController Login(string Portal, string Options, const UniqueNetId UniqueId, out string ErrorMessage, const optional UniqueNetId ConsoleUniqueId)
{
    local PlayerController PC;

    PC = super.Login(Portal, Options, UniqueId, ErrorMessage);
    // End:0x4B
    if(PC == none)
    {
        return none;
    }
    // End:0xE7
    if(NumberOfClientsToWaitFor == 0)
    {
        NumberOfClientsToWaitFor = GetIntOption(Options, "NumClients", 1);
        URLToLoad = ParseOption(Options, "SubMap");
        URLToLoad = (URLToLoad $ "?game=") $ (ParseOption(Options, "SubGame"));        
    }
    else
    {
        NumberOfClientsToWaitFor--;
    }
    // End:0x12B
    if(NumberOfClientsToWaitFor == 0)
    {
        WorldInfo.SeamlessTravel(URLToLoad, true);
    }
    return PC;
    //return ReturnValue;    
}

event GetSeamlessTravelActorList(bool bToEntry, out array<Actor> ActorList)
{
    //return;    
}
