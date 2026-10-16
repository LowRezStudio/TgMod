class TgPlayerCamera extends Camera
    transient
    native(View)
    hidecategories(Navigation);

struct native PropertyDecayState
{
    var float PropertyLevel;
    var float PropertyMax;
    var float LastDecayTimestamp;

    structdefaultproperties
    {
        PropertyLevel=0.0000000
        PropertyMax=0.0000000
        LastDecayTimestamp=0.0000000
    }
};

struct native PropertyDecayParams
{
    var float LambdaImpulse;
    var float LambdaAccumulation;
    var float AccumulationImpulseMix;

    structdefaultproperties
    {
        LambdaImpulse=0.0000000
        LambdaAccumulation=0.0000000
        AccumulationImpulseMix=0.0000000
    }
};

var TgPlayerController PlayerOwner;
var() editinline TgCameraModule CurrentCameraMod;
var Class<TgCameraModule> DefaultCameraModuleClass;
var array<TgCameraModule> CameraModuleList;
var Rotator CamAngle;
var Vector CameraLocationLocalToTarget;
var Quat CameraRotationLocalToTarget;
var bool bTweening;
var bool bInterpolatingFOV;
var bool m_bPlayingHeal;
var float fTweenStart;
var float fTweenDuration;
var TgCameraModule LastCameraMod;
var float fFOVInterpStartTimestamp;
var float fFOVInterpStartValue;
var float fFOVInterpEndTimestamp;
var float fLastAppliedFOV;
var float m_fCollisionTraceExtent;
var TgEmitter_CameraEffect_Bleed m_BleedCameraEffect;
var TgEmitter_CameraEffect_Daze m_DazeCameraEffect;
var TgEmitter_CameraEffect_Fire m_FireCameraEffect;
var TgEmitter_CameraEffect_Freeze m_FreezeCameraEffect;
var TgEmitter_CameraEffect_Heal m_HealCameraEffect;
var TgEmitter_CameraEffect_Knockback m_KnockbackCameraEffect;
var TgEmitter_CameraEffect_Mark m_MarkCameraEffect;
var TgEmitter_CameraEffect_Poison m_PoisonCameraEffect;
var TgEmitter_CameraEffect_Venom m_VenomCameraEffect;
var TgEmitter_CameraEffect_Root m_RootCameraEffect;
var TgEmitter_CameraEffect_Slow m_SlowCameraEffect;
var TgEmitter_CameraEffect_Stun m_StunCameraEffect;
var TgEmitter_CameraEffect_Hidden m_HiddenCameraEffect;
var TgEmitter_CameraEffect_Hidden m_GrassCameraEffect;
var TgEmitter_CameraEffect_Teleport m_TeleportCameraEffect;
var TgEmitter_CameraEffect_PreTeleport m_PreTeleportCameraEffect;
var TgEmitter_CameraEffect_CCImmune m_CCImmuneCameraEffect;
var TgEmitter_CameraEffect_Cripple m_CrippleCameraEffect;
var TgEmitter_CameraEffect_Revealed m_RevealedCameraEffect;
var protected transient array<TgEmitter_CameraEffect> m_CameraEffects;
var int m_nCameraEffectIdCounter;
var Class<TgEmitter_CameraEffect_DamageBase> m_HealthDamageCameraEffectClasses[EDamageEffectScreenLocation];
var Class<TgEmitter_CameraEffect_DamageBase> m_ShieldDamageCameraEffectClasses[EDamageEffectScreenLocation];
var PropertyDecayState m_HealthDamageFXState[EDamageEffectScreenLocation];
var PropertyDecayState m_HealingFXState;
var PropertyDecayParams m_HealthDamageFXParams;
var PropertyDecayParams m_HealingFXParams;
var float m_fAccumulateHealing;
var float m_fSecondsSinceLastHealFXUpdate;
var float m_fHealFXUpdatePeriod;
var float m_fHealingFXHalflifeAccumulation;
var float m_fHealingFXHalflifeImpulse;
var float m_fHealingFXReliefFactor;
var float m_fHealingFXAccumulationMix;
var float m_fHealingFXVisibleThreshold;
var float m_fHealingCritFXThreshold;
var float m_fHealthDamageFXHalflifeAccumulation;
var float m_fHealthDamageFXHalflifeImpulse;
var float m_fHealthDamageFXPainFactor;
var float m_fHealthDamageFXAccumulationMix;
var float m_fHealthDamageCritFXThreshold;
var float m_fHealthDamageCritFXAccumulationMix;

// Export UTgPlayerCamera::execCameraTrace(FFrame&, void* const)
native function CameraTrace(out Vector HitLocation, out Vector HitNormal, Vector End, Vector Start, Actor Target);

