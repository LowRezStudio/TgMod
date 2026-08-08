class PComSupportCommands extends Object
    native
    config(Engine);

const GC_OS_TYPE_BELOW_XP = 10300;

const GC_OS_TYPE_XP = 10301;

const GC_OS_TYPE_VISTA = 10303;

const GC_OS_TYPE_WIN7 = 10305;

const GC_OS_TYPE_WIN8 = 10307;

enum GC_ALERT_PRIORITY {
    GC_APT_MINIMAL,  // 0
    GC_APT_NORMAL,  // 1
    GC_APT_HIGH,  // 2
    GC_APT_CRITICAL,  // 3
};

enum GC_CHAT_CHANNEL {
    GC_CC_GLOBAL,  // 0
    GC_CC_CLAN,  // 1
    GC_CC_INSTANCE,  // 2
    GC_CC_LOCAL_TEAM,  // 3
    GC_CC_PARTY,  // 4
    GC_CC_CITY,  // 5
    GC_CC_PERSONAL,  // 6
    GC_CC_PRIVATE_1,  // 7
    GC_CC_EOM_LOBBY,  // 8
    GC_CC_SYSTEM,  // 9
    GC_CC_TRADE,  // 10
    GC_CC_LFG,  // 11
    GC_CC_LFG_2,  // 12
    GC_CC_HELP,  // 13
    GC_CC_VOIP_NEWS,  // 14
    GC_CC_GM,  // 15
    GC_CC_VIP,  // 16
    GC_CC_LFG_3,  // 17
    GC_CC_COUNT,  // 18
    GC_CC_VOIP_ECHO,  // 19
    GC_CC_VOIP_CONF,  // 20
    GC_CC_COMBAT,  // 21
    GC_CC_EMOTE,  // 22
    GC_CC_INVALID,  // 23
    GC_CC_LAST,  // 24
};

enum GC_STEAM_TXN_TYPES {
    GC_STT_INVALID,  // 0
    GC_STT_GETUSERINFO,  // 1
    GC_STT_INIT,  // 2
    GC_STT_FINALIZE,  // 3
    GC_STT_DECLINE,  // 4
};

var const transient PComPlayerController PC;
var const transient WorldInfo WorldInfo;

native exec function gmMatchForce(optional int nQueueId=0);  // Export UPComSupportCommands::execgmMatchForce(FFrame&, void* const)

native exec function gmMatchNext(int nMapId);  // Export UPComSupportCommands::execgmMatchNext(FFrame&, void* const)

native exec function gmCommand(string sCommand);  // Export UPComSupportCommands::execgmCommand(FFrame&, void* const)

native exec function gmC(string sCommand);  // Export UPComSupportCommands::execgmC(FFrame&, void* const)

native exec function gmDiag(int Code, int Route);  // Export UPComSupportCommands::execgmDiag(FFrame&, void* const)

native function GPerfDebugFeet(int feet);  // Export UPComSupportCommands::execGPerfDebugFeet(FFrame&, void* const)

native function GPerfDebugSkips(int skips);  // Export UPComSupportCommands::execGPerfDebugSkips(FFrame&, void* const)

native function GPerfDebugRelevMode(int Mode);  // Export UPComSupportCommands::execGPerfDebugRelevMode(FFrame&, void* const)

native function GPerfServerFlags(int Flags, int alternate1, int alternate2);  // Export UPComSupportCommands::execGPerfServerFlags(FFrame&, void* const)

native function GPerfAllRelevantLimit(int feet);  // Export UPComSupportCommands::execGPerfAllRelevantLimit(FFrame&, void* const)

native function GPerfDebugTickRate(int tickHz, int altTickHz);  // Export UPComSupportCommands::execGPerfDebugTickRate(FFrame&, void* const)

native function GPerfDebugPhysicsThreshold(float fThresh1, float fThresh2);  // Export UPComSupportCommands::execGPerfDebugPhysicsThreshold(FFrame&, void* const)

native function SetLogServerTickStatsFlags(int Flags, bool bSet);  // Export UPComSupportCommands::execSetLogServerTickStatsFlags(FFrame&, void* const)

exec function gmmf() { }

exec function scLog(string LogName, optional bool bEnabled=true) { }

exec function scLogMark(string Comment) { }

exec function scStartGame(optional string Reason="Admin") { }

exec function scEndGame(optional string Reason="Admin") { }

exec function scScore(int nTeam, optional int nCount=1) { }

exec function scTime(int nSeconds) { }

exec function scTimer(string sCommand) { }

exec function scDemoRec(string sCommand) { }

exec function scDemoStop() { }

exec function scPerfDebugFeet(int feet) { }

exec function scPerfDebugSkip(int skips) { }

exec function scPerfDebugRelevMode(int Mode) { }

exec function scPerfTickRate(int tickHz, int altTickHz) { }

exec function scPerfPhysThreshold(float thresh1, float thesh2) { }

exec function scGPerfServerFlags(int Flags, int alternate1, int alternate2) { }

exec function scPerfAlwaysRelevantLimit(int feet) { }

exec function scLogTickFlags(int nFlags, optional bool bSet=true) { }
