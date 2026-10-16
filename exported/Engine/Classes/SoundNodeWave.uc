class SoundNodeWave extends SoundNode
    native(Sound)
    perobjectconfig
    editinlinenew
    hidecategories(Object,Object);

enum EDecompressionType
{
    DTYPE_Setup,                    // 0
    DTYPE_Invalid,                  // 1
    DTYPE_Preview,                  // 2
    DTYPE_Native,                   // 3
    DTYPE_RealTime,                 // 4
    DTYPE_Procedural,               // 5
    DTYPE_Xenon,                    // 6
    DTYPE_Dingo,                    // 7
    DTYPE_MAX                       // 8
};

var(Compression) int CompressionQuality;
var(Compression) bool bForceRealTimeDecompression;
var(Compression) bool bLoopingSound;
var const transient bool bDynamicResource;
var(TTS) bool bUseTTS;
var transient bool bProcedural;
var(Subtitles) const localized bool bMature;
var(Subtitles) const localized bool bManualWordWrap;
var(Subtitles) const localized bool bSingleLine;
var(TTS) AudioDevice.ETTSSpeaker TTSSpeaker;
var const transient SoundNodeWave.EDecompressionType DecompressionType;
var() const Scene.EDetailMode MobileDetailMode;
var(TTS) const localized string SpokenText;
var(Info) const editconst float Volume;
var(Info) const editconst float Pitch;
var(Info) const editconst float Duration;
var(Info) const editconst int NumChannels;
var(Info) const editconst int SampleRate;
var native const UntypedBulkData_Mirror RawData;
var native const Pointer VorbisDecompressor;
var native const Pointer RawPCMData;
var const int RawPCMDataSize;
var native const UntypedBulkData_Mirror CompressedPCData;
var native const UntypedBulkData_Mirror CompressedXbox360Data;
var native const UntypedBulkData_Mirror CompressedDingoData;
var native const UntypedBulkData_Mirror CompressedPS3Data;
var native const UntypedBulkData_Mirror CompressedWiiUData;
var native const UntypedBulkData_Mirror CompressedIPhoneData;
var native const UntypedBulkData_Mirror CompressedFlashData;
var native const UntypedBulkData_Mirror CompressedOrbisData;
var const transient int ResourceID;
var const transient int ResourceSize;
var native const Pointer ResourceData;
var(Subtitles) const localized array<localized SubtitleCue> Subtitles;
var array<LocalizedSubtitle> LocalizedSubtitles;

event GeneratePCMData(out array<byte> Buffer, int SamplesNeeded)
{
    //return;    
}

defaultproperties
{
    CompressionQuality=40
    bLoopingSound=true
    Volume=0.7500000
    Pitch=1.0000000
}