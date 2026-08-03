interface OnlineVoiceInterface extends Interface
    abstract;

function bool RegisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex)
{
    //return ReturnValue;    
}

function bool UnregisterLocalTalker(byte LocalUserNum, optional byte ChannelIndex)
{
    //return ReturnValue;    
}

function bool RegisterRemoteTalker(UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool UnregisterRemoteTalker(UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool IsLocalPlayerTalking(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool IsRemotePlayerTalking(UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool IsHeadsetPresent(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool SetRemoteTalkerPriority(byte LocalUserNum, UniqueNetId PlayerID, int Priority)
{
    //return ReturnValue;    
}

function bool UpdatePlayerMuteSetting(bool PlayerMuteSetting)
{
    //return ReturnValue;    
}

function bool MuteRemoteTalker(byte LocalUserNum, UniqueNetId PlayerID, optional bool bIsSystemWide)
{
    //return ReturnValue;    
}

function bool UnmuteRemoteTalker(byte LocalUserNum, UniqueNetId PlayerID, optional bool bIsSystemWide)
{
    //return ReturnValue;    
}

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
    //return;    
}

function ClearPlayerTalkingDelegate(delegate<OnPlayerTalkingStateChange> TalkerDelegate)
{
    //return;    
}

function StartNetworkedVoice(byte LocalUserNum)
{
    //return;    
}

function StopNetworkedVoice(byte LocalUserNum)
{
    //return;    
}

function bool StartSpeechRecognition(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool StopSpeechRecognition(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool GetRecognitionResults(byte LocalUserNum, out array<SpeechRecognizedWord> Words)
{
    //return ReturnValue;    
}

delegate OnRecognitionComplete()
{
    //return;    
}

function AddRecognitionCompleteDelegate(byte LocalUserNum, delegate<OnRecognitionComplete> RecognitionDelegate)
{
    //return;    
}

function ClearRecognitionCompleteDelegate(byte LocalUserNum, delegate<OnRecognitionComplete> RecognitionDelegate)
{
    //return;    
}

function bool SelectVocabulary(byte LocalUserNum, int VocabularyId)
{
    //return ReturnValue;    
}

function bool SetSpeechRecognitionObject(byte LocalUserNum, SpeechRecognition SpeechRecogObj)
{
    //return ReturnValue;    
}

function bool MuteAll(byte LocalUserNum, bool bAllowFriends)
{
    //return ReturnValue;    
}

function bool UnmuteAll(byte LocalUserNum)
{
    //return ReturnValue;    
}
