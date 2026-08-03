class MobileDebugCameraInput extends MobilePlayerInput within GamePlayerController
    transient
    config(Game)
    hidecategories(Object,UIRoot);

function bool InputKey(int ControllerId, name Key, Object.EInputEvent Event, optional float AmountDepressed = 1.0000000, optional bool bGamepad = false)
{
    local PlayerController PC;
    local MobileDebugCameraController DCC;

    // End:0x142
    foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0x141
        if(PC.bIsPlayer && PC.IsLocalPlayerController())
        {
            DCC = MobileDebugCameraController(PC);
            // End:0xF2
            if((DCC != none) && DCC.OriginalControllerRef == none)
            {
                continue;                
            }            
            return DCC.NativeInputKey(ControllerId, Key, Event, AmountDepressed, bGamepad);
        }        
    }    
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    OnReceivedNativeInputKey=InputKey
}