interface OnlineGameDVRInterface extends Interface;

function EnableRecording();

function DisableRecording();

function bool ReadRecordedClips(byte LocalUserNum);

delegate OnReadRecordedClipsComplete(bool bWasSuccessful, byte LocalUserNum);

function ClearCachedRecordedClips(byte LocalUserNum);

function AddReadRecordedClipsCompleteDelegate(byte LocalUserNum, delegate<OnReadRecordedClipsComplete> ReadRecordedClipsCompleteDelegate);

function ClearReadRecordedClipsCompleteDelegate(byte LocalUserNum, delegate<OnReadRecordedClipsComplete> ReadRecordedClipsCompleteDelegate);

function bool BeginRecordingEvent(byte LocalUserNum, string EventName);

delegate OnRecordEventComplete(bool bWasSuccessful, byte LocalUserNum, string EventName);

function AddRecordEventCompleteDelegate(byte LocalUserNum, delegate<OnRecordEventComplete> RecordEventCompleteDelegate);

function ClearRecordEventCompleteDelegate(byte LocalUserNum, delegate<OnRecordEventComplete> RecordEventCompleteDelegate);

function bool EndRecordingEvent(byte LocalUserNum, string EventName);

function bool RecordPreviousTimespan(byte LocalUserNum, string EventName, float Duration);

function bool CancelRecordingEvent(byte LocalUserNum, string EventName);
