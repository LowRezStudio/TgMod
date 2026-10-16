class TgDeviceForm_Barrage extends TgDeviceForm;

var TgPlayerController m_CachedActiveOverlayController;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPlayerController TgPC;

    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x42
    if(PawnOwner == none)
    {
        return;
    }
    TgPC = TgPlayerController(PawnOwner.GetALocalPlayerController());
    // End:0xCA
    if((TgPC == none) || !TgPC.GetTgPawn().IsEnemy(PawnOwner))
    {
        return;
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local BinocularSettings binoSettings;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    m_CachedActiveOverlayController = TgPlayerController(PawnOwner.GetALocalPlayerController());
    // End:0x21F
    if((m_CachedActiveOverlayController != none) && m_CachedActiveOverlayController.GetTgPawn() == PawnOwner)
    {
        m_CachedActiveOverlayController.SetHUDOverlay(2);
        binoSettings.fRange = 0.0000000;
        binoSettings.nTargets = 0;
        binoSettings.fTimer1 = 0.0010000;
        binoSettings.fTimer2 = 1.0000000;
        binoSettings.fTimer3 = 1.0000000;
        binoSettings.fTimerDuration = 1.0000000;
        // End:0x1F4
        if(PawnOwner != none)
        {
            binoSettings.rHeading = PawnOwner.Rotation;
        }
        m_CachedActiveOverlayController.SetBinocularSettings(binoSettings);        
    }
    else
    {
        m_CachedActiveOverlayController = none;
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    local BinocularSettings binoSettings;

    super.StopFire(nFireModeNum);
    // End:0x1AC
    if((m_CachedActiveOverlayController != none) && m_CachedActiveOverlayController.GetTgPawn() == PawnOwner)
    {
        binoSettings.fRange = 0.0000000;
        binoSettings.nTargets = 0;
        binoSettings.fTimer1 = 0.0000000;
        binoSettings.fTimer2 = 0.0000000;
        binoSettings.fTimer3 = 0.0000000;
        binoSettings.fTimerDuration = 1.0000000;
        // End:0x163
        if(PawnOwner != none)
        {
            binoSettings.rHeading = PawnOwner.Rotation;
        }
        m_CachedActiveOverlayController.SetBinocularSettings(binoSettings);
        m_CachedActiveOverlayController.SetHUDOverlay(0);
    }
    m_CachedActiveOverlayController = none;
    //return;    
}
