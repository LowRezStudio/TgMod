class TgDeviceForm extends Object
    native(Devices);

const DEFAULT_FX_RADIUS = 240.0f;

struct native transient ModeData
{
    var init float c_fBuildupTime;
    var init bool c_bContinuousFire;
    var init bool c_FxInstantFire;
    var init name c_nmOffhandAnimationType;
    var init bool c_bScaleFireAnimsWithRefire;
    var init bool c_bInterruptAnimOnRefire;
    var init float c_fEffectRadius;
    var init float c_fMaxRange;
    var init CameraAnim c_WhileFiringCameraAnim;

    structdefaultproperties
    {
        c_fBuildupTime=0.0000000
        c_bContinuousFire=false
        c_FxInstantFire=false
        c_nmOffhandAnimationType="None"
        c_bScaleFireAnimsWithRefire=false
        c_bInterruptAnimOnRefire=false
        c_fEffectRadius=0.0000000
        c_fMaxRange=0.0000000
        c_WhileFiringCameraAnim=none
    }
};

var private native const noexport Pointer VfTable_FCallbackEventDevice;
var TgPawn PawnOwner;
var EquipDeviceInfo c_EquipDeviceInfo;
var int m_nDeviceType;
var TgObject.DeviceTargetMode m_eTargetingMode;
var TgDevice.ETargetingModeStatus c_eTargetingModeStatus;
var bool c_bDeployed;
var bool c_bHandDevice;
var bool c_bDisableDefaultTimelapseRecovery;
var bool c_bIsTransitioningToNewMode;
var bool c_bTargetingModeEnabled;
var bool c_bTargeterInitializedThisTick;
var bool c_bTargeterIsInWorldDPG;
var bool c_bUseInstigatorMesh;
var bool c_bIsInHand;
var bool m_bInitializingAssets;
var bool m_bLoopWhileFiringCameraAnim;
var bool m_bUseImpactFXOverride;
var bool m_bRecoilTimerActive;
var array<AnimSet> c_PawnAnimSetOverrideList;
var array<ModeData> ModeDatas;
var native Pointer m_pAmSetup;
var export editinline MeshComponent c_Mesh;
var export editinline MeshComponent c_AttachedMesh;
var protected export editinline MeshComponent c_ThirdPersonMesh;
var protected export editinline TgSkeletalMeshComponent c_FirstPersonMesh;
var name c_nmMountPoint;
var name FormState;
var int c_nFireMode;
var int c_nEquipSlot;
var float c_fLastReceivedRefireTime;
var int c_nLastFxMode;
var TgSkeletalMeshActor c_TargetingModeMeshIndicator;
var TgSpecialFx c_TargetingModeFx;
var AimData c_TargetingAim;
var int c_nTargetingModeFxId;
var float c_fRemainingTransitionTime;
var float c_fTotalTransitionTime;
var Actor m_LockedTarget;
var ObjectReferencer m_AssetReference;
var Actor m_OwnerActor;
var array<TgAnimNodeBlendByAbilitySimple> m_AbilityBlendList1P;
var array<TgAnimNodeBlendByAbilitySimple> m_AbilityBlendList3P;
var array<TgAnimNodeChannelFire> m_ChannelFireBlendList1P;
var array<TgAnimNodeChannelFire> m_ChannelFireBlendList3P;
var array<TgAnimNodeTargeting> m_TargetingBlendList1P;
var array<TgAnimNodeTargeting> m_TargetingBlendList3P;
var array<TgAnimNodeToggleWithTransition> m_ToggleTransitionNodes1P;
var array<TgAnimNodeToggleWithTransition> m_ToggleTransitionNodes3P;
var array<TgAnimBlendByAmmo> m_AmmoBlendList1P;
var array<TgAnimBlendByAmmo> m_AmmoBlendList3P;
var CameraAnimInst m_WhileFiringCameraAnimInst;
var float m_fWhileFiringCameraAnimBlendInTime;
var float m_fWhileFiringCameraAnimBlendOutTime;
var native const transient Pointer m_RandomShotSpreadStream;
var int m_nLastSetShotSpreadSeed;
var TgGameplayCurves m_GameplayCurves;
var float m_fRecoilTimer;

// Export UTgDeviceForm::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nMode);

// Export UTgDeviceForm::execAttachDevice_DA(FFrame&, void* const)
native function AttachDevice_DA(SkeletalMeshComponent ParentMesh, MeshComponent AttachedMesh, optional name nmSocket);

// Export UTgDeviceForm::execAttachInHandDevice_DA(FFrame&, void* const)
native function bool AttachInHandDevice_DA(bool bFirstPerson);

// Export UTgDeviceForm::execDetachDevice_DA(FFrame&, void* const)
native function DetachDevice_DA(SkeletalMeshComponent ParentMesh, MeshComponent AttachedMesh);

// Export UTgDeviceForm::execDetachInHandDevice_DA(FFrame&, void* const)
native function DetachInHandDevice_DA();

