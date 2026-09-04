interface OnlineGameDVRInterface extends Interface
    abstract;

function EnableRecording()
{
    //return;    
}

function DisableRecording()
{
    //return;    
}

function bool ReadRecordedClips(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnReadRecordedClipsComplete(bool bWasSuccessful, byte LocalUserNum)
{
    //return;    
}

function ClearCachedRecordedClips(byte LocalUserNum)
{
    //return;    
}

function AddReadRecordedClipsCompleteDelegate(byte LocalUserNum, delegate<OnReadRecordedClipsComplete> ReadRecordedClipsCompleteDelegate)
{
    //return;    
}

function ClearReadRecordedClipsCompleteDelegate(byte LocalUserNum, delegate<OnReadRecordedClipsComplete> ReadRecordedClipsCompleteDelegate)
{
    //return;    
}

function bool BeginRecordingEvent(byte LocalUserNum, string EventName)
{
    //return ReturnValue;    
}

delegate OnRecordEventComplete(bool bWasSuccessful, byte LocalUserNum, string EventName)
{
    //return;    
}

function AddRecordEventCompleteDelegate(byte LocalUserNum, delegate<OnRecordEventComplete> RecordEventCompleteDelegate)
{
    //return;    
}

function ClearRecordEventCompleteDelegate(byte LocalUserNum, delegate<OnRecordEventComplete> RecordEventCompleteDelegate)
{
    //return;    
}

function bool EndRecordingEvent(byte LocalUserNum, string EventName)
{
    //return ReturnValue;    
}

function bool RecordPreviousTimespan(byte LocalUserNum, string EventName, float Duration)
{
    //return ReturnValue;    
}

function bool CancelRecordingEvent(byte LocalUserNum, string EventName)
{
    //return ReturnValue;    
}
