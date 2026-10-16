class TgPawn_Character extends TgPawn_Biped
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const TGC_REMEMBER_PLAYER_ATTACKED_TIME = 2;
const TGC_KILL_COMBO_MAX_TIME = 5;
const TG_MAX_DISTANCE_FOR_SHARED_VISIBILITY_SQ = 2560000;
const TG_HIT_INDICATOR_POINTS_TO_INSTIGATOR = 1;
const TG_MAX_PLAYER_STUCK_BOMBS = 6;
const TG_ROLE_DAMAGE = 10601;
const TG_ROLE_FLANKER = 10541;
const TG_ROLE_FRONTLINE = 10542;
const TG_ROLE_SUPPORT = 15060;

enum EUITargeters
{
    TARGETER_KINESSA,               // 0
    TARGETER_TYRA,                  // 1
    TARGETER_TORVALD,               // 2
    TARGETER_ORACLE,                // 3
    TARGETER_ASTRO,                 // 4
    TARGETER_YING,                  // 5
    TARGETER_MAX                    // 6
};

struct native WeaponDOF
{
    var bool IsActive;
    var DOFAndBloomEffect.EDOFType DOFType;
    var float Falloff;
    var float BlurKernelSize;
    var DOFEffect.EFocusType FocusType;
    var float FocusInnerRadius;
    var float FocusDistance;
    var float MaxNearBlurAmount;
    var float MinBlurAmount;
    var float MaxFarBlurAmount;

    structdefaultproperties
    {
        IsActive=false
        DOFType=EDOFType.DOFType_SimpleDOF
        Falloff=0.0000000
        BlurKernelSize=0.0000000
        FocusType=EFocusType.FOCUS_Distance
        FocusInnerRadius=0.0000000
        FocusDistance=0.0000000
        MaxNearBlurAmount=0.0000000
        MinBlurAmount=0.0000000
        MaxFarBlurAmount=0.0000000
    }
};

struct native ForceFaceTargetActor
{
    var Actor TargetActor;
    var float HeightOffset;
    var Quat InitialQuat;
    var float InterpTime;
    var float StartTime;
    var float Duration;
    var Object ForceRotationInstigator;

    structdefaultproperties
    {
        TargetActor=none
        HeightOffset=0.0000000
        InitialQuat=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=0.0000000)
        InterpTime=0.0000000
        StartTime=0.0000000
        Duration=0.0000000
        ForceRotationInstigator=none
    }
};

struct native TeleportParams
{
    var Vector vTargetLocation;
    var Rotator rTargetRotation;
    var bool bPlayFx;
    var bool bDoBackTrace;
    var Vector vBackTraceDir;
    var float fBackTraceIncrement;
    var float fBackTraceMaxDist;
    var bool bLookForGround;
    var float fGroundSearchHeight;
    var float fGroundSearchRayRadius;
    var bool bCheckLineOfSight;
    var float fMovementCorrectionDisableTime;
    var int nTeleportEnterState;
    var int nTeleportExitState;
    var bool bFakeTeleport;

    structdefaultproperties
    {
        vTargetLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        rTargetRotation=(Pitch=0,Yaw=0,Roll=0)
        bPlayFx=false
        bDoBackTrace=false
        vBackTraceDir=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        fBackTraceIncrement=0.0000000
        fBackTraceMaxDist=0.0000000
        bLookForGround=false
        fGroundSearchHeight=0.0000000
        fGroundSearchRayRadius=0.0000000
        bCheckLineOfSight=false
        fMovementCorrectionDisableTime=0.0000000
        nTeleportEnterState=0
        nTeleportExitState=0
        bFakeTeleport=false
    }
};

var bool c_bUpdatePlayerStatUI;
var bool m_bInHandFiring;
var bool r_bNearCapturePoint;
var bool r_bNearPayload;
var bool r_bNearSiegeMonster;
var bool r_bVisibleToEnemies;
var bool s_bAmmoReloadCheat;
var bool s_bAutomountProtection;
var bool m_bAttemptingAirJump;
var bool m_bDelayingStopSpecialJumpFx;
var bool m_bPendingBounce;
var bool s_bInitiatingJoin;
var const bool s_bReplicateInhandAmmo;
var transient float m_fLastCapturePointReclaimedTime;
var float m_fMinReclaimPointTime;
var transient float m_fInHandStartFireTime;
var transient float m_fInHandStopFireTime;
var float m_fWallDamagePercent;
var float m_fSiegeDamagePercent;
var repnotify float r_fZoomAmt;
var repnotify byte r_nCriticalHit;
var() float m_fMountZoomOverride;
var TgDeploy_BombKingStickyBomb r_StuckBombs[6];
var int m_nCharacterRole;
var() export editinline TgCustomCharacterComponent m_CustomCharacterComponent;
var() export editinline PrimitiveComponent m_MountedCollisionComponent;
var() export editinline PrimitiveComponent m_MeshEncompassingCollisionComponent;
var array<TgDeviceInterface_MoveSpeedMultiplier> m_CachedMoveSpeedModDevices;
var int m_nAirJumps;
var(Blades) float m_fAirJumpZSpeed;
var Vector m_vBounceVelocity;
var TgPawn_Character m_JoinTargetLocal;
var TgPawn_Character m_JoinSourceLocal;
var repnotify TgPawn_Character r_JoinTarget;
var Vector r_vJoinSourceLocation;
var Vector r_vJoinTargetLocation;
var float r_fJoinTweenDuration;
var repnotify TgPawn_Character r_JoinSource;
var array<ForceFaceTargetActor> m_ForceFaceActors;
var repnotify int r_nInHandCurrentAmmo;
var repnotify int r_nInHandMaxAmmo;

replication
{
    // Pos:0x000
    if(bNetDirty)
        r_JoinSource, r_JoinTarget, 
        r_bNearCapturePoint, r_bNearPayload, 
        r_bVisibleToEnemies, r_fJoinTweenDuration, 
        r_nInHandCurrentAmmo, r_nInHandMaxAmmo, 
        r_vJoinSourceLocation, r_vJoinTargetLocation;

    // Pos:0x00A
    if(bNetDirty && (!bNetOwner || bDemoRecording) || bNetTimelapse)
        r_fZoomAmt;

    // Pos:0x043
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_StuckBombs, r_nCriticalHit;
}

// Export UTgPawn_Character::execApplyPawnSetup(FFrame&, void* const)
native function bool ApplyPawnSetup();

// Export UTgPawn_Character::execSetSpawnMana(FFrame&, void* const)
native function SetSpawnMana();

// Export UTgPawn_Character::execLoadDisconnectedPlayerState(FFrame&, void* const)
native function LoadDisconnectedPlayerState();