// Export UTgDeviceForm::execInitCameraViewpoint(FFrame&, void* const)
native function InitCameraViewpoint();

// Export UTgDeviceForm::execLogDebugInfo(FFrame&, void* const)
native function bool LogDebugInfo();

// Export UTgDeviceForm::execActivateFxGroup(FFrame&, void* const)
native function ActivateFxGroup(name nmGroup);

// Export UTgDeviceForm::execActivateFxIndependent(FFrame&, void* const)
native function TgSpecialFx ActivateFxIndependent(name nmGroup, optional bool bSkipActivate, optional ParticleChannelContainer PSysChannels);

// Export UTgDeviceForm::execDeactivateFxGroup(FFrame&, void* const)
native function DeactivateFxGroup(name nmGroup);

// Export UTgDeviceForm::execGetFormIndex(FFrame&, void* const)
native function int GetFormIndex();

// Export UTgDeviceForm::execDestruct(FFrame&, void* const)
native function Destruct(Vector vLocation);

// Export UTgDeviceForm::execResetAfterRagDoll(FFrame&, void* const)
native function ResetAfterRagDoll();

// Export UTgDeviceForm::execSpawnSpecialFxIndependent(FFrame&, void* const)
native static function TgSpecialFx SpawnSpecialFxIndependent(int nSpecialFxId, optional ParticleChannelContainer PSysChannels);

// Export UTgDeviceForm::execUpdateTargetingModeStatus(FFrame&, void* const)
native function UpdateTargetingModeStatus(TgDevice.ETargetingModeStatus Status, const out AimData Aim);

// Export UTgDeviceForm::execUpdateTargetingModeStatusForFX(FFrame&, void* const)
native function UpdateTargetingModeStatusForFX(TgSpecialFx Fx, TgDevice.ETargetingModeStatus Status, const out AimData Aim);

// Export UTgDeviceForm::execUpdateTargetingModeLocation(FFrame&, void* const)
native function UpdateTargetingModeLocation(Vector NewLocation, Rotator NewRotation, optional float DistanceScale = 1.0000000);

// Export UTgDeviceForm::execUpdateTargetingList(FFrame&, void* const)
native function UpdateTargetingList(const out array<ImpactInfo> ImpactList);

// Export UTgDeviceForm::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial();

// Export UTgDeviceForm::execUpdateFirstPersonWeaponFOV(FFrame&, void* const)
native function UpdateFirstPersonWeaponFOV(optional Vector2D Resolution);

// Export UTgDeviceForm::execUsesTargetingMode(FFrame&, void* const)
native function bool UsesTargetingMode();

// Export UTgDeviceForm::execCanPlayBasicHitFx(FFrame&, void* const)
native function bool CanPlayBasicHitFx(const TgPawn Target);

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilitySimple asAnimNode;
    local TgAnimNodeChannelFire cfAnimNode;
    local TgAnimNodeTargeting tAnimNode;
    local TgAnimNodeToggleWithTransition twtAnimNode;
    local TgAnimBlendByAmmo bbaAnimNode;

    m_AbilityBlendList3P.Length = 0;
    m_ChannelFireBlendList3P.Length = 0;
    m_TargetingBlendList3P.Length = 0;
    m_ToggleTransitionNodes3P.Length = 0;
    m_AmmoBlendList3P.Length = 0;
    // End:0x73
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xEC
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeChannelFire', cfAnimNode)
    {
        // End:0xEB
        if(int(cfAnimNode.m_EquipPoint) == c_nEquipSlot)
        {
            m_ChannelFireBlendList3P.AddItem(cfAnimNode);
        }        
    }    
    // End:0x166
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeTargeting', tAnimNode)
    {
        // End:0x165
        if(int(tAnimNode.m_EquipPoint) == c_nEquipSlot)
        {
            m_TargetingBlendList3P.AddItem(tAnimNode);
        }        
    }    
    // End:0x215
    if(((c_nEquipSlot >= 2) && c_nEquipSlot <= 4) || c_nEquipSlot == 16)
    {
        // End:0x214
        foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilitySimple', asAnimNode)
        {
            // End:0x213
            if(c_nEquipSlot == int(asAnimNode.m_EqpPoint))
            {
                m_AbilityBlendList3P.AddItem(asAnimNode);
            }            
        }        
    }
    // End:0x260
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeToggleWithTransition', twtAnimNode)
    {
        m_ToggleTransitionNodes3P.AddItem(twtAnimNode);        
    }    
    // End:0x2DA
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByAmmo', bbaAnimNode)
    {
        // End:0x2D9
        if(c_nEquipSlot == int(bbaAnimNode.m_EquipPoint))
        {
            m_AmmoBlendList3P.AddItem(bbaAnimNode);
        }        
    }    
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    local TgAnimNodeBlendByAbilitySimple asAnimNode;
    local TgAnimNodeChannelFire cfAnimNode;
    local TgAnimNodeTargeting tAnimNode;
    local TgAnimNodeToggleWithTransition twtAnimNode;
    local TgAnimBlendByAmmo bbaAnimNode;

    m_AbilityBlendList1P.Length = 0;
    m_ChannelFireBlendList1P.Length = 0;
    m_TargetingBlendList1P.Length = 0;
    m_ToggleTransitionNodes1P.Length = 0;
    m_AmmoBlendList1P.Length = 0;
    // End:0x73
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    // End:0xEC
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeChannelFire', cfAnimNode)
    {
        // End:0xEB
        if(int(cfAnimNode.m_EquipPoint) == c_nEquipSlot)
        {
            m_ChannelFireBlendList1P.AddItem(cfAnimNode);
        }        
    }    
    // End:0x166
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeTargeting', tAnimNode)
    {
        // End:0x165
        if(int(tAnimNode.m_EquipPoint) == c_nEquipSlot)
        {
            m_TargetingBlendList1P.AddItem(tAnimNode);
        }        
    }    
    // End:0x215
    if(((c_nEquipSlot >= 2) && c_nEquipSlot <= 4) || c_nEquipSlot == 16)
    {
        // End:0x214
        foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeBlendByAbilitySimple', asAnimNode)
        {
            // End:0x213
            if(c_nEquipSlot == int(asAnimNode.m_EqpPoint))
            {
                m_AbilityBlendList1P.AddItem(asAnimNode);
            }            
        }        
    }
    // End:0x260
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimNodeToggleWithTransition', twtAnimNode)
    {
        m_ToggleTransitionNodes1P.AddItem(twtAnimNode);        
    }    
    // End:0x2DA
    foreach SkelComp.AllAnimNodes(Class'TgGame.TgAnimBlendByAmmo', bbaAnimNode)
    {
        // End:0x2D9
        if(c_nEquipSlot == int(bbaAnimNode.m_EquipPoint))
        {
            m_AmmoBlendList1P.AddItem(bbaAnimNode);
        }        
    }    
    //return;    
}

