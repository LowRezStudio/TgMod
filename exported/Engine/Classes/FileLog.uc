class FileLog extends FileWriter
    native
    notplaceable
    hidecategories(Navigation,Movement,Collision);

function OpenLog(coerce string LogFilename, optional string extension, optional bool bUnique)
{
    OpenFile(LogFilename, 0, extension, bUnique);
    //return;    
}

function CloseLog()
{
    CloseFile();
    //return;    
}
