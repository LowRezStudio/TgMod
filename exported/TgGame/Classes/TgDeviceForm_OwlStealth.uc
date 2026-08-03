class TgDeviceForm_OwlStealth extends TgDeviceForm
    native(ChampOwl);

// Export UTgDeviceForm_OwlStealth::execStealthTransition(FFrame&, void* const)
native function StealthTransition(bool bStealthActivating, float fTransitionTime);

event BuildUp(int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional float fBuildupTime = 0.0000000)
{
    super.BuildUp(nFireMode, nEquipSlot, nSocketIndex, fBuildupTime);
    StealthTransition(true, fBuildupTime);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    StealthTransition(false, 0.2000000);
    //return;    
}

event DoInterrupt()
{
    super.DoInterrupt();
    StealthTransition(false, 0.2000000);
    //return;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    // End:0x3D
    if((int(DesiredState) == int(1)) && FormState != 'DeviceFiring')
    {
        StealthTransition(true, 0.0000000);
    }
    super.RecoverDeviceState(DesiredState);
    //return;    
}