simulated function OnReload(float fReloadTime)
{
    //return;    
}

event SetAmmoBlendNodesAmount(int nAmmoAmt, optional bool bTickOnly = false)
{
    local int I;

    I = 0;
    J0x10:

    // End:0xBE [Loop If]
    if(I < m_AmmoBlendList1P.Length)
    {
        // End:0xB0
        if(m_AmmoBlendList1P[I] != none)
        {
            // End:0xB0
            if(!bTickOnly || m_AmmoBlendList1P[I].m_bCheckAmmoPerTick)
            {
                m_AmmoBlendList1P[I].SetAmmoAmt(nAmmoAmt);
            }
        }
        I++;
        // [Loop Continue]
        goto J0x10;
    }
    I = 0;
    J0xC9:

    // End:0x177 [Loop If]
    if(I < m_AmmoBlendList3P.Length)
    {
        // End:0x169
        if(m_AmmoBlendList3P[I] != none)
        {
            // End:0x169
            if(!bTickOnly || m_AmmoBlendList1P[I].m_bCheckAmmoPerTick)
            {
                m_AmmoBlendList3P[I].SetAmmoAmt(nAmmoAmt);
            }
        }
        I++;
        // [Loop Continue]
        goto J0xC9;
    }
    //return;    
}

function SetAbilityBlendNodesActive(bool bActive, bool bOnFire, optional bool bIsInterrupted = false)
{
    local int I;

    I = 0;
    J0x10:

    // End:0x96 [Loop If]
    if(I < m_AbilityBlendList1P.Length)
    {
        // End:0x88
        if(m_AbilityBlendList1P[I] != none)
        {
            m_AbilityBlendList1P[I].SetAbilityFiring(bActive, bOnFire, bIsInterrupted);
        }
        I++;
        // [Loop Continue]
        goto J0x10;
    }
    I = 0;
    J0xA1:

    // End:0x127 [Loop If]
    if(I < m_AbilityBlendList3P.Length)
    {
        // End:0x119
        if(m_AbilityBlendList3P[I] != none)
        {
            m_AbilityBlendList3P[I].SetAbilityFiring(bActive, bOnFire, bIsInterrupted);
        }
        I++;
        // [Loop Continue]
        goto J0xA1;
    }
    //return;    
}

