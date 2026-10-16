class GameCheatManager extends CheatManager within GamePlayerController
    native
    config(Game);

var DebugCameraController DebugCameraControllerRef;
var Class<DebugCameraController> DebugCameraControllerClass;
var config string DebugCameraControllerClassName;

function PatchDebugCameraController()
{
    local Class<DebugCameraController> TempCameraControllerClass;

    // End:0x62
    if(DebugCameraControllerClassName != "")
    {
        TempCameraControllerClass = Class<DebugCameraController>(DynamicLoadObject(DebugCameraControllerClassName, Class'Core.Class'));
        // End:0x62
        if(TempCameraControllerClass != none)
        {
            DebugCameraControllerClass = TempCameraControllerClass;
        }
    }
    //return;    
}

exec function ToggleDebugCamera(optional bool bDrawDebugText = true)
{
    local PlayerController PC;
    local DebugCameraController DCC;

    // End:0xED
    foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0xEC
        if(PC.bIsPlayer && PC.IsLocalPlayerController())
        {
            DCC = DebugCameraController(PC);
            // End:0xE9
            if((DCC != none) && DCC.OriginalControllerRef == none)
            {
                continue;                
            }
            // End:0xED
            break;
        }        
    }    
    // End:0x168
    if((DCC != none) && DCC.OriginalControllerRef != none)
    {
        DCC.DisableDebugCamera();
        DCC.Destroy();
        DCC = none;        
    }
    else
    {
        // End:0x18B
        if(PC != none)
        {
            EnableDebugCamera(bDrawDebugText);
        }
    }
    //return;    
}

exec function TeleportPawnToCamera(optional bool bToggleDebugCameraOff = true)
{
    local PlayerController PC;
    local DebugCameraController DCC;
    local Vector ViewLocation;
    local Rotator ViewRotation;

    // End:0xED
    foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0xEC
        if(PC.bIsPlayer && PC.IsLocalPlayerController())
        {
            DCC = DebugCameraController(PC);
            // End:0xE9
            if((DCC != none) && DCC.OriginalControllerRef == none)
            {
                continue;                
            }
            // End:0xED
            break;
        }        
    }    
    // End:0x23E
    if((DCC != none) && DCC.OriginalControllerRef != none)
    {
        // End:0x223
        if(DCC.OriginalControllerRef.Pawn != none)
        {
            Outer.GetPlayerViewPoint(ViewLocation, ViewRotation);
            DCC.OriginalControllerRef.Pawn.SetLocation(ViewLocation);
            DCC.OriginalControllerRef.Pawn.SetRotation(ViewRotation);
        }
        // End:0x23B
        if(bToggleDebugCameraOff)
        {
            ToggleDebugCamera();
        }        
    }
    else
    {
        Outer.ClientMessage("TeleportPawnToCamera should be used in conjunction with the ToggleDebugCamera command.   Failed.");
    }
    //return;    
}

function EnableDebugCamera(bool bEnableDebugText)
{
    local Player P;
    local Vector eyeLoc;
    local Rotator eyeRot;
    local float CameraFOVAngle;

    P = Outer.Player;
    // End:0x366
    if(((P != none) && Outer.Pawn != none) && Outer.IsLocalPlayerController())
    {
        PatchDebugCameraController();
        // End:0xB2
        if(DebugCameraControllerRef != none)
        {
            DebugCameraControllerRef.Destroy();
        }
        CameraFOVAngle = Outer.GetFOVAngle();
        DebugCameraControllerRef = Outer.Spawn(DebugCameraControllerClass);
        DebugCameraControllerRef.PlayerInput = none;
        DebugCameraControllerRef.OriginalPlayer = P;
        DebugCameraControllerRef.OriginalControllerRef = Outer;
        Outer.GetPlayerViewPoint(eyeLoc, eyeRot);
        DebugCameraControllerRef.SetLocation(eyeLoc);
        DebugCameraControllerRef.SetRotation(eyeRot);
        DebugCameraControllerRef.bDrawDebugText = bEnableDebugText;
        P.SwitchController(DebugCameraControllerRef);
        DebugCameraControllerRef.OnActivate(Outer);
        DebugCameraControllerRef.GetPlayerViewPoint(eyeLoc, eyeRot);
        // End:0x33E
        if(DebugCameraControllerRef.PlayerCamera != none)
        {
            DebugCameraControllerRef.PlayerCamera.SetFOV(CameraFOVAngle);
            DebugCameraControllerRef.PlayerCamera.UpdateCamera(0.0000000);            
        }
        else
        {
            DebugCameraControllerRef.FOVAngle = CameraFOVAngle;
        }
    }
    //return;    
}

exec function TestHttp(string Verb, string Payload, string URL, optional bool bSendParallelRequest)
{
    local HttpRequestInterface R;

    R = Class'Engine.HttpFactory'.static.CreateRequest();
    R.__OnProcessRequestComplete__Delegate = OnRequestComplete;
    R.SetURL(URL);
    // End:0xBE
    if(Len(Verb) > 0)
    {
        R.SetVerb(Verb);        
    }
    // End:0xFA
    if(Len(Payload) > 0)
    {
        R.SetContentAsString(Payload);        
    }
    // End:0x121
    if(!R.ProcessRequest())
    {        
    }
    // End:0x200
    if(bSendParallelRequest)
    {
        // End:0x200
        if(!Class'Engine.HttpFactory'.static.CreateRequest().SetURL("http://www.epicgames.com").SetVerb("GET").SetHeader("Test", "Value").SetProcessRequestCompleteDelegate(OnRequestComplete).ProcessRequest())
        {            
        }
    }
    //return;    
}

function OnRequestComplete(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed)
{
    local array<string> Headers;
    local string Header, Payload;
    local int PayloadIndex;

    // End:0xD3
    if(Response != none)
    {
        Headers = Response.GetHeaders();
        // End:0x50
        foreach Headers(Header)
        {            
        }        
        Payload = Response.GetContentAsString();
        // End:0xD3
        if(Len(Payload) > 1024)
        {
            PayloadIndex = 0;
            J0x9A:

            // End:0xD0 [Loop If]
            if(PayloadIndex < Len(Payload))
            {
                PayloadIndex = PayloadIndex + 1024;
                // [Loop Continue]
                goto J0x9A;
            }            
        }
    }
    //return;    
}

defaultproperties
{
    DebugCameraControllerClassName="GameFramework.DebugCameraController"
}