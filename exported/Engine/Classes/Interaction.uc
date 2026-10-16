class Interaction extends UIRoot
    transient
    native(UserInterface)
    config(Engine)
    hidecategories(Object,UIRoot);

enum ETouchType
{
    Touch_Began,                    // 0
    Touch_Moved,                    // 1
    Touch_Stationary,               // 2
    Touch_Ended,                    // 3
    Touch_Cancelled,                // 4
    Touch_MAX                       // 5
};

//var delegate<OnReceivedNativeInputKey> __OnReceivedNativeInputKey__Delegate;
//var delegate<OnReceivedNativeInputAxis> __OnReceivedNativeInputAxis__Delegate;
//var delegate<OnReceivedNativeInputChar> __OnReceivedNativeInputChar__Delegate;
//var delegate<OnInitialize> __OnInitialize__Delegate;

delegate bool OnReceivedNativeInputKey(int ControllerId, name Key, Object.EInputEvent EventType, optional float AmountDepressed = 1.0000000, optional bool bGamepad)
{
    //return ReturnValue;    
}

delegate bool OnReceivedNativeInputAxis(int ControllerId, name Key, float Delta, float DeltaTime, optional bool bGamepad)
{
    //return ReturnValue;    
}

delegate bool OnReceivedNativeInputChar(int ControllerId, string Unicode)
{
    //return ReturnValue;    
}

event Tick(float DeltaTime)
{
    //return;    
}

event PostRender(Canvas Canvas)
{
    //return;    
}

// Export UInteraction::execInit(FFrame&, void* const)
native final function Init();

delegate OnInitialize()
{
    //return;    
}

function Initialized()
{
    //return;    
}

function NotifyGameSessionEnded()
{
    //return;    
}

function NotifyPlayerAdded(int PlayerIndex, LocalPlayer AddedPlayer)
{
    //return;    
}

function NotifyPlayerRemoved(int PlayerIndex, LocalPlayer RemovedPlayer)
{
    //return;    
}

defaultproperties
{
    OnInitialize=Initialized
}