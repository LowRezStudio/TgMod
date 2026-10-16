interface OnlineSystemInterface extends Interface
    abstract;

function bool HasLinkConnection()
{
    //return ReturnValue;    
}

delegate OnLinkStatusChange(bool bIsConnected)
{
    //return;    
}

function AddLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate)
{
    //return;    
}

function ClearLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate)
{
    //return;    
}

delegate OnExternalUIChange(bool bIsOpening)
{
    //return;    
}

function AddExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate)
{
    //return;    
}

function ClearExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate)
{
    //return;    
}

function OnlineSubsystem.ENetworkNotificationPosition GetNetworkNotificationPosition()
{
    //return ReturnValue;    
}

function SetNetworkNotificationPosition(OnlineSubsystem.ENetworkNotificationPosition NewPos)
{
    //return;    
}

delegate OnControllerChange(int ControllerId, bool bIsConnected, bool bPauseGame)
{
    //return;    
}

function AddControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate)
{
    //return;    
}

function ClearControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate)
{
    //return;    
}

function bool IsControllerConnected(int ControllerId)
{
    //return ReturnValue;    
}

function OnlineSubsystem.EOnlineServerConnectionStatus GetCurrentConnectionStatus()
{
    //return ReturnValue;    
}

delegate OnConnectionStatusChange(OnlineSubsystem.EOnlineServerConnectionStatus ConnectionStatus)
{
    //return;    
}

function AddConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate)
{
    //return;    
}

function ClearConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate)
{
    //return;    
}

function OnlineSubsystem.ENATType GetNATType()
{
    //return ReturnValue;    
}

delegate OnStorageDeviceChange()
{
    //return;    
}

function AddStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate)
{
    //return;    
}

function ClearStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate)
{
    //return;    
}

function int GetLocale()
{
    //return ReturnValue;    
}