// Export UTgPlayerCamera::execCheckPenetration(FFrame&, void* const)
native final function CheckPenetration(Vector CheckLocation, float CheckRadius);

// Export UTgPlayerCamera::execClearPenetrationList(FFrame&, void* const)
native final function ClearPenetrationList();

// Export UTgPlayerCamera::execCheckViewTarget(FFrame&, void* const)
native function CheckViewTarget(out TViewTarget VT);

private final function float LambdaFromHalflife(float fHalflife)
{
    return -((fHalflife <= 0.0001000) ? 99.0000000 : 0.6931500 / fHalflife);
    //return ReturnValue;    
}

function PostBeginPlay()
{
    super.PostBeginPlay();
    m_HealthDamageFXParams.LambdaAccumulation = LambdaFromHalflife(m_fHealthDamageFXHalflifeAccumulation);
    m_HealthDamageFXParams.LambdaImpulse = LambdaFromHalflife(m_fHealthDamageFXHalflifeImpulse);
    m_HealthDamageFXParams.AccumulationImpulseMix = m_fHealthDamageFXAccumulationMix;
    m_HealingFXParams.LambdaAccumulation = LambdaFromHalflife(m_fHealingFXHalflifeAccumulation);
    m_HealingFXParams.LambdaImpulse = LambdaFromHalflife(m_fHealingFXHalflifeImpulse);
    m_HealingFXParams.AccumulationImpulseMix = m_fHealingFXAccumulationMix;
    // End:0x179
    if(CurrentCameraMod == none)
    {
        // End:0x165
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            SwitchCameras(DefaultCameraModuleClass);            
        }
        else
        {
            SwitchCameras(Class'TgGame.TgCameraModule_Server');
        }
    }
    //return;    
}

function InitializeFor(PlayerController PC)
{
    super.InitializeFor(PC);
    PlayerOwner = TgPlayerController(PC);
    // End:0xC9
    if((PlayerOwner != none) && int(PlayerOwner.c_GameWinState) != int(0))
    {
        self.FadeAlpha = vect2d(1.0000000, 1.0000000);
        self.FadeAmount = 1.0000000;
        self.bEnableFading = true;
    }
    //return;    
}

function ResetFOV()
{
    bLockedFOV = false;
    bInterpolatingFOV = false;
    //return;    
}

function SetFOV(float NewFOV)
{
    LockedFOV = NewFOV;
    bLockedFOV = true;
    bInterpolatingFOV = false;
    //return;    
}

function InterpolateFOV(float NewFOV, float InterpolationTime)
{
    // End:0x2F
    if(bLockedFOV)
    {
        fFOVInterpStartValue = LockedFOV;
        bLockedFOV = false;        
    }
    else
    {
        fFOVInterpStartValue = fLastAppliedFOV;
    }
    LockedFOV = NewFOV;
    fFOVInterpStartTimestamp = WorldInfo.TimeSeconds;
    fFOVInterpEndTimestamp = fFOVInterpStartTimestamp + InterpolationTime;
    bInterpolatingFOV = true;
    //return;    
}

function float GetFOVAngle()
{
    // End:0x17
    if(bInterpolatingFOV)
    {
        return fLastAppliedFOV;
    }
    return super.GetFOVAngle();
    //return ReturnValue;    
}

event TgCameraModule SwitchCameras(Class<TgCameraModule> CameraClass, optional float fTweenTime = 0.0000000)
{
    local TgCameraModule module, NewModule;

    // End:0x2B
    if(CameraClass == none)
    {
        CameraClass = DefaultCameraModuleClass;
    }
    // End:0x9A
    if((CurrentCameraMod != none) && CurrentCameraMod.Class == CameraClass)
    {
        CurrentCameraMod.OnBecomeActive(CurrentCameraMod);
        return CurrentCameraMod;
    }
    NewModule = none;
    // End:0xFF
    foreach CameraModuleList(module)
    {
        // End:0xFE
        if(module.Class == CameraClass)
        {
            NewModule = module;            
        }
        else
        {            
        }
    }    
    // End:0x12C
    if(NewModule == none)
    {
        NewModule = CreateCamera(CameraClass);
    }
    // End:0x232
    if(NewModule != none)
    {
        EndLastCameraTween();
        // End:0x1F4
        if(CurrentCameraMod != none)
        {
            CurrentCameraMod.OnBecomeInActive(NewModule);
            LastCameraMod = CurrentCameraMod;
            // End:0x1EA
            if(fTweenTime > float(0))
            {
                bTweening = true;
                fTweenStart = WorldInfo.TimeSeconds;
                fTweenDuration = fTweenTime;                
            }
            else
            {
                EndLastCameraTween();
            }
        }
        NewModule.OnBecomeActive(CurrentCameraMod);
        CurrentCameraMod = NewModule;        
    }
    return CurrentCameraMod;
    //return ReturnValue;    
}

