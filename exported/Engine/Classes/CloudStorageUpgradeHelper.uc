interface CloudStorageUpgradeHelper extends Interface
    abstract
    native(PlatformInterface);

event HandleLocalDocument(out string DocName, out int bShouldMoveToCloud, out int bShouldDeleteLocalFile)
{
    //return;    
}

event HandleLocalKeyValue(out string CloudKeyName, out PlatformInterfaceData CloudValue, out int bShouldMoveToCloud, out int bShouldDeleteLocalKey)
{
    //return;    
}

event GetCloudUpgradeKeys(out array<string> CloudKeys)
{
    //return;    
}
