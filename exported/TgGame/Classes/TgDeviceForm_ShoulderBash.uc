class TgDeviceForm_ShoulderBash extends TgDeviceForm
    native(ChampFlak);

var int moveAmount;

// Export UTgDeviceForm_ShoulderBash::execUpdateTargetingModeLocation(FFrame&, void* const)
native function UpdateTargetingModeLocation(Vector NewLocation, Rotator NewRotation, optional float DistanceScale = 1.0000000);

// Export UTgDeviceForm_ShoulderBash::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

simulated event EnterTargetingMode()
{
    // End:0x39
    if(c_Mesh != none)
    {
        // End:0x39
        if((c_TargetingModeFx == none) || c_TargetingModeMeshIndicator == none)
        {
            InitializeTargetingModeFX();
        }
    }
    //return;    
}

defaultproperties
{
    moveAmount=10
}