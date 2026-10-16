class TgDevice_KinessaInhand extends TgDevice
    native(ChampKinessa)
    hidecategories(Navigation);

var() Vector m_vSniperProjectileSpawnOffset;
var ForceFeedbackWaveform m_ForceFeedbackStartFireScout;
var ForceFeedbackWaveform m_ForceFeedbackStartFireSniper;

// Export UTgDevice_KinessaInhand::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nFireModeNum, optional bool ForceSet = false);

// Export UTgDevice_KinessaInhand::execRequiresAmmoToFire(FFrame&, void* const)
native function bool RequiresAmmoToFire();

simulated function StartSteadyInhandEffects()
{
    local TgDeviceFire sniperFiremode;

    sniperFiremode = GetCurrentFire();
    // End:0x44
    if(sniperFiremode != none)
    {
        sniperFiremode.m_bRequireLOS = false;
    }
    //return;    
}

simulated function EndSteadyInhandEffects()
{
    local TgDeviceFire sniperFiremode;

    sniperFiremode = GetCurrentFire();
    // End:0x44
    if(sniperFiremode != none)
    {
        sniperFiremode.m_bRequireLOS = true;
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function FirePostHitDelay()
    {
        local TgPawn_Kinessa Kinessa;

        super.FirePostHitDelay();
        // End:0xAF
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0xAF
            if(int(CurrentFireMode) != int(0))
            {
                Kinessa = TgPawn_Kinessa(Instigator);
                // End:0xAF
                if(Kinessa != none)
                {
                    Kinessa.m_fZoomChargeTimestamp = Kinessa.WorldInfo.TimeSeconds;
                }
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_vSniperProjectileSpawnOffset=(X=30.0000000,Y=0.0000000,Z=-3.0000000)
    m_ForceFeedbackStartFireScout=ForceFeedbackWaveform'gp_forcefeedback.LightForceFeedback'
    m_ForceFeedbackStartFireSniper=ForceFeedbackWaveform'gp_forcefeedback.HeavyForceFeedback'
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_None
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_Sniper'
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Kinessa.DeviceInhand'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=0.9800000,fMinAccuracy=0.8500000,fAccuracyLossPerShot=0.0400000,fAccuracyGainPerSec=0.5000000,fAccuracyGainDelay=0.2000000)
}