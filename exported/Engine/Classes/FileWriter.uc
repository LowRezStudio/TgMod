class FileWriter extends Info
    native
    notplaceable
    hidecategories(Navigation,Movement,Collision);

enum FWFileType
{
    FWFT_Log,                       // 0
    FWFT_Stats,                     // 1
    FWFT_HTML,                      // 2
    FWFT_User,                      // 3
    FWFT_Debug,                     // 4
    FWFT_MAX                        // 5
};

var native const Pointer ArchivePtr;
var const string Filename;
var const FileWriter.FWFileType FileType;
var bool bFlushEachWrite;
var bool bWantsAsyncWrites;

// Export UFileWriter::execOpenFile(FFrame&, void* const)
native final function bool OpenFile(coerce string InFilename, optional FileWriter.FWFileType InFileType, optional string InExtension, optional bool bUnique, optional bool bIncludeTimeStamp);

// Export UFileWriter::execCloseFile(FFrame&, void* const)
native final function CloseFile();

// Export UFileWriter::execLogf(FFrame&, void* const)
native final function Logf(coerce string logString);

event Destroyed()
{
    CloseFile();
    //return;    
}

defaultproperties
{
    bFlushEachWrite=true
    bTickIsDisabled=true
}