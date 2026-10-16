interface OnlineNewsInterface extends Interface
    abstract;

function bool ReadNews(byte LocalUserNum, OnlineSubsystem.EOnlineNewsType NewsType)
{
    //return ReturnValue;    
}

delegate OnReadNewsCompleted(bool bWasSuccessful, OnlineSubsystem.EOnlineNewsType NewsType)
{
    //return;    
}

function AddReadNewsCompletedDelegate(delegate<OnReadNewsCompleted> ReadNewsDelegate)
{
    //return;    
}

function ClearReadNewsCompletedDelegate(delegate<OnReadNewsCompleted> ReadNewsDelegate)
{
    //return;    
}

function string GetNews(byte LocalUserNum, OnlineSubsystem.EOnlineNewsType NewsType)
{
    //return ReturnValue;    
}