protected function TgCameraModule CreateCamera(Class<TgCameraModule> CameraClass)
{
    local TgCameraModule NewCam;

    NewCam = new (Outer) CameraClass;
    // End:0x8C
    if(NewCam != none)
    {
        NewCam.PlayerCamera = self;
        NewCam.Init();
        CameraModuleList[CameraModuleList.Length] = NewCam;
    }
    return NewCam;
    //return ReturnValue;    
}

function UpdateViewTarget(out TViewTarget OutVT, float DeltaTime)
{
    local CameraActor CamActor;
    local TViewTarget tweenVT;
    local float fTweenPct;
    local TgClientSettings Settings;

    // End:0x66
    if(((PendingViewTarget.Target != none) && OutVT == ViewTarget) && BlendParams.bLockOutgoing)
    {
        return;
    }
    OutVT.POV.FOV = DefaultFOV;
    Settings = PlayerOwner.GetClientSettings();
    // End:0x154
    if(Settings != none)
    {
        bConstrainAspectRatio = true;
        ConstrainedAspectRatio = Settings.GetDesiredAspectRatio();
        // End:0x12E
        if(ConstrainedAspectRatio == 0.0000000)
        {
            ConstrainedAspectRatio = 1.7777800;
        }
        OutVT.AspectRatio = ConstrainedAspectRatio;
    }
    CamActor = CameraActor(OutVT.Target);
    // End:0x2C8
    if(CamActor != none)
    {
        CamActor.GetCameraView(DeltaTime, OutVT.POV);
        OutVT.POV.FOV = (57.2957800 * Atan(Tan((0.0174533 * OutVT.POV.FOV) / 2.0000000) * CamActor.AspectRatio)) * 2.0000000;
        CamOverridePostProcessAlpha = CamActor.CamOverridePostProcessAlpha;
        CamPostProcessSettings = CamActor.CamOverridePostProcess;        
    }
    else
    {
        // End:0x5AB
        if((Pawn(OutVT.Target) == none) || !Pawn(OutVT.Target).CalcCamera(DeltaTime, OutVT.POV.Location, OutVT.POV.Rotation, OutVT.POV.FOV))
        {
            // End:0x5A9
            if(CurrentCameraMod != none)
            {
                tweenVT = OutVT;
                // End:0x4D9
                if((LastCameraMod != none) && bTweening)
                {
                    fTweenPct = ((fTweenDuration > float(0)) ? (WorldInfo.TimeSeconds - fTweenStart) / fTweenDuration : 1.0000000);
                    // End:0x47F
                    if(fTweenPct >= float(1))
                    {
                        EndLastCameraTween();                        
                    }
                    else
                    {
                        LastCameraMod.UpdateCamera(Pawn(tweenVT.Target), self, DeltaTime, tweenVT);
                    }                    
                }
                else
                {
                    // End:0x4FE
                    if((LastCameraMod == none) == bTweening)
                    {
                        EndLastCameraTween();
                    }
                }
                CurrentCameraMod.UpdateCamera(Pawn(OutVT.Target), self, DeltaTime, OutVT);
                // End:0x5A6
                if(LastCameraMod != none)
                {
                    OutVT.POV = BlendViewTargets(tweenVT, OutVT, fTweenPct);
                }                
            }
            else
            {
                return;
            }
        }
    }
    ApplyCameraModifiers(DeltaTime, OutVT.POV);
    //return;    
}

function EndLastCameraTween()
{
    // End:0x2E
    if(LastCameraMod != none)
    {
        LastCameraMod.OnTweenOutEnd();
    }
    LastCameraMod = none;
    bTweening = false;
    //return;    
}

function ProcessInput(PlayerInput PlayerInput, float DeltaTime)
{
    CamAngle.Yaw += int(PlayerInput.aTurn);
    CamAngle.Pitch += int(PlayerInput.aLookUp);
    // End:0xBC
    if(CurrentCameraMod != none)
    {
        CurrentCameraMod.ProcessInput(PlayerInput, DeltaTime);
    }
    //return;    
}

function zoomIn()
{
    CurrentCameraMod.zoomIn();
    //return;    
}

function ZoomOut()
{
    CurrentCameraMod.ZoomOut();
    //return;    
}

