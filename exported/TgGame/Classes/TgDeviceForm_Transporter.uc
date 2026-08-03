class TgDeviceForm_Transporter extends TgDeviceForm
    native(ChampKinessa);

var TgSkeletalMeshActor c_TargetingModeMeshIndicator2;
var TgSpecialFx c_TargetingModeFx2;
var Vector c_TargetingModeFx2Location;
var int c_nTargetingModeFx2Id;

// Export UTgDeviceForm_Transporter::execInitializeTargetingModeFX(FFrame&, void* const)
native function InitializeTargetingModeFX();

// Export UTgDeviceForm_Transporter::execUpdateTargetingMode2Location(FFrame&, void* const)
native function UpdateTargetingMode2Location(Vector NewLocation, Rotator NewRotation, optional float DistanceScale = 1.0000000);

// Export UTgDeviceForm_Transporter::execUpdateTargetingModeStatus(FFrame&, void* const)
native function UpdateTargetingModeStatus(TgDevice.ETargetingModeStatus Status, const out AimData Aim);

simulated event EnterTargetingMode()
{
    super.EnterTargetingMode();
    ShowReticle(false);
    //return;    
}

simulated event ExitTargetingMode()
{
    super.ExitTargetingMode();
    // End:0x63
    if(c_TargetingModeFx2 != none)
    {
        c_TargetingModeFx2.Deactivate(true);
        c_TargetingModeFx2.Detach();
        c_TargetingModeFx2 = none;
    }
    // End:0x95
    if(c_TargetingModeMeshIndicator2 != none)
    {
        c_TargetingModeMeshIndicator2.Destroy();
        c_TargetingModeMeshIndicator2 = none;
    }
    ShowReticle(true);
    //return;    
}

simulated function ShowReticle(bool bShow)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(PawnOwner.Controller);
    // End:0x73
    if(TgPC != none)
    {
        TgPC.SetReticleVisibility(bShow, bShow);
    }
    //return;    
}

defaultproperties
{
    c_nTargetingModeFx2Id=7219
}