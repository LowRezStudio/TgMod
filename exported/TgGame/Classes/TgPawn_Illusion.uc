class TgPawn_Illusion extends TgPawn_Ying
    native(ChampYing)
    config(Game)
    hidecategories(Navigation)
    implements(TgInterface_YingIllusion);

const MAX_ILLUSION_TARGETS = 2;
const HEAL_BEAM_FX_ID = 7224;

enum EDecoyAIState
{
    DAIS_Normal,                    // 0
    DAIS_Shatter,                   // 1
    DAIS_Rift,                      // 2
    DAIS_MAX                        // 3
};

var private native const noexport Pointer VfTable_ITgInterface_YingIllusion;
var TgPawn_Illusion.EDecoyAIState m_eAIState;
var repnotify TgObject.INITIALIZEABLE_BOOL r_eLifelike;
var float m_fDamageScale;
var float m_fDamageAccumulator;
var float m_fDamageAccumulatorReductionRatePerSec;
var float m_fFlickerDamageMin;
var float m_fFlickerDamageMax;
var float m_fDamageAccumulatorCap;
var float m_fPrevFrameHealth;
var const float m_fTimedDestroyedFXDuration;
var const float m_fTimedDestroyedFXMeshHiddenTime;
var const float m_fEarlyShatterRecheckTime;
var const bool m_bCanShatterEarly;
var bool m_bUsingReplacementMIC;
var bool m_bSpringBloomFlag;
var bool c_BeamsCreated;
var repnotify float r_fShatterDelay;
var TgDevice m_CachedShatterDevice;
var array<MaterialInstanceConstant> m_replacementMICs;
var array<MaterialInstanceConstant> m_headReplacementMICs;
var array<MaterialInstanceConstant> m_weaponReplacementMICs;
var const MaterialInstanceConstant m_ShatterMaterialLocal;
var const MaterialInstanceConstant m_ShatterMaterialFriendly;
var const MaterialInstanceConstant m_ShatterMaterialEnemy;
var const MaterialInstanceConstant m_HitMaterialLocal;
var const MaterialInstanceConstant m_HitMaterialFriendly;
var const MaterialInstanceConstant m_HitMaterialEnemy;
var const MaterialInstanceConstant m_DestroyMaterialLocal;
var const MaterialInstanceConstant m_DestroyMaterialFriendly;
var const MaterialInstanceConstant m_DestroyMaterialEnemy;
var array< delegate<DestroyedEvent> > s_OnDeathDelegates;
var repnotify TgPawn_Character r_Targets[2];
var array<TgBeamHelper> c_Beams;
var repnotify int r_nBeamSpawnIterator;
//var delegate<DestroyedEvent> __DestroyedEvent__Delegate;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_Targets, r_fShatterDelay;

    // Pos:0x020
    if(((int(Role) == int(ROLE_Authority)) && bNetDirty) && (!bNetOwner || bDemoRecording) || bNetTimelapse)
        r_eLifelike, r_nBeamSpawnIterator;
}

delegate DestroyedEvent(Actor destroyedActor)
{
    //return;    
}

// Export UTgPawn_Illusion::execSetPetOwner(FFrame&, void* const)
native function SetPetOwner(TgPawn petOwner);

// Export UTgPawn_Illusion::execSpawnGuard(FFrame&, void* const)
native function SpawnGuard();

// Export UTgPawn_Illusion::execDropHealthNugget(FFrame&, void* const)
native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_Illusion::execDropHealthNuggetTeamOnly(FFrame&, void* const)
native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_Illusion::execInitializeInhandWeapon(FFrame&, void* const)
native function InitializeInhandWeapon(int DeviceID);

// Export UTgPawn_Illusion::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_Illusion::execDeviceOnHit(FFrame&, void* const)
native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);

// Export UTgPawn_Illusion::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_Illusion::execReplaceMaterial(FFrame&, void* const)
native function ReplaceMaterial(MaterialInstanceConstant materialToUse, optional float ParamValue = 0.0000000);

// Export UTgPawn_Illusion::execClearReplacementMaterial(FFrame&, void* const)
native function ClearReplacementMaterial();

// Export UTgPawn_Illusion::execReplaceWithShatterMaterial(FFrame&, void* const)
native function ReplaceWithShatterMaterial();

// Export UTgPawn_Illusion::execReplaceWithHitOverlayMaterial(FFrame&, void* const)
native function ReplaceWithHitOverlayMaterial();

// Export UTgPawn_Illusion::execReplaceWithDestroyedMaterial(FFrame&, void* const)
native function ReplaceWithDestroyedMaterial();

// Export UTgPawn_Illusion::execCheckEarlyShatter(FFrame&, void* const)
native function CheckEarlyShatter();

