class TgDeviceForm_OwlStealth extends TgDeviceForm
    native(ChampOwl)
    config(Engine)
    dependson(TgPawn);

native function StealthTransition(bool bStealthActivating, float fTransitionTime);  // Export UTgDeviceForm_OwlStealth::execStealthTransition(FFrame&, void* const)

event BuildUp(int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional float fBuildupTime=0.0000000) { }

event StopFire(int nFireModeNum) { }

event DoInterrupt() { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }
