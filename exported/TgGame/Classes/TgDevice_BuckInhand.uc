class TgDevice_BuckInhand extends TgDevice
    hidecategories(Navigation);

enum ReloadAnimType
{
    RAT_FirstShell,                 // 0
    RAT_LoopingShells,              // 1
    RAT_PostReload,                 // 2
    RAT_MAX                         // 3
};

var float m_fReloadScaleUsed;
var float m_fStartReloadTimestamp;
var float m_fFirstShellReloadTime;
var float m_fShellReloadTime;
var float m_fPostReloadTime;
var float m_fReloadTimer;
var int m_nProgressiveReloadTransactionID;
var bool m_bIsReloadingFirstShell;
var bool s_bPendingServerEndReload;

simulated event bool Use()
{
    // End:0x88
    if(IsTimerActive('PreReloadTimer') && !m_bIsReloadingFirstShell)
    {
        ClearTimer('PreReloadTimer');
        PlayReloadAnim(2, m_fPostReloadTime * m_fReloadScaleUsed);
        SetTimer(m_fPostReloadTime * m_fReloadScaleUsed, false, 'PostReloadTimer');
        ServerEndReloadForInhandFire();
    }
    return super.Use();
    //return ReturnValue;    
}

reliable server function ServerEndReloadForInhandFire()
{
    // End:0x8B
    if(IsTimerActive('PreReloadTimer'))
    {
        // End:0x7F
        if(!m_bIsReloadingFirstShell)
        {
            ClearTimer('PreReloadTimer');
            PlayReloadAnim(2, m_fPostReloadTime * m_fReloadScaleUsed);
            SetTimer(m_fPostReloadTime * m_fReloadScaleUsed, false, 'PostReloadTimer');            
        }
        else
        {
            s_bPendingServerEndReload = true;
        }
    }
    //return;    
}

simulated event bool StartReload(optional bool bIgnoreCurrentAmmo = false)
{
    local TgDeviceFire FireMode;
    local TgPawn TgP;

    // End:0x76
    if((((IsReloading()) || !bIgnoreCurrentAmmo && (GetCurrentAmmoAmount()) >= r_nMaxAmmoClipCount) || Instigator == none) || !Instigator.IsAliveAndWell())
    {
        return false;
    }
    FireMode = GetCurrentFire();
    // End:0x9B
    if(FireMode == none)
    {
        return false;
    }
    TgP = TgPawn(Instigator);
    m_fReloadScaleUsed = ((TgP != none) ? TgP.GetReloadScale() : 1.0000000);
    m_nProgressiveReloadTransactionID = GiveAmmoDelayedWithValidationRegen(0);
    m_fStartReloadTimestamp = WorldInfo.TimeSeconds;
    m_fShellReloadTime = FireMode.m_fAmmoClipPreReloadTime;
    m_fFirstShellReloadTime = FireMode.GetCustomValue1();
    m_fPostReloadTime = FireMode.m_fAmmoClipPostReloadTime + ((int(Role) < int(ROLE_Authority)) ? 0.1000000 : 0.0000000);
    m_bIsReloadingFirstShell = true;
    // End:0x1FB
    if(int(Role) < int(ROLE_Authority))
    {
        ServerStartReload();        
    }
    else
    {
        s_bPendingServerEndReload = false;
    }
    m_fTotalReloadTime = ((m_fFirstShellReloadTime + (float(Max(0, (r_nMaxAmmoClipCount - (GetCurrentAmmoAmount())) - 1)) * m_fShellReloadTime)) + m_fPostReloadTime) * m_fReloadScaleUsed;
    // End:0x396
    if(m_fTotalReloadTime > float(0))
    {
        // End:0x2F3
        if((TgP != none) && TgP.m_WeaponMesh != none)
        {
            TgP.m_WeaponMesh.PlayReload(int(r_eEquippedAt), m_fTotalReloadTime, GetCurrentAmmoAmount());
        }
        SetTimer(m_fTotalReloadTime, false, 'FullReloadTimer');
        PlayReloadAnim(0, m_fFirstShellReloadTime * m_fReloadScaleUsed);
        // End:0x36D
        if((m_fFirstShellReloadTime * m_fReloadScaleUsed) > 0.0000000)
        {
            SetTimer(m_fFirstShellReloadTime * m_fReloadScaleUsed, false, 'PreReloadTimer');            
        }
        else
        {
            PreReloadTimer();
        }
        PlayNextSimulatedForceFeedbackWaveform(none, m_ForceFeedbackStartReload, m_fReloadScaleUsed);
    }
    NotifyDeviceEvent(1);
    return true;
    //return ReturnValue;    
}