// Export UTgPawn_Illusion::execIsStatTrackable(FFrame&, void* const)
native function bool IsStatTrackable();

// Export UTgPawn_Illusion::execShouldPawnMeshBeHiddenThisTick(FFrame&, void* const)
native function bool ShouldPawnMeshBeHiddenThisTick();

// Export UTgPawn_Illusion::execShouldInHandDeviceBeHiddenThisTick(FFrame&, void* const)
native function bool ShouldInHandDeviceBeHiddenThisTick();

// Export UTgPawn_Illusion::execIsNonCombat(FFrame&, void* const)
native function bool IsNonCombat();

simulated event ReplicatedEvent(name VarName)
{
    switch(VarName)
    {
        // End:0x7D
        case 'r_fShatterDelay':
            // End:0x7A
            if(((r_fShatterDelay > float(0)) && r_Owner != none) && !r_Owner.IsLocallyControlled())
            {
                TriggerShatter(r_fShatterDelay);
            }
            // End:0xFE
            break;
        // End:0x96
        case 'r_eLifelike':
            ConsiderCreateBeams();
            // End:0xFE
            break;
        // End:0xB9
        case 'r_Targets':
            ConsiderCreateBeams();
            UpdateBeamAttachments();
            // End:0xFE
            break;
        // End:0xE8
        case 'r_nBeamSpawnIterator':
            c_BeamsCreated = false;
            ConsiderCreateBeams();
            UpdateBeamAttachments();
            // End:0xFE
            break;
        // End:0xFFFF
        default:
            super(TgPawn_Character).ReplicatedEvent(VarName);
            break;
    }
    //return;    
}

simulated event UpdateWeaponMesh()
{
    super(TgPawn).UpdateWeaponMesh();
    // End:0x4A
    if(m_WeaponMesh != none)
    {
        m_WeaponMesh.SetFireLoopDisplayGroup('FireLoopB', 'FireLoopTailSound');
    }
    //return;    
}

event bool ShouldScoreKill()
{
    return false;
    //return ReturnValue;    
}

simulated function PlayInitialSpawnFX()
{
    // End:0x37
    if(r_fIntroTime > float(0))
    {
        SetMeshVisibility(false);
        FxActivateGroupSelf('RiftIllusionSpawned', 0, 0, 0, true);        
    }
    else
    {
        FxActivateGroupSelf('IllusionSpawned', 0, 0, 0, true);
    }
    //return;    
}

simulated event ConsiderCreateBeams()
{
    // End:0x0F
    if(c_BeamsCreated)
    {
        return;
    }
    // End:0x45
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        CreateBeams();        
    }
    else
    {
        // End:0x63
        if(int(r_eLifelike) != int(0))
        {
            CreateBeams();
        }
    }
    //return;    
}

simulated event UpdateBeamAttachments()
{
    local int I;

    // End:0xF5
    if((m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh3P != none)
    {
        I = 0;
        J0x40:

        // End:0xF2 [Loop If]
        if(I < (GetNumNeededBeams()))
        {
            c_Beams[I].AttachToMesh(m_WeaponMesh.m_WeaponMesh3P, 'WSO_Emit_01');
            c_Beams[I].AttachToTarget(r_Targets[I]);
            I++;
            // [Loop Continue]
            goto J0x40;
        }        
    }
    else
    {
        I = 0;
        J0x100:

        // End:0x162 [Loop If]
        if(I < (GetNumNeededBeams()))
        {
            c_Beams[I].AttachToTarget(r_Targets[I]);
            I++;
            // [Loop Continue]
            goto J0x100;
        }
    }
    //return;    
}

simulated function CreateBeams()
{
    local int I;
    local TgBeamHelper Beam;

    // End:0x157
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        c_Beams.Length = 0;
        I = 0;
        J0x40:

        // End:0x157 [Loop If]
        if(I < (GetNumNeededBeams()))
        {
            Beam = Class'TgGame.TgBeamHelper'.static.Create(7224);
            Beam.AttachToMesh(m_WeaponMesh.m_WeaponMesh3P, 'WSO_Emit_01');
            Beam.Activate();
            Beam.m_bRequiresTarget = true;
            Beam.SetVisible(true);
            c_Beams[I] = Beam;
            I++;
            // [Loop Continue]
            goto J0x40;
        }
    }
    c_BeamsCreated = true;
    //return;    
}

simulated function int GetNumNeededBeams()
{
    // End:0x1A
    if(int(r_eLifelike) == int(2))
    {
        return 2;        
    }
    else
    {
        return 1;
    }
    //return ReturnValue;    
}