// Export UTgPawn_Character::execOnHealingWell(FFrame&, void* const)
native function OnHealingWell(bool bTouched);

// Export UTgPawn_Character::execReapplyLoadoutEffects(FFrame&, void* const)
native function ReapplyLoadoutEffects(optional bool bKeepFiringMount);

// Export UTgPawn_Character::execApplyItemEffects(FFrame&, void* const)
native function bool ApplyItemEffects(TgInventoryObject pItem, bool bRemove);

// Export UTgPawn_Character::execApplyMonsterRewardEffects(FFrame&, void* const)
native function bool ApplyMonsterRewardEffects(TgInventoryObject pItem, bool bRemove);

// Export UTgPawn_Character::execOnPawnDied(FFrame&, void* const)
native function OnPawnDied();

// Export UTgPawn_Character::execSpawnGuard(FFrame&, void* const)
native function SpawnGuard();

// Export UTgPawn_Character::execPlayMatchStartCue(FFrame&, void* const)
native function PlayMatchStartCue();

// Export UTgPawn_Character::execGlobalOnPlayerDied(FFrame&, void* const)
native function GlobalOnPlayerDied(TgPawn_Character Player);

// Export UTgPawn_Character::execPawnOnDamaged(FFrame&, void* const)
native function PawnOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_Character::execPawnOnHealed(FFrame&, void* const)
native function PawnOnHealed(out OnHealedParams Params);

// Export UTgPawn_Character::execPawnOnKilled(FFrame&, void* const)
native function PawnOnKilled(Actor pVictim);

// Export UTgPawn_Character::execPawnOnAssisted(FFrame&, void* const)
native function PawnOnAssisted(Actor pVictim);

// Export UTgPawn_Character::execPawnOnRevive(FFrame&, void* const)
native function PawnOnRevive();

// Export UTgPawn_Character::execPawnOnEnterCombat(FFrame&, void* const)
native function PawnOnEnterCombat();

// Export UTgPawn_Character::execPawnOnExitCombat(FFrame&, void* const)
native function PawnOnExitCombat();

// Export UTgPawn_Character::execPawnOnGetHealthNugget(FFrame&, void* const)
native function PawnOnGetHealthNugget(TgDeploy_HealthNugget nugget);

// Export UTgPawn_Character::execPawnOnEnterCapturePoint(FFrame&, void* const)
native function PawnOnEnterCapturePoint(TgChaosCapturePoint capturePoint);

// Export UTgPawn_Character::execPawnOnLeaveCapturePoint(FFrame&, void* const)
native function PawnOnLeaveCapturePoint(TgChaosCapturePoint capturePoint);

// Export UTgPawn_Character::execPawnOnTeleported(FFrame&, void* const)
native function PawnOnTeleported(TgSpawnTeleporterEntrance From, TgSpawnTeleporterExit To, Vector OriginalPawnLocation);

// Export UTgPawn_Character::execDeviceOnStartBuildup(FFrame&, void* const)
native function DeviceOnStartBuildup(TgDevice Dev);

// Export UTgPawn_Character::execDeviceOnStopBuildup(FFrame&, void* const)
native function DeviceOnStopBuildup(TgDevice Dev, optional bool WasInterrupted = false);

// Export UTgPawn_Character::execDeviceOnFire(FFrame&, void* const)
native function DeviceOnFire(TgDevice Dev);

// Export UTgPawn_Character::execProjectileOnFire(FFrame&, void* const)
native function ProjectileOnFire(TgProjectile Proj);

// Export UTgPawn_Character::execDeviceOnStartFire(FFrame&, void* const)
native function DeviceOnStartFire(TgDevice Dev);

// Export UTgPawn_Character::execDeviceOnStopFire(FFrame&, void* const)
native function DeviceOnStopFire(TgDevice Dev, optional bool WasInterrupted = false);

// Export UTgPawn_Character::execDeviceOnHit(FFrame&, void* const)
native function DeviceOnHit(TgDevice Dev, const out ImpactInfo Impact);

// Export UTgPawn_Character::execDeviceOnHitSpecial(FFrame&, void* const)
native function DeviceOnHitSpecial(TgDevice Dev, const out ImpactInfo Impact, int nHitSpecialSituationalType);

// Export UTgPawn_Character::execDeviceOnDamaged(FFrame&, void* const)
native function DeviceOnDamaged(out OnDamagedParams Params);

// Export UTgPawn_Character::execDeviceOnHealed(FFrame&, void* const)
native function DeviceOnHealed(out OnHealedParams Params);

// Export UTgPawn_Character::execDeviceOnKilled(FFrame&, void* const)
native function DeviceOnKilled(TgDevice Dev, const out ImpactInfo Impact, float fDamage);

// Export UTgPawn_Character::execDeviceOnReload(FFrame&, void* const)
native function DeviceOnReload(TgDevice Dev);

// Export UTgPawn_Character::execDeviceOnMiss(FFrame&, void* const)
native function DeviceOnMiss(TgDevice Dev);

// Export UTgPawn_Character::execDeviceAdjustDamage(FFrame&, void* const)
native function DeviceAdjustDamage(out AdjustDamageParams Params, out float fDamage);

// Export UTgPawn_Character::execDeviceAdjustHeal(FFrame&, void* const)
native function DeviceAdjustHeal(const out AdjustHealParams Params, out float fHeal);

// Export UTgPawn_Character::execDropHealthNugget(FFrame&, void* const)
native function DropHealthNugget(optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_Character::execDropHealthNuggetTeamOnly(FFrame&, void* const)
native function DropHealthNuggetTeamOnly(int nTaskForce, optional Vector SpawnVelocity, optional float fHealOverride = -1.0000000, optional float fHoTOverride = -1.0000000);

// Export UTgPawn_Character::execGetBaseSpeed(FFrame&, void* const)
native function float GetBaseSpeed();

// Export UTgPawn_Character::execOverrideDistanceFadeRange(FFrame&, void* const)
native function bool OverrideDistanceFadeRange();

// Export UTgPawn_Character::execGetDefaultHeadMeshId(FFrame&, void* const)
native function int GetDefaultHeadMeshId();

// Export UTgPawn_Character::execGetRole(FFrame&, void* const)
native function int GetRole();

// Export UTgPawn_Character::execTakeHealthDamage(FFrame&, void* const)
native function TakeHealthDamage(float fDamage, Controller InstigatedBy, Class<DamageType> DamageType, ImpactInfo Impact, ExtraDamageInfo ExtraInfo, optional Actor DamageCauser);

// Export UTgPawn_Character::execQueueBounce(FFrame&, void* const)
native function QueueBounce(const out Vector vBounceVelocity);

// Export UTgPawn_Character::execFindGround(FFrame&, void* const)
native function bool FindGround(const out Vector vSourceLocation, out Vector vGroundLocation, out Vector vGroundNormal, const optional float fCheckDist = 500.0000000, const optional float fCheckRadius = 0.0000000, const optional Vector vRayDir = vect(0.0000000, 0.0000000, -1.0000000));

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x42
    if(c_LocalPC != none)
    {
        c_LocalPC.CheckHealthFX(1.0000000, 1.0000000);
    }
    //return;    
}

