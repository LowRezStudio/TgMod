class TgDevice_YingInhand extends TgDevice
    native(ChampYing)
    hidecategories(Navigation);

var TgPawn_Ying m_CachedYingPawn;

// Export UTgDevice_YingInhand::execCanReload(FFrame&, void* const)
native function bool CanReload(optional bool bIsAutoReload = false);

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated function bool HasCachedYingPawn()
{
    // End:0x2B
    if(m_CachedYingPawn == none)
    {
        m_CachedYingPawn = TgPawn_Ying(Instigator);
    }
    return m_CachedYingPawn != none;
    //return ReturnValue;    
}

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
    local TgDeployable deployTarget;

    // End:0x195
    if(HasCachedYingPawn())
    {
        m_CachedYingPawn.r_InhandTarget = HitActor;
        // End:0x174
        if(m_CachedYingPawn.r_InhandTarget != none)
        {
            deployTarget = TgDeployable(HitActor);
            // End:0x122
            if((deployTarget != none) && int(deployTarget.m_CollisionSettings.mCollisionMode) != int(0))
            {
                m_CachedYingPawn.r_InhandHitOffset = HitLocation - m_CachedYingPawn.r_InhandTarget.Location;                
            }
            else
            {
                // End:0x174
                if(!IsZero(m_CachedYingPawn.r_InhandHitOffset))
                {
                    m_CachedYingPawn.r_InhandHitOffset = vect(0.0000000, 0.0000000, 0.0000000);
                }
            }
        }
        m_CachedYingPawn.bNetDirty = true;
    }
    //return;    
}

function HandleClientReportedInstantShot(AimData InServerAim, AimData InClientAim, ImpactToValidate InPrimaryImpact, array<ImpactToValidate> InClientImpacts)
{
    local ImpactInfo VerifiedPrimaryImpact;
    local array<float> hitRanges;

    PendingImpactList.Length = 0;
    // End:0x129
    if(ValidateClientInstantHit(VerifiedPrimaryImpact, PendingImpactList, InServerAim, InClientAim, InPrimaryImpact, InClientImpacts, hitRanges))
    {
        // End:0xA0
        if(HasCachedYingPawn())
        {
            m_CachedYingPawn.r_InhandTarget = VerifiedPrimaryImpact.HitActor;
        }
        PlayClientFireFx(VerifiedPrimaryImpact.HitLocation, m_nSocketIndex, Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(VerifiedPrimaryImpact.HitActor), GetRefireTime());
        DeliverQueuedPendingHits();
        UpdateIndex();
    }
    //return;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_bUsesBurstFire=true
    m_bOnlyFirstBurstCostsAmmo=true
    m_bDoNotAllowHeadShots=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=4.0000000,Z=-9.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_nBurstTotalShots=5
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_YingInhand'
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
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.FireYing'
}