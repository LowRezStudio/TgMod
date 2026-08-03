class TgDebugCameraController extends DebugCameraController
    config(Input)
    hidecategories(Navigation);

exec function Camera(name NewMode)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(OriginalControllerRef);
    // End:0x53
    if(TgPC != none)
    {
        TgPC.Camera(NewMode);
    }
    switch(NewMode)
    {
        // End:0x7F
        case 'Attach':
            DisableDebugCamera();
            // End:0xB4
            break;
        // End:0x98
        case 'Freeze':
            DisableDebugCamera();
            // End:0xB4
            break;
        // End:0xB1
        case 'Reset':
            DisableDebugCamera();
            // End:0xB4
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

function DisableDebugCamera()
{
    // End:0x92
    if(OriginalControllerRef != none)
    {
        // End:0x50
        if(bIsFrozenRendering == true)
        {            
            ConsoleCommand("FreezeRendering");
            bIsFrozenRendering = false;
        }
        // End:0x92
        if(OriginalPlayer != none)
        {
            OriginalPlayer.SwitchController(OriginalControllerRef);
            OnDeactivate(self);
        }
    }
    //return;    
}

defaultproperties
{
    InputClass=Class'TgGame.TgDebugCameraInput'
    // Reference: CylinderComponent'TgGame.Default__TgDebugCameraController.CollisionCylinder'
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