simulated function PreReloadTimer()
{
    local TgDeviceFire FireMode;
    local TgPawn_Character TgP;
    local float fReloadTimeRemaining;

    FireMode = GetCurrentFire();
    m_bIsReloadingFirstShell = false;
    // End:0x1AD
    if(FireMode != none)
    {
        // End:0x8E
        if(int(Role) == int(ROLE_Authority))
        {
            TgP = TgPawn_Character(Instigator);
            // End:0x8E
            if(TgP != none)
            {
                TgP.DeviceOnReload(self);
            }
        }
        PlayNextSimulatedForceFeedbackWaveform(m_ForceFeedbackStartReload, m_ForceFeedbackStopReload);
        UpdateDelayedAmmoTransactionRegen(m_nProgressiveReloadTransactionID, 1);
        // End:0x16B
        if(((GetCurrentAmmoAmount()) >= r_nMaxAmmoClipCount) || (int(Role) == int(ROLE_Authority)) && s_bPendingServerEndReload)
        {
            fReloadTimeRemaining = m_fPostReloadTime * m_fReloadScaleUsed;
            PlayReloadAnim(2, fReloadTimeRemaining);
            // End:0x15E
            if(fReloadTimeRemaining > 0.0000000)
            {
                SetTimer(fReloadTimeRemaining, false, 'PostReloadTimer');                
            }
            else
            {
                PostReloadTimer();
            }            
        }
        else
        {
            SetTimer(m_fShellReloadTime * m_fReloadScaleUsed, false, 'PreReloadTimer');
            PlayReloadAnim(1, m_fShellReloadTime * m_fReloadScaleUsed);
        }
    }
    //return;    
}

simulated function PlayReloadAnim(TgDevice_BuckInhand.ReloadAnimType rat, float ReloadTime)
{
    local TgPawn_Character TgP;

    TgP = TgPawn_Character(Instigator);
    // End:0x106
    if(TgP != none)
    {
        // End:0xAC
        if(TgP.m_WeaponMesh != none)
        {
            TgP.m_WeaponMesh.PlayReload(int(r_eEquippedAt), ReloadTime, GetCurrentAmmoAmount(), int(rat));
        }
        // End:0x106
        if(int(Role) == int(ROLE_Authority))
        {
            TgP.FlashReload(r_nDeviceInstanceId, ReloadTime, GetCurrentAmmoAmount(), int(rat));
        }
    }
    //return;    
}

simulated function PostReloadTimer()
{
    // End:0x5D
    if(((int(Role) < int(ROLE_Authority)) && Instigator != none) && Instigator.IsLocallyControlled())
    {
        ValidateDelayedAmmoTransactionRegen(m_nProgressiveReloadTransactionID, false);
    }
    //return;    
}

reliable server function ServerStartReload()
{
    // End:0x49
    if(!StartReload())
    {
        GiveAmmoDelayedWithValidationRegen(0);
        // End:0x49
        if(!IsReloading())
        {
            ClientInterruptReload((GetCurrentAmmoAmount()) >= r_nMaxAmmoClipCount);
        }
    }
    //return;    
}

reliable client simulated function ClientInterruptReload(optional bool bAllowAmmoFill = false)
{
    // End:0x12
    if(LogDebugInfo())
    {
    }
    // End:0x4A
    if(self.IsTimerActive('PostReloadTimer'))
    {
        ValidateDelayedAmmoTransactionRegen(m_nProgressiveReloadTransactionID);
    }
    ClearTimer('PreReloadTimer');
    ClearTimer('PostReloadTimer');
    ClearTimer('FullReloadTimer');
    //return;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bConsolidateMultipleShots=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=15.0000000,Z=-20.0000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_BuckInhand'
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetVert[1]=(KeyframeName="V100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetVert[2]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[2]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftlowx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Buck.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.HeavyForceFeedback'
}