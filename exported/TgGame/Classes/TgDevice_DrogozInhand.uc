class TgDevice_DrogozInhand extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation);

var TgPawn_Drogoz m_CachedDrogozPawn;
var Vector m_vSalvoProjectileSpawnOffset;
var bool m_bStartedSalvo;
var TgDevice m_SalvoDevice;
var int m_nSalvoRockets;

// Export UTgDevice_DrogozInhand::execCanReload(FFrame&, void* const)
native function bool CanReload(optional bool bIsAutoReload = false);

// Export UTgDevice_DrogozInhand::execShouldAutoFire(FFrame&, void* const)
native function bool ShouldAutoFire();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x60
    if((((int(CurrentFireMode) == int(1)) && Current != none) && Current.m_nDeviceType != 11070) && ShouldAutoFire())
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    // End:0x28
    if(int(CurrentFireMode) == int(1))
    {
        m_nSalvoRockets = GetCurrentAmmoAmount();
    }
    super.FireAmmunition();
    // End:0x64
    if((int(CurrentFireMode) == int(1)) && (GetCurrentAmmoAmount()) == 0)
    {
        NotifyDeviceEvent(4);
    }
    //return;    
}

simulated function bool HasCachedDrogozPawn()
{
    // End:0x2B
    if(m_CachedDrogozPawn == none)
    {
        m_CachedDrogozPawn = TgPawn_Drogoz(Instigator);
    }
    return m_CachedDrogozPawn != none;
    //return ReturnValue;    
}

simulated event SetAmmo(int AmmoCount, optional int ClipSize = -1, optional bool bShouldValidate = false, optional int ValidationIDOverride = 0)
{
    super.SetAmmo(AmmoCount, ClipSize);
    // End:0x9E
    if((int(Role) == int(ROLE_Authority)) && HasCachedDrogozPawn())
    {
        m_CachedDrogozPawn.r_nInhandAmmoRemaining = GetCurrentAmmoAmount();
        m_CachedDrogozPawn.bNetDirty = true;
    }
    //return;    
}

simulated event Vector GetProjectileSpawnOffset()
{
    // End:0x1E
    if(int(CurrentFireMode) == int(1))
    {
        return m_vSalvoProjectileSpawnOffset;
    }
    return m_vProjectileSpawnOffset;
    //return ReturnValue;    
}

simulated function PrimeSalvo()
{
    SetFireMode(1, true);
    m_bStartedSalvo = false;
    // End:0x46
    if(HasCachedDrogozPawn())
    {
        m_CachedDrogozPawn.r_bSalvoActiveFlag = true;
    }
    //return;    
}

simulated function EndSalvo()
{
    // End:0x56
    if(Instigator.IsLocallyControlled())
    {
        SetAmmo(r_nMaxAmmoClipCount,, true);
        // End:0x56
        if(int(Role) < int(ROLE_Authority))
        {
            ServerStartSalvoReload();
        }
    }
    // End:0x7D
    if(int(CurrentFireMode) == int(1))
    {
        SetTimer(1.0000000, false, 'SalvoPostFireTimer');
    }
    SetFireMode(0, true);
    m_nSalvoRockets = 0;
    // End:0xC2
    if(HasCachedDrogozPawn())
    {
        m_CachedDrogozPawn.r_bSalvoActiveFlag = false;
    }
    //return;    
}

function SalvoPostFireTimer()
{
    //return;    
}

reliable server function ServerStartSalvoReload()
{
    local bool bIsSalvoReloadAllowed;

    bIsSalvoReloadAllowed = (int(CurrentFireMode) == int(1)) || IsTimerActive('SalvoPostFireTimer');
    SetAmmo(((bIsSalvoReloadAllowed) ? r_nMaxAmmoClipCount : GetCurrentAmmoAmount()),, true);
    NotifyDeviceEvent(4);
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0xF0
        case 11041:
            // End:0xEE
            if(Dev.IsA('TgDevice_Salvo'))
            {
                m_SalvoDevice = Dev;
                Dev.RegisterDelegate(2, PrimeSalvo);
                Dev.RegisterDelegate(3, EndSalvo);
            }
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0xDB
        case 11041:
            // End:0xDB
            if(Dev.IsA('TgDevice_Salvo'))
            {
                Dev.UnregisterDelegate(2, PrimeSalvo);
                Dev.UnregisterDelegate(3, EndSalvo);
            }
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated function Projectile ProjectileFire(optional int ProjectileIndex = 0)
{
    local TgProj_DrogozRocket drogozProj;

    drogozProj = TgProj_DrogozRocket(super.ProjectileFire(ProjectileIndex));
    // End:0x7F
    if((m_nSalvoRockets > 0) || m_CachedDrogozPawn.r_bSalvoActiveFlag)
    {
        drogozProj.m_bWasFromSalvo = true;
    }
    return drogozProj;
    //return ReturnValue;    
}

state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        super.StartFiringLogic();
        // End:0x2A
        if(int(CurrentFireMode) == int(1))
        {
            m_bStartedSalvo = true;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_vSalvoProjectileSpawnOffset=(X=0.0000000,Y=4.5000000,Z=-6.0000000)
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=15.0000000,Z=-7.5000000)
    m_fAltFireLockOutTime=0.0000000
    m_nLinkedDeviceTypes[0]=11041
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Drogoz.DeviceRocketLauncher'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.HeavyForceFeedback'
}