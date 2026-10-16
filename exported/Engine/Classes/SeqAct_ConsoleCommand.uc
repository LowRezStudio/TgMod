class SeqAct_ConsoleCommand extends SequenceAction
    hidecategories(Object);

var string Command;
var() array<string> Commands;

function VersionUpdated(int OldVersion, int NewVersion)
{
    // End:0x4B
    if((OldVersion < 2) && (Commands.Length == 0) || Commands[0] == "")
    {
        Commands[0] = Command;
    }
    //return;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    Commands[0]=""
    ObjName="Console Command"
}