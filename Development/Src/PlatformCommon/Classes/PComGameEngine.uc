class PComGameEngine extends GameEngine
    transient
    native
    config(Engine);

struct MAR_EVENT {
    var bool bSuccess;
    var int nFunction;
    var QWord qwId;
    var QWord qwInfo;
    var int nStmMsgId;
    var int nEventFlags;
    var string fsMessage;
    var const Pointer pMarshal;
    structdefaultproperties {}
};

var array< delegate<OnMarshalEvent> > MarshalEventDelegates;
var native const Pointer pOutgoingMarshal;
var native const Pointer pEventMarshal;

native function bool SetFunction(int nFunction);  // Export UPComGameEngine::execSetFunction(FFrame&, void* const)

native function bool SetFieldInt(int nToken, int IntValue);  // Export UPComGameEngine::execSetFieldInt(FFrame&, void* const)

native function bool SetFieldFloat(int nToken, float FloatValue);  // Export UPComGameEngine::execSetFieldFloat(FFrame&, void* const)

native function bool SetFieldString(int nToken, string StrValue);  // Export UPComGameEngine::execSetFieldString(FFrame&, void* const)

native function ClearMarshal();  // Export UPComGameEngine::execClearMarshal(FFrame&, void* const)

native function SendMarshal(UniqueNetId qwPlayerId, bool bLowPriority);  // Export UPComGameEngine::execSendMarshal(FFrame&, void* const)

native function SendMarshalAll(bool bLowPriority);  // Export UPComGameEngine::execSendMarshalAll(FFrame&, void* const)

native function bool GetFieldInt(int nToken, out int IntValue);  // Export UPComGameEngine::execGetFieldInt(FFrame&, void* const)

native function bool GetFieldFloat(int nToken, out float FloatValue);  // Export UPComGameEngine::execGetFieldFloat(FFrame&, void* const)

native function bool GetFieldString(int nToken, out string StrValue);  // Export UPComGameEngine::execGetFieldString(FFrame&, void* const)

delegate OnMarshalEvent(Pointer pMarEvent);

native function AddMarshalEventDelegate(delegate<OnMarshalEvent> MarshalEventDelegate);  // Export UPComGameEngine::execAddMarshalEventDelegate(FFrame&, void* const)

native function ClearMarshalEventDelegate(delegate<OnMarshalEvent> MarshalEventDelegate);  // Export UPComGameEngine::execClearMarshalEventDelegate(FFrame&, void* const)

native function SendCtrlRequest(string fsRequest);  // Export UPComGameEngine::execSendCtrlRequest(FFrame&, void* const)

native function SendGameRequest(string fsRequest);  // Export UPComGameEngine::execSendGameRequest(FFrame&, void* const)

native function bool HandlePlayerCommandInput(string FSCommand, optional PlayerController PC);  // Export UPComGameEngine::execHandlePlayerCommandInput(FFrame&, void* const)
