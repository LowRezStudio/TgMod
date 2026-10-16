interface OnlineAccountInterface extends Interface
    abstract;

function bool CreateOnlineAccount(string UserName, string Password, string EmailAddress, optional string ProductKey)
{
    //return ReturnValue;    
}

delegate OnCreateOnlineAccountCompleted(OnlineSubsystem.EOnlineAccountCreateStatus ErrorStatus)
{
    //return;    
}

function AddCreateOnlineAccountCompletedDelegate(delegate<OnCreateOnlineAccountCompleted> AccountCreateDelegate)
{
    //return;    
}

function ClearCreateOnlineAccountCompletedDelegate(delegate<OnCreateOnlineAccountCompleted> AccountCreateDelegate)
{
    //return;    
}

function bool CreateLocalAccount(string UserName, optional string Password)
{
    //return ReturnValue;    
}

function bool RenameLocalAccount(string NewUserName, string OldUserName, optional string Password)
{
    //return ReturnValue;    
}

function bool DeleteLocalAccount(string UserName, optional string Password)
{
    //return ReturnValue;    
}

function bool GetLocalAccountNames(out array<string> Accounts)
{
    //return ReturnValue;    
}