function DisableChannelFireBlendNodes()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x73 [Loop If]
    if(I < m_ChannelFireBlendList1P.Length)
    {
        // End:0x65
        if(m_ChannelFireBlendList1P[I] != none)
        {
            m_ChannelFireBlendList1P[I].EndChannel();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x7E:

    // End:0xE6 [Loop If]
    if(I < m_ChannelFireBlendList3P.Length)
    {
        // End:0xD8
        if(m_ChannelFireBlendList3P[I] != none)
        {
            m_ChannelFireBlendList3P[I].EndChannel();
        }
        I++;
        // [Loop Continue]
        goto J0x7E;
    }
    //return;    
}

event Generic1(optional byte byExtraData)
{
    //return;    
}

event Generic2(optional byte byExtraData)
{
    //return;    
}

event Generic3(optional byte byExtraData)
{
    //return;    
}

event Generic4(optional byte byExtraData)
{
    //return;    
}

event Generic5(optional byte byExtraData)
{
    //return;    
}

event OnCreated()
{
    //return;    
}

event SetSourceArcingBeamEffect(Actor Source)
{
    //return;    
}

event SetTargetArcingBeamEffect(Actor Target)
{
    //return;    
}

event PlayImpactEffects(Vector HitLocation, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional Vector FireOrigin, optional float fHitTraceDistOverride = -1.0000000, optional bool bGenerateUpdatedHitLocation = false)
{
    local Vector NewHitLoc, HitNormal;
    local Actor HitActor;
    local TraceHitInfo HitInfo;
    local AkEvent HitAkEvent;
    local SoundCue HitSoundCue;
    local KActor HitKActor;
    local editinline ParticleSystemComponent ImpactPSC;
    local Rotator aimDirection, FireRot;

    // End:0x2F
    if(PawnOwner == none)
    {
        return;
    }
    // End:0xDC
    if(FireOrigin == vect(0.0000000, 0.0000000, 0.0000000))
    {
        FireOrigin = PawnOwner.Location;
        // End:0xDC
        if(PawnOwner.m_WeaponMesh != none)
        {
            PawnOwner.m_WeaponMesh.GetFiringSocketTransform(FireOrigin, FireRot);
        }
    }
    HitNormal = Normal(FireOrigin - HitLocation);
    // End:0x19B
    if(fHitTraceDistOverride < 0.0000000)
    {
        HitActor = PawnOwner.Trace(NewHitLoc, HitNormal, HitLocation - (HitNormal * float(32)), HitLocation + (HitNormal * float(32)), true,, HitInfo, PawnOwner.1);        
    }
    else
    {
        HitActor = PawnOwner.Trace(NewHitLoc, HitNormal, HitLocation - (((HitNormal * fHitTraceDistOverride) * float(16)) * float(2)), HitLocation, true,, HitInfo, PawnOwner.1);
    }
    // End:0x2B4
    if(bGenerateUpdatedHitLocation)
    {
        // End:0x253
        if(HitActor != none)
        {
            HitLocation = NewHitLoc;
        }
        bSuccessfulHit = (HitActor != none) && HitActor.IsA('TgPawn') || HitActor.IsA('TgDeployable');
    }
    aimDirection = PawnOwner.Rotation;
    aimDirection.Pitch = PawnOwner.m_nSmoothedRemoteViewPitch;
    // End:0x474
    if((((((nEquipSlot == 1) || m_bUseImpactFXOverride) || c_bHandDevice) && ModeDatas[c_nFireMode].c_FxInstantFire) && PawnOwner.m_WeaponMesh != none) && ((HitLocation - FireOrigin) Dot Vector(aimDirection)) > 0.0000000)
    {
        PawnOwner.m_WeaponMesh.PlayTracerEffects(HitLocation, nEquipSlot);
        PawnOwner.m_WeaponMesh.QueueInstantHitImpactEffects(HitLocation, bSuccessfulHit, HitActor, HitNormal, FireOrigin, nEquipSlot);
    }
    // End:0x94D
    if(HitInfo.PhysMaterial != none)
    {
        // End:0x684
        if((((HitActor != none) && TgPawn(HitActor) == none) && TgDeployable(HitActor) == none) && TgProjectile(HitActor) == none)
        {
            // End:0x628
            if(HitInfo.PhysMaterial.DeviceImpactSound != none)
            {
                HitAkEvent = AkEvent(HitInfo.PhysMaterial.DeviceImpactSound);
                HitSoundCue = SoundCue(HitInfo.PhysMaterial.DeviceImpactSound);
                // End:0x5EC
                if(HitAkEvent != none)
                {
                    HitActor.PostAkEvent(HitAkEvent);                    
                }
                else
                {
                    // End:0x628
                    if(HitSoundCue != none)
                    {
                        HitActor.PlaySound(HitSoundCue);
                    }
                }
            }
            HitKActor = KActor(HitActor);
            // End:0x684
            if(HitKActor != none)
            {
                HitKActor.ClientWeaponHitEffects(NewHitLoc, HitNormal);
            }
        }
        // End:0x94D
        if(HitInfo.PhysMaterial.ImpactEffect != none)
        {
            ImpactPSC = new (self) Class'Engine.ParticleSystemComponent';
            ImpactPSC.bAutoActivate = false;
            ImpactPSC.SetTemplate(HitInfo.PhysMaterial.ImpactEffect);
            ImpactPSC.SetAbsolute(true, true, true);
            ImpactPSC.SetTranslation(NewHitLoc);
            ImpactPSC.SetRotation(Rotator(HitNormal));
            // End:0x92D
            if((PawnOwner.WorldInfo != none) && PawnOwner.WorldInfo.MyEmitterPool != none)
            {
                ImpactPSC.__OnSystemFinished__Delegate = PawnOwner.WorldInfo.MyEmitterPool.OnParticleSystemFinished;
                PawnOwner.WorldInfo.MyEmitterPool.AttachComponent(ImpactPSC);
                PawnOwner.WorldInfo.MyEmitterPool.ActiveComponents.AddItem(ImpactPSC);
            }
            ImpactPSC.ActivateSystem(true);
        }
    }
    //return;    
}

simulated function ParticleSystemDone(ParticleSystemComponent PSC)
{
    //return;    
}

event BeginActive()
{
    // End:0x11
    if(PawnOwner == none)
    {
        return;
    }
    GotoFormState('Active');
    PawnOwner.BlendToAnimTreeDeviceType();
    //return;    
}

event BeginDeviceTakingOut(optional bool PlayEquipAnim = true)
{
    // End:0x3D
    if(PawnOwner != none)
    {
        PawnOwner.AddRemoveAnimSetList(c_PawnAnimSetOverrideList, true);
    }
    DeactivateFxGroup('Activation');
    ActivateFxGroup('Activation');
    AttachAndDeploy_DA();
    c_bIsInHand = true;
    BeginActive();
    //return;    
}

function EndDevicePuttingDown()
{
    GotoFormState('DeviceOutOfHand');
    DeactivateFxGroup('Activation');
    DetachInHandDevice_DA();
    c_bIsInHand = false;
    //return;    
}

// Export UTgDeviceForm::execInitializeTargetingModeFX(FFrame&, void* const)
native function InitializeTargetingModeFX();

simulated event EnterTargetingMode()
{
    // End:0x19
    if(!c_bTargetingModeEnabled)
    {
        NotifyEnterTargetingMode();
    }
    c_bTargetingModeEnabled = true;
    c_bDeployed = false;
    // End:0xA6
    if(c_Mesh != none)
    {
        // End:0x6A
        if((c_TargetingModeFx == none) || c_TargetingModeMeshIndicator == none)
        {
            InitializeTargetingModeFX();
        }
        // End:0xA6
        if((c_TargetingModeFx != none) && c_TargetingModeMeshIndicator != none)
        {
            UpdateTargetingModeStatus(c_eTargetingModeStatus, c_TargetingAim);
        }
    }
    // End:0xD5
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormEnteredTargetingMode(self);
    }
    //return;    
}