simulated function PrepareIntro()
{
    local TgAnimNodeBlendByIntroduction AnimNodeIterator;

    super(TgPawn).PrepareIntro();
    // End:0x41
    foreach m_AnimNodeBlendByIntroductions(AnimNodeIterator)
    {
        AnimNodeIterator.PrepareIntroduction();        
    }    
    Mesh.ForceSkelUpdate();
    //return;    
}

simulated function PlayIntroAnims()
{
    local TgAnimNodeBlendByIntroduction AnimNodeIterator;

    // End:0x37
    foreach m_AnimNodeBlendByIntroductions(AnimNodeIterator)
    {
        AnimNodeIterator.PlayIntroduction();        
    }    
    //return;    
}

simulated function PlaySpawnFx()
{
    super(TgPawn).PlaySpawnFx();
    PlayIntroAnims();
    PlayEmoteSelfOnly(6);
    SetTimer(25.0000000, false, 'PlayAnnouncerMatchStartCue');
    //return;    
}

simulated function PlayAnnouncerMatchStartCue()
{
    // End:0x22
    if(TgPlayerController(Controller) != none)
    {
        PlayMatchStartCue();
    }
    //return;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local TgPawn attackerPawn, PetPawn;
    local int I;

    super(TgPawn).TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    // End:0x197
    if(!ClassIsChildOf(DamageType, Class'TgGame.TgDamageType_AbilityCost'))
    {
        // End:0x197
        if(InstigatedBy != none)
        {
            attackerPawn = TgPawn(InstigatedBy.Pawn);
            // End:0x104
            if(attackerPawn.r_Owner != none)
            {
                PetPawn = attackerPawn;
                attackerPawn = attackerPawn.r_Owner;
            }
            // End:0x197
            if((attackerPawn != none) && attackerPawn.IsA('TgPawn_Character'))
            {
                attackerPawn.SetTimer(2.0000000, false, 'RememberPlayerAttackerExpired');
                // End:0x197
                if(PetPawn != none)
                {
                    PetPawn.SetTimer(2.0000000, false, 'RememberPlayerAttackerExpired');
                }
            }
        }
    }
    // End:0x22F
    if((InstigatedBy == Controller) && int(Role) == int(ROLE_Authority))
    {
        I = 0;
        J0x1CF:

        // End:0x22F [Loop If]
        if(I < 6)
        {
            // End:0x221
            if(r_StuckBombs[I] != none)
            {
                r_StuckBombs[I].DetachFromPlayer();
            }
            I++;
            // [Loop Continue]
            goto J0x1CF;
        }
    }
    //return;    
}

function ResetKillCombo()
{
    s_nKillCombo = 0;
    //return;    
}

simulated function CharacterPawnControllerSet()
{
    c_bShowDecalRing = Controller == none;
    RecalculateMaterial(IsFriendlyWithLocalPawn());
    c_bUpdatePlayerStatUI = true;
    //return;    
}

simulated function OnRespawn()
{
    super(TgPawn).OnRespawn();
    SpawnGuard();
    //return;    
}

simulated event bool PostPawnSetup()
{
    local bool Success;
    local TgRepInfo_Game GRI;

    Success = super(TgPawn).PostPawnSetup();
    // End:0x2C
    if(Success)
    {
        SpawnGuard();
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x98
    if(GRI != none)
    {
        // End:0x98
        if(GRI.r_bShowHeadMesh)
        {
            ShowHeadMesh();
        }
    }
    return Success;
    //return ReturnValue;    
}

simulated function ShowHeadMesh()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x5F
    if((c_nCurrentHeadMeshID == 0) && r_nHeadMeshOverride == 0)
    {
        c_nCurrentHeadMeshID = GetDefaultHeadMeshId();
    }
    // End:0x2A1
    if((((m_HeadMesh == none) || c_nCurrentHeadMeshID != r_nHeadMeshOverride) || m_HeadMesh.ParentAnimComponent != Mesh) || m_HeadMesh.SkeletalMesh == none)
    {
        // End:0x11D
        if(m_HeadMesh != none)
        {
            DetachComponent(m_HeadMesh);
            m_HeadMesh.SetParentAnimComponent(none);
        }
        // End:0x13F
        if(r_nHeadMeshOverride != 0)
        {
            c_nCurrentHeadMeshID = r_nHeadMeshOverride;
        }
        // End:0x29E
        if(c_nCurrentHeadMeshID != 0)
        {
            m_HeadMesh = new (self) Class'TgGame.TgSkeletalMeshComponent';
            m_HeadMesh.SetLightEnvironment(LightEnvironment);
            CreateMeshComponent(c_nCurrentHeadMeshID, m_HeadMesh, false);
            // End:0x200
            if(m_HeadMesh.SkeletalMesh == none)
            {
                c_nCurrentHeadMeshID = GetDefaultHeadMeshId();
                CreateMeshComponent(c_nCurrentHeadMeshID, m_HeadMesh, false);
            }
            AttachComponent(m_HeadMesh);
            m_HeadMesh.SetParentAnimComponent(Mesh);
            m_HeadMesh.SetShadowParent(Mesh);
            m_HeadSilhouetteIndex = InitializeSilhouetteComponent(m_HeadMesh);
            m_HeadOverlayIndex = InitializeOverlayMeshComponent(m_HeadMesh, false);
        }        
    }
    //return;    
}

simulated function HideHeadMesh()
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0xE0
    if(m_HeadMesh != none)
    {
        logr((("Hide Head Mesh " @ string(m_HeadMesh.Name)) @ ", ") @ string(m_HeadMesh.bAttached));
        // End:0xD5
        if(m_HeadMesh.bAttached)
        {
            DetachComponent(m_HeadMesh);
        }
        m_HeadMesh = none;
    }
    /* Statement decompilation error: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
        
    */

    // End:0x266
    /*@Error*/
    logr((("Detaching Head Silouette " @ string(m_HeadSilhouetteIndex)) @ ", Array Length: ") @ string(m_SilhouetteInfos.Length));
    /* Statement decompilation error: Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index
        
    */

    /*@Error*/
}