simulated function PlayDyingEffects()
{
    local Vector FXLocation;
    local Rotator FXRotation;
    local TgSpecialFx DyingSpecialFX;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    SetTimer(2.0000000, false, 'FindNewTargetTimer');
    // End:0x336
    if(Mesh != none)
    {
        Mesh.FxDeactivateGroup('IllusionShatterTrail', 0);
        Mesh.FxDeactivateGroup('WhileAlive', 0);
        // End:0x1DF
        if((int(r_eDeathReason) == int(1)) || r_bHasCompensate)
        {
            DyingSpecialFX = TgSpecialFx(Mesh.FxGet('IllusionShattered', 0));
            // End:0x1D0
            if(DyingSpecialFX != none)
            {
                // End:0x18F
                if(!Mesh.GetSocketWorldLocationAndRotation(DyingSpecialFX.c_nmSocket, FXLocation, FXRotation))
                {
                    FXLocation = Location;
                    FXRotation = Rotation;
                }
                Mesh.FxActivateIndependant('IllusionShattered', 0, FXLocation, Vector(FXRotation));
            }
            c_bMeshHiddenDueToDeath = true;            
        }
        else
        {
            SetPhysics(4);
            SetProperty(32, (GetPropCurrentValue(32)) + float(1));
            DyingSpecialFX = TgSpecialFx(Mesh.FxGet('IllusionDestroyed', 0));
            // End:0x336
            if(DyingSpecialFX != none)
            {
                // End:0x2CA
                if(!Mesh.GetSocketWorldLocationAndRotation(DyingSpecialFX.c_nmSocket, FXLocation, FXRotation))
                {
                    FXLocation = Location;
                    FXRotation = Rotation;
                }
                Mesh.FxActivateIndependant('IllusionDestroyed', 0, FXLocation, Vector(FXRotation));
                PlayDeathAnimation();
                ReplaceWithDestroyedMaterial();
                SetTimer(m_fTimedDestroyedFXDuration, false, 'TimedDestroyedFX');
            }
        }
    }
    // End:0x3AB
    if((m_WeaponMesh != none) && m_WeaponMesh.m_WeaponMesh3P != none)
    {
        m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MirrorActive', 0);
    }
    //return;    
}

function bool Died(Controller Killer, Class<DamageType> DamageType, Vector HitLocation)
{
    local TgPawn_Ying yingOwner;
    local delegate<DestroyedEvent> onEventDelegate;

    // End:0x41
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x40
        foreach s_OnDeathDelegates(onEventDelegate)
        {
            DestroyedEvent(self);            
        }        
    }
    // End:0x12E
    if(int(r_eDeathReason) != int(1))
    {
        yingOwner = TgPawn_Ying(r_Owner);
        // End:0x12E
        if(((int(Role) == int(ROLE_Authority)) && yingOwner != none) && yingOwner.r_bHasCompensate)
        {
            m_eAIState = 0;
            // End:0xDF
            if(m_CachedShatterDevice == none)
            {
                CacheShatterDevice();
            }
            // End:0x12E
            if(m_CachedShatterDevice != none)
            {
                m_CachedShatterDevice.SetFireMode(1, true);
                m_CachedShatterDevice.FireAmmunition();
            }
        }
    }
    return super.Died(Killer, DamageType, HitLocation);
    //return ReturnValue;    
}

event CacheShatterDevice()
{
    m_CachedShatterDevice = GetDeviceByClass(Class'TgGame.TgDevice_Shatter');
    //return;    
}

simulated function TimedDestroyedFX()
{
    c_bMeshHiddenDueToDeath = true;
    //return;    
}

simulated function TriggerShatter(float fDelay)
{
    // End:0xA2
    if(int(Role) == int(ROLE_Authority))
    {
        ClearTimer('Suicide');
        SetTimer(fDelay, false, 'Shatter');
        // End:0x6D
        if(m_bCanShatterEarly)
        {
            CheckEarlyShatter();
            SetTimer(m_fEarlyShatterRecheckTime, true, 'CheckEarlyShatter');
        }
        m_eAIState = 1;
        r_fShatterDelay = fDelay;
        bNetDirty = true;
        ApplyStartShatterEffects();
    }
    // End:0x104
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        SetTimer(fDelay, false, 'Shatter');
        ReplaceWithShatterMaterial();
        FxActivateGroupSelf('IllusionShatterTrail', 0);
    }
    //return;    
}

function ApplyStartShatterEffects()
{
    // End:0x19
    if(m_CachedShatterDevice == none)
    {
        CacheShatterDevice();
    }
    // End:0x51
    if((m_CachedShatterDevice == none) || m_CachedShatterDevice.m_FireMode.Length <= 1)
    {
        return;
    }
    m_CachedShatterDevice.m_FireMode[1].ApplyHitSpecial(self);
    //return;    
}

event Suicide()
{
    m_bSpringBloomFlag = false;
    super(TgPawn).Suicide();
    //return;    
}

