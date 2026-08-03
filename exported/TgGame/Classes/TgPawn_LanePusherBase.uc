class TgPawn_LanePusherBase extends TgPawn_Biped
    abstract
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const TGPM_REMEMBER_PLAYER_ATTACKED_TIME = 4;

struct native ServerSplineSync
{
    var TgSplineActor Spline;
    var float SplineDist;
    var bool bMoving;

    structdefaultproperties
    {
        Spline=none
        SplineDist=0.0000000
        bMoving=false
    }
};

var float s_fSpeedMultiplierToCatchUpToSquad;
var TgPawn_Character s_PlayerAttacker;
var float s_fMaxRelevancyDistanceSquared;
var const TgSplineActor r_StartSpline;
var repnotify const ServerSplineSync r_ServerSync;
var const bool m_bMoving;
var bool c_bServerSync;
var const bool m_bDoNotScaleCollisionBoxWithDatabase;
var const bool m_bApplySplinePitchToActor;
var const bool c_bApplySplinePitchToMesh;
var const bool m_bFullStopWhenNoDesiredSpeed;
var const bool s_bStopBackpeddlingAtCheckpoints;
var bool m_bAllowBackpeddling;
var bool m_bDestroyed;
var bool r_bAsleep;
var private TgSplineActor m_Spline;
var export editinline StaticMeshComponent m_CollisionBox;
var float m_fSplineDist;
var float c_fSplineDistCorrection;
var float c_fClientSideMovementFudgeFactor;
var float c_fClientCorrectionTolerance;
var float c_fClientCorrectionRate;
var float m_fGroundSpeedScaleLastTick;
var float r_fTrackGroundSpeed;
var float m_fAcceleration;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_ServerSync, r_StartSpline, 
        r_bAsleep, r_fTrackGroundSpeed;
}

// Export UTgPawn_LanePusherBase::execSetInitialLevel(FFrame&, void* const)
native function SetInitialLevel();

// Export UTgPawn_LanePusherBase::execPostPawnSetupServer(FFrame&, void* const)
native function PostPawnSetupServer();

// Export UTgPawn_LanePusherBase::execSetTargetActor(FFrame&, void* const)
native function SetTargetActor(Actor Target);

// Export UTgPawn_LanePusherBase::execSendPing(FFrame&, void* const)
native function SendPing();

// Export UTgPawn_LanePusherBase::execSetSpline(FFrame&, void* const)
native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);

// Export UTgPawn_LanePusherBase::execUpdateMoving(FFrame&, void* const)
native final function UpdateMoving();

// Export UTgPawn_LanePusherBase::execUpdateServerSync(FFrame&, void* const)
native final function UpdateServerSync();

// Export UTgPawn_LanePusherBase::execReceiveServerSync(FFrame&, void* const)
native function ReceiveServerSync();

// Export UTgPawn_LanePusherBase::execSnapToServerSync(FFrame&, void* const)
native function SnapToServerSync();

// Export UTgPawn_LanePusherBase::execIsImmuneToDamage(FFrame&, void* const)
native function bool IsImmuneToDamage();

// Export UTgPawn_LanePusherBase::execIsImmuneToHealing(FFrame&, void* const)
native function bool IsImmuneToHealing();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x26
    if(VarName == 'r_ServerSync')
    {
        c_bServerSync = true;        
    }
    else
    {
        // End:0x47
        if(VarName == 'r_TargetActor')
        {
            TargetActorUpdated();
        }
    }
    super(TgPawn).ReplicatedEvent(VarName);
    //return;    
}

event Despawn()
{
    local TgGame_Arena TgGA;

    TgGA = TgGame_Arena(WorldInfo.Game);
    // End:0x6B
    if(TgGA != none)
    {
        TgGA.OnMinionDespawn(int(GetTaskForceNumber()));
    }
    super(TgPawn).Despawn();
    //return;    
}