simulated event ReceivedPropValues()
{
    // End:0x1B
    if(Controller != none)
    {
        c_bUpdatePlayerStatUI = true;
    }
    //return;    
}

simulated function bool IsViewPawn()
{
    local TgPlayerController PC;

    PC = TgPlayerController(GetALocalPlayerController());
    // End:0x55
    if((PC != none) && self == PC.GetTgPawn())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event ReplicatedEvent(name VarName)
{
    local TgPlayerController TgPC;
    local TgDeviceForm_Inhand inhandDeviceForm;

    switch(VarName)
    {
        // End:0x93
        case 'r_nCriticalHit':
            // End:0x90
            if(!c_bJustStartedTimelapsePlayback || c_bJustEndedTimelapsePlayback)
            {
                TgPC = TgPlayerController(GetALocalPlayerController());
                // End:0x90
                if((TgPC != none) && TgPC.GetTgPawn() == self)
                {
                }
            }
            // End:0x27A
            break;
        // End:0xB5
        case 'r_fZoomAmt':
            SetWeaponZoom(r_fZoomAmt);
            // End:0x27A
            break;
        // End:0xCE
        case 'Controller':
            CharacterPawnControllerSet();
            // End:0x27A
            break;
        // End:0xE7
        case 'r_CurrentPropValues':
            SyncMana();
            // End:0x27A
            break;
        // End:0x100
        case 'r_nHeadMeshOverride':
            ShowHeadMesh();
            // End:0x27A
            break;
        // End:0x12D
        case 'r_JoinTarget':
            // End:0x12A
            if(int(Role) < int(ROLE_Authority))
            {
                ClientJoinToTarget();
            }
            // End:0x27A
            break;
        // End:0x15A
        case 'r_JoinSource':
            // End:0x157
            if(int(Role) < int(ROLE_Authority))
            {
                UpdateJoinSourceLocal();
            }
            // End:0x27A
            break;
        // End:0x20A
        case 'r_nInHandCurrentAmmo':
            TgPC = TgPlayerController(GetALocalPlayerController());
            // End:0x20A
            if((TgPC != none) && TgPC.GetTgPawn() == self)
            {
                TgPC.NotifyUpdatedInhandAmmoCount(r_nInHandCurrentAmmo, GetDeviceByEqPoint(1), r_EquipDeviceInfo[1].nDeviceId);
            }
        // End:0x277
        case 'r_nInHandMaxAmmo':
            inhandDeviceForm = TgDeviceForm_Inhand(c_EquipForm[1]);
            // End:0x274
            if(inhandDeviceForm != none)
            {
                inhandDeviceForm.OnAmmoCountUpdated(r_nInHandCurrentAmmo, r_nInHandMaxAmmo);
            }
            // End:0x27A
            break;
        // End:0xFFFF
        default:
            break;
    }
    super(TgPawn).ReplicatedEvent(VarName);
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local TgRepInfo_Game chaosGRI;
    local TgDevice inhandDevice, inhand;
    local TgDeviceForm_Inhand inhandDeviceForm;

    super(TgPawn).Tick(DeltaSeconds);
    // End:0x61
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && c_bUpdatePlayerStatUI)
    {
        UpdatePlayerStatUI();
        c_bUpdatePlayerStatUI = false;
    }
    // End:0x2BB
    if(int(Role) == int(ROLE_Authority))
    {
        chaosGRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x20C
        if((((chaosGRI != none) && chaosGRI.r_LanePusher != none) && chaosGRI.r_AttackingTaskForce != none) && chaosGRI.r_LanePusher.IsAliveAndWell())
        {
            // End:0x209
            if(int(chaosGRI.r_AttackingTaskForce.r_nTaskForce) == int(GetTaskForceNumber()))
            {
                // End:0x1F0
                if(VSizeSq(Location - chaosGRI.r_LanePusher.Location) <= Square(40.0000000 * float(16)))
                {
                    // End:0x1ED
                    if(!r_bNearSiegeMonster)
                    {
                        r_bNearSiegeMonster = true;
                    }                    
                }
                else
                {
                    // End:0x209
                    if(r_bNearSiegeMonster)
                    {
                        r_bNearSiegeMonster = false;
                    }
                }
            }            
        }
        else
        {
            // End:0x225
            if(r_bNearSiegeMonster)
            {
                r_bNearSiegeMonster = false;
            }
        }
        // End:0x2BB
        if(int(Role) <= int(ROLE_AutonomousProxy))
        {
            inhandDevice = GetDeviceByEqPoint(1);
            // End:0x2BB
            if((inhandDevice != none) && inhandDevice.IsFiring())
            {
                // End:0x29E
                if(r_bNearCapturePoint)
                {
                    PlayEmoteAtWorldLocation(36);                    
                }
                else
                {
                    // End:0x2BB
                    if(!IsA('TgPawn_Cassie'))
                    {
                        PlayEmoteAtWorldLocation(30);
                    }
                }
            }
        }
    }
    // End:0x2F1
    if(int(Physics) == int(1))
    {
        m_nAirJumps = 0;
        // End:0x2F1
        if(m_bDelayingStopSpecialJumpFx)
        {
            StopSpecialJumpFx();
        }
    }
    // End:0x46E
    if(s_bReplicateInhandAmmo)
    {
        inhand = self.GetDeviceByEqPoint(1);
        // End:0x46E
        if(inhand != none)
        {
            // End:0x46E
            if((r_nInHandCurrentAmmo != inhand.GetCurrentAmmoAmount()) || r_nInHandMaxAmmo != inhand.r_nMaxAmmoClipCount)
            {
                r_nInHandCurrentAmmo = inhand.GetCurrentAmmoAmount();
                r_nInHandMaxAmmo = inhand.r_nMaxAmmoClipCount;
                bNetDirty = true;
                // End:0x46E
                if(int(WorldInfo.NetMode) == int(NM_Standalone))
                {
                    inhandDeviceForm = TgDeviceForm_Inhand(c_EquipForm[1]);
                    // End:0x46E
                    if(inhandDeviceForm != none)
                    {
                        inhandDeviceForm.OnAmmoCountUpdated(r_nInHandCurrentAmmo, r_nInHandMaxAmmo);
                    }
                }
            }
        }
    }
    //return;    
}

function PossessedBy(Controller C, bool bVehicleTransition)
{
    super(TgPawn).PossessedBy(C, bVehicleTransition);
    NotifyTeamChanged();
    LoadDisconnectedPlayerState();
    // End:0x88
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && C.IsLocalPlayerController())
    {
        CharacterPawnControllerSet();
    }
    //return;    
}

