class TeamInfo extends ReplicationInfo
    native(ReplicationInfo)
    nativereplication
    notplaceable
    hidecategories(Navigation,Movement,Collision);

var const localized string TeamName;
var int Size;
var float Score;
var repnotify int TeamIndex;
var Color TeamColor;

replication
{
    // Pos:0x000
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        Score;

    // Pos:0x020
    if(bNetInitial && int(Role) == int(ROLE_Authority))
        TeamIndex, TeamName;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x7C
    if(VarName == 'TeamIndex')
    {
        // End:0x79
        if(WorldInfo.GRI != none)
        {
            WorldInfo.GRI.SetTeam(TeamIndex, self);
        }        
    }
    else
    {
        super(Actor).ReplicatedEvent(VarName);
    }
    //return;    
}

simulated event Destroyed()
{
    local TeamInfo OtherTeam;

    super(Actor).Destroyed();
    // End:0xCF
    if(WorldInfo.GRI != none)
    {
        // End:0xCE
        foreach DynamicActors(Class'Engine.TeamInfo', OtherTeam)
        {
            // End:0xCD
            if((OtherTeam != self) && OtherTeam.TeamIndex == TeamIndex)
            {
                WorldInfo.GRI.SetTeam(TeamIndex, OtherTeam);
                // End:0xCE
                break;
            }            
        }        
    }
    //return;    
}

function bool AddToTeam(Controller Other)
{
    // End:0x11
    if(Other == none)
    {
        return false;
    }
    // End:0x41
    if(Other.PlayerReplicationInfo == none)
    {
        ScriptTrace();
        return false;
    }
    Size++;
    Other.PlayerReplicationInfo.SetPlayerTeam(self);
    return true;
    //return ReturnValue;    
}

function RemoveFromTeam(Controller Other)
{
    Size--;
    // End:0x75
    if((Other != none) && Other.PlayerReplicationInfo != none)
    {
        Other.PlayerReplicationInfo.SetPlayerTeam(none);
    }
    //return;    
}

simulated function string GetHumanReadableName()
{
    return TeamName;
    //return ReturnValue;    
}

// Export UTeamInfo::execGetTeamNum(FFrame&, void* const)
native simulated function byte GetTeamNum();

defaultproperties
{
    TeamName="Team"
    TeamIndex=-1
    TeamColor=(R=255,G=64,B=64,A=255)
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    NetUpdateFrequency=2.0000000
}