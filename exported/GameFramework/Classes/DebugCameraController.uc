class DebugCameraController extends GamePlayerController
    native
    config(Input)
    hidecategories(Navigation);

var globalconfig name PrimaryKey;
var globalconfig name SecondaryKey;
var globalconfig name UnselectKey;
var globalconfig bool bShowSelectedInfo;
var bool bDrawDebugText;
var bool bIsFrozenRendering;
var Class<HUD> HUDClass;
var PlayerController OriginalControllerRef;
var Player OriginalPlayer;
var export editinline DrawFrustumComponent DrawFrustum;
var Actor SelectedActor;
var export editinline PrimitiveComponent SelectedComponent;

// Export UDebugCameraController::execPrimarySelect(FFrame&, void* const)
native function PrimarySelect(Vector HitLoc, Vector HitNormal, TraceHitInfo HitInfo);

// Export UDebugCameraController::execSecondarySelect(FFrame&, void* const)
native function SecondarySelect(Vector HitLoc, Vector HitNormal, TraceHitInfo HitInfo);

// Export UDebugCameraController::execUnselect(FFrame&, void* const)
native function Unselect();

simulated event PostBeginPlay()
{
    super(PlayerController).PostBeginPlay();
    // End:0x31
    if(myHUD != none)
    {
        myHUD.Destroy();
    }
    myHUD = Spawn(HUDClass, self);
    //return;    
}

function OnActivate(PlayerController PC)
{
    // End:0x4B
    if(DebugCameraHUD(myHUD) != none)
    {
        DebugCameraHUD(myHUD).bDrawDebugText = bDrawDebugText;
    }
    // End:0x8F
    if(DrawFrustum == none)
    {
        DrawFrustum = new (PC.PlayerCamera) Class'Engine.DrawFrustumComponent';
    }
    // End:0xEA
    if(bDrawDebugText)
    {
        DrawFrustum.SetHidden(false);        
        ConsoleCommand("show camfrustums true");        
    }
    else
    {
        DrawFrustum.SetHidden(true);        
        ConsoleCommand("show camfrustums false");
    }
    PC.SetHidden(false);
    PC.PlayerCamera.SetHidden(false);
    DrawFrustum.FrustumAngle = PC.PlayerCamera.CameraCache.POV.FOV;
    DrawFrustum.SetAbsolute(true, true, false);
    DrawFrustum.SetTranslation(PC.PlayerCamera.CameraCache.POV.Location);
    DrawFrustum.SetRotation(PC.PlayerCamera.CameraCache.POV.Rotation);
    PC.PlayerCamera.AttachComponent(DrawFrustum);
    //return;    
}

function OnDeactivate(PlayerController PC)
{
    DrawFrustum.SetHidden(true);
    PC.PlayerCamera.DetachComponent(DrawFrustum);
    PC.SetHidden(true);
    PC.PlayerCamera.SetHidden(true);
    //return;    
}

exec function SetFreezeRendering()
{
    ConsoleCommand("FreezeRendering");
    bIsFrozenRendering = !bIsFrozenRendering;
    //return;    
}

exec function MoreSpeed()
{
    bRun = 2;
    //return;    
}

exec function NormalSpeed()
{
    bRun = 0;
    //return;    
}

function DisableDebugCamera()
{
    // End:0xB1
    if(OriginalControllerRef != none)
    {
        // End:0x50
        if(bIsFrozenRendering == true)
        {            
            ConsoleCommand("FreezeRendering");
            bIsFrozenRendering = false;
        }
        // End:0xB1
        if(OriginalPlayer != none)
        {
            OriginalPlayer.SwitchController(OriginalControllerRef);
            OriginalControllerRef.InitInputSystem();
            OnDeactivate(self);
        }
    }
    //return;    
}

function InitDebugInputSystem()
{
    OriginalControllerRef.PlayerInput.InitInputSystem();
    OriginalControllerRef.InitInputSystem();
    //return;    
}

function bool NativeInputKey(int ControllerId, name Key, Object.EInputEvent Event, optional float AmountDepressed = 1.0000000, optional bool bGamepad = false)
{
    local Vector CamLoc, ZeroVec;
    local Rotator CamRot;
    local TraceHitInfo HitInfo;
    local Actor HitActor;
    local Vector HitLoc, HitNormal;

    CamLoc = PlayerCamera.CameraCache.POV.Location;
    CamRot = PlayerCamera.CameraCache.POV.Rotation;
    // End:0x2C5
    if(int(Event) == int(0))
    {
        // End:0xF7
        if(Key == UnselectKey)
        {
            Unselect();
            SelectedActor = none;
            SelectedComponent = none;
            return true;
        }
        // End:0x1DE
        if(Key == PrimaryKey)
        {
            HitActor = Trace(HitLoc, HitNormal, ((Vector(CamRot) * float(5000)) * float(20)) + CamLoc, CamLoc, true, ZeroVec, HitInfo);
            // End:0x1DC
            if(HitActor != none)
            {
                SelectedActor = HitActor;
                SelectedComponent = HitInfo.HitComponent;
                PrimarySelect(HitLoc, HitNormal, HitInfo);
            }
            return true;
        }
        // End:0x2C5
        if(Key == SecondaryKey)
        {
            HitActor = Trace(HitLoc, HitNormal, ((Vector(CamRot) * float(5000)) * float(20)) + CamLoc, CamLoc, true, ZeroVec, HitInfo);
            // End:0x2C3
            if(HitActor != none)
            {
                SelectedActor = HitActor;
                SelectedComponent = HitInfo.HitComponent;
                SecondarySelect(HitLoc, HitNormal, HitInfo);
            }
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

exec function ShowDebugSelectedInfo()
{
    bShowSelectedInfo = !bShowSelectedInfo;
    //return;    
}

// Export UDebugCameraController::execConsoleCommand(FFrame&, void* const)
native function string ConsoleCommand(string Command, optional bool bWriteToLog = true);

auto state PlayerWaiting
{
    function PlayerMove(float DeltaTime)
    {
        local float UndilatedDeltaTime;

        UndilatedDeltaTime = DeltaTime / WorldInfo.TimeDilation;
        super(BaseSpectating).PlayerMove(UndilatedDeltaTime);
        // End:0x92
        if(WorldInfo.Pauser != none)
        {
            PlayerCamera.UpdateCamera(DeltaTime);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    PrimaryKey="LeftMouseButton"
    SecondaryKey="RightMouseButton"
    UnselectKey="Escape"
    bShowSelectedInfo=true
    bDrawDebugText=true
    HUDClass=Class'GameFramework.DebugCameraHUD'
    InputClass=Class'GameFramework.DebugCameraInput'
    // Reference: CylinderComponent'GameFramework.Default__DebugCameraController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__GamePlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    bHidden=false
    bAlwaysTick=true
    bHiddenEd=false
    CollisionComponent=CollisionCylinder
}