event TakeDamage(int Damage, Controller InstigatedBy, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local TgPawn_Character attackerPawn;
    local Class<TgDamageType> TgDamage;

    // End:0x1BD
    if((InstigatedBy != none) && !ClassIsChildOf(DamageType, Class'TgGame.TgDamageType_AbilityCost'))
    {
        attackerPawn = TgPawn_Character(InstigatedBy.Pawn);
        // End:0xD1
        if((attackerPawn != none) && (s_PlayerAttacker == none) || s_PlayerAttacker == attackerPawn)
        {
            ClearTimer('RememberPlayerAttackerExpired');
            s_PlayerAttacker = attackerPawn;
            SetTimer(4.0000000, false, 'RememberPlayerAttackerExpired');
        }
        TgDamage = Class<TgDamageType>(DamageType);
        // End:0x1BD
        if(TgDamage != none)
        {
            Momentum = RandRange(TgDamage.default.m_bMinImpulse, TgDamage.default.m_bMaxImpulse) * Normal(Momentum);
            Momentum.Z += RandRange(TgDamage.default.m_bMinUpKick, TgDamage.default.m_bMaxUpKick);
        }
    }
    super(TgPawn).TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    //return;    
}

function RememberPlayerAttackerExpired()
{
    s_PlayerAttacker = none;
    //return;    
}

simulated event TargetActorUpdated()
{
    local TgPawn TargetPawn;

    TargetPawn = TgPawn(r_TargetActor);
    // End:0x98
    if(((TargetPawn != none) && TargetPawn.Controller != none) && TargetPawn.Controller.IsLocalPlayerController())
    {
        ToggleAggroAlert(true);        
    }
    else
    {
        ToggleAggroAlert(false);
    }
    //return;    
}

simulated function ToggleAggroAlert(bool bOn)
{
    // End:0x92
    if(TgSkeletalMeshComponent(Mesh) != none)
    {
        // End:0x5E
        if(bOn)
        {
            TgSkeletalMeshComponent(Mesh).FxActivateGroup('Targeting Beam', 0);            
        }
        else
        {
            TgSkeletalMeshComponent(Mesh).FxDeactivateGroup('Targeting Beam', 0);
        }
    }
    //return;    
}

simulated function PlayDeathAnimation()
{
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    // End:0xA2
    if((WorldInfo.IsPlayingDemo() && WorldInfo.DemoPlayTimeDilation > 1.0000000) && int(r_eDeathReason) == int(0))
    {
        PlayFullBodyAnim('Death', 1.0000000, 0.0000000, -1.0000000, false, true);        
    }
    else
    {
        super(TgPawn).PlayDeathAnimation();
    }
    //return;    
}

simulated event ClientUpdateMoving()
{
    // End:0x77
    if(Mesh != none)
    {
        // End:0x4C
        if(m_bMoving)
        {
            Mesh.FxActivateGroup('SiegeEngineMoving', 0);            
        }
        else
        {
            Mesh.FxDeactivateGroup('SiegeEngineMoving', 0);
        }
    }
    //return;    
}

simulated event PropertySet(int nPropertyId, float fPreviousValue, float fNewValue)
{
    super(TgPawn).PropertySet(nPropertyId, fPreviousValue, fNewValue);
    // End:0x48
    if(nPropertyId == 49)
    {
        r_fTrackGroundSpeed = fNewValue;
    }
    //return;    
}

function SetMovementPhysics()
{
    SetPhysics(7);
    //return;    
}

simulated function Tick(float DeltaTime)
{
    // End:0x14
    if(int(Role) == int(ROLE_Authority))
    {
    }
    super(TgPawn).Tick(DeltaTime);
    //return;    
}

simulated function DestroyIt(optional bool bSkipFx)
{
    // End:0x10
    if(m_bDestroyed)
    {
        return;
    }
    bNetDirty = true;
    ForceNetRelevant();
    SetCollision(false, false);
    SetPhysics(0);
    m_bDestroyed = true;
    SetHidden(true);
    //return;    
}

function float GetDistanceToEndOfSpline()
{
    local float fDist;

    // End:0x4F
    if(m_Spline != none)
    {
        fDist = m_Spline.DistanceToEndOfSplineChain();
        fDist -= m_fSplineDist;        
    }
    else
    {
        fDist = 0.0000000;
    }
    return fDist;
    //return ReturnValue;    
}

simulated state Dying
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        UpdateMoving();
        //return;        
    }
    stop;    
}

