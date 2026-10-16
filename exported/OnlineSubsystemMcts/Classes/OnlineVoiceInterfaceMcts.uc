class OnlineVoiceInterfaceMcts extends Object within OnlineSubsystemMcts
    native
    implements(OnlineVoiceInterface);

enum EMuteType
{
    MUTE_None,                      // 0
    MUTE_AllButFriends,             // 1
    MUTE_All,                       // 2
    MUTE_MAX                        // 3
};

struct native LocalTalkerMcts
{
    var bool bHasVoice;
    var bool bHasNetworkedVoice;
    var bool bIsRecognizingSpeech;
    var bool bWasTalking;
    var bool bIsTalking;
    var bool bIsRegistered;
    var OnlineVoiceInterfaceMcts.EMuteType MuteType;

    structdefaultproperties
    {
        bHasVoice=false
        bHasNetworkedVoice=false
        bIsRecognizingSpeech=false
        bWasTalking=false
        bIsTalking=false
        bIsRegistered=false
        MuteType=EMuteType.MUTE_None
    }
};

var native const transient Pointer MctsSubsystem;
var native const transient Pointer VoiceEnginePtr;
var LocalTalkerMcts CurrentLocalTalker;
var array<RemoteTalker> RemoteTalkers;
var const array<UniqueNetId> MuteList;
var array< delegate<OnRecognitionComplete> > SpeechRecognitionCompleteDelegates;
var array< delegate<OnPlayerTalkingStateChange> > TalkingDelegates;
//var delegate<OnPlayerTalkingStateChange> __OnPlayerTalkingStateChange__Delegate;
//var delegate<OnRecognitionComplete> __OnRecognitionComplete__Delegate;

// Export UOnlineVoiceInterfaceMcts::execRegisterLocalTalker(FFrame&, void* const)
native function bool RegisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex);

// Export UOnlineVoiceInterfaceMcts::execUnregisterLocalTalker(FFrame&, void* const)
native function bool UnregisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex);

// Export UOnlineVoiceInterfaceMcts::execRegisterRemoteTalker(FFrame&, void* const)
native function bool RegisterRemoteTalker(UniqueNetId PlayerID);

// Export UOnlineVoiceInterfaceMcts::execUnregisterRemoteTalker(FFrame&, void* const)
native function bool UnregisterRemoteTalker(UniqueNetId PlayerID);

// Export UOnlineVoiceInterfaceMcts::execIsLocalPlayerTalking(FFrame&, void* const)
native function bool IsLocalPlayerTalking(byte LocalUserNum);

// Export UOnlineVoiceInterfaceMcts::execIsRemotePlayerTalking(FFrame&, void* const)
native function bool IsRemotePlayerTalking(UniqueNetId PlayerID);

// Export UOnlineVoiceInterfaceMcts::execIsHeadsetPresent(FFrame&, void* const)
native function bool IsHeadsetPresent(byte LocalUserNum);

// Export UOnlineVoiceInterfaceMcts::execSetRemoteTalkerPriority(FFrame&, void* const)
native function bool SetRemoteTalkerPriority(byte LocalUserNum, UniqueNetId PlayerID, int Priority);

function bool UpdatePlayerMuteSetting(bool PlayerMuteSetting)
{
    //return ReturnValue;    
}

// Export UOnlineVoiceInterfaceMcts::execMuteRemoteTalker(FFrame&, void* const)
native function bool MuteRemoteTalker(byte LocalUserNum, UniqueNetId PlayerID, optional bool bIsSystemWide);

// Export UOnlineVoiceInterfaceMcts::execUnmuteRemoteTalker(FFrame&, void* const)
native function bool UnmuteRemoteTalker(byte LocalUserNum, UniqueNetId PlayerID, optional bool bIsSystemWide);

function bool IsTalkerMuted(UniqueNetId ConsoleId)
{
    //return ReturnValue;    
}

delegate OnPlayerTalkingStateChange(UniqueNetId Player, bool bIsTalking)
{
    //return;    
}

function AddPlayerTalkingDelegate(delegate<OnPlayerTalkingStateChange> TalkerDelegate)
{
    local int AddIndex;

    // End:0x69
    if(TalkingDelegates.Find(TalkerDelegate) == -1)
    {
        AddIndex = TalkingDelegates.Length;
        TalkingDelegates.Length = TalkingDelegates.Length + 1;
        TalkingDelegates[AddIndex] = TalkerDelegate;
    }
    //return;    
}

function ClearPlayerTalkingDelegate(delegate<OnPlayerTalkingStateChange> TalkerDelegate)
{
    local int RemoveIndex;

    RemoveIndex = TalkingDelegates.Find(TalkerDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        TalkingDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineVoiceInterfaceMcts::execStartNetworkedVoice(FFrame&, void* const)
native function StartNetworkedVoice(byte LocalUserNum);

// Export UOnlineVoiceInterfaceMcts::execStopNetworkedVoice(FFrame&, void* const)
native function StopNetworkedVoice(byte LocalUserNum);

// Export UOnlineVoiceInterfaceMcts::execStartSpeechRecognition(FFrame&, void* const)
native function bool StartSpeechRecognition(byte LocalUserNum);

// Export UOnlineVoiceInterfaceMcts::execStopSpeechRecognition(FFrame&, void* const)
native function bool StopSpeechRecognition(byte LocalUserNum);

// Export UOnlineVoiceInterfaceMcts::execGetRecognitionResults(FFrame&, void* const)
native function bool GetRecognitionResults(byte LocalUserNum, out array<SpeechRecognizedWord> Words);

delegate OnRecognitionComplete()
{
    //return;    
}

function AddRecognitionCompleteDelegate(byte LocalUserNum, delegate<OnRecognitionComplete> RecognitionDelegate)
{
    // End:0x3E
    if(SpeechRecognitionCompleteDelegates.Find(RecognitionDelegate) == -1)
    {
        SpeechRecognitionCompleteDelegates[SpeechRecognitionCompleteDelegates.Length] = RecognitionDelegate;
    }
    //return;    
}

function ClearRecognitionCompleteDelegate(byte LocalUserNum, delegate<OnRecognitionComplete> RecognitionDelegate)
{
    local int RemoveIndex;

    RemoveIndex = SpeechRecognitionCompleteDelegates.Find(RecognitionDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        SpeechRecognitionCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineVoiceInterfaceMcts::execSelectVocabulary(FFrame&, void* const)
native function bool SelectVocabulary(byte LocalUserNum, int VocabularyId);

// Export UOnlineVoiceInterfaceMcts::execSetSpeechRecognitionObject(FFrame&, void* const)
native function bool SetSpeechRecognitionObject(byte LocalUserNum, SpeechRecognition SpeechRecogObj);

function bool MuteAll(byte LocalUserNum, bool bAllowFriends)
{
    // End:0x60
    if(int(LocalUserNum) == Outer.LoggedInPlayerNum)
    {
        CurrentLocalTalker.MuteType = ((bAllowFriends) ? 1 : 2);
        return true;
    }
    return false;
    //return ReturnValue;    
}

function bool UnmuteAll(byte LocalUserNum)
{
    // End:0x4F
    if(int(LocalUserNum) == Outer.LoggedInPlayerNum)
    {
        CurrentLocalTalker.MuteType = 0;
        return true;
    }
    return false;
    //return ReturnValue;    
}
