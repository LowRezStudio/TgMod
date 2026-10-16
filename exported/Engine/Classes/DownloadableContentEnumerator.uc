class DownloadableContentEnumerator extends Object
    native(GameEngine);

var protectedwrite array<OnlineContent> DLCBundles;
var string DLCRootDir;
var protected array< delegate<OnFindDLCComplete> > FindDLCDelegates;
//var delegate<OnFindDLCComplete> __OnFindDLCComplete__Delegate;

// Export UDownloadableContentEnumerator::execFindDLC(FFrame&, void* const)
native function FindDLC();

delegate OnFindDLCComplete()
{
    //return;    
}

function AddFindDLCDelegate(delegate<OnFindDLCComplete> InDelegate)
{
    // End:0x36
    if(FindDLCDelegates.Find(InDelegate) == -1)
    {
        FindDLCDelegates.AddItem(InDelegate);
    }
    //return;    
}

function ClearFindDLCDelegate(delegate<OnFindDLCComplete> InDelegate)
{
    local int RemoveIndex;

    RemoveIndex = FindDLCDelegates.Find(InDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        FindDLCDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UDownloadableContentEnumerator::execDeleteDLC(FFrame&, void* const)
native function DeleteDLC(string DLCName);

function InstallAllDLC()
{
    local DownloadableContentManager DLCManager;

    DLCManager = Class'Engine.GameEngine'.static.GetDLCManager();
    // End:0x60
    if(DLCManager != none)
    {
        DLCManager.InstallDLCs(DLCBundles);
    }
    //return;    
}

// Export UDownloadableContentEnumerator::execInstallDLC(FFrame&, void* const)
native function InstallDLC(string DLCName);

// Export UDownloadableContentEnumerator::execTriggerFindDLCDelegates(FFrame&, void* const)
native function TriggerFindDLCDelegates();

defaultproperties
{
    DLCRootDir="../../DLC/"
}