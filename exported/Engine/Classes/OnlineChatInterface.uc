interface OnlineChatInterface extends Interface
    abstract;

delegate OnChatMessage(int Channel, string Sender, string Message)
{
    //return;    
}

function AddChatMessageDelegate(delegate<OnChatMessage> ChatDelegate)
{
    //return;    
}

function ClearChatMessageDelegate(delegate<OnChatMessage> ChatDelegate)
{
    //return;    
}

function SendChatMessage(int Channel, string Message)
{
    //return;    
}

function NotifyTeamChange(QWord PlayerUID, byte TeamID)
{
    //return;    
}
