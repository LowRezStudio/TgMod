class TgDevice_RuckusInhand extends TgDevice_DualWield
    native(ChampRuckus)
    hidecategories(Navigation);

var float m_fSpinAmount;
var float m_fCurrentSpinScale;
var(Spin) float m_fStartingSpinRate;
var(Spin) float m_fMaxSpinRate;
var(Spin) float m_fDurationToMaxSpin;
var(Spin) float m_fSpinDownRate;
var(Spin) float m_fSlowestFireDelay;
var float m_fFiringMoveSpeedModifier;
var bool m_bLeftMouseMovePenalty;
var bool m_bInFireLoop;
var bool m_bAltFireSpinning;
var bool m_bHexaFireSpinning;
var(MovePenalty) float m_fMoveSpeedDecreaseInterpolationDuration;
var(MovePenalty) float m_fMoveSpeedIncreaseInterpolationDuration;
var float r_fRecyclerPercent;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fRecyclerPercent;
}

simulated function bool ShouldConsumeAmmo(int nFireRequestID, optional array<ImpactToValidate> Impacts)
{
    local int I;

    // End:0x135
    if(r_fRecyclerPercent > 0.0000000)
    {
        // End:0x128
        if(((Instigator != none) && !Instigator.IsLocallyControlled()) && UsesSimulatedAmmo())
        {
            // End:0x8B
            if((Impacts.Length == 0) && !m_CachedMissedInstantFire)
            {
                ClientSyncAmmoGivenFromServer(-1);                
            }
            else
            {
                // End:0x128
                if((Impacts.Length > 0) && m_CachedMissedInstantFire)
                {
                    I = 0;
                    J0xB5:

                    // End:0x128 [Loop If]
                    if(I < Impacts.Length)
                    {
                        // End:0x11A
                        if(Impacts[I].Impact.HitActor != none)
                        {
                            ClientSyncAmmoGivenFromServer(1);
                            // [Explicit Break]
                            goto J0x128;
                        }
                        ++I;
                        // [Loop Continue]
                        goto J0xB5;
                    }
                }
            }
        }
        J0x128:

        return !m_CachedMissedInstantFire;
    }
    return super(TgDevice).ShouldConsumeAmmo(nFireRequestID);
    //return ReturnValue;    
}

reliable server function SetLeftMouseMovePenalty(bool bLeftMouseMovePenalty)
{
    m_bLeftMouseMovePenalty = bLeftMouseMovePenalty;
    //return;    
}