simulated event UpdateCamera(float DeltaTime)
{
    local Vector ViewLocation;
    local Rotator ViewRotation;
    local int I;
    local TgPlayerController TgPC;
    local TgPawn TgP;
    local float CamFOV;

    // End:0x4A
    if(WorldInfo.IsPlayingDemo())
    {
        DeltaTime = WorldInfo.m_fRealDeltaSeconds;
    }
    // End:0x343
    if((PCOwner.IsLocalPlayerController() || !bUseClientSideCameraUpdates) || bDebugClientSideCamera)
    {
        DoUpdateCamera(DeltaTime);
        // End:0x241
        if(((int(WorldInfo.NetMode) == int(NM_Client)) && bShouldSendClientSideCameraUpdate) && !WorldInfo.IsPlayingDemo())
        {
            ViewLocation = CameraCache.POV.Location;
            ViewRotation = CameraCache.POV.Rotation;
            // End:0x1C1
            if(TgPlayerController(PCOwner) != none)
            {
                TgPlayerController(PCOwner).GetAimingViewPoint(ViewLocation, ViewRotation);
            }
            PCOwner.ServerUpdateCamera(ViewLocation, (ViewRotation.Pitch & 65535) + ((ViewRotation.Yaw & 65535) << 16));
            bShouldSendClientSideCameraUpdate = false;
        }
        TgPC = TgPlayerController(PCOwner);
        // End:0x343
        if(TgPC != none)
        {
            TgP = TgPC.GetTgPawn();
            // End:0x343
            if(((TgP != none) && TgP.m_WeaponMesh != none) && !TgP.m_WeaponMesh.CanUseCameraBone())
            {
                TgP.m_WeaponMesh.UpdateTransform(DeltaTime, true);
            }
        }
    }
    CamFOV = CameraCache.POV.FOV;
    // End:0x411
    if(m_BleedCameraEffect != none)
    {
        m_BleedCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x4A6
    if(m_DazeCameraEffect != none)
    {
        m_DazeCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x53B
    if(m_FireCameraEffect != none)
    {
        m_FireCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x5D0
    if(m_CCImmuneCameraEffect != none)
    {
        m_CCImmuneCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x665
    if(m_FreezeCameraEffect != none)
    {
        m_FreezeCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x6FA
    if(m_HealCameraEffect != none)
    {
        m_HealCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x78F
    if(m_KnockbackCameraEffect != none)
    {
        m_KnockbackCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x824
    if(m_MarkCameraEffect != none)
    {
        m_MarkCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x8B9
    if(m_TeleportCameraEffect != none)
    {
        m_TeleportCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x94E
    if(m_PreTeleportCameraEffect != none)
    {
        m_PreTeleportCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0x9E3
    if(m_HiddenCameraEffect != none)
    {
        m_HiddenCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0xA78
    if(m_GrassCameraEffect != none)
    {
        m_GrassCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0xB0D
    if(m_PoisonCameraEffect != none)
    {
        m_PoisonCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0xBA2
    if(m_CrippleCameraEffect != none)
    {
        m_CrippleCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0xC37
    if(m_RootCameraEffect != none)
    {
        m_RootCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0xCCC
    if(m_SlowCameraEffect != none)
    {
        m_SlowCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    // End:0xD61
    if(m_RevealedCameraEffect != none)
    {
        m_RevealedCameraEffect.UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
    }
    I = 0;
    J0xD6C:

    // End:0xE55 [Loop If]
    if(I < m_CameraEffects.Length)
    {
        // End:0xDB7
        if(m_CameraEffects[I] == none)
        {
            m_CameraEffects.Remove(I--, 1);            
        }
        else
        {
            m_CameraEffects[I].UpdateLocation(CameraCache.POV.Location, CameraCache.POV.Rotation, CamFOV);
        }
        I++;
        // [Loop Continue]
        goto J0xD6C;
    }
    //return;    
}

// Export UTgPlayerCamera::execGetViewLocalToTarget(FFrame&, void* const)
native function GetViewLocalToTarget(const Actor InViewTarget, out Vector LocalViewLocation, out Quat LocalViewRotation);

// Export UTgPlayerCamera::execUpdateCameraLocalToTarget(FFrame&, void* const)
native final function UpdateCameraLocalToTarget();

function FillCameraCache(const out TPOV NewPOV)
{
    // End:0x76
    if(WorldInfo.IsPlayingDemo() || CameraCache.TimeStamp != WorldInfo.TimeSeconds)
    {
        LastFrameCameraCache = CameraCache;
    }
    CameraCache.TimeStamp = WorldInfo.TimeSeconds;
    CameraCache.POV = NewPOV;
    ApplyFOVModification(CameraCache.POV.FOV);
    UpdateCameraLocalToTarget();
    //return;    
}

function ApplyFOVModification(out float FOV)
{
    local float interpAmt;

    // End:0x128
    if(bInterpolatingFOV)
    {
        // End:0x6B
        if(fFOVInterpEndTimestamp > fFOVInterpStartTimestamp)
        {
            interpAmt = FPctByRange(WorldInfo.TimeSeconds, fFOVInterpStartTimestamp, fFOVInterpEndTimestamp);            
        }
        else
        {
            interpAmt = 1.0000000;
        }
        // End:0xE1
        if(LockedFOV > float(1))
        {
            // End:0xB7
            if(interpAmt > float(1))
            {
                bInterpolatingFOV = false;
                bLockedFOV = true;                
            }
            else
            {
                FOV = Lerp(fFOVInterpStartValue, LockedFOV, interpAmt);
            }            
        }
        else
        {
            // End:0x101
            if(interpAmt > float(1))
            {
                bInterpolatingFOV = false;                
            }
            else
            {
                FOV = Lerp(fFOVInterpStartValue, FOV, interpAmt);
            }
        }
    }
    // End:0x148
    if(bLockedFOV)
    {
        FOV = LockedFOV;
    }
    fLastAppliedFOV = FOV;
    //return;    
}

function float GetFOVInterpZoomPct()
{
    // End:0x13
    if(bLockedFOV)
    {
        return 1.0000000;
    }
    // End:0x28
    if(!bInterpolatingFOV)
    {
        return 0.0000000;
    }
    // End:0xD0
    if(fFOVInterpEndTimestamp > fFOVInterpStartTimestamp)
    {
        // End:0x8E
        if(LockedFOV > float(1))
        {
            return FPctByRange(WorldInfo.TimeSeconds, fFOVInterpStartTimestamp, fFOVInterpEndTimestamp);            
        }
        else
        {
            return 1.0000000 - FPctByRange(WorldInfo.TimeSeconds, fFOVInterpStartTimestamp, fFOVInterpEndTimestamp);
        }
    }
    return ((LockedFOV > float(1)) ? 1.0000000 : 0.0000000);
    //return ReturnValue;    
}

function PlayBleed(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_BleedCameraEffect == none)
        {
            m_BleedCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Bleed', self);
        }
        m_BleedCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_BleedCameraEffect != none)
        {
            m_BleedCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayOnFire(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_FireCameraEffect == none)
        {
            m_FireCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Fire', self);
        }
        m_FireCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_FireCameraEffect != none)
        {
            m_FireCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayFreeze(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_FreezeCameraEffect == none)
        {
            m_FreezeCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Freeze', self);
        }
        m_FreezeCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_FreezeCameraEffect != none)
        {
            m_FreezeCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayCCImmuneEffects(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_CCImmuneCameraEffect == none)
        {
            m_CCImmuneCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_CCImmune', self);
        }
        m_CCImmuneCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_CCImmuneCameraEffect != none)
        {
            m_CCImmuneCameraEffect.Deactivate();
        }
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local float fHealing;

    super(Actor).Tick(DeltaSeconds);
    m_fSecondsSinceLastHealFXUpdate += DeltaSeconds;
    // End:0x97
    if(m_HealCameraEffect == none)
    {
        m_HealCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Heal', self);
        m_HealCameraEffect.Deactivate();
        m_bPlayingHeal = false;
        m_fSecondsSinceLastHealFXUpdate = m_fHealFXUpdatePeriod;
    }
    // End:0x1EC
    if(m_fSecondsSinceLastHealFXUpdate >= m_fHealFXUpdatePeriod)
    {
        m_fSecondsSinceLastHealFXUpdate -= m_fHealFXUpdatePeriod;
        UpdateDecay(m_HealingFXState, m_HealingFXParams, m_fAccumulateHealing);
        fHealing = m_fHealingFXReliefFactor * MixProperty(m_HealingFXState, m_HealingFXParams);
        m_fAccumulateHealing = 0.0000000;
        m_HealCameraEffect.SetHealIntensity(fHealing, fHealing >= m_fHealingCritFXThreshold);
        // End:0x1EC
        if((fHealing > m_fHealingFXVisibleThreshold) != m_bPlayingHeal)
        {
            m_bPlayingHeal = m_bPlayingHeal ^^ true;
            // End:0x1CD
            if(m_bPlayingHeal)
            {
                m_HealCameraEffect.Activate();                
            }
            else
            {
                m_HealCameraEffect.Deactivate();
            }
        }
    }
    //return;    
}

event PlayHeal(float fHealAmount)
{
    m_fAccumulateHealing += fHealAmount;
    //return;    
}

function PlayKnockback(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_KnockbackCameraEffect == none)
        {
            m_KnockbackCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Knockback', self);
        }
        m_KnockbackCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_KnockbackCameraEffect != none)
        {
            m_KnockbackCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayPoisoned(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_PoisonCameraEffect == none)
        {
            m_PoisonCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Poison', self);
        }
        m_PoisonCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_PoisonCameraEffect != none)
        {
            m_PoisonCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayVenom(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_VenomCameraEffect == none)
        {
            m_VenomCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Venom', self);
        }
        m_VenomCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_VenomCameraEffect != none)
        {
            m_VenomCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayCrippled(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_CrippleCameraEffect == none)
        {
            m_CrippleCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Cripple', self);
        }
        m_CrippleCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_CrippleCameraEffect != none)
        {
            m_CrippleCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayRoot(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_RootCameraEffect == none)
        {
            m_RootCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Root', self);
        }
        m_RootCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_RootCameraEffect != none)
        {
            m_RootCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlaySlow(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_SlowCameraEffect == none)
        {
            m_SlowCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Slow', self);
        }
        m_SlowCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_SlowCameraEffect != none)
        {
            m_SlowCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayStun(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_StunCameraEffect == none)
        {
            m_StunCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Stun', self);
        }
        m_StunCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_StunCameraEffect != none)
        {
            m_StunCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayDaze(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_DazeCameraEffect == none)
        {
            m_DazeCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Daze', self);
        }
        m_DazeCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_DazeCameraEffect != none)
        {
            m_DazeCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayMark(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_MarkCameraEffect == none)
        {
            m_MarkCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Mark', self);
        }
        m_MarkCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_MarkCameraEffect != none)
        {
            m_MarkCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayPreTeleportFX()
{
    m_PreTeleportCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_PreTeleport', self);
    m_PreTeleportCameraEffect.Deactivate();
    m_PreTeleportCameraEffect.Activate();
    //return;    
}

function PlayTeleportFx()
{
    m_TeleportCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Teleport', self);
    m_TeleportCameraEffect.Deactivate();
    m_TeleportCameraEffect.Activate();
    //return;    
}

function PlayHidden(bool bEnabled, optional ParticleSystem Template)
{
    // End:0x8A
    if(bEnabled)
    {
        // End:0x40
        if(m_HiddenCameraEffect == none)
        {
            m_HiddenCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Hidden', self);
        }
        m_HiddenCameraEffect.ChangeTemplate(Template);
        m_HiddenCameraEffect.Activate();        
    }
    else
    {
        // End:0xB8
        if(m_HiddenCameraEffect != none)
        {
            m_HiddenCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayGrass(bool bEnabled, optional ParticleSystem Template)
{
    // End:0x8A
    if(bEnabled)
    {
        // End:0x40
        if(m_GrassCameraEffect == none)
        {
            m_GrassCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Hidden', self);
        }
        m_GrassCameraEffect.ChangeTemplate(Template);
        m_GrassCameraEffect.Activate();        
    }
    else
    {
        // End:0xB8
        if(m_GrassCameraEffect != none)
        {
            m_GrassCameraEffect.Deactivate();
        }
    }
    //return;    
}

function PlayRevealed(bool bEnabled)
{
    // End:0x61
    if(bEnabled)
    {
        // End:0x3F
        if(m_RevealedCameraEffect == none)
        {
            m_RevealedCameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect_Revealed', self);
        }
        m_RevealedCameraEffect.Activate();        
    }
    else
    {
        // End:0x8F
        if(m_RevealedCameraEffect != none)
        {
            m_RevealedCameraEffect.Deactivate();
        }
    }
    //return;    
}

event TgEmitter_CameraEffect AddCameraEffect(ParticleSystem Template, optional array<Fx_Sound> SoundList)
{
    local TgEmitter_CameraEffect CameraEffect;
    local Vector2D ViewportSize;
    local Vector Param;

    CameraEffect = Spawn(Class'TgGame.TgEmitter_CameraEffect', self);
    CameraEffect.SetTemplate(Template);
    CameraEffect.SetSoundList(SoundList);
    m_CameraEffects.AddItem(CameraEffect);
    LocalPlayer(PlayerOwner.Player).ViewportClient.GetViewportSize(ViewportSize);
    Param.X = ViewportSize.X;
    Param.Y = ViewportSize.Y;
    CameraEffect.ParticleSystemComponent.SetVectorParameter('ScreenSize', Param);
    CameraEffect.Activate();
    return CameraEffect;
    //return ReturnValue;    
}

event RemoveCameraEffect(TgEmitter_CameraEffect CameraEffect)
{
    m_CameraEffects.RemoveItem(CameraEffect);
    // End:0x97
    if(!CameraEffect.bDeleteMe && !CameraEffect.bPendingDelete)
    {
        CameraEffect.Deactivate();
        CameraEffect.Destroy();
    }
    //return;    
}

function TgEmitter_CameraEffect FindCameraEffect(Class<TgEmitter_CameraEffect> CameraEffectClass)
{
    local TgEmitter_CameraEffect CameraEffect;

    // End:0x75
    foreach m_CameraEffects(CameraEffect)
    {
        // End:0x74
        if(!CameraEffect.bDeleteMe && CameraEffect.Class == CameraEffectClass)
        {            
            return CameraEffect;
        }        
    }    
    return none;
    //return ReturnValue;    
}

private final function PlayDamageCameraEffect(TgEmitter_CameraEffect_DamageBase.EDamageEffectScreenLocation ScreenLocation, float fDamageAmount, bool bCritical)
{
    local TgEmitter_CameraEffect DamageEffect;

    // End:0x124
    if(m_HealthDamageCameraEffectClasses[int(ScreenLocation)] != none)
    {
        DamageEffect = FindCameraEffect(m_HealthDamageCameraEffectClasses[int(ScreenLocation)]);
        // End:0x98
        if(DamageEffect == none)
        {
            DamageEffect = Spawn(m_HealthDamageCameraEffectClasses[int(ScreenLocation)], self);
            m_CameraEffects.AddItem(DamageEffect);
        }
        // End:0x124
        if(DamageEffect != none)
        {
            // End:0x105
            if(TgEmitter_CameraEffect_DamageBase(DamageEffect) != none)
            {
                TgEmitter_CameraEffect_DamageBase(DamageEffect).SetDamageIntensity(fDamageAmount * m_fHealthDamageFXPainFactor, bCritical);
            }
            DamageEffect.Activate();
        }
    }
    //return;    
}

private final function UpdateDecay(out PropertyDecayState PropState, const PropertyDecayParams PropParams, float fPropertyCurrent)
{
    local float fImpulsePrev, fAccumulatedPrev, fTimeNow, fdt, fAccumulated, fImpulse;

    fAccumulated = fPropertyCurrent;
    fImpulse = fPropertyCurrent;
    fImpulsePrev = PropState.PropertyMax;
    fAccumulatedPrev = PropState.PropertyLevel;
    fTimeNow = WorldInfo.TimeSeconds;
    fdt = fTimeNow - PropState.LastDecayTimestamp;
    PropState.LastDecayTimestamp = fTimeNow;
    fAccumulated += (fAccumulatedPrev * Exp(fdt * PropParams.LambdaAccumulation));
    // End:0x190
    if(fImpulse < fImpulsePrev)
    {
        fImpulse = FMax(fImpulse, fImpulsePrev * Exp(fdt * PropParams.LambdaImpulse));
    }
    PropState.PropertyMax = fImpulse;
    PropState.PropertyLevel = fAccumulated;
    //return;    
}

private final function float MixProperty(const PropertyDecayState PropState, const PropertyDecayParams PropParams)
{
    return Lerp(PropState.PropertyMax, PropState.PropertyLevel, PropParams.AccumulationImpulseMix);
    //return ReturnValue;    
}

private final function bool CheckCrit(int ScreenLocation)
{
    local float fAccumulated, fImpulse;

    fImpulse = m_HealthDamageFXState[ScreenLocation].PropertyMax;
    fAccumulated = m_HealthDamageFXState[ScreenLocation].PropertyLevel;
    return Lerp(fImpulse, fAccumulated, m_fHealthDamageCritFXAccumulationMix) >= m_fHealthDamageCritFXThreshold;
    //return ReturnValue;    
}

event TakeHit(Vector Direction, float fDamageAmount, Class<DamageType> DamageType, const out ExtraDamageInfo ExtraInfo, TgPawn.EHitAudioCue eCue)
{
    local float fYaw;
    local Rotator Rot;
    local int ScreenLocation, Prev, Next;
    local TgPawn TgP;
    local Vector LocalDirection;
    local TgCameraShake Shake;
    local Class<TgDamageType> TgDmgType;
    local TgObject.RecoilHitDir RecoilDir;
    local float fDamageIntensity;
    local bool bCritical;

    Rot = CameraCache.POV.Rotation;
    Rot.Pitch = 0;
    Rot.Roll = 0;
    LocalDirection = Direction << Rot;
    fYaw = Atan2(LocalDirection.X, LocalDirection.Y);
    fYaw += (3.1415930 / 4.0000000);
    fYaw /= (3.1415930 / 2.0000000);
    ScreenLocation = (2 * FFloor(fYaw)) % 8;
    ScreenLocation = ((ScreenLocation < 0) ? 8 + ScreenLocation : ScreenLocation);
    Prev = (ScreenLocation - 1) % 8;
    Prev = ((Prev < 0) ? 8 + Prev : Prev);
    Next = (ScreenLocation + 1) % 8;
    Next = ((Next < 0) ? 8 + Next : Next);
    UpdateDecay(m_HealthDamageFXState[ScreenLocation], m_HealthDamageFXParams, fDamageAmount);
    fDamageIntensity = MixProperty(m_HealthDamageFXState[ScreenLocation], m_HealthDamageFXParams);
    bCritical = CheckCrit(ScreenLocation);
    PlayDamageCameraEffect(byte(Prev), fDamageIntensity, bCritical);
    PlayDamageCameraEffect(byte(ScreenLocation), fDamageIntensity, bCritical);
    PlayDamageCameraEffect(byte(Next), fDamageIntensity, bCritical);
    TgDmgType = Class<TgDamageType>(DamageType);
    // End:0x55A
    if(TgDmgType != none)
    {
        Shake = new Class'TgGame.TgCameraShake';
        switch(ScreenLocation)
        {
            // End:0x381
            case 4:
                Shake = TgDmgType.default.m_LeftCameraShake;
                RecoilDir = 2;
                // End:0x55A
                break;
            // End:0x3BC
            case 0:
                Shake = TgDmgType.default.m_RightCameraShake;
                RecoilDir = 3;
                // End:0x55A
                break;
            // End:0x3F8
            case 2:
                Shake = TgDmgType.default.m_ForwardCameraShake;
                RecoilDir = 0;
                // End:0x55A
                break;
            // End:0x434
            case 6:
                Shake = TgDmgType.default.m_BackwardCameraShake;
                RecoilDir = 1;
                // End:0x55A
                break;
            // End:0x470
            case 3:
                Shake = TgDmgType.default.m_ForwardLeftCameraShake;
                RecoilDir = 0;
                // End:0x55A
                break;
            // End:0x4AB
            case 1:
                Shake = TgDmgType.default.m_ForwardRightCameraShake;
                RecoilDir = 0;
                // End:0x55A
                break;
            // End:0x4E7
            case 5:
                Shake = TgDmgType.default.m_BackwardLeftCameraShake;
                RecoilDir = 1;
                // End:0x55A
                break;
            // End:0x523
            case 7:
                Shake = TgDmgType.default.m_BackwardRightCameraShake;
                RecoilDir = 1;
                // End:0x55A
                break;
            // End:0xFFFF
            default:
                Shake = TgDmgType.default.m_ForwardCameraShake;
                RecoilDir = 0;
                break;
        }
    }
    TgP = PlayerOwner.GetTgPawn();
    // End:0x6DB
    if(TgP != none)
    {
        TgP.PlayTakeHit(Direction, int(fDamageAmount), DamageType, ExtraInfo, eCue);
        // End:0x671
        if(Shake != none)
        {
            Shake.m_fShakeScale = FClamp(fDamageAmount / 400.0000000, 0.2500000, 1.0000000);
            PlayerOwner.PlayTgCameraShake(Shake, TgP.Location, self);
        }
        // End:0x6DB
        if(TgP.m_WeaponMesh != none)
        {
            TgP.m_WeaponMesh.PlayHitReaction(RecoilDir, fDamageAmount);
        }
    }
    //return;    
}

defaultproperties
{
    DefaultCameraModuleClass=Class'TgGame.TgCameraModule_ThirdPerson'
    m_fCollisionTraceExtent=24.0000000
    m_HealthDamageCameraEffectClasses[0]=Class'TgGame.TgEmitter_CameraEffect_DamageRight'
    m_HealthDamageCameraEffectClasses[1]=Class'TgGame.TgEmitter_CameraEffect_DamageTopRight'
    m_HealthDamageCameraEffectClasses[2]=Class'TgGame.TgEmitter_CameraEffect_DamageTop'
    m_HealthDamageCameraEffectClasses[3]=Class'TgGame.TgEmitter_CameraEffect_DamageTopLeft'
    m_HealthDamageCameraEffectClasses[4]=Class'TgGame.TgEmitter_CameraEffect_DamageLeft'
    m_HealthDamageCameraEffectClasses[5]=Class'TgGame.TgEmitter_CameraEffect_DamageBottomLeft'
    m_HealthDamageCameraEffectClasses[6]=Class'TgGame.TgEmitter_CameraEffect_DamageBottom'
    m_HealthDamageCameraEffectClasses[7]=Class'TgGame.TgEmitter_CameraEffect_DamageBottomRight'
    m_fHealFXUpdatePeriod=0.1000000
    m_fHealingFXHalflifeAccumulation=0.3500000
    m_fHealingFXHalflifeImpulse=0.6500000
    m_fHealingFXReliefFactor=0.0100000
    m_fHealingFXAccumulationMix=0.1250000
    m_fHealingFXVisibleThreshold=0.2500000
    m_fHealingCritFXThreshold=2.0000000
    m_fHealthDamageFXHalflifeAccumulation=0.6000000
    m_fHealthDamageFXHalflifeImpulse=1.5000000
    m_fHealthDamageFXPainFactor=0.0012500
    m_fHealthDamageFXAccumulationMix=0.4000000
    m_fHealthDamageCritFXThreshold=1000.0000000
    m_fHealthDamageCritFXAccumulationMix=0.2000000
    ConstrainedAspectRatio=1.7777800
    DefaultAspectRatio=1.7777800
}