event bool Died(Controller Killer, Class<DamageType> dmgType, Vector HitLocation)
{
    local int I, CapturePointTaskForce;
    local TgRepInfo_Game GRI;
    local TgCapturePoint capturePoint;
    local TgPawn_Character TgPCharacter;
    local bool retValue;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x221
    if((GRI != none) && GRI.m_CPRIArray.Length > 0)
    {
        I = 0;
        J0x72:

        // End:0x221 [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            capturePoint = GRI.m_CPRIArray[I].r_OwningCapturePoint;
            CapturePointTaskForce = GRI.m_CPRIArray[I].r_nControlledByTaskForce;
            // End:0x213
            if(((((capturePoint != none) && CapturePointTaskForce > 0) && CapturePointTaskForce != int(GetTaskForceNumber())) && VSizeSq2D(capturePoint.Location - Location) <= 2560000.0000000) && capturePoint.m_CurrentBotSpawners[CapturePointTaskForce - 1].nCurrentCount > 0)
            {
                capturePoint.OnNearbyEnemyPlayerDied(self);
                // [Explicit Break]
                goto J0x221;
            }
            I++;
            // [Loop Continue]
            goto J0x72;
        }
    }
    J0x221:

    retValue = super(TgPawn).Died(Killer, dmgType, HitLocation);
    // End:0x303
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x303
        if(r_nPhysicalType == 10034)
        {
            // End:0x302
            foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', TgPCharacter)
            {
                // End:0x301
                if((TgPCharacter != none) && TgPCharacter.IsAliveAndWell())
                {
                    TgPCharacter.GlobalOnPlayerDied(self);
                }                
            }            
        }
    }
    return retValue;
    //return ReturnValue;    
}

simulated exec function ComposeCharacter(optional int Idx = -1, optional int MeshAsmId = -1)
{
    // End:0xBF
    if((((m_CustomCharacterComponent != none) && Idx > -1) && MeshAsmId > -1) && Idx < m_CustomCharacterComponent.m_CompositeParts.Length)
    {
        m_CustomCharacterComponent.m_CompositeParts[Idx].MeshAsmId = MeshAsmId;
    }
    m_CustomCharacterComponent.ComposeCharacter(Mesh);
    //return;    
}

simulated event SetMountedCollision(bool IsActive)
{
    // End:0x84
    if(m_MountedCollisionComponent != none)
    {
        m_MountedCollisionComponent.SetTraceBlocking(IsActive, IsActive);
        m_MountedCollisionComponent.SetActorCollision(IsActive, false);
        m_bCanBeHeadShot = !IsActive;
    }
    //return;    
}

simulated function GetCameraZoomOverride(out float fZoom, out float fZoomDuration)
{
    super(TgPawn).GetCameraZoomOverride(fZoom, fZoomDuration);
    fZoomDuration = m_fZoomDurationOverride;
    // End:0x53
    if(m_fZoomDistOverride != float(0))
    {
        fZoom = m_fZoomDistOverride;
    }
    // End:0x74
    if(r_bIsMounted)
    {
        fZoom *= m_fMountZoomOverride;
    }
    //return;    
}

simulated function bool AllowRagdoll()
{
    return !TgPlayerController(GetALocalPlayerController()).AllowRagdoll();
    //return ReturnValue;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgChaosCapturePoint capturePoint;
    local TgPlayerController TgPC;
    local KActor TouchedKActor;

    super(TgPawn).Touch(Other, OtherComp, HitLocation, HitNormal);
    TouchedKActor = KActor(Other);
    // End:0x78
    if(TouchedKActor != none)
    {
        TouchedKActor.ClientTouchEffects();
    }
    capturePoint = TgChaosCapturePoint(Other);
    // End:0x150
    if((capturePoint != none) && int(capturePoint.r_eStatus) == int(1))
    {
        TgPC = TgPlayerController(Controller);
        // End:0x150
        if((TgPC != none) && TgPC.IsTimerActive('SpawnPathfinder'))
        {
            TgPC.ClearTimer('SpawnPathfinder');
        }
    }
    //return;    
}

simulated event ForceUpdateAmmoAnim()
{
    local int I;
    local TgRepInfo_Player PRI;

    PRI = GetPRI();
    // End:0x25
    if(PRI == none)
    {
        return;
    }
    // End:0x7A
    if(int(Role) == int(ROLE_Authority))
    {
        PRI.r_nFlashUpdateAmmo++;
        PRI.bNetDirty = true;
    }
    I = 0;
    J0x85:

    // End:0x10E [Loop If]
    if(I < 33)
    {
        // End:0x100
        if(c_EquipForm[I] != none)
        {
            c_EquipForm[I].SetAmmoBlendNodesAmount(PRI.r_PlayerDeviceAmmo[I]);
        }
        I++;
        // [Loop Continue]
        goto J0x85;
    }
    //return;    
}

simulated function SetWeaponZoom(optional float fZoomAmt = 0.0000000)
{
    r_fZoomAmt = fZoomAmt;
    bNetDirty = true;
    UpdateWeaponZoomEffects(r_fZoomAmt);
    //return;    
}

simulated function UpdateWeaponZoomEffects(optional float fZoomAmt = 0.0000000)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera Cam;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x8D
    if((TgPC != none) && TgPC.GetTgPawn() == self)
    {
        Cam = TgPlayerCamera(TgPC.PlayerCamera);
    }
    // End:0x109
    if(fZoomAmt > 0.0000000)
    {
        // End:0xD7
        if(Cam != none)
        {
            Cam.SetFOV(fZoomAmt);
        }
        // End:0x106
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.SetFOVZoomed(true);
        }        
    }
    else
    {
        // End:0x137
        if(Cam != none)
        {
            Cam.ResetFOV();
        }
        // End:0x166
        if(m_WeaponMesh != none)
        {
            m_WeaponMesh.SetFOVZoomed(false);
        }
    }
    //return;    
}

simulated function StartWeaponZoomInterpolation(float fZoomAmt, float fInterpTime)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera Cam;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0xC4
    if((TgPC != none) && TgPC.GetTgPawn() == self)
    {
        Cam = TgPlayerCamera(TgPC.PlayerCamera);
        // End:0xC4
        if(Cam != none)
        {
            Cam.InterpolateFOV(fZoomAmt, fInterpTime);
        }
    }
    //return;    
}

