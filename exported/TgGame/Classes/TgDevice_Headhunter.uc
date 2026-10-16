class TgDevice_Headhunter extends TgDevice_Stim
    hidecategories(Navigation);

var TgDevice_KinessaInhand m_CachedInhandDevice;
var TgDevice_SniperMode m_CachedSniperModeDevice;
var bool m_bCamFXEnabled;

simulated function OnStartFireRequestSent()
{
    super(TgDevice).OnStartFireRequestSent();
    // End:0x39
    if(HasCachedInhandDevice())
    {
        m_CachedInhandDevice.GiveAmmo(5, true);
    }
    //return;    
}

simulated function Tick(float DeltaTime)
{
    super(Actor).Tick(DeltaTime);
    // End:0x9A
    if((HasCachedSniperDevice()) && IsFiring())
    {
        // End:0x8F
        if(m_CachedSniperModeDevice.IsFiring() && !m_CachedSniperModeDevice.IsTimerActive('FirePreHitDelay'))
        {
            ToggleCamFX(true);            
        }
        else
        {
            ToggleCamFX(false);
        }
    }
    //return;    
}

simulated function ToggleCamFX(bool bEnable)
{
    local TgPawn_Kinessa kinessaOwner;

    kinessaOwner = TgPawn_Kinessa(Owner);
    // End:0xDD
    if(((kinessaOwner != none) && (GetCurrentFire()) != none) && bEnable != m_bCamFXEnabled)
    {
        // End:0x98
        if(bEnable)
        {
            GetCurrentFire().ApplyHitSpecial(kinessaOwner,, 10694);            
        }
        else
        {
            GetCurrentFire().RemoveHitSpecial(kinessaOwner, true, 10694);
        }
        m_bCamFXEnabled = bEnable;
    }
    //return;    
}

simulated function bool HasCachedInhandDevice()
{
    local TgPawn_Kinessa kinessaOwner;

    // End:0x71
    if(m_CachedInhandDevice == none)
    {
        kinessaOwner = TgPawn_Kinessa(Owner);
        // End:0x71
        if(kinessaOwner != none)
        {
            m_CachedInhandDevice = TgDevice_KinessaInhand(kinessaOwner.GetDeviceById(12872));
        }
    }
    return m_CachedInhandDevice != none;
    //return ReturnValue;    
}

simulated function bool HasCachedSniperDevice()
{
    local TgPawn_Kinessa kinessaOwner;

    // End:0x71
    if(m_CachedSniperModeDevice == none)
    {
        kinessaOwner = TgPawn_Kinessa(Owner);
        // End:0x71
        if(kinessaOwner != none)
        {
            m_CachedSniperModeDevice = TgDevice_SniperMode(kinessaOwner.GetDeviceById(13142));
        }
    }
    return m_CachedSniperModeDevice != none;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        // End:0x5B
        if((HasCachedSniperDevice()) && m_CachedSniperModeDevice.IsFiring())
        {
            m_CachedSniperModeDevice.RefreshZoomState(true);
        }
        // End:0xAB
        if((HasCachedInhandDevice()) && m_CachedInhandDevice.IsReloading())
        {
            m_CachedInhandDevice.InterruptReload();
        }
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        super.FirePostHitDelay();
        // End:0x5B
        if((HasCachedSniperDevice()) && m_CachedSniperModeDevice.IsFiring())
        {
            m_CachedSniperModeDevice.RefreshZoomState(true);
        }
        ToggleCamFX(false);
        //return;        
    }
    stop;    
}
