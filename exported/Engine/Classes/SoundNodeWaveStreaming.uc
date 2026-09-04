class SoundNodeWaveStreaming extends SoundNodeWave
    native(Sound)
    perobjectconfig
    editinlinenew
    hidecategories(Object,Object);

var private array<byte> QueuedAudio;
var const float InactiveDuration;

// Export USoundNodeWaveStreaming::execQueueAudio(FFrame&, void* const)
native event QueueAudio(array<byte> Data);

// Export USoundNodeWaveStreaming::execQueueSilence(FFrame&, void* const)
native event QueueSilence(float Seconds);

// Export USoundNodeWaveStreaming::execResetAudio(FFrame&, void* const)
native event ResetAudio();

// Export USoundNodeWaveStreaming::execAvailableAudioBytes(FFrame&, void* const)
native event int AvailableAudioBytes();

// Export USoundNodeWaveStreaming::execGeneratePCMData(FFrame&, void* const)
native event GeneratePCMData(out array<byte> Buffer, int SamplesNeeded);

defaultproperties
{
    bLoopingSound=false
    bProcedural=true
}