event Shatter()
{
    m_eAIState = 0;
    ClearTimer('CheckEarlyShatter');
    ClearTimer('Shatter');
    // End:0x4F
    if(!IsAliveAndWell())
    {
        Suicide();
        return;
    }
    // End:0x68
    if(m_CachedShatterDevice == none)
    {
        CacheShatterDevice();
    }
    // End:0x83
    if(m_CachedShatterDevice == none)
    {
        Suicide();
        return;
    }
    m_CachedShatterDevice.SetFireMode(1, true);
    m_CachedShatterDevice.FireAmmunition();
    Despawn();
    //return;    
}

function ClearDimensionalLink()
{
    //return;    
}

function AddOnDestroyDelegate(delegate<DestroyedEvent> delDestroy)
{
    // End:0x36
    if(s_OnDeathDelegates.Find(delDestroy) == -1)
    {
        s_OnDeathDelegates.AddItem(delDestroy);
    }
    //return;    
}

// Export UTgPawn_Illusion::execGetActorFromInterface(FFrame&, void* const)
native function Actor GetActorFromInterface();

// Export UTgPawn_Illusion::execIsNotDestroyed(FFrame&, void* const)
native function bool IsNotDestroyed();

simulated function PlayDimensionalLinkFX()
{
    // End:0x36
    if((Mesh != none) && IsAliveAndWell())
    {
        FxReactivateGroupSelf('YingDimensionalLink', 0);
    }
    //return;    
}

simulated function bool AllowRagdoll()
{
    return true;
    //return ReturnValue;    
}

function TgPawn_Ying GetOwningYing()
{
    return TgPawn_Ying(m_PetOwner);
    //return ReturnValue;    
}

state Intro
{
    simulated function BeginState(name PreviousStateName)
    {
        SetCollision(false, false);
        ConsiderCreateBeams();
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        SetCollision(true, true);
        super.EndState(NextStateName);
        // End:0x63
        if(r_fIntroTime > float(0))
        {
            FxDeactivateGroupSelf('RiftIllusionSpawned', 0);
            FxActivateGroupSelf('IllusionSpawned', 0, 0, 0, true);
            SetMeshVisibility(true);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fDamageScale=1.0000000
    m_fDamageAccumulatorReductionRatePerSec=250.0000000
    m_fFlickerDamageMin=25.0000000
    m_fFlickerDamageMax=75.0000000
    m_fDamageAccumulatorCap=200.0000000
    m_fTimedDestroyedFXDuration=1.0000000
    m_fTimedDestroyedFXMeshHiddenTime=0.4000000
    m_fEarlyShatterRecheckTime=0.2000000
    m_bSpringBloomFlag=true
    m_ShatterMaterialLocal=MaterialInstanceConstant'FX_Ying.Materials.MIC_Shatter_Pulse_A'
    m_ShatterMaterialFriendly=MaterialInstanceConstant'FX_Ying.Materials.MIC_Shatter_Pulse_B'
    m_ShatterMaterialEnemy=MaterialInstanceConstant'FX_Ying.Materials.MIC_Shatter_Pulse_C'
    m_HitMaterialLocal=MaterialInstanceConstant'FX_Ying.Materials.MIC_Illusion_Hit_A'
    m_HitMaterialFriendly=MaterialInstanceConstant'FX_Ying.Materials.MIC_Illusion_Hit_B'
    m_HitMaterialEnemy=MaterialInstanceConstant'FX_Ying.Materials.MIC_Illusion_Hit_C'
    m_DestroyMaterialLocal=MaterialInstanceConstant'FX_Ying.Materials.MIC_Illusion_Fade_A'
    m_DestroyMaterialFriendly=MaterialInstanceConstant'FX_Ying.Materials.MIC_Illusion_Fade_B'
    m_DestroyMaterialEnemy=MaterialInstanceConstant'FX_Ying.Materials.MIC_Illusion_Fade_C'
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Illusion.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    // Archetype: TgCustomCharacterComponent'TgGame.Default__TgPawn_Ying.CustomCharacterInfo'
    begin object name="CustomCharacterInfo"
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Illusion.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Ying.MountedCollision'
    begin object name="MountedCollision"
        ReplacementPrimitive=none
    end object
    m_MountedCollisionComponent=MountedCollision
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_ILLUSION
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Illusion.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Ying.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_fMaxAimAssistStacks=0.1000000
    m_nInitHUDOverlayDisplayMask=73
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Illusion.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Ying.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Illusion.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Ying.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Illusion.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Ying.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Illusion.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Ying.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_nSuccessfulHitSpecialFXId=6978
    PeripheralVision=-1.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Illusion.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Ying.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Illusion.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Ying.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    CollisionComponent=CollisionCylinder
}