class TgDeviceForm_Scope extends TgDeviceForm_ToggleWithLockout
    native(ChampOwl);

var float m_fTransitionAmount;
var float m_fTransitionPerSec;
var const float m_fWeaponZoomFOV;

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    EnableZoom(false);
    //return;    
}

simulated event SetToggleState(bool bIsActive)
{
    super(TgDeviceForm).SetToggleState(bIsActive);
    EnableZoom(bIsActive);
    //return;    
}

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive)
{
    super(TgDeviceForm).PlayToggleTransitionAnimations(transitionPercent, totalTransitionTime, transitionToActive);
    m_fTransitionAmount = transitionPercent;
    m_fTransitionPerSec = (1.0000000 / totalTransitionTime) * float(((transitionToActive) ? 1 : -1));
    //return;    
}

simulated function EnableZoom(bool bIsActive)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera Cam;

    // End:0x1A6
    if(PawnOwner != none)
    {
        TgPC = TgPlayerController(PawnOwner.GetALocalPlayerController());
        // End:0x1A6
        if((TgPC != none) && TgPC.GetTgPawn() == PawnOwner)
        {
            Cam = TgPlayerCamera(TgPC.PlayerCamera);
            // End:0x112
            if(Cam != none)
            {
                // End:0xF3
                if(bIsActive)
                {
                    Cam.SetFOV(34.0000000);                    
                }
                else
                {
                    Cam.ResetFOV();
                }
            }
            TgPC.SetHUDOverlay(((bIsActive) ? 3 : 0));
            // End:0x1A6
            if(PawnOwner.m_WeaponMesh != none)
            {
                PawnOwner.m_WeaponMesh.SetFOVZoomed(bIsActive);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_fWeaponZoomFOV=45.0000000
    m_GameplayCurves=TgGameplayCurves'GP_Owl.DeviceInhand'
}