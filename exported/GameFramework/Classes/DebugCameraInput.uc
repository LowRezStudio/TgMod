class DebugCameraInput extends PlayerInput within PlayerController
    transient
    config(Input)
    hidecategories(Object,UIRoot);

function bool InputKey(int ControllerId, name Key, Object.EInputEvent Event, optional float AmountDepressed = 1.0000000, optional bool bGamepad = false)
{
    local PlayerController PC;
    local DebugCameraController DCC;

    // End:0x142
    foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0x141
        if(PC.bIsPlayer && PC.IsLocalPlayerController())
        {
            DCC = DebugCameraController(PC);
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
    Bindings=/* Array type was not detected. */
    OnReceivedNativeInputKey=InputKey
}