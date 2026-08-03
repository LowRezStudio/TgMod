class OnlineTitleFileDownloadMcp extends OnlineTitleFileDownloadBase
    native
    config(Engine);

struct native TitleFileMcp extends TitleFile
{
    var private native const Pointer HttpDownloader;
};

var private array<TitleFileMcp> TitleFiles;
var transient int DownloadCount;

// Export UOnlineTitleFileDownloadMcp::execReadTitleFile(FFrame&, void* const)
native function bool ReadTitleFile(string FileToRead, optional OnlineSubsystem.EOnlineFileType FileType = 1);

// Export UOnlineTitleFileDownloadMcp::execGetTitleFileContents(FFrame&, void* const)
native function bool GetTitleFileContents(string Filename, out array<byte> FileContents);

function OnlineSubsystem.EOnlineEnumerationReadState GetTitleFileState(string Filename)
{
    local int FileIndex;

    FileIndex = TitleFiles.Find('Filename', Filename);
    // End:0x63
    if(FileIndex != -1)
    {
        return TitleFiles[FileIndex].AsyncState;
    }
    return 3;
    //return ReturnValue;    
}

// Export UOnlineTitleFileDownloadMcp::execClearDownloadedFiles(FFrame&, void* const)
native function bool ClearDownloadedFiles();

// Export UOnlineTitleFileDownloadMcp::execClearDownloadedFile(FFrame&, void* const)
native function bool ClearDownloadedFile(string Filename);