simulated event NotifyExitTargetingMode(bool bDeployed)
{
    //return;    
}

simulated event NotifyEnterTargetingMode()
{
    //return;    
}

simulated event NotifyTargetingModeStatusChange()
{
    //return;    
}

simulated event ExitTargetingMode()
{
    // End:0x21
    if(c_bTargetingModeEnabled)
    {
        NotifyExitTargetingMode(c_bDeployed);
    }
    c_bTargetingModeEnabled = false;
    c_bDeployed = false;
    c_eTargetingModeStatus = 0;
    // End:0x9E
    if(c_TargetingModeFx != none)
    {
        c_TargetingModeFx.Deactivate(true);
        c_TargetingModeFx.Detach();
        c_TargetingModeFx = none;
    }
    // End:0xD0
    if(c_TargetingModeMeshIndicator != none)
    {
        c_TargetingModeMeshIndicator.Destroy();
        c_TargetingModeMeshIndicator = none;
    }
    // End:0xFF
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormExitedTargetingMode(self);
    }
    //return;    
}

event EnterTargeting()
{
    // End:0x72
    if((PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
    {
        PawnOwner.m_WeaponMesh.PlayTargetingEffects(c_nEquipSlot);
    }
    //return;    
}

event InterruptTargeting()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xAD [Loop If]
    if(I < m_TargetingBlendList1P.Length)
    {
        // End:0x9F
        if((m_TargetingBlendList1P[I] != none) && int(m_TargetingBlendList1P[I].m_EquipPoint) == c_nEquipSlot)
        {
            m_TargetingBlendList1P[I].InterruptTargeting();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0xB8:

    // End:0x15A [Loop If]
    if(I < m_TargetingBlendList3P.Length)
    {
        // End:0x14C
        if((m_TargetingBlendList3P[I] != none) && int(m_TargetingBlendList3P[I].m_EquipPoint) == c_nEquipSlot)
        {
            m_TargetingBlendList3P[I].InterruptTargeting();
        }
        I++;
        // [Loop Continue]
        goto J0xB8;
    }
    //return;    
}

event FireHoldFull(bool bIsFull)
{
    // End:0x12C
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        // End:0xD7
        if(bIsFull)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('FireHoldFull', 0);            
        }
        else
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('FireHoldFull', 0);
        }
    }
    //return;    
}

