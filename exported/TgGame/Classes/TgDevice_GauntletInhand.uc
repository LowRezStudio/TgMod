class TgDevice_GauntletInhand extends TgDevice
    native(ChampGauntlet)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgPawn_Gauntlet m_CachedGauntletPawn;

// Export UTgDevice_GauntletInhand::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo Impact;

    Impact = super.CalcWeaponFire(Aim, ImpactList);
    UpdateInhandTargetInfo(Impact.HitActor, Impact.HitLocation);
    return Impact;
    //return ReturnValue;    
}

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact)
{
    UpdateInhandTargetInfo(VerifiedPrimaryImpact.HitActor, VerifiedPrimaryImpact.HitLocation);
    //return;    
}

simulated function UpdateInhandTargetInfo(Actor HitActor, Vector HitLocation)
{
    // End:0x103
    if(HasCachedGauntlet())
    {
        // End:0x61
        if(m_CachedGauntletPawn.r_InhandTarget != HitActor)
        {
            m_CachedGauntletPawn.r_InhandTarget = HitActor;
        }
        // End:0xE2
        if(m_CachedGauntletPawn.r_InhandTarget != none)
        {
            m_CachedGauntletPawn.r_InhandHitOffset = HitLocation - m_CachedGauntletPawn.r_InhandTarget.Location;
        }
        m_CachedGauntletPawn.bNetDirty = true;
    }
    //return;    
}

simulated function bool HasCachedGauntlet()
{
    // End:0x2B
    if(m_CachedGauntletPawn == none)
    {
        m_CachedGauntletPawn = TgPawn_Gauntlet(Instigator);
    }
    return m_CachedGauntletPawn != none;
    //return ReturnValue;    
}

simulated function StopFire()
{
    // End:0x4E
    if(HasCachedGauntlet())
    {
        m_CachedGauntletPawn.r_InhandTarget = none;
        m_CachedGauntletPawn.bNetDirty = true;
    }
    super.StopFire();
    //return;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bDisableLagCompensation=true
    m_bDoNotAllowHeadShots=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=4.0000000,Z=-9.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_GauntletInhand'
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
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.LightForceFeedback'
}