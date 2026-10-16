class TgDevice_ViktorInhand extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation);

var bool m_bIsADS;
var() Vector m_vADSProjectileSpawnOffset;
var(Recoil) float m_fADSRecoilMultiplier;
var float m_fMinAccuracyDefault;
var float m_fMinAccuracyADS;
var float m_fAccuracyLossPerShotDefault;
var float m_fAccuracyLossPerShotADS;
var TgPawn_Character m_CachedPawnOwner;

simulated event Vector GetProjectileSpawnOffset()
{
    return ((m_bIsADS) ? m_vADSProjectileSpawnOffset : m_vProjectileSpawnOffset);
    //return ReturnValue;    
}

simulated event SetAmmo(int AmmoCount, optional int ClipSize = -1, optional bool bShouldValidate = false, optional int ValidationIDOverride = 0)
{
    super.SetAmmo(AmmoCount, ClipSize, bShouldValidate, ValidationIDOverride);
    // End:0x7A
    if(c_DeviceForm != none)
    {
        c_DeviceForm.SetAmmoBlendNodesAmount(AmmoCount);
    }
    //return;    
}

simulated function ShowReticle(bool bShow)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(Instigator.Controller);
    // End:0x73
    if(TgPC != none)
    {
        TgPC.SetReticleVisibility(bShow, bShow);
    }
    //return;    
}

simulated function StartADSBonuses()
{
    // End:0xAF
    if(!m_bIsADS)
    {
        m_fMinAccuracyDefault = m_AccuracySettings[0].fMinAccuracy;
        m_fAccuracyLossPerShotDefault = m_AccuracySettings[0].fAccuracyLossPerShot;
        m_AccuracySettings[0].fMinAccuracy = m_fMinAccuracyADS;
        m_AccuracySettings[0].fAccuracyLossPerShot = m_fAccuracyLossPerShotADS;
    }
    m_bIsADS = true;
    // End:0xFF
    if((m_CachedPawnOwner == none) || m_CachedPawnOwner.r_nWeaponSkinId != 19265)
    {
        ShowReticle(false);
    }
    // End:0x12D
    if(HasCachedCharacter())
    {
        m_CachedPawnOwner.m_bAirAccuracyPenalty = false;
    }
    m_fCurrentAdvancedAccuracy = FMax(m_fMinAccuracyADS, m_fCurrentAdvancedAccuracy);
    m_fLastMinAccuracy = m_fCurrentAdvancedAccuracy;
    //return;    
}

simulated function EndADSBonuses()
{
    // End:0x5D
    if(m_bIsADS)
    {
        m_AccuracySettings[0].fMinAccuracy = m_fMinAccuracyDefault;
        m_AccuracySettings[0].fAccuracyLossPerShot = m_fAccuracyLossPerShotDefault;
    }
    m_bIsADS = false;
    ShowReticle(true);
    // End:0xA2
    if(HasCachedCharacter())
    {
        m_CachedPawnOwner.m_bAirAccuracyPenalty = true;
    }
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
    switch(Dev.r_nDeviceId)
    {
        // End:0xBA
        case 14157:
            Dev.RegisterDelegate(0, StartADSBonuses);
            Dev.RegisterDelegate(3, EndADSBonuses);
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
    switch(Dev.r_nDeviceId)
    {
        // End:0xBA
        case 14157:
            Dev.UnregisterDelegate(0, StartADSBonuses);
            Dev.UnregisterDelegate(3, EndADSBonuses);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated function bool HasCachedCharacter()
{
    // End:0x2B
    if(m_CachedPawnOwner == none)
    {
        m_CachedPawnOwner = TgPawn_Character(Instigator);
    }
    return m_CachedPawnOwner != none;
    //return ReturnValue;    
}

simulated function TgGameplayCurvesSet_RecoilSimple GetRecoilCurve()
{
    local int I;
    local TgGameplayCurves GPCurves;
    local TgGameplayCurvesSet_RecoilSimple recoilCurves;

    GPCurves = GetCurrentGameplayCurves();
    // End:0x25
    if(GPCurves == none)
    {
        return none;
    }
    I = 0;
    J0x30:

    // End:0x1AD [Loop If]
    if(I < GPCurves.CurveSets.Length)
    {
        // End:0x19F
        if((GPCurves.CurveSets[I] != none) && int(GPCurves.CurveSets[I].CurveSetType) == int(2))
        {
            recoilCurves = TgGameplayCurvesSet_RecoilSimple(GPCurves.CurveSets[I]);
            // End:0x19F
            if((recoilCurves != none) && (!m_bIsADS && int(recoilCurves.RecoilType) == int(0)) || m_bIsADS && int(recoilCurves.RecoilType) == int(1))
            {
                return recoilCurves;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x30;
    }
    return none;
    //return ReturnValue;    
}

simulated function float GetRecoilMultiplier()
{
    local TgPawn_Character PawnOwner;
    local TgDevice ADS;
    local float fBaseMultiplier;

    fBaseMultiplier = super.GetRecoilMultiplier();
    PawnOwner = TgPawn_Character(Instigator);
    // End:0xA7
    if(PawnOwner != none)
    {
        ADS = PawnOwner.GetDeviceByEqPoint(16);
        // End:0xA7
        if((ADS != none) && ADS.IsFiring())
        {
            return m_fADSRecoilMultiplier;
        }
    }
    return fBaseMultiplier;
    //return ReturnValue;    
}

defaultproperties
{
    m_vADSProjectileSpawnOffset=(X=30.0000000,Y=0.0000000,Z=-3.0000000)
    m_fADSRecoilMultiplier=1.0000000
    m_fMinAccuracyADS=1.0000000
    m_fAccuracyLossPerShotADS=0.0090000
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_ViktorInhand'
    m_nLinkedDeviceIDs[0]=14157
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Viktor.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.LightForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0000000,fMinAccuracy=0.8400000,fAccuracyLossPerShot=0.0300000,fAccuracyGainPerSec=0.4800000,fAccuracyGainDelay=0.2000000)
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=6.0000000,fRecoilCenterDelay=0.3000000,fRecoilSmoothRate=15.0000000)
}