simulated function OnStartTimelapseNewDeviceState()
{
    local int I;

    super(TgPawn).OnStartTimelapseNewDeviceState();
    I = 1;
    J0x15:

    // End:0x10C [Loop If]
    if(I < 33)
    {
        // End:0xFE
        if(c_EquipForm[I] != none)
        {
            // End:0xFE
            if(c_EquipForm[I].IsA('TgDeviceForm_ToggleWithLockout'))
            {
                // End:0xB6
                if(int(r_ReplicatedDeviceState[I]) == int(1))
                {
                    c_EquipForm[I].Generic2();                    
                }
                else
                {
                    // End:0xFE
                    if(int(r_ReplicatedDeviceState[I]) == int(0))
                    {
                        c_EquipForm[I].Generic1();
                    }
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x15;
    }
    //return;    
}

simulated event PreTimeLapse(bool bPlayOfTheGame)
{
    super(TgPawn).PreTimeLapse(bPlayOfTheGame);
    SetWeaponZoom(r_fZoomAmt);
    OnStartTimelapseNewDeviceState();
    //return;    
}

simulated event OnBecameSpectatorViewTarget()
{
    super(TgPawn).OnBecameSpectatorViewTarget();
    UpdateWeaponZoomEffects(r_fZoomAmt);
    OnStartTimelapseNewDeviceState();
    //return;    
}

simulated event OnCeaseSpectatorViewTarget()
{
    super(TgPawn).OnCeaseSpectatorViewTarget();
    UpdateWeaponZoomEffects(0.0000000);
    //return;    
}

event RemoveStickyBombs()
{
    local int X;

    // End:0x7F
    if(int(Role) == int(ROLE_Authority))
    {
        X = 0;
        J0x1F:

        // End:0x7F [Loop If]
        if(X < 6)
        {
            // End:0x71
            if(r_StuckBombs[X] != none)
            {
                r_StuckBombs[X].DetachFromPlayer();
            }
            X++;
            // [Loop Continue]
            goto J0x1F;
        }
    }
    //return;    
}

event StartAutomountProtectionTimer()
{
    local bool bInItemShop;
    local TgItemShopVolume ItemShop;

    bInItemShop = false;
    // End:0x58
    foreach AllActors(Class'TgGame.TgItemShopVolume', ItemShop)
    {
        // End:0x57
        if(ItemShop.Encompasses(self))
        {
            bInItemShop = true;
            // End:0x58
            break;
        }        
    }    
    // End:0x87
    if(!bInItemShop)
    {
        s_bAutomountProtection = true;
        SetTimer(5.0000000, false, 'AutomountProtectionTimer');
    }
    //return;    
}

function AutomountProtectionTimer()
{
    s_bAutomountProtection = false;
    //return;    
}

function bool CannotJumpNow()
{
    local bool oldIgnorePhysCheck, bCannotJump;

    oldIgnorePhysCheck = m_bIgnorePhysCheckForJump;
    m_bIgnorePhysCheckForJump = CanAirJump();
    bCannotJump = super(TgPawn).CannotJumpNow();
    m_bIgnorePhysCheckForJump = oldIgnorePhysCheck;
    return bCannotJump;
    //return ReturnValue;    
}

function bool CheckPhysicsStateForJumping()
{
    return super(TgPawn).CheckPhysicsStateForJumping() || CanAirJump();
    //return ReturnValue;    
}

function bool CanAirJump()
{
    return ((int(Physics) == int(2)) && m_nAirJumps < (GetNumAirJumps())) && !r_bIsMounted;
    //return ReturnValue;    
}

function bool DoJump(bool bUpdating, optional float JumpZSpeed = 0.0000000)
{
    local bool bJumpSuccessful, oldAllowHigherWallJumping, oldIgnorePhysCheckForJump;
    local float fJumpSpeed;

    fJumpSpeed = JumpZSpeed;
    oldAllowHigherWallJumping = m_bAllowHigherWallJumping;
    oldIgnorePhysCheckForJump = m_bIgnorePhysCheckForJump;
    // End:0xA9
    if(CanAirJump())
    {
        // End:0x77
        if(m_fAirJumpZSpeed > float(0))
        {
            fJumpSpeed = m_fAirJumpZSpeed;
        }
        m_bAllowHigherWallJumping = false;
        m_bIgnorePhysCheckForJump = true;
        m_bAttemptingAirJump = true;
        InterruptLift();        
    }
    else
    {
        m_bAttemptingAirJump = false;
    }
    bJumpSuccessful = super(TgPawn).DoJump(bUpdating, fJumpSpeed);
    // End:0x11A
    if(bJumpSuccessful)
    {
        r_bIsJumping = true;
        m_bIgnorePhysCheckForJump = false;
        // End:0x11A
        if(m_bAttemptingAirJump)
        {
            m_nAirJumps++;
        }
    }
    m_bAllowHigherWallJumping = oldAllowHigherWallJumping;
    m_bIgnorePhysCheckForJump = oldIgnorePhysCheckForJump;
    return bJumpSuccessful;
    //return ReturnValue;    
}

simulated function FlashJumpEffects()
{
    // End:0x1F
    if(m_bAttemptingAirJump)
    {
        FlashPlaySpecialEffect(7);        
    }
    else
    {
        super(TgPawn).FlashJumpEffects();
    }
    //return;    
}

simulated event StopSpecialJumpFx()
{
    // End:0x2D
    if(int(Physics) == int(1))
    {
        m_bDelayingStopSpecialJumpFx = false;
        super(TgPawn).StopSpecialJumpFx();        
    }
    else
    {
        m_bDelayingStopSpecialJumpFx = true;
    }
    //return;    
}

simulated event int GetNumAirJumps()
{
    return 0;
    //return ReturnValue;    
}

simulated function bool CanAddForcedViewTarget()
{
    return Controller != none;
    //return ReturnValue;    
}

reliable client simulated function ClientAddForcedViewTarget(Actor TargetActor, float InterpTime, float Duration, Object ForceRotationInstigator, optional float HeightOffset = 0.0000000)
{
    // End:0x69
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        AddForcedViewTarget(TargetActor, InterpTime, Duration, ForceRotationInstigator, HeightOffset);
    }
    //return;    
}

simulated function AddForcedViewTarget(Actor TargetActor, float InterpTime, float Duration, Object ForceRotationInstigator, optional float HeightOffset = 0.0000000)
{
    local ForceFaceTargetActor newForcedTarget;

    // End:0x69
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ClientAddForcedViewTarget(TargetActor, InterpTime, Duration, ForceRotationInstigator, HeightOffset);
    }
    // End:0x7A
    if(!CanAddForcedViewTarget())
    {
        return;
    }
    ClearOldForcedViewTargets();
    // End:0x227
    if((TargetActor != none) && Controller != none)
    {
        newForcedTarget.TargetActor = TargetActor;
        newForcedTarget.HeightOffset = HeightOffset;
        newForcedTarget.InitialQuat = QuatFromRotator(Controller.Rotation);
        newForcedTarget.InterpTime = InterpTime;
        newForcedTarget.StartTime = Controller.WorldInfo.TimeSeconds;
        Duration = FMax(0.0000000, Duration);
        newForcedTarget.Duration = Duration;
        newForcedTarget.ForceRotationInstigator = ForceRotationInstigator;
        m_ForceFaceActors.AddItem(newForcedTarget);
    }
    //return;    
}

reliable client simulated function ClientRemoveForcedViewTarget(Object ForceRotationInstigator)
{
    // End:0x3C
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        RemoveForcedViewTarget(ForceRotationInstigator);
    }
    //return;    
}