simulated function Tick(float DeltaTime)
{
    local float fPreFireTimeRemaining, fLocalTimeRemaining;
    local bool bInFireLoop;
    local float spinFactor;
    local TgPawn_Ruckus Ruckus;
    local TgDeviceFire CurrFireMode;
    local TgPlayerController TgPC;
    local bool bLeftMouseDown;

    super(Actor).Tick(DeltaTime);
    bInFireLoop = m_bInFireLoop && !IsReloading();
    // End:0x16A
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        bLeftMouseDown = false;
        Ruckus = TgPawn_Ruckus(Instigator);
        CurrFireMode = GetCurrentFire();
        // End:0x128
        if((Ruckus != none) && CurrFireMode != none)
        {
            TgPC = TgPlayerController(Ruckus.Controller);
            // End:0x128
            if(TgPC != none)
            {
                bLeftMouseDown = TgPC.bPressingLeftMouseButton;
            }
        }
        // End:0x16A
        if(m_bLeftMouseMovePenalty != bLeftMouseDown)
        {
            m_bLeftMouseMovePenalty = bLeftMouseDown;
            SetLeftMouseMovePenalty(m_bLeftMouseMovePenalty);
        }
    }
    // End:0x3B2
    if(((bInFireLoop || m_bAltFireSpinning) || m_bHexaFireSpinning) || m_bLeftMouseMovePenalty && IsReloading())
    {
        // End:0x1E8
        if(m_fDurationToMaxSpin <= 0.0000000)
        {
            m_fSpinAmount += (DeltaTime * m_fMaxSpinRate);            
        }
        else
        {
            m_fSpinAmount += ((DeltaTime * m_fCurrentSpinScale) * m_fMaxSpinRate);
            // End:0x231
            if(m_bHexaFireSpinning)
            {
                SetCurrentSpinScale(1.0000000);                
            }
            else
            {
                SetCurrentSpinScale(FMin(m_fCurrentSpinScale + (DeltaTime / m_fDurationToMaxSpin), 1.0000000));
            }
        }
        // End:0x357
        if(m_bInFireLoop)
        {
            // End:0x357
            if((m_fCurrentSpinScale > 0.0000000) && m_fMaxSpinRate > 0.0000000)
            {
                fPreFireTimeRemaining = GetTimerRate('FirePreHitDelay') - GetTimerCount('FirePreHitDelay');
                // End:0x357
                if(fPreFireTimeRemaining > 0.2000000)
                {
                    spinFactor = m_fStartingSpinRate + ((1.0000000 - m_fStartingSpinRate) * m_fCurrentSpinScale);
                    fLocalTimeRemaining = (1.0000000 - m_fSpinAmount) / (spinFactor * m_fMaxSpinRate);
                    fLocalTimeRemaining = FMax(fLocalTimeRemaining, 0.1000000);
                }
            }
        }
        // End:0x3AF
        if((m_fMoveSpeedDecreaseInterpolationDuration > 0.0000000) && m_fFiringMoveSpeedModifier > 0.0000000)
        {
            m_fFiringMoveSpeedModifier = FMax(m_fFiringMoveSpeedModifier - (DeltaTime / m_fMoveSpeedDecreaseInterpolationDuration), 0.0000000);
        }        
    }
    else
    {
        m_fSpinAmount = 0.0000000;
        SetCurrentSpinScale(FMax(m_fCurrentSpinScale - (DeltaTime * m_fSpinDownRate), 0.0000000));
        // End:0x449
        if((m_fMoveSpeedIncreaseInterpolationDuration > 0.0000000) && m_fFiringMoveSpeedModifier < 1.0000000)
        {
            m_fFiringMoveSpeedModifier = FMin(m_fFiringMoveSpeedModifier + (DeltaTime / m_fMoveSpeedIncreaseInterpolationDuration), 1.0000000);
        }
    }
    //return;    
}

simulated function SetCurrentSpinScale(float fCurrentSpinScale)
{
    local float RefireTime;
    local TgPawn_Ruckus Ruckus;
    local TgGameplayCurves GPCurves;

    m_fCurrentSpinScale = fCurrentSpinScale;
    Ruckus = TgPawn_Ruckus(Instigator);
    // End:0xBA
    if(Ruckus != none)
    {
        Ruckus.r_fBarrelSpinFactor = fCurrentSpinScale;
        Ruckus.r_fBarrelSpinRate = fCurrentSpinScale * m_fMaxSpinRate;
        Ruckus.bNetDirty = true;
    }
    GetCurrentFire().m_fFirePostHitDelay = m_fSlowestFireDelay;
    GPCurves = GetCurrentGameplayCurves();
    // End:0x165
    if(GPCurves != none)
    {
        // End:0x165
        if(GPCurves.GetPrimaryDistributionValueByType(8, m_fCurrentSpinScale, RefireTime))
        {
            GetCurrentFire().m_fFirePostHitDelay = RefireTime;
        }
    }
    //return;    
}

simulated function bool RequireMovementForAimAssist()
{
    return !m_bHexaFireSpinning;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        m_bInFireLoop = true;
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        m_bInFireLoop = false;
        ClearTimer('FirePreHitDelay');
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fStartingSpinRate=0.0010000
    m_fMaxSpinRate=20.0000000
    m_fDurationToMaxSpin=1.0000000
    m_fSpinDownRate=1.0000000
    m_fSlowestFireDelay=0.3000000
    m_fFiringMoveSpeedModifier=1.0000000
    m_fMoveSpeedDecreaseInterpolationDuration=0.5000000
    m_fMoveSpeedIncreaseInterpolationDuration=0.5000000
    m_vProjectileSpawnOffset2=(X=5.0000000,Y=-18.0000000,Z=-7.0000000)
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_bParentAnimComponent1PHead=true
    m_vMeshViewOffset=(X=10.0000000,Y=0.0000000,Z=-3.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=90.0000000
    m_vProjectileSpawnOffset=(X=5.0000000,Y=18.0000000,Z=-7.0000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_RuckusInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Ruckus.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.LightForceFeedback'
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=0.9900000,fMinAccuracy=0.9400000,fAccuracyLossPerShot=0.0050000,fAccuracyGainPerSec=0.3500000,fAccuracyGainDelay=0.2000000)
}