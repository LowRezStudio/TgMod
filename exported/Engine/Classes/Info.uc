class Info extends Actor
    abstract
    native
    notplaceable
    hidecategories(Navigation,Movement,Collision);

struct native export transient KeyValuePair
{
    var() init string Key;
    var() init string Value;

    structdefaultproperties
    {
        Key=""
        Value=""
    }
};

struct native export transient PlayerResponseLine
{
    var() init int PlayerNum;
    var() init int PlayerID;
    var() init string PlayerName;
    var() init int Ping;
    var() init int Score;
    var() init int StatsID;
    var() init array<KeyValuePair> PlayerInfo;

    structdefaultproperties
    {
        PlayerNum=0
        PlayerID=0
        PlayerName=""
        Ping=0
        Score=0
        StatsID=0
        PlayerInfo=none
    }
};

struct native export transient ServerResponseLine
{
    var() init int ServerID;
    var() init string IP;
    var() init int Port;
    var() init int QueryPort;
    var() init string ServerName;
    var() init string MapName;
    var() init string GameType;
    var() init int CurrentPlayers;
    var() init int MaxPlayers;
    var() init int Ping;
    var() init array<KeyValuePair> ServerInfo;
    var() init array<PlayerResponseLine> PlayerInfo;

    structdefaultproperties
    {
        ServerID=0
        IP=""
        Port=0
        QueryPort=0
        ServerName=""
        MapName=""
        GameType=""
        CurrentPlayers=0
        MaxPlayers=0
        Ping=0
        ServerInfo=none
        PlayerInfo=none
    }
};

defaultproperties
{
    Components[0]=none
    bHidden=true
    bSkipActorPropertyReplication=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=10.0000000
}