simulated function RemoveForcedViewTarget(Object ForceRotationInstigator)
{
    local int I;

    // End:0x3C
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ClientRemoveForcedViewTarget(ForceRotationInstigator);
    }
    I = m_ForceFaceActors.Length - 1;
    J0x53:

    // End:0xB9 [Loop If]
    if(I >= 0)
    {
        // End:0xAB
        if(m_ForceFaceActors[I].ForceRotationInstigator == ForceRotationInstigator)
        {
            m_ForceFaceActors.Remove(I, 1);
        }
        --I;
        // [Loop Continue]
        goto J0x53;
    }
    //return;    
}

simulated function ClearOldForcedViewTargets()
{
    local int I;

    I = m_ForceFaceActors.Length - 1;
    J0x17:

    // End:0xCF [Loop If]
    if(I >= 0)
    {
        // End:0xC1
        if((m_ForceFaceActors[I].StartTime + m_ForceFaceActors[I].Duration) < Controller.WorldInfo.TimeSeconds)
        {
            m_ForceFaceActors.Remove(I, 1);
        }
        --I;
        // [Loop Continue]
        goto J0x17;
    }
    //return;    
}

simulated function bool HasForcedRotation()
{
    return m_ForceFaceActors.Length > 0;
    //return ReturnValue;    
}

simulated event UpdateForcedRotation(float DeltaTime)
{
    local Rotator ForcedCameraRotation;
    local Vector Target, toTarget;
    local Quat targetQuat, newQuat;
    local float fProgress;

    ClearOldForcedViewTargets();
    // End:0x2F4
    if(m_ForceFaceActors.Length > 0)
    {
        // End:0x2F4
        if(Controller != none)
        {
            Target = m_ForceFaceActors[0].TargetActor.Location;
            Target.Z += m_ForceFaceActors[0].HeightOffset;
            toTarget = Target - self.Location;
            targetQuat = QuatFromRotator(Rotator(toTarget));
            // End:0x1FB
            if(m_ForceFaceActors[0].InterpTime > 0.0000000)
            {
                fProgress = (Controller.WorldInfo.TimeSeconds - m_ForceFaceActors[0].StartTime) / m_ForceFaceActors[0].InterpTime;
                fProgress = FClamp(fProgress, 0.0000000, 1.0000000);
                fProgress = 1.0000000 - fProgress;
                fProgress *= fProgress;
                fProgress = 1.0000000 - fProgress;                
            }
            else
            {
                fProgress = 1.0000000;
            }
            newQuat = QuatSlerp(m_ForceFaceActors[0].InitialQuat, targetQuat, fProgress, true);
            ForcedCameraRotation = QuatToRotator(newQuat);
            ForcedCameraRotation.Roll = 0;
            self.SetDesiredRotation(ForcedCameraRotation);
            self.FaceRotation(ForcedCameraRotation, 0.0000000);
            Controller.SetRotation(ForcedCameraRotation);
        }
    }
    //return;    
}

function bool IsJoined()
{
    return (r_JoinSource != none) || r_JoinTarget != none;
    //return ReturnValue;    
}

function AbortJoin()
{
    // End:0x54
    if((r_JoinSource != none) && !r_JoinSource.s_bInitiatingJoin)
    {
        r_JoinSource.UnjoinFromTarget();
    }
    // End:0x7E
    if((r_JoinTarget != none) && !s_bInitiatingJoin)
    {
        UnjoinFromTarget();
    }
    //return;    
}

simulated event StartPhysTween(Vector Target, float fTime, TgPawn.ETweenState tweenState, optional bool bCollideWithWorld = false, optional bool bRotateTowardsTarget = false)
{
    // End:0x37
    if((int(Role) == int(ROLE_Authority)) && IsJoined())
    {
        AbortJoin();
    }
    super(TgPawn).StartPhysTween(Target, fTime, tweenState, bCollideWithWorld, bRotateTowardsTarget);
    //return;    
}

function JoinToTarget(TgPawn_Character Target, Vector SourceLocation, Vector TargetLocation, float TweenDuration)
{
    s_bInitiatingJoin = true;
    r_JoinTarget = Target;
    r_vJoinSourceLocation = SourceLocation;
    r_vJoinTargetLocation = TargetLocation;
    r_fJoinTweenDuration = TweenDuration;
    // End:0xC7
    if(r_JoinTarget != none)
    {
        r_JoinTarget.r_JoinSource = self;
        r_JoinTarget.bNetDirty = true;
        r_JoinTarget.UpdateJoinSourceLocal();
    }
    bNetDirty = true;
    ClientJoinToTarget();
    s_bInitiatingJoin = false;
    //return;    
}

function UnjoinFromTarget()
{
    // End:0x4E
    if(r_JoinTarget != none)
    {
        r_JoinTarget.r_JoinSource = none;
        r_JoinTarget.UpdateJoinSourceLocal();
    }
    r_JoinTarget = none;
    bNetDirty = true;
    ClientUnjoinFromTarget();
    //return;    
}

simulated function ClientJoinToTarget()
{
    ClientUnjoinFromTarget();
    // End:0x64
    if(r_JoinTarget != none)
    {
        m_JoinTargetLocal = r_JoinTarget;
        // End:0x5A
        if(IsViewPawn())
        {
            m_JoinTargetLocal.m_eForcedSilhouetteVisibility = 2;
        }
        TweenForJoin();
    }
    //return;    
}

simulated function ClientUnjoinFromTarget()
{
    // End:0x188
    if(m_JoinTargetLocal != none)
    {
        // End:0x3D
        if(IsViewPawn())
        {
            m_JoinTargetLocal.m_eForcedSilhouetteVisibility = 0;
        }
        RemoveJoinForcedView(m_JoinTargetLocal, self);
        RemoveJoinForcedView(self, m_JoinTargetLocal);
        // End:0xF7
        if(m_JoinTargetLocal.IsAliveAndWell() && (int(m_JoinTargetLocal.Physics) == int(15)) || int(m_JoinTargetLocal.Physics) == int(13))
        {
            m_JoinTargetLocal.SetPhysics(2);
        }
        // End:0x169
        if(self.IsAliveAndWell() && (int(self.Physics) == int(15)) || int(self.Physics) == int(13))
        {
            self.SetPhysics(2);
        }
        m_JoinTargetLocal = none;
        ClearTimer('TweenForJoinFinished');
    }
    //return;    
}