event BuildUp(int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional float fBuildupTime = 0.0000000)
{
    local AnimSequence FullBodyAnimSeq;

    GotoFormState('DeviceBuildup');
    // End:0x8F
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormBuildup(c_nEquipSlot, fBuildupTime);
        PawnOwner.AddRemoveAnimSetList(c_PawnAnimSetOverrideList, true);
    }
    ActivateFxGroup('BuildUp');
    c_nLastFxMode = c_nFireMode;
    // End:0x1C3
    if(PawnOwner != none)
    {
        // End:0x1C3
        if(ModeDatas[c_nFireMode].c_nmOffhandAnimationType != 'None')
        {
            FullBodyAnimSeq = PawnOwner.Mesh.FindAnimSequence(ModeDatas[c_nFireMode].c_nmOffhandAnimationType);
            // End:0x1C3
            if(FullBodyAnimSeq != none)
            {
                PawnOwner.PlayFullBodyAnim(ModeDatas[c_nFireMode].c_nmOffhandAnimationType, 1.0000000, 0.2000000, 0.2000000, false, true);
            }
        }
    }
    //return;    
}

simulated function TgDeviceForm InHandWeaponForm()
{
    // End:0x7A
    if((PawnOwner != none) && int(PawnOwner.m_eEquippedInHand) != int(0))
    {
        return PawnOwner.c_EquipForm[int(PawnOwner.m_eEquippedInHand)];
    }
    return none;
    //return ReturnValue;    
}

simulated event bool IsCurrentInHandWeapon()
{
    // End:0x83
    if(((PawnOwner != none) && int(PawnOwner.m_eEquippedInHand) != int(0)) && PawnOwner.c_EquipForm[int(PawnOwner.m_eEquippedInHand)] == self)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local PlayerController PC;
    local int I;

    SetAbilityBlendNodesActive(true, false);
    SetAmmoBlendNodesAmount(nAmmoRemaining);
    DeactivateFxGroup('StartFire');
    ActivateFxGroup('StartFire');
    m_LockedTarget = Target;
    // End:0x76
    if(UsesTargetingMode())
    {
        c_bDeployed = true;
    }
    GotoFormState('DeviceFiring');
    // End:0x158
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormStartFire(c_nEquipSlot, fRefireTime, nFireMode, nAmmoRemaining);
        // End:0x113
        if(!c_bHandDevice)
        {
            PawnOwner.AddRemoveAnimSetList(c_PawnAnimSetOverrideList, true);
        }
        PC = PawnOwner.GetALocalPlayerController();
        StartWhileFiringCameraAnim(PC, nFireMode);
    }
    c_nLastFxMode = c_nFireMode;
    c_fLastReceivedRefireTime = fRefireTime;
    I = 0;
    J0x189:

    // End:0x22B [Loop If]
    if(I < m_TargetingBlendList1P.Length)
    {
        // End:0x21D
        if((m_TargetingBlendList1P[I] != none) && int(m_TargetingBlendList1P[I].m_EquipPoint) == c_nEquipSlot)
        {
            m_TargetingBlendList1P[I].EndTargeting();
        }
        I++;
        // [Loop Continue]
        goto J0x189;
    }
    I = 0;
    J0x236:

    // End:0x2D8 [Loop If]
    if(I < m_TargetingBlendList3P.Length)
    {
        // End:0x2CA
        if((m_TargetingBlendList3P[I] != none) && int(m_TargetingBlendList3P[I].m_EquipPoint) == c_nEquipSlot)
        {
            m_TargetingBlendList3P[I].EndTargeting();
        }
        I++;
        // [Loop Continue]
        goto J0x236;
    }
    m_bRecoilTimerActive = true;
    //return;    
}

function StartWhileFiringCameraAnim(PlayerController PC, optional int nFireMode = 0)
{
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(PC);
    // End:0x1C7
    if((((((PC != none) && !PC.IsSpectating()) && PawnOwner != none) && ((TgPC == none) && PC.Pawn == PawnOwner) || (TgPC != none) && TgPC.GetTgPawn() == PawnOwner) && PC.PlayerCamera != none) && ModeDatas[nFireMode].c_WhileFiringCameraAnim != none)
    {
        m_WhileFiringCameraAnimInst = PC.PlayerCamera.PlayCameraAnim(ModeDatas[nFireMode].c_WhileFiringCameraAnim, 1.0000000, 1.0000000, m_fWhileFiringCameraAnimBlendInTime, m_fWhileFiringCameraAnimBlendOutTime, m_bLoopWhileFiringCameraAnim);
    }
    //return;    
}

event StopWhileFiringCameraAnim(PlayerController PC, bool bImmediate)
{
    // End:0x8D
    if(((m_WhileFiringCameraAnimInst != none) && PC != none) && PC.PlayerCamera != none)
    {
        PC.PlayerCamera.StopCameraAnim(m_WhileFiringCameraAnimInst, bImmediate);
    }
    //return;    
}

