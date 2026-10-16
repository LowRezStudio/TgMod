class MobileDebugCameraController extends DebugCameraController
    config(Input)
    hidecategories(Navigation);

var int OldMobileGroup;
var MobilePlayerInput MPI;

function OnActivate(PlayerController PC)
{
    MPI = MobilePlayerInput(OriginalControllerRef.PlayerInput);
    // End:0x8C
    if(MPI != none)
    {
        OldMobileGroup = MPI.CurrentMobileGroup;
        MPI.CurrentMobileGroup = -1;
    }
    MPI = new (self) Class'GameFramework.MobileDebugCameraInput';
    super.OnActivate(PC);
    MPI.InitInputSystem();
    SetupDebugZones();
    MPI.ActivateInputGroup("DebugGroup");
    MobileDebugCameraHUD(myHUD).bDrawDebugText = bDrawDebugText;
    //return;    
}

function InitDebugInputSystem()
{
    MPI.MobileInputGroups.Remove(0, MPI.MobileInputGroups.Length);
    MPI.MobileInputZones.Remove(0, MPI.MobileInputZones.Length);
    //return;    
}

function OnDeactivate(PlayerController PC)
{
    local MobilePlayerInput MobileInput;

    MPI.CurrentMobileGroup = -1;
    super.OnDeactivate(PC);
    MobileInput = MobilePlayerInput(OriginalControllerRef.PlayerInput);
    MobileInput.SwapZoneOwners();
    MobileInput.CurrentMobileGroup = OldMobileGroup;
    //return;    
}

event InitInputSystem()
{
    super(PlayerController).InitInputSystem();
    //return;    
}

function SetupDebugZones()
{
    local float Ratio, Spacer;
    local MobileInputZone StickMoveZone, StickLookZone;
    local Vector2D ViewportSize;

    MPI.InitializeInputZones();
    StickMoveZone = MPI.FindZone("DebugStickMoveZone");
    StickLookZone = MPI.FindZone("DebugStickLookZone");
    LocalPlayer(OriginalPlayer).ViewportClient.GetViewportSize(ViewportSize);
    Ratio = ViewportSize.Y / ViewportSize.X;
    Spacer = float(((Ratio == 0.7500000) ? 96 : 64));
    Spacer *= (ViewportSize.X / float(1024));
    // End:0x60E
    if(StickMoveZone != none)
    {
        // End:0x293
        if(Ratio == 0.7500000)
        {
            StickMoveZone.SizeX = ViewportSize.X * 0.1200000;
            StickMoveZone.SizeY = StickMoveZone.SizeX;
            StickMoveZone.ActiveSizeX = StickMoveZone.SizeX;
            StickMoveZone.ActiveSizeY = StickMoveZone.SizeY;
        }
        StickMoveZone.SizeX = Spacer + StickMoveZone.SizeX;
        StickMoveZone.SizeY = Spacer + StickMoveZone.SizeY;
        // End:0x35B
        if(Ratio == 0.7500000)
        {
            StickMoveZone.SizeY *= 1.5000000;
        }
        StickMoveZone.X = 0.0000000;
        StickMoveZone.Y = ViewportSize.Y - StickMoveZone.SizeY;
        StickMoveZone.CurrentCenter.X = (StickMoveZone.X + StickMoveZone.SizeX) - (StickMoveZone.ActiveSizeX * 0.5000000);
        // End:0x4FC
        if(Ratio == 0.7500000)
        {
            StickMoveZone.CurrentCenter.Y = ViewportSize.Y - (StickMoveZone.SizeY * 0.3300000);            
        }
        else
        {
            StickMoveZone.CurrentCenter.Y = StickMoveZone.Y + (StickMoveZone.ActiveSizeY * 0.5000000);
        }
        StickMoveZone.CurrentLocation = StickMoveZone.CurrentCenter;
        StickMoveZone.InitialCenter = StickMoveZone.CurrentCenter;
        StickMoveZone.bCenterOnEvent = true;
    }
    // End:0xABB
    if(StickLookZone != none)
    {
        // End:0x729
        if(Ratio == 0.7500000)
        {
            StickLookZone.SizeX = ViewportSize.X * 0.1200000;
            StickLookZone.SizeY = StickLookZone.SizeX;
            StickLookZone.ActiveSizeX = StickLookZone.SizeX;
            StickLookZone.ActiveSizeY = StickLookZone.SizeY;
        }
        StickLookZone.SizeX = Spacer + StickLookZone.SizeX;
        StickLookZone.SizeY = Spacer + StickLookZone.SizeY;
        // End:0x7F1
        if(Ratio == 0.7500000)
        {
            StickLookZone.SizeY *= 1.5000000;
        }
        StickLookZone.X = ViewportSize.X - StickLookZone.SizeX;
        StickLookZone.Y = ViewportSize.Y - StickLookZone.SizeY;
        StickLookZone.CurrentCenter.X = StickLookZone.X + (StickLookZone.ActiveSizeX * 0.5000000);
        // End:0x9A9
        if(Ratio == 0.7500000)
        {
            StickLookZone.CurrentCenter.Y = ViewportSize.Y - (StickLookZone.SizeY * 0.3300000);            
        }
        else
        {
            StickLookZone.CurrentCenter.Y = StickLookZone.Y + (StickLookZone.ActiveSizeY * 0.5000000);
        }
        StickLookZone.CurrentLocation = StickLookZone.CurrentCenter;
        StickLookZone.InitialCenter = StickLookZone.CurrentCenter;
        StickLookZone.bCenterOnEvent = true;
    }
    //return;    
}

defaultproperties
{
    HUDClass=Class'GameFramework.MobileDebugCameraHUD'
    InputClass=Class'GameFramework.MobileDebugCameraInput'
    // Reference: CylinderComponent'GameFramework.Default__MobileDebugCameraController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__DebugCameraController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}