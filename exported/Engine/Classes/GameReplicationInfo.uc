class GameReplicationInfo extends ReplicationInfo
    native(ReplicationInfo)
    nativereplication
    config(Game)
    notplaceable
    hidecategories(Navigation,Movement,Collision);

var repnotify Class<GameInfo> GameClass;
var bool bStopCountDown;
var repnotify bool bMatchHasBegun;
var repnotify bool bMatchIsOver;
var int RemainingTime;
var int ElapsedTime;
var int RemainingMinute;
var int GoalScore;
var int TimeLimit;
var array<TeamInfo> Teams;
var() globalconfig string ServerName;
var Actor Winner;
var array<PlayerReplicationInfo> PRIArray;
var array<PlayerReplicationInfo> InactivePRIArray;

replication
{
    // Pos:0x000
    if(bNetDirty)
        Winner, bMatchHasBegun, 
        bMatchIsOver, bStopCountDown;

    // Pos:0x00A
    if(!bNetInitial && bNetDirty)
        RemainingMinute;

    // Pos:0x025
    if(bNetInitial)
        ElapsedTime, GameClass, 
        GoalScore, RemainingTime, 
        ServerName, TimeLimit;
}

simulated event PostBeginPlay()
{
    local PlayerReplicationInfo PRI;
    local TeamInfo TI;

    // End:0x35
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        ServerName = "";
    }
    SetTimer(WorldInfo.TimeDilation, true);
    WorldInfo.GRI = self;
    // End:0xA6
    foreach DynamicActors(Class'Engine.PlayerReplicationInfo', PRI)
    {
        AddPRI(PRI);        
    }    
    // End:0x116
    foreach DynamicActors(Class'Engine.TeamInfo', TI)
    {
        // End:0x115
        if(TI.TeamIndex >= 0)
        {
            SetTeam(TI.TeamIndex, TI);
        }        
    }    
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x49
    if(VarName == 'bMatchHasBegun')
    {
        // End:0x46
        if(bMatchHasBegun)
        {
            WorldInfo.NotifyMatchStarted();
        }        
    }
    else
    {
        // End:0x7A
        if(VarName == 'bMatchIsOver')
        {
            // End:0x77
            if(bMatchIsOver)
            {
                EndGame();
            }            
        }
        else
        {
            // End:0x9E
            if(VarName == 'GameClass')
            {
                ReceivedGameClass();                
            }
            else
            {
                super(Actor).ReplicatedEvent(VarName);
            }
        }
    }
    //return;    
}

simulated function ReceivedGameClass()
{
    local PlayerController PC;

    // End:0x48
    foreach LocalPlayerControllers(Class'Engine.PlayerController', PC)
    {
        PC.ReceivedGameClass(GameClass);        
    }    
    //return;    
}

function Reset()
{
    super(Actor).Reset();
    Winner = none;
    //return;    
}

simulated event Timer()
{
    // End:0x68
    if((WorldInfo.Game == none) || WorldInfo.Game.MatchIsInProgress())
    {
        ElapsedTime++;
    }
    // End:0xBE
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        // End:0xBE
        if(RemainingMinute != 0)
        {
            RemainingTime = RemainingMinute;
            RemainingMinute = 0;
        }
    }
    // End:0x138
    if((RemainingTime > 0) && !bStopCountDown)
    {
        RemainingTime--;
        // End:0x138
        if(int(WorldInfo.NetMode) != int(NM_Client))
        {
            // End:0x138
            if((RemainingTime % 60) == 0)
            {
                RemainingMinute = RemainingTime;
            }
        }
    }
    SetTimer(WorldInfo.TimeDilation, true);
    //return;    
}

// Export UGameReplicationInfo::execOnSameTeam(FFrame&, void* const)
native simulated function bool OnSameTeam(Actor A, Actor B);

// Export UGameReplicationInfo::execCheckIsEnemy(FFrame&, void* const)
native simulated function bool CheckIsEnemy(const Actor A, const Actor B);

simulated function AddPRI(PlayerReplicationInfo PRI)
{
    local int I;

    // End:0x99
    if(!PRI.bIsInactive)
    {
        I = 0;
        J0x2F:

        // End:0x78 [Loop If]
        if(I < PRIArray.Length)
        {
            // End:0x6A
            if(PRIArray[I] == PRI)
            {
                return;
            }
            I++;
            // [Loop Continue]
            goto J0x2F;
        }
        PRIArray[PRIArray.Length] = PRI;        
    }
    else
    {
        // End:0xD7
        if(InactivePRIArray.Find(PRI) == -1)
        {
            InactivePRIArray[InactivePRIArray.Length] = PRI;
        }
    }
    //return;    
}

simulated function RemovePRI(PlayerReplicationInfo PRI)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x69 [Loop If]
    if(I < PRIArray.Length)
    {
        // End:0x5B
        if(PRIArray[I] == PRI)
        {
            PRIArray.Remove(I, 1);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function SetTeam(int Index, TeamInfo TI)
{
    // End:0x2C
    if(Index >= 0)
    {
        Teams[Index] = TI;
    }
    //return;    
}

simulated function StartMatch()
{
    bMatchHasBegun = true;
    //return;    
}

simulated function EndGame()
{
    bMatchIsOver = true;
    //return;    
}

simulated function bool IsMultiplayerGame()
{
    return int(WorldInfo.NetMode) != int(NM_Standalone);
    //return ReturnValue;    
}

simulated function bool IsCoopMultiplayerGame()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldShowGore()
{
    return true;
    //return ReturnValue;    
}

simulated event float GetMissionTime()
{
    //return ReturnValue;    
}

simulated function OnFogAdded(ExponentialHeightFog Fog)
{
    //return;    
}

defaultproperties
{
    bStopCountDown=true
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    s_bThrottleNetRelevancy=false
}