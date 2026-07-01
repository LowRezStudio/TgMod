class PComSupportCommands extends Object
    native;

const GC_OS_TYPE_BELOW_XP = 10300;
const GC_OS_TYPE_XP = 10301;
const GC_OS_TYPE_VISTA = 10303;
const GC_OS_TYPE_WIN7 = 10305;
const GC_OS_TYPE_WIN8 = 10307;

enum GC_ALERT_PRIORITY
{
    GC_APT_MINIMAL,
    GC_APT_NORMAL,
    GC_APT_HIGH,
    GC_APT_CRITICAL
};

enum GC_CHAT_CHANNEL
{
    GC_CC_GLOBAL,
    GC_CC_CLAN,
    GC_CC_INSTANCE,
    GC_CC_LOCAL_TEAM,
    GC_CC_PARTY,
    GC_CC_CITY,
    GC_CC_PERSONAL,
    GC_CC_PRIVATE_1,
    GC_CC_EOM_LOBBY,
    GC_CC_SYSTEM,
    GC_CC_TRADE,
    GC_CC_LFG,
    GC_CC_LFG_2,
    GC_CC_HELP,
    GC_CC_VOIP_NEWS,
    GC_CC_GM,
    GC_CC_VIP,
    GC_CC_LFG_3,
    GC_CC_COUNT,
    GC_CC_VOIP_ECHO,
    GC_CC_VOIP_CONF,
    GC_CC_COMBAT,
    GC_CC_EMOTE,
    GC_CC_INVALID,
    GC_CC_LAST
};

enum GC_STEAM_TXN_TYPES
{
    GC_STT_INVALID,
    GC_STT_GETUSERINFO,
    GC_STT_INIT,
    GC_STT_FINALIZE,
    GC_STT_DECLINE
};

var const transient PComPlayerController PC;
var const transient WorldInfo WorldInfo;

// Export UPComSupportCommands::execgmMatchForce(FFrame&, void* const)
native exec function gmMatchForce(optional int nQueueId = 0);

// Export UPComSupportCommands::execgmMatchNext(FFrame&, void* const)
native exec function gmMatchNext(int nMapId);

// Export UPComSupportCommands::execgmMatchLobbyPause(FFrame&, void* const)
native exec function gmMatchLobbyPause();

// Export UPComSupportCommands::execgmMatchLobbyResume(FFrame&, void* const)
native exec function gmMatchLobbyResume();

// Export UPComSupportCommands::execgmCommand(FFrame&, void* const)
native exec function gmCommand(string sCommand);

// Export UPComSupportCommands::execgmC(FFrame&, void* const)
native exec function gmC(string sCommand);

// Export UPComSupportCommands::execgmDiag(FFrame&, void* const)
native exec function gmDiag(int Code, int Route);

// Export UPComSupportCommands::execGPerfDebugFeet(FFrame&, void* const)
native function GPerfDebugFeet(int feet);

// Export UPComSupportCommands::execGPerfDebugSkips(FFrame&, void* const)
native function GPerfDebugSkips(int skips);

// Export UPComSupportCommands::execGPerfDebugRelevMode(FFrame&, void* const)
native function GPerfDebugRelevMode(int Mode);

// Export UPComSupportCommands::execGPerfServerFlags(FFrame&, void* const)
native function GPerfServerFlags(int Flags, int alternate1, int alternate2);

// Export UPComSupportCommands::execGPerfAllRelevantLimit(FFrame&, void* const)
native function GPerfAllRelevantLimit(int feet);

// Export UPComSupportCommands::execGPerfDebugTickRate(FFrame&, void* const)
native function GPerfDebugTickRate(int tickHz, int altTickHz);

// Export UPComSupportCommands::execGPerfDebugPhysicsThreshold(FFrame&, void* const)
native function GPerfDebugPhysicsThreshold(float fThresh1, float fThresh2);

// Export UPComSupportCommands::execSetLogServerTickStatsFlags(FFrame&, void* const)
native function SetLogServerTickStatsFlags(int Flags, bool bSet);

exec function gmmf()
{
    //return;    
}

exec function scLog(string LogName, optional bool bEnabled = true)
{
    //return;    
}

exec function scLogMark(string Comment)
{
    //return;    
}

exec function scStartGame(optional string Reason = "Admin")
{
    //return;    
}

exec function scEndGame(optional string Reason = "Admin")
{
    //return;    
}

exec function scScore(int nTeam, optional int nCount = 1)
{
    //return;    
}

exec function scTime(int nSeconds)
{
    //return;    
}

exec function scTimer(string sCommand)
{
    //return;    
}

exec function scDemoRec(string sCommand)
{
    //return;    
}

exec function scDemoStop()
{
    //return;    
}

exec function scPerfDebugFeet(int feet)
{
    //return;    
}

exec function scPerfDebugSkip(int skips)
{
    //return;    
}

exec function scPerfDebugRelevMode(int Mode)
{
    //return;    
}

exec function scPerfTickRate(int tickHz, int altTickHz)
{
    //return;    
}

exec function scPerfPhysThreshold(float thresh1, float thesh2)
{
    //return;    
}

exec function scGPerfServerFlags(int Flags, int alternate1, int alternate2)
{
    //return;    
}

exec function scPerfAlwaysRelevantLimit(int feet)
{
    //return;    
}

exec function scLogTickFlags(int nFlags, optional bool bSet = true)
{
    //return;    
}