simulated function TweenForJoin()
{
    // End:0xB7
    if(m_JoinTargetLocal != none)
    {
        m_JoinTargetLocal.StartPhysTween(r_vJoinTargetLocation, r_fJoinTweenDuration, 4, true, false);
        self.StartPhysTween(r_vJoinSourceLocation, r_fJoinTweenDuration, 4, true, false);
        SetTimer(r_fJoinTweenDuration + 0.0100000, false, 'TweenForJoinFinished');
        AddJoinForcedView(m_JoinTargetLocal, self);
        AddJoinForcedView(self, m_JoinTargetLocal);
    }
    //return;    
}

simulated function TweenForJoinFinished()
{
    // End:0x81
    if(m_JoinTargetLocal != none)
    {
        m_JoinTargetLocal.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        m_JoinTargetLocal.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        m_JoinTargetLocal.SetPhysics(13);
    }
    self.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    self.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    self.SetPhysics(13);
    //return;    
}

simulated function AddJoinForcedView(TgPawn_Character Source, TgPawn_Character Target)
{
    // End:0x5C
    if((Source != none) && Target != none)
    {
        Source.AddForcedViewTarget(Target, r_fJoinTweenDuration, 100.0000000, self, 0.0000000);
    }
    //return;    
}

simulated function RemoveJoinForcedView(TgPawn_Character Source, TgPawn_Character Target)
{
    // End:0x40
    if((Source != none) && Target != none)
    {
        Source.RemoveForcedViewTarget(self);
    }
    //return;    
}

simulated function UpdateJoinSourceLocal()
{
    // End:0x80
    if(IsViewPawn())
    {
        // End:0x3D
        if(m_JoinSourceLocal != none)
        {
            m_JoinSourceLocal.m_eForcedSilhouetteVisibility = 0;
        }
        m_JoinSourceLocal = r_JoinSource;
        // End:0x80
        if(m_JoinSourceLocal != none)
        {
            m_JoinSourceLocal.m_eForcedSilhouetteVisibility = 2;
        }
    }
    //return;    
}

simulated event bool AdvancedTeleport(const out TeleportParams Params, optional out Vector vTeleportLocation, optional bool bFakeTeleport = false)
{
    local Vector vTargetLocation, vGroundLocation, vGroundNormal, vLosSourceLocation, vTemp;

    local float fBackTraceCurrentDist, fTemp;
    local bool bValidLocation;

    fBackTraceCurrentDist = 0.0000000;
    J0x15:

    bValidLocation = true;
    // End:0x93
    if(Params.bDoBackTrace)
    {
        vTargetLocation = Params.vTargetLocation + (Params.vBackTraceDir * fBackTraceCurrentDist);        
    }
    else
    {
        vTargetLocation = Params.vTargetLocation;
    }
    // End:0x18D
    if(Params.bLookForGround)
    {
        vTemp = vTargetLocation + (vect(0.0000000, 0.0000000, 1.0000000) * Params.fGroundSearchHeight);
        // End:0x18D
        if(FindGround(vTemp, vGroundLocation, vGroundNormal, Params.fGroundSearchHeight, Params.fGroundSearchRayRadius))
        {
            vTargetLocation = vGroundLocation;
        }
    }
    // End:0x27A
    if(Params.bCheckLineOfSight)
    {
        vTemp = self.Location - vTargetLocation;
        vTemp.Z = 0.0000000;
        fTemp = VSize(vTemp);
        vTemp = Normal(vTemp);
        vLosSourceLocation = vTargetLocation + (vTemp * fTemp);
        // End:0x27A
        if(!TeleportTraceCheck(vTargetLocation, vLosSourceLocation))
        {
            bValidLocation = false;
        }
    }
    // End:0x383
    if(bValidLocation && Teleport(vTargetLocation, Params.rTargetRotation, Params.bPlayFx, Params.nTeleportEnterState, Params.nTeleportExitState, true, vTeleportLocation, bFakeTeleport))
    {
        // End:0x381
        if(!bFakeTeleport && Params.fMovementCorrectionDisableTime > 0.0000000)
        {
            DisableMovementCorrection(Params.fMovementCorrectionDisableTime);
        }
        return true;
    }
    fBackTraceCurrentDist += Params.fBackTraceIncrement;
    // End:0x15
    if(!(!Params.bDoBackTrace || fBackTraceCurrentDist >= Params.fBackTraceMaxDist))
        goto J0x15;
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_fMinReclaimPointTime=10.0000000
    m_fMountZoomOverride=1.0000000
    // Reference: TgCustomCharacterComponent'TgGame.Default__TgPawn_Character.CustomCharacterInfo'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CustomCharacterInfo'
    begin object name="CustomCharacterInfo" class=TgGame.TgCustomCharacterComponent
    end object
    m_CustomCharacterComponent=CustomCharacterInfo
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Character.MountedCollision'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MountedCollision'
    begin object name="MountedCollision" class=Engine.CylinderComponent
        CollisionHeight=70.0000000
        CollisionRadius=35.0000000
        ReplacementPrimitive=none
        BlockZeroExtent=false
        BlockNonZeroExtent=false
        Translation=(X=0.0000000,Y=0.0000000,Z=24.0000000)
    end object
    m_MountedCollisionComponent=MountedCollision
    m_fAirJumpZSpeed=600.0000000
    m_HitReactionType=EHitReactionType.HIT_Reaction_Procedural
    c_bUpdatesWeaponMesh=true
    c_bUpdateSkelMeshWhenNotRendered=true
    c_bShowDecalRing=true
    m_bOverlaysEnabled=true
    m_bUseSilhouettes=true
    m_bAcceptsHitReactions=true
    m_bUpdateEyeHeight=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Character.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Biped.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    FireLocationOffsets[1]=(X=0.0000000,Y=0.0000000,Z=55.0000000)
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Character.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Biped.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_Character.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Biped.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    // Reference: AudioComponent'TgGame.Default__TgPawn_Character.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Biped.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_Character.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Biped.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fHUDOverlayMorphMountedZOffset=25.0000000
    bDirectHitWall=true
    PeripheralVision=0.5000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_Character.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Biped.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    InventoryManagerClass=Class'TgGame.TgInventoryManager_Player'
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_Character.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Biped.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=MountedCollision
    Components[8]=CustomCharacterInfo
    bAlwaysRelevant=true
    bIgnoreBaseRotation=true
    CollisionComponent=CollisionCylinder
    RotationRate=(Pitch=0,Yaw=80000,Roll=2048)
}