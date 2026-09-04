class OnlineVoiceInterfaceMcts extends Object within OnlineSubsystemMcts
    native
    implements(OnlineVoiceInterface)
    config(Engine);

enum EMuteType {
    MUTE_None,  // 0
    MUTE_AllButFriends,  // 1
    MUTE_All,  // 2
};

struct LocalTalkerMcts {
    var bool bHasVoice;
    var bool bHasNetworkedVoice;
    var bool bIsRecognizingSpeech;
    var bool bWasTalking;
    var bool bIsTalking;
    var bool bIsRegistered;
    var OnlineVoiceInterfaceMcts.EMuteType MuteType;
    structdefaultproperties {}
};

var native const transient Pointer MctsSubsystem;
var native const transient Pointer VoiceEnginePtr;
var LocalTalkerMcts CurrentLocalTalker;
var array<RemoteTalker> RemoteTalkers;
var const array<UniqueNetId> MuteList;
var array< delegate<OnRecognitionComplete> > SpeechRecognitionCompleteDelegates;
var array< delegate<OnPlayerTalkingStateChange> > TalkingDelegates;

native function bool RegisterLocalTalker(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execRegisterLocalTalker(FFrame&, void* const)

native function bool UnregisterLocalTalker(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execUnregisterLocalTalker(FFrame&, void* const)

native function bool RegisterRemoteTalker(UniqueNetId PlayerID);  // Export UOnlineVoiceInterfaceMcts::execRegisterRemoteTalker(FFrame&, void* const)

native function bool UnregisterRemoteTalker(UniqueNetId PlayerID);  // Export UOnlineVoiceInterfaceMcts::execUnregisterRemoteTalker(FFrame&, void* const)

native function bool IsLocalPlayerTalking(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execIsLocalPlayerTalking(FFrame&, void* const)

native function bool IsRemotePlayerTalking(UniqueNetId PlayerID);  // Export UOnlineVoiceInterfaceMcts::execIsRemotePlayerTalking(FFrame&, void* const)

native function bool IsHeadsetPresent(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execIsHeadsetPresent(FFrame&, void* const)

native function bool SetRemoteTalkerPriority(byte LocalUserNum, UniqueNetId PlayerID, int Priority);  // Export UOnlineVoiceInterfaceMcts::execSetRemoteTalkerPriority(FFrame&, void* const)

function bool UpdatePlayerMuteSetting(bool PlayerMuteSetting) { }

native function bool MuteRemoteTalker(byte LocalUserNum, UniqueNetId PlayerID, optional bool bIsSystemWide);  // Export UOnlineVoiceInterfaceMcts::execMuteRemoteTalker(FFrame&, void* const)

native function bool UnmuteRemoteTalker(byte LocalUserNum, UniqueNetId PlayerID, optional bool bIsSystemWide);  // Export UOnlineVoiceInterfaceMcts::execUnmuteRemoteTalker(FFrame&, void* const)

function bool IsTalkerMuted(UniqueNetId ConsoleId) { }

delegate OnPlayerTalkingStateChange(UniqueNetId Player, bool bIsTalking);

function AddPlayerTalkingDelegate(delegate<OnPlayerTalkingStateChange> TalkerDelegate) { }

function ClearPlayerTalkingDelegate(delegate<OnPlayerTalkingStateChange> TalkerDelegate) { }

native function StartNetworkedVoice(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execStartNetworkedVoice(FFrame&, void* const)

native function StopNetworkedVoice(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execStopNetworkedVoice(FFrame&, void* const)

native function bool StartSpeechRecognition(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execStartSpeechRecognition(FFrame&, void* const)

native function bool StopSpeechRecognition(byte LocalUserNum);  // Export UOnlineVoiceInterfaceMcts::execStopSpeechRecognition(FFrame&, void* const)

native function bool GetRecognitionResults(byte LocalUserNum, out array<SpeechRecognizedWord> Words);  // Export UOnlineVoiceInterfaceMcts::execGetRecognitionResults(FFrame&, void* const)

delegate OnRecognitionComplete();

function AddRecognitionCompleteDelegate(byte LocalUserNum, delegate<OnRecognitionComplete> RecognitionDelegate) { }

function ClearRecognitionCompleteDelegate(byte LocalUserNum, delegate<OnRecognitionComplete> RecognitionDelegate) { }

native function bool SelectVocabulary(byte LocalUserNum, int VocabularyId);  // Export UOnlineVoiceInterfaceMcts::execSelectVocabulary(FFrame&, void* const)

native function bool SetSpeechRecognitionObject(byte LocalUserNum, SpeechRecognition SpeechRecogObj);  // Export UOnlineVoiceInterfaceMcts::execSetSpeechRecognitionObject(FFrame&, void* const)

function bool MuteAll(byte LocalUserNum, bool bAllowFriends) { }

function bool UnmuteAll(byte LocalUserNum) { }