defaultproperties
{
    s_fSpeedMultiplierToCatchUpToSquad=1.2000000
    s_fMaxRelevancyDistanceSquared=10240000.0000000
    c_bApplySplinePitchToMesh=true
    m_bAllowBackpeddling=true
    // Reference: StaticMeshComponent'TgGame.Default__TgPawn_LanePusherBase.CollisionBox'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionBox'
    begin object name="CollisionBox" class=Engine.StaticMeshComponent
        StaticMesh=StaticMesh'GOD_CommonAssets.Meshes.1_unit_Box_Xaxis'
        ReplacementPrimitive=none
        HiddenGame=true
        bSeenByAI=true
    end object
    m_CollisionBox=CollisionBox
    c_fClientCorrectionTolerance=10.0000000
    r_fTrackGroundSpeed=200.0000000
    m_eForcedSilhouetteVisibility=EForcedSilhouetteVisibility.FSV_Visible
    m_bAffectedByVortices=false
    m_bCannotBeVolumeStealthed=true
    m_bIsAIVisionBlocker=true
    m_bCanBeKnockedBack=false
    m_bCausesPushblock=false
    m_bPushblockAffectsEnemies=true
    m_bUseSmoothNetReceiveRotation=false
    m_bForceSmoothCorrection=true
    r_bHasAccurateRotation=false
    c_bUpdateSkelMeshWhenNotRendered=true
    c_bUpdateSkelMeshWhenNotRenderedServer=true
    m_bUseSilhouettes=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_LanePusherBase.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgPawn_Biped.MyLightEnvironment'
    begin object name="MyLightEnvironment"
        bSynthesizeSHLight=false
    end object
    LightEnvironment=MyLightEnvironment
    FireLocationOffsets[1]=(X=30.0000000,Y=4.0000000,Z=25.0000000)
    // Reference: TgDropShadowDecalComponent'TgGame.Default__TgPawn_LanePusherBase.ShadowDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ShadowDecal'
    // Archetype: TgDropShadowDecalComponent'TgGame.Default__TgPawn_Biped.ShadowDecal'
    begin object name="ShadowDecal"
        ReplacementPrimitive=none
        Scale=0.7500000
    end object
    c_PlayerDropShadow=ShadowDecal
    // Reference: TgManifestGroup'TgGame.Default__TgPawn_LanePusherBase.TgManifestGroup0'
    // Archetype: TgManifestGroup'TgGame.Default__TgPawn_Biped.TgManifestGroup0'
    begin object name="TgManifestGroup0"
    end object
    c_AssetManifestGroup=TgManifestGroup0
    m_fHitReactionAIPauseTime=0.0000000
    m_fHitReactionBlendOutTime=0.0000000
    // Reference: AudioComponent'TgGame.Default__TgPawn_LanePusherBase.TakeHitAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TakeHitAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Biped.TakeHitAC'
    begin object name="TakeHitAC"
    end object
    m_TakeHitAudioComponent=TakeHitAC
    // Reference: AudioComponent'TgGame.Default__TgPawn_LanePusherBase.PainAC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PainAC'
    // Archetype: AudioComponent'TgGame.Default__TgPawn_Biped.PainAC'
    begin object name="PainAC"
    end object
    m_PainAudioComponent=PainAC
    m_fHUDOverlayZOffset=-200.0000000
    bIgnoreForces=true
    bCanBeBaseForPawns=true
    AirSpeed=0.0000000
    AirControl=0.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPawn_LanePusherBase.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPawn_Biped.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
        CollideActors=false
        BlockActors=false
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=MyLightEnvironment
    Components[3]=CollisionCylinder
    Components[4]=TakeHitAC
    Components[5]=PainAC
    // Reference: PComPositionHistoryComponent'TgGame.Default__TgPawn_LanePusherBase.PositionHistoryComponent'
    // Archetype: PComPositionHistoryComponent'TgGame.Default__TgPawn_Biped.PositionHistoryComponent'
    begin object name="PositionHistoryComponent"
    end object
    Components[6]=PositionHistoryComponent
    Components[7]=CollisionBox
    Physics=EPhysics.PHYS_Interpolating
    bReplicateMovement=false
    bUpdateSimulatedPosition=false
    bCollideWorld=false
    bBlocksTeleport=true
    bCollideAsEncroacher=true
    m_bSupportsRelativeLocationBase=true
    CollisionComponent=CollisionBox
    RotationRate=(Pitch=0,Yaw=40000,Roll=2048)
}