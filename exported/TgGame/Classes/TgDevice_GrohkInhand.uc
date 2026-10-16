class TgDevice_GrohkInhand extends TgDevice_ArcingBeam
    native(ChampGrohk)
    hidecategories(Navigation);

var TgPawn_Grohk m_CachedGrohkPawn;

// Export UTgDevice_GrohkInhand::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(const out ImpactInfo Impact, out float fDamage, int nPropertyId);

// Export UTgDevice_GrohkInhand::execIsValidArcTarget(FFrame&, void* const)
native function bool IsValidArcTarget(Actor TestActor, ArcingInfo Info);

simulated function bool HasCachedGrohkPawn()
{
    // End:0x2B
    if(m_CachedGrohkPawn == none)
    {
        m_CachedGrohkPawn = TgPawn_Grohk(Instigator);
    }
    return m_CachedGrohkPawn != none;
    //return ReturnValue;    
}

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo Impact;

    Impact = super(TgDevice).CalcWeaponFire(Aim, ImpactList);
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
    local TgDeployable deployTarget;

    // End:0x224
    if(HasCachedGrohkPawn())
    {
        // End:0x82
        if(m_CachedGrohkPawn.r_InhandTarget != HitActor)
        {
            m_CachedGrohkPawn.r_InhandTarget = HitActor;
            m_CachedGrohkPawn.bNetDirty = true;
        }
        // End:0x203
        if(m_CachedGrohkPawn.r_InhandTarget != none)
        {
            deployTarget = TgDeployable(HitActor);
            // End:0x190
            if((deployTarget != none) && int(deployTarget.m_CollisionSettings.mCollisionMode) != int(0))
            {
                m_CachedGrohkPawn.r_InhandHitOffset = HitLocation - m_CachedGrohkPawn.r_InhandTarget.Location;
                m_CachedGrohkPawn.bNetDirty = true;                
            }
            else
            {
                // End:0x203
                if(!IsZero(m_CachedGrohkPawn.r_InhandHitOffset))
                {
                    m_CachedGrohkPawn.r_InhandHitOffset = vect(0.0000000, 0.0000000, 0.0000000);
                    m_CachedGrohkPawn.bNetDirty = true;
                }
            }
        }
        m_CachedGrohkPawn.bNetDirty = true;
    }
    //return;    
}

defaultproperties
{
    m_nMaxNumArcsPerTarget=0
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bCanReloadEarly=false
    m_bDoNotAllowHeadShots=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=4.0000000,Z=-9.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_Orb'
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
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Grohk.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.LightForceFeedback'
}