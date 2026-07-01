class PComGameEngine extends GameEngine
    transient
    native
    config(Engine);

var native const Pointer pOutgoingMarshal;

// Export UPComGameEngine::execSetFunction(FFrame&, void* const)
native function bool SetFunction(int nFunction);

// Export UPComGameEngine::execSetFieldInt(FFrame&, void* const)
native function bool SetFieldInt(int nToken, int IntValue);

// Export UPComGameEngine::execSetFieldFloat(FFrame&, void* const)
native function bool SetFieldFloat(int nToken, float FloatValue);

// Export UPComGameEngine::execSetFieldString(FFrame&, void* const)
native function bool SetFieldString(int nToken, string StrValue);

// Export UPComGameEngine::execClearMarshal(FFrame&, void* const)
native function ClearMarshal();

// Export UPComGameEngine::execSendMarshal(FFrame&, void* const)
native function SendMarshal(UniqueNetId qwPlayerId, bool bLowPriority);

// Export UPComGameEngine::execSendMarshalAll(FFrame&, void* const)
native function SendMarshalAll(bool bLowPriority);

// Export UPComGameEngine::execSendCtrlRequest(FFrame&, void* const)
native function SendCtrlRequest(string fsRequest);

// Export UPComGameEngine::execSendGameRequest(FFrame&, void* const)
native function SendGameRequest(string fsRequest);
