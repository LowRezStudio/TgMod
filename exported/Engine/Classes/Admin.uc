class Admin extends PlayerController
    config(Game)
    notplaceable
    hidecategories(Navigation);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    AddCheats();
    //return;    
}

exec function Admin(string CommandLine)
{
    ServerAdmin(CommandLine);
    //return;    
}

reliable server function ServerAdmin(string CommandLine)
{
    local string Result;

    Result = ConsoleCommand(CommandLine);
    // End:0x43
    if(Result != "")
    {
        ClientMessage(Result);
    }
    //return;    
}

exec function KickBan(string S)
{
    ServerKickBan(S);
    //return;    
}

reliable server function ServerKickBan(string S)
{
    WorldInfo.Game.KickBan(S);
    //return;    
}

exec function Kick(string S)
{
    ServerKick(S);
    //return;    
}

reliable server function ServerKick(string S)
{
    WorldInfo.Game.Kick(S);
    //return;    
}

exec function PlayerList()
{
    local PlayerReplicationInfo PRI;

    // End:0x1A
    foreach DynamicActors(Class'Engine.PlayerReplicationInfo', PRI)
    {        
    }    
    //return;    
}

exec function RestartMap()
{
    ServerRestartMap();
    //return;    
}

reliable server function ServerRestartMap()
{
    ClientTravel("?restart", 2);
    //return;    
}

exec function Switch(string URL)
{
    ServerSwitch(URL);
    //return;    
}

reliable server function ServerSwitch(string URL)
{
    WorldInfo.ServerTravel(URL);
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__Admin.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__PlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}