function OnEndViewTarget(PlayerController PC)
{
    StopWhileFiringCameraAnim(PC, true);
    //return;    
}

event StopFire(int nFireModeNum)
{
    SetAbilityBlendNodesActive(false, false);
    DisableChannelFireBlendNodes();
    // End:0x26
    if(c_Mesh != none)
    {
    }
    DeactivateFxGroup('StopFire');
    ActivateFxGroup('StopFire');
    // End:0xD7
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormStopFire(c_nEquipSlot);
        // End:0xAD
        if(FormState == 'DeviceFiring')
        {
            GotoFormState('Active');
        }
        StopWhileFiringCameraAnim(PawnOwner.GetALocalPlayerController(), false);
    }
    m_LockedTarget = none;
    // End:0x10A
    if(m_bRecoilTimerActive)
    {
        m_fRecoilTimer = 0.0000000;
        m_bRecoilTimerActive = false;
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    // End:0x89
    if((HitLocation != vect(0.0000000, 0.0000000, 0.0000000)) && ModeDatas[c_nFireMode].c_FxInstantFire)
    {
        PlayImpactEffects(HitLocation, nEquipSlot, nSocketIndex, bSuccessfulHit);
    }
    SetAbilityBlendNodesActive(true, true, true);
    // End:0xDF
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormFire(c_nEquipSlot, fRefireTime, nFireMode);
    }
    //return;    
}

event FireMulti(Vector vAimStart, Vector vAimDir, int nFireMode, const out byte hitRanges[20], float fMaxRange, int nSeed, float fSpreadAngle, int nNumShots, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local array<Vector> vHitLocations;
    local float fDistUnit;

    fDistUnit = fMaxRange / 255.0000000;
    RecoverFireMultiHitLocations(vHitLocations, vAimStart, vAimDir, hitRanges, fDistUnit, nSeed, fSpreadAngle, nNumShots);
    FireMultiUnpacked(vHitLocations, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime, fDistUnit);
    //return;    
}

event FireMultiUnpacked(array<Vector> vHitLocations, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime, optional float fPackedDistanceUnit = 0.0000000)
{
    local int I;

    // End:0xA2
    if(fPackedDistanceUnit > 0.0000000)
    {
        I = 0;
        J0x37:

        // End:0x9F [Loop If]
        if(I < vHitLocations.Length)
        {
            PlayImpactEffects(vHitLocations[I], nEquipSlot, nSocketIndex,,, fPackedDistanceUnit * 2.0000000, true);
            I++;
            // [Loop Continue]
            goto J0x37;
        }        
    }
    else
    {
        I = 0;
        J0xAD:

        // End:0x10F [Loop If]
        if(I < vHitLocations.Length)
        {
            PlayImpactEffects(vHitLocations[I], nEquipSlot, nSocketIndex, bSuccessfulHit);
            I++;
            // [Loop Continue]
            goto J0xAD;
        }
    }
    // End:0x158
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormFire(c_nEquipSlot, fRefireTime, nFireMode);
    }
    //return;    
}

// Export UTgDeviceForm::execRecoverFireMultiHitLocations(FFrame&, void* const)
native function RecoverFireMultiHitLocations(out array<Vector> vHitLocations, const out Vector vAimStart, const out Vector vAimDir, const out byte hitRanges[20], float fDistUnit, int nSeed, float fSpreadAngle, int nNumShots);

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    local TgSpectatorController Spectator;
    local Actor ViewTarget;
    local TgPlayerController PC;
    local bool bOwnerLocalPlayer, bTargetLocalPlayer;
    local TgPawn TargetPawn;
    local TgDeployable TargetDeployable;

    // End:0x410
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormHit(c_nEquipSlot, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
        PC = TgPlayerController(PawnOwner.GetALocalPlayerController());
        // End:0x10E
        if((PC != none) && PC.GetTgPawn() == PawnOwner)
        {
            PC.ShowHit(Target, fDamageAmount, ExtraInfo);
        }
        TargetPawn = TgPawn(Target);
        // End:0x3B4
        if((TargetPawn != none) && CanPlayBasicHitFx(TargetPawn))
        {
            Spectator = none;
            // End:0x1C5
            if(PawnOwner.WorldInfo.IsPlayingDemo())
            {
                Spectator = TgSpectatorController(PawnOwner.GetALocalPlayerController());
            }
            // End:0x260
            if(Spectator != none)
            {
                ViewTarget = Spectator.GetViewTarget();
                // End:0x25D
                if((ViewTarget != none) && (ViewTarget == PawnOwner) || ViewTarget == TargetPawn)
                {
                    TargetPawn.PlayHitReactionMaterialPulse();
                }                
            }
            else
            {
                bOwnerLocalPlayer = (PawnOwner.Controller != none) && PawnOwner.Controller.IsLocalPlayerController();
                bTargetLocalPlayer = (TargetPawn.Controller != none) && TargetPawn.Controller.IsLocalPlayerController();
                // End:0x365
                if(bOwnerLocalPlayer || bTargetLocalPlayer)
                {
                    TargetPawn.PlayHitReactionMaterialPulse();
                }
                TargetPawn.PlayGenericTakeHit(HitLocation, HitNormal, PawnOwner, fDamageAmount, ExtraInfo);
            }            
        }
        else
        {
            TargetDeployable = TgDeployable(Target);
            // End:0x410
            if(TargetDeployable != none)
            {
                TargetDeployable.PlayGenericTakeHit(HitLocation, HitNormal);
            }
        }
    }
    //return;    
}

event Cooldown(int nFireModeNum)
{
    GotoFormState('DeviceCoolDown');
    ActivateFxGroup('Cooldown');
    c_nLastFxMode = c_nFireMode;
    //return;    
}

event CooldownComplete()
{
    // End:0x24
    if((c_bHandDevice == true) && (IsCurrentInHandWeapon()) == false)
    {
        return;
    }
    BeginActive();
    //return;    
}

event DoInterrupt()
{
    BeginActive();
    // End:0x41
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormInterruptFire(c_nEquipSlot);
    }
    SetAbilityBlendNodesActive(false, false, true);
    //return;    
}

event DeviceAnimNotify()
{
    // End:0x21
    if(FormState == 'DeviceTakingOut')
    {
        AttachAndDeploy_DA();
    }
    //return;    
}

simulated event AttachAndDeploy_DA()
{
    // End:0x38
    if(PawnOwner != none)
    {
        AttachInHandDevice_DA(PawnOwner.IsFirstPerson());
    }
    //return;    
}

simulated function EndCurrentState()
{
    // End:0x2D
    if(FormState == 'DeviceCoolDown')
    {
        DeactivateFxGroup('Cooldown');        
    }
    else
    {
        // End:0x5A
        if(FormState == 'DeviceModeEquipping')
        {
            DeactivateFxGroup('EquipMode');            
        }
        else
        {
            // End:0x84
            if(FormState == 'DeviceBuildup')
            {
                DeactivateFxGroup('BuildUp');
            }
        }
    }
    //return;    
}

simulated event GotoFormState(name NewState)
{
    // End:0x98
    if(NewState != FormState)
    {
        EndCurrentState();
        FormState = NewState;
        // End:0x98
        if(((PawnOwner != none) && c_nEquipSlot > 0) && c_nEquipSlot < 33)
        {
            PawnOwner.c_EquipFormState[c_nEquipSlot] = NewState;
        }
    }
    //return;    
}

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x8F [Loop If]
    if(I < m_ToggleTransitionNodes1P.Length)
    {
        // End:0x81
        if(m_ToggleTransitionNodes1P[I] != none)
        {
            m_ToggleTransitionNodes1P[I].StartTransition(transitionPercent, totalTransitionTime, transitionToActive);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x9A:

    // End:0x11E [Loop If]
    if(I < m_ToggleTransitionNodes3P.Length)
    {
        // End:0x110
        if(m_ToggleTransitionNodes3P[I] != none)
        {
            m_ToggleTransitionNodes3P[I].StartTransition(transitionPercent, totalTransitionTime, transitionToActive);
        }
        I++;
        // [Loop Continue]
        goto J0x9A;
    }
    //return;    
}

simulated event SetToggleState(bool IsActive)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x7D [Loop If]
    if(I < m_ToggleTransitionNodes1P.Length)
    {
        // End:0x6F
        if(m_ToggleTransitionNodes1P[I] != none)
        {
            m_ToggleTransitionNodes1P[I].SetToggleState(IsActive);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    I = 0;
    J0x88:

    // End:0xFA [Loop If]
    if(I < m_ToggleTransitionNodes3P.Length)
    {
        // End:0xEC
        if(m_ToggleTransitionNodes3P[I] != none)
        {
            m_ToggleTransitionNodes3P[I].SetToggleState(IsActive);
        }
        I++;
        // [Loop Continue]
        goto J0x88;
    }
    //return;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    // End:0x0F
    if(c_bDisableDefaultTimelapseRecovery)
    {
        return;
    }
    // End:0x5D
    if((int(DesiredState) == int(1)) && FormState != 'DeviceFiring')
    {
        StartFire(c_nLastFxMode, c_fLastReceivedRefireTime);        
    }
    else
    {
        // End:0xA7
        if((int(DesiredState) == int(0)) && FormState == 'DeviceFiring')
        {
            DoInterrupt();
            StopFire(c_nLastFxMode);
        }
    }
    //return;    
}

simulated event OnRetrieveAnimDone()
{
    //return;    
}

simulated event OnDestroyed()
{
    //return;    
}

defaultproperties
{
    c_fTotalTransitionTime=0.5000000
    m_fWhileFiringCameraAnimBlendInTime=0.2000000
    m_fWhileFiringCameraAnimBlendOutTime=0.2000000
}