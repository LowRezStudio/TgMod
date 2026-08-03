class TgProjectile extends Projectile
    native(Projectiles)
    nativereplication
    hidecategories(Navigation)
    implements(TgSkinnableInterface,TgObserver_ViewTargetChanged);

const PROJECTILE_LINE_TRACE_DISTANCE = 32;

enum SpawnDeployableOrientation
{
    SDO_AlignUpToNormal,            // 0
    SDO_FaceRotation,               // 1
    SDO_MAX                         // 2
};

struct native CollisionSettingsProjectile
{
    var bool bPassThroughFriends;
    var bool bPassThroughEnemies;
    var bool bPassThroughShields;
    var bool bPassThroughBlocker;
    var bool bExplodeOnShields;
    var bool bExplodeOnBlockers;
    var bool bHitAndPassThrough;
    var bool bHitOnTick;
    var bool bOnlyHitOnceOnPassThrough;

    structdefaultproperties
    {
        bPassThroughFriends=false
        bPassThroughEnemies=false
        bPassThroughShields=false
        bPassThroughBlocker=false
        bExplodeOnShields=false
        bExplodeOnBlockers=false
        bHitAndPassThrough=false
        bHitOnTick=false
        bOnlyHitOnceOnPassThrough=false
    }
};

struct native TrackingSettings
{
    var const bool bUsesTracking;
    var Actor mTarget;
    var float fTurnStrength;
    var float fVertTurnStrength;
    var bool bIgnoreNonTargets;
    var bool bIgnoreWorldIfSeeking;
    var bool bIgnoreWorldIfNotSeeking;

    structdefaultproperties
    {
        bUsesTracking=false
        mTarget=none
        fTurnStrength=0.0000000
        fVertTurnStrength=0.0000000
        bIgnoreNonTargets=false
        bIgnoreWorldIfSeeking=false
        bIgnoreWorldIfNotSeeking=false
    }
};

var private native const noexport Pointer VfTable_ITgSkinnableInterface;
var private native const noexport Pointer VfTable_ITgObserver_ViewTargetChanged;
var TgDeviceFire s_LastDefaultMode;
var repnotify int r_nProjectileId;
var repnotify float r_fDuration;
var float m_fPostLandDuration;
var float m_fLandZThreshold;
var float m_fPersistTime;
var float m_fPersistHitPulse;
var int m_nTargetPhysicalType;
var export editinline MeshComponent c_Mesh;
var TgSpecialFx c_ExplosionFx;
var TgImpactFx c_ImpactFx;
var bool c_bRotationFollowsVelocity;
var bool m_bExplodeAtMaxRange;
var bool m_bDeployOnCharacter;
var bool m_bDeployOnTarget;
var bool m_bDeployOnGround;
var bool m_bAlwaysDeployUpwards;
var bool m_bStickToWalls;
var bool c_bIsAOE;
var bool m_bCountDirectHitForAOE;
var bool m_bUseAOEDirectHit;
var bool m_bHasExploded;
var bool m_bHitValidTarget;
var bool m_bIngoreBehindProjCollisions;
var bool m_bIsInitialized;
var bool m_bIsShutDown;
var bool m_bPIEInitialized;
var bool m_bHasPlayedFizzleFX;
var bool m_bHasPlayedHitWallFX;
var bool m_bHasPlayedHitTargetFX;
var bool m_bSuppressDeployableSpawn;
var bool m_bAltFireHit;
var bool m_bInvertTeam;
var bool m_bFirstShotAfterMovementAbility;
var bool m_bCanSpawnOnClientFirst;
var bool m_bTrackToWorldLocation;
var float r_fAccelRate;
var float m_fTossZ;
var float m_fFireAngle;
var Actor r_Owner;
var repnotify int r_nOwnerFireModeId;
var TgDeviceFire m_OwnerFireMode;
var array<TgDeviceFire> m_ExtraFireModes;
var float r_fRange;
var float m_fProximityDistance;
var TgCollisionProxy m_CollisionProxy;
var int s_nSpawnBotId;
var int s_nSpawnDeployableId;
var TgProjectile.SpawnDeployableOrientation m_DeployableSpawnOrientation;
var TgObject.TG_EQUIP_POINT r_eEquippedAt;
var float m_fDamageRadius;
var Vector r_vSpawnLocation;
var Vector m_vSpawnRotation;
var Vector m_vLocationLastTick;
var float m_fMinTravelRange;
var float s_fSpawnTime;
var int m_nPostRenderIcon;
var int m_nUniqueId;
var float m_fBaseDamageMultiplier;
var Vector c_vHitWallVelocity;
var() const editconst export editinline DynamicLightEnvironmentComponent LightEnvironment;
var Vector m_vSpawnPosition;
var export editinline ParticleSystemComponent m_DebugProximityDistancePSC;
var float m_fStandingStillPercent;
var int m_nTargetsHitCount;
var CollisionSettingsProjectile m_CollisionSettings;
var array<Actor> m_PassThroughTargets;
var TrackingSettings m_TrackingSettings;
var float m_fDelayTrackSeconds;
var float m_fExplosionOffsetDistance;
var float s_fAoeRewindTime;
var TgAkActorUnoccluded m_AkActorUnoccluded;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_Owner, r_eEquippedAt, 
        r_fAccelRate, r_fDuration, 
        r_fRange, r_nOwnerFireModeId, 
        r_nProjectileId, r_vSpawnLocation;
}

// Export UTgProjectile::execGetBuffedRange(FFrame&, void* const)
native function float GetBuffedRange();

// Export UTgProjectile::execCheckPhysicality(FFrame&, void* const)
native function bool CheckPhysicality(int nPawnType);

// Export UTgProjectile::execCompleteInitialization(FFrame&, void* const)
native function CompleteInitialization();

// Export UTgProjectile::execNativePostRenderFor(FFrame&, void* const)
native simulated function NativePostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir);

// Export UTgProjectile::execSpawnBot(FFrame&, void* const)
native function TgPawn SpawnBot(Vector vLocation, bool bPet);

// Export UTgProjectile::execGetBotSpawnLocationAndRotation(FFrame&, void* const)
native function bool GetBotSpawnLocationAndRotation(out Vector OutLocation, out Rotator OutRotation, Vector vLocation, Pointer botSetup);

// Export UTgProjectile::execSpawnDeployable(FFrame&, void* const)
native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);

// Export UTgProjectile::execGetDeployLocationAndRotation(FFrame&, void* const)
native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation, Vector vLocation, optional Actor TargetActor, optional Vector vNormal);

// Export UTgProjectile::execOnViewTargetChanged(FFrame&, void* const)
native function OnViewTargetChanged(optional Actor aNewViewTarget);

// Export UTgProjectile::execPostAkEvent(FFrame&, void* const)
native function PostAkEvent(AkEvent InAkEvent);

// Export UTgProjectile::execGetTerminalVelocity(FFrame&, void* const)
native function float GetTerminalVelocity();

event bool UseAOE()
{
    return (m_OwnerFireMode != none) && m_OwnerFireMode.m_bIsAOE;
    //return ReturnValue;    
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x50
    if(GetALocalPlayerController() != none)
    {
        GetALocalPlayerController().myHUD.AddPostRenderedActor(self);
    }
    m_vSpawnPosition = Location;
    // End:0x83
    if(int(Role) < int(ROLE_Authority))
    {
        m_bIsInitialized = true;
    }
    //return;    
}

event PostProjectileInitialize()
{
    // End:0x66
    if(int(Role) == int(ROLE_Authority))
    {
        s_fSpawnTime = WorldInfo.TimeSeconds;
        // End:0x66
        if(r_fDuration > 0.0000000)
        {
            SetTimer(r_fDuration, false, 'TimerExplode');
        }
    }
    //return;    
}

simulated function StartPulse()
{
    // End:0x15
    if(m_fPersistHitPulse == 0.0000000)
    {
        return;
    }
    TimerPulse();
    SetTimer(m_fPersistHitPulse, true, 'TimerPulse');
    SetPhysics(0);
    HideProjectile();
    SetCollision(false, false);
    Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    SetTimer(m_fPersistTime, false, 'ShutDown');
    //return;    
}

simulated event ClientSetExplode()
{
    // End:0x2A
    if(r_fDuration > 0.0000000)
    {
        SetTimer(r_fDuration, false, 'TimerExplode');
    }
    //return;    
}

simulated function TimerPulse()
{
    ApplyHit(none, Location, vect(0.0000000, 0.0000000, 0.0000000));
    //return;    
}

simulated function TimerExplode()
{
    local Vector HitNormal;

    ImpactedActor = self;
    Explode(Location, HitNormal);
    //return;    
}

simulated event Landed(Vector HitNormal, Actor FloorActor)
{
    super(Actor).Landed(HitNormal, FloorActor);
    Explode(Location, HitNormal);
    //return;    
}

event Init(Vector Direction)
{
    local TgPawn TgP;
    local bool bPlayerControlled;

    SetRotation(Rotator(Direction));
    TgP = TgPawn(r_Owner);
    // End:0xA3
    if(TgP != none)
    {
        // End:0xA3
        if((TgP.Controller != none) && TgP.Controller.IsA('PlayerController'))
        {
            bPlayerControlled = true;
        }
    }
    Velocity = CalculateInitialVelocity(Direction, bPlayerControlled);
    SetAcceleration();
    //return;    
}

// Export UTgProjectile::execCalculateInitialVelocity(FFrame&, void* const)
native function Vector CalculateInitialVelocity(Vector vAimDirection, bool bPlayerControlled);

simulated function bool CheckProjectileRange(optional Vector vLocOverride)
{
    local Vector vActualLocation;

    // End:0x4A
    if(m_TrackingSettings.bUsesTracking && m_TrackingSettings.mTarget != none)
    {
        return true;        
    }
    else
    {
        // End:0x5D
        if(r_fRange == float(0))
        {
            return true;
        }
    }
    vActualLocation = ((VSizeSq(vLocOverride) > float(0)) ? vLocOverride : Location);
    // End:0xB4
    if(VSize(vActualLocation - r_vSpawnLocation) > r_fRange)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

function RangeReached()
{
    // End:0x1A
    if(m_bExplodeAtMaxRange)
    {
        ServerDetonate();        
    }
    else
    {
        ServerFizzle();
    }
    //return;    
}

simulated function UpdateSeekingDirection(float fDeltaTime)
{
    local Vector moveVector, TargetLocation;
    local float fDist, vertTurnStrength, turnStrength, Pitch;
    local Rotator Rot, targetRot;

    Rot = Rotation;
    Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    // End:0x2C4
    if(m_TrackingSettings.mTarget != none)
    {
        TargetLocation = GetSeekLocation();
        moveVector = TargetLocation - Location;
        fDist = VSize(moveVector);
        // End:0x12C
        if(fDist < float(32))
        {
            Move(moveVector);
            Velocity = vect(0.0000000, 0.0000000, 0.0000000);
            ExplodeOnTarget(m_TrackingSettings.mTarget, m_TrackingSettings.mTarget.Location, Normal(moveVector));
            return;
        }
        targetRot = Rotator(Normal(TargetLocation - Location));
        turnStrength = m_TrackingSettings.fTurnStrength;
        vertTurnStrength = m_TrackingSettings.fVertTurnStrength;
        // End:0x1D5
        if((fDist > float(1)) && fDist < float(100))
        {
            Rot = targetRot;            
        }
        else
        {
            Pitch = FInterpTo(float(Rot.Pitch), float(targetRot.Pitch), fDeltaTime, vertTurnStrength);
            Rot = RInterpTo(Rot, targetRot, fDeltaTime, turnStrength);
            Rot.Pitch = int(Pitch);
        }
        SetRotation(Rot);
        Velocity = Vector(Rot) * Speed;
    }
    //return;    
}

simulated event Vector GetSeekLocation()
{
    local float fDist, fSpeed;
    local Vector TargetLocation;

    // End:0x39
    if(m_TrackingSettings.mTarget == none)
    {
        return Location + Vector(Rotation);
    }
    TargetLocation = m_TrackingSettings.mTarget.Location;
    // End:0x10E
    if(m_TrackingSettings.mTarget.CollisionComponent != none)
    {
        TargetLocation = m_TrackingSettings.mTarget.CollisionComponent.Bounds.Origin;
    }
    fDist = VSize(TargetLocation - Location);
    fSpeed = VSize(Velocity);
    // End:0x1E3
    if((fSpeed > float(0)) && VSizeSq(m_TrackingSettings.mTarget.Velocity) > float(0))
    {
        TargetLocation += (m_TrackingSettings.mTarget.Velocity * (fDist / fSpeed));
    }
    return TargetLocation;
    //return ReturnValue;    
}

event SetTarget(Actor TargetActor, optional Vector TargetLocation)
{
    // End:0xAD
    if(m_TrackingSettings.bUsesTracking)
    {
        m_TrackingSettings.mTarget = TargetActor;
        // End:0x83
        if(TargetActor != none)
        {
            bCollideWorld = !m_TrackingSettings.bIgnoreWorldIfSeeking;            
        }
        else
        {
            bCollideWorld = !m_TrackingSettings.bIgnoreWorldIfNotSeeking;
        }
    }
    //return;    
}

simulated function bool IsValidTarget(Actor A)
{
    local bool bValidTarget;
    local TgPawn PawnTarget;
    local TgDeployable deployTarget;
    local TgDestructible destTarget;
    local int nPhysicality;

    bValidTarget = false;
    // End:0x5D
    if(m_OwnerFireMode != none)
    {
        bValidTarget = m_OwnerFireMode.IsValidTarget(A,,, m_bInvertTeam);        
    }
    else
    {
        PawnTarget = TgPawn(A);
        deployTarget = TgDeployable(A);
        destTarget = TgDestructible(A);
        // End:0x303
        if(((PawnTarget != none) || deployTarget != none) || destTarget != none)
        {
            nPhysicality = 0;
            // End:0x187
            if(PawnTarget != none)
            {
                nPhysicality = PawnTarget.r_nPhysicalType;
                // End:0x184
                if((!PawnTarget.IsNonCombat() && IsEnemy(A)) && CheckPhysicality(nPhysicality))
                {
                    bValidTarget = true;
                }                
            }
            else
            {
                // End:0x248
                if((deployTarget != none) && deployTarget.bProjTarget)
                {
                    nPhysicality = deployTarget.r_nPhysicalType;
                    // End:0x245
                    if((IsEnemy(A) && CheckPhysicality(nPhysicality)) && deployTarget.GetMaxHealth() > float(0))
                    {
                        bValidTarget = true;
                    }                    
                }
                else
                {
                    // End:0x303
                    if((destTarget != none) && destTarget.bProjTarget)
                    {
                        nPhysicality = destTarget.m_nPhysicalType;
                        // End:0x303
                        if((IsEnemy(A) && CheckPhysicality(nPhysicality)) && destTarget.r_nMaxHealth > 0)
                        {
                            bValidTarget = true;
                        }
                    }
                }
            }
        }
    }
    return bValidTarget;
    //return ReturnValue;    
}

simulated function GetHitLocationForProximityTouch(Actor Target, out Vector HitLocation, out Vector HitNormal)
{
    local Vector accHitLocation, accHitNormal, StartTrace, EndTrace;

    StartTrace = HitLocation - (Normal(Velocity) * 100.0000000);
    EndTrace = HitLocation + (Normal(Velocity) * 100.0000000);
    // End:0x106
    if(TraceComponent(accHitLocation, accHitNormal, Target.CollisionComponent, EndTrace, StartTrace, vect(0.0000000, 0.0000000, 0.0000000),, Target.bCollideComplex))
    {
        HitLocation = accHitLocation - (Normal(Velocity) * 2.0000000);
        HitNormal = accHitNormal;
        return;
    }
    // End:0x257
    if(CylinderComponent(Target.CollisionComponent) != none)
    {
        StartTrace = HitLocation;
        EndTrace = Target.CollisionComponent.Bounds.Origin;
        // End:0x257
        if(TraceComponent(accHitLocation, accHitNormal, Target.CollisionComponent, EndTrace, StartTrace, vect(0.0000000, 0.0000000, 0.0000000),, Target.bCollideComplex))
        {
            HitLocation = accHitLocation - (Normal(EndTrace - StartTrace) * 2.0000000);
            HitNormal = accHitNormal;
        }
    }
    //return;    
}

simulated function bool ProximityReached(Actor A, Vector HitLocation, Vector HitNormal)
{
    local bool bValidTarget;
    local Vector ReferencePoint, AccurateHitLocation, MovementDirection;
    local TgDeployable deployTarget;

    bValidTarget = (IsValidTarget(A)) && !CheckTeamPassThrough(A);
    // End:0x4B
    if(m_fProximityDistance <= float(0))
    {
        return false;
    }
    deployTarget = TgDeployable(A);
    // End:0x123
    if(((deployTarget != none) && (int(deployTarget.m_CollisionSettings.mCollisionMode) == int(2)) || int(deployTarget.m_CollisionSettings.mCollisionMode) == int(1)) || A.IsA('TgDestructible'))
    {
        bValidTarget = false;
    }
    MovementDirection = Normal(Velocity);
    // End:0x2C7
    if(bValidTarget)
    {
        ReferencePoint = m_vLocationLastTick;
        // End:0x17A
        if(IsZero(ReferencePoint))
        {
            ReferencePoint = r_vSpawnLocation;
        }
        AccurateHitLocation = HitLocation;
        GetHitLocationForProximityTouch(A, AccurateHitLocation, HitNormal);
        // End:0x203
        if((VSizeSq(r_vSpawnLocation) > 0.0000000) && m_bIngoreBehindProjCollisions)
        {
            // End:0x203
            if((Normal(AccurateHitLocation - ReferencePoint) Dot MovementDirection) < -0.2000000)
            {
                return false;
            }
        }
        // End:0x257
        if((m_OwnerFireMode != none) && m_OwnerFireMode.IsBlockedByBlocker(self, A, ReferencePoint, AccurateHitLocation) != none)
        {
            return false;
        }
        // End:0x2A0
        if(Abs(1.0000000 - Abs(Normal(AccurateHitLocation - Location) Dot MovementDirection)) > 0.0010000)
        {
            AccurateHitLocation = Location;
        }
        ProcessTouch(A, AccurateHitLocation, HitNormal);
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function SetAcceleration()
{
    Acceleration = Normal(Velocity) * r_fAccelRate;
    //return;    
}

simulated function bool IsOutsideMinRange(Vector HitLocation)
{
    local float fDistanceTraveled;

    // End:0x22
    if(m_TrackingSettings.bUsesTracking)
    {
        return true;
    }
    fDistanceTraveled = VSize2D(r_vSpawnLocation - HitLocation);
    return fDistanceTraveled >= m_fMinTravelRange;
    //return ReturnValue;    
}

simulated event HitWall(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    local KActorFromStatic NewKActor;
    local editinline StaticMeshComponent HitStaticMesh;
    local TgDeployable hitDeployable;

    // End:0x30
    if(!IsOutsideMinRange(Location))
    {
        bHurtEntry = true;
        ShutDown();
        return;
    }
    hitDeployable = TgDeployable(Wall);
    // End:0xB3
    if(((hitDeployable != none) && int(hitDeployable.m_CollisionSettings.mCollisionMode) != int(0)) && CheckTeamPassThrough(hitDeployable))
    {
        return;
    }
    // End:0x108
    if(Wall.IsA('TgFracturedStaticMeshActor'))
    {
        // End:0x108
        if(m_bIsInitialized)
        {
            ExplodeOnTarget(Wall, Location, HitNormal);
        }
    }
    TriggerEventClass(Class'Engine.SeqEvent_HitWall', Wall);
    // End:0x1EC
    if(Wall.bWorldGeometry)
    {
        HitStaticMesh = StaticMeshComponent(WallComp);
        // End:0x1EC
        if((HitStaticMesh != none) && HitStaticMesh.CanBecomeDynamic())
        {
            NewKActor = Class'Engine.KActorFromStatic'.static.MakeDynamic(HitStaticMesh);
            // End:0x1EC
            if(NewKActor != none)
            {
                Wall = NewKActor;
            }
        }
    }
    ImpactedActor = Wall;
    PlayHitWallExplosionFX(HitNormal, Location);
    ExplodeOnTarget(((Wall.bStatic) ? none : Wall), Location, HitNormal);
    ImpactedActor = none;
    //return;    
}

simulated event FellOutOfWorld(Class<DamageType> dmgType)
{
    Explode(Location, vect(0.0000000, 0.0000000, 1.0000000));
    //return;    
}

simulated event ProcessTouchAsEvent(Actor Other, Vector HitLocation, Vector HitNormal)
{
    ProcessTouch(Other, HitLocation, HitNormal);
    //return;    
}

function ShutdownAndNotifyClient()
{
    bHurtEntry = true;
    ShutDown();
    //return;    
}

simulated function bool HandleOnProjectileHitTarget(Actor Other, Vector HitLocation, Vector HitNormal)
{
    local TgPawn HitPawn;
    local byte bDestroyProjectile;

    HitPawn = TgPawn(Other);
    // End:0x9C
    if(HitPawn != none)
    {
        bDestroyProjectile = 0;
        HitPawn.OnProjectileHitTarget(self, HitLocation, HitNormal, bDestroyProjectile);
        // End:0x9C
        if(int(bDestroyProjectile) != int(0))
        {
            Fizzle();
            ShutdownAndNotifyClient();
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
    // End:0x217
    if(m_bIsInitialized)
    {
        // End:0x37
        if((Instigator == none) || Other == Instigator)
        {
            return;
        }
        // End:0x4F
        if(CheckTeamPassThrough(Other))
        {
            return;
        }
        // End:0x7F
        if(!IsOutsideMinRange(HitLocation))
        {
            bHurtEntry = true;
            ShutDown();
            return;
        }
        // End:0x99
        if(!CheckProjectileRange(HitLocation))
        {
            return;
        }
        // End:0xB1
        if(ForcefieldExclusionCheck(Other))
        {
            return;
        }
        // End:0xDB
        if(HandleOnProjectileHitTarget(Other, HitLocation, HitNormal))
        {
            return;
        }
        // End:0x118
        if(ShouldExplodeOnTouching(Other))
        {
            ExplodeOnTarget(Other, HitLocation, HitNormal);
            return;
        }
        // End:0x1AF
        if(IsValidTarget(Other))
        {
            // End:0x187
            if(!bHurtEntry && m_CollisionSettings.bHitAndPassThrough)
            {
                HitPassThroughTarget(Other, HitLocation, HitNormal);                
            }
            else
            {
                ExplodeOnTarget(Other, HitLocation, HitNormal);
            }            
        }
        else
        {
            // End:0x1EE
            if((m_OwnerFireMode != none) && !m_bHitValidTarget)
            {
                m_OwnerFireMode.HandleMiss();
            }
            ExplodeOnTarget(Other, HitLocation, -Normal(Velocity));
        }
    }
    //return;    
}

simulated function bool ForcefieldExclusionCheck(Actor Other)
{
    local TgDeployable deployable;

    deployable = TgDeployable(Other);
    // End:0x13A
    if(((deployable != none) && int(deployable.m_CollisionSettings.mCollisionMode) != int(0)) && deployable.m_CollisionSettings.fProjectileAllowanceRadius > float(0))
    {
        // End:0x13A
        if(VSizeSq(deployable.Location - m_vSpawnPosition) <= (deployable.m_CollisionSettings.fProjectileAllowanceRadius * deployable.m_CollisionSettings.fProjectileAllowanceRadius))
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldExplodeOnTouching(Actor Other)
{
    local TgDeployable deployable;

    // End:0x11
    if(Other == none)
    {
        return false;
    }
    deployable = TgDeployable(Other);
    // End:0x9E
    if(((deployable != none) && m_CollisionSettings.bExplodeOnShields) && int(deployable.m_CollisionSettings.mCollisionMode) == int(1))
    {
        return true;
    }
    // End:0x10F
    if(((deployable != none) && m_CollisionSettings.bExplodeOnBlockers) && int(deployable.m_CollisionSettings.mCollisionMode) == int(2))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function HitPassThroughTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x24
    if(!m_CollisionSettings.bHitAndPassThrough)
    {
        return;
    }
    // End:0x69
    if(m_PassThroughTargets.Find(Target) == -1)
    {
        m_bHitValidTarget = true;
        m_PassThroughTargets.AddItem(Target);        
    }
    else
    {
        // End:0x8B
        if(m_CollisionSettings.bOnlyHitOnceOnPassThrough)
        {
            return;
        }
    }
    // End:0xF5
    if(!m_CollisionSettings.bHitOnTick && m_PassThroughTargets.Find(Target) != -1)
    {
        ApplyHit(Target, HitLocation, HitNormal);
    }
    //return;    
}

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x4C
    if(Other.bProjTarget)
    {
        // End:0x4C
        if(ProximityReached(Other, HitLocation, HitNormal))
        {
            return;
        }
    }
    // End:0x105
    if(m_CollisionSettings.bHitAndPassThrough && m_CollisionSettings.bHitOnTick)
    {
        // End:0x105
        if(((m_PassThroughTargets.Find(Other) == -1) && m_OwnerFireMode != none) && m_OwnerFireMode.IsValidTarget(Other))
        {
            m_PassThroughTargets.AddItem(Other);
        }
    }
    //return;    
}

simulated event ProxyUnTouch(Actor Other)
{
    // End:0x78
    if(m_CollisionSettings.bHitAndPassThrough && m_CollisionSettings.bHitOnTick)
    {
        // End:0x78
        if(m_PassThroughTargets.Find(Other) != -1)
        {
            m_PassThroughTargets.RemoveItem(Other);
        }
    }
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    // End:0x141
    if(m_TrackingSettings.bUsesTracking && m_TrackingSettings.mTarget != none)
    {
        // End:0xB6
        if((TgPawn(m_TrackingSettings.mTarget) != none) && m_TrackingSettings.mTarget.IsInState('Dying'))
        {
            ShutDown();            
        }
        else
        {
            // End:0x12E
            if((TgDeployable(m_TrackingSettings.mTarget) != none) && TgDeployable(m_TrackingSettings.mTarget).m_bInDestroyedState)
            {
                ShutDown();                
            }
            else
            {
                UpdateSeekingDirection(DeltaSeconds);
            }
        }
    }
    //return;    
}

simulated event bool CheckTeamPassThrough(Actor Other)
{
    local TgTeamBlocker blocker;
    local TgKAsset_ClientSideSim ClientSideKAsset;
    local TraceHitInfo HitInfo;
    local Vector HitLocation, HitNormal;
    local TgPawn TargetPawn;
    local TgDeployable TargetDeployable;
    local TgPawn OwningPawn;
    local TgDeploy_BombKingStickyBomb BKStickyBomb;

    // End:0x11
    if(Other == none)
    {
        return true;
    }
    // End:0xBF
    if(m_TrackingSettings.bUsesTracking)
    {
        // End:0xBF
        if(m_TrackingSettings.bIgnoreNonTargets && m_TrackingSettings.mTarget != none)
        {
            // End:0xBD
            if(Other != m_TrackingSettings.mTarget)
            {
                return m_TrackingSettings.bIgnoreNonTargets;
            }
            return false;
        }
    }
    ClientSideKAsset = TgKAsset_ClientSideSim(Other);
    // End:0x182
    if(ClientSideKAsset != none)
    {
        Trace(HitLocation, HitNormal, Location, Location + (Normal(Velocity) * float(32)), true, vect(0.0000000, 0.0000000, 0.0000000), HitInfo, 1);
        ClientSideKAsset.OnHit(Location, Normal(Velocity) * -1.0000000, self, HitInfo);
        return true;
    }
    BKStickyBomb = TgDeploy_BombKingStickyBomb(Other);
    // End:0x1DB
    if(BKStickyBomb != none)
    {
        // End:0x1DB
        if(BKStickyBomb.r_StuckPlayer == Instigator)
        {
            return true;
        }
    }
    // End:0x221
    if(m_CollisionSettings.bPassThroughBlocker && Other.bWorldGeometry)
    {
        return true;
    }
    blocker = TgTeamBlocker(Other);
    // End:0x288
    if(blocker != none)
    {
        return !blocker.m_bBlockFriendlyFire && !IsEnemy(blocker);
    }
    OwningPawn = TgPawn(Instigator);
    TargetPawn = TgPawn(Other);
    TargetDeployable = TgDeployable(Other);
    // End:0x42B
    if(TargetPawn != none)
    {
        // End:0x32C
        if(TargetPawn.IsA('TgPawn_SiegeWall'))
        {
            return m_CollisionSettings.bPassThroughBlocker;
        }
        // End:0x359
        if(TargetPawn.GetPropCurrentValue(132) > 0.0000000)
        {
            return true;
        }
        switch(TargetPawn.r_nPhysicalType)
        {
            // End:0x389
            case 10035:
            // End:0x3D2
            case 15046:
                // End:0x3CF
                if((OwningPawn != none) && OwningPawn.IsMyPet(Other))
                {
                    return false;
                }
                // End:0x3D5
                break;
            // End:0xFFFF
            default:
                break;
        }
        return ((IsEnemy(Other)) ? m_CollisionSettings.bPassThroughEnemies : m_CollisionSettings.bPassThroughFriends);        
    }
    else
    {
        // End:0x6FC
        if(TargetDeployable != none)
        {
            // End:0x476
            if(TargetDeployable.IsA('TgDeploy_Transporter'))
            {
                return !IsEnemy(Other);                
            }
            else
            {
                // End:0x62D
                if(int(TargetDeployable.m_CollisionSettings.mCollisionMode) != int(0))
                {
                    return (((m_CollisionSettings.bPassThroughShields && int(TargetDeployable.m_CollisionSettings.mCollisionMode) == int(1)) || m_CollisionSettings.bPassThroughBlocker && int(TargetDeployable.m_CollisionSettings.mCollisionMode) == int(2)) || !TargetDeployable.m_CollisionSettings.bBlockFriendlyFire && !IsEnemy(TargetDeployable)) || TargetDeployable.m_CollisionSettings.bOnlyBlockShotsFromFront && (Vector(TargetDeployable.Rotation) Dot Velocity) > float(0);
                }
            }
            switch(TargetDeployable.r_nPhysicalType)
            {
                // End:0x65D
                case 10035:
                // End:0x6A6
                case 15046:
                    // End:0x6A3
                    if((OwningPawn != none) && OwningPawn.IsMyPet(Other))
                    {
                        return false;
                    }
                    // End:0x6A9
                    break;
                // End:0xFFFF
                default:
                    break;
            }
            return ((IsEnemy(Other)) ? m_CollisionSettings.bPassThroughEnemies : m_CollisionSettings.bPassThroughFriends);
        }
    }
    return false;
    //return ReturnValue;    
}

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator)
{
    return FireMode.ApplyHit(Impact, DamageInstigator);
    //return ReturnValue;    
}

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem)
{
    local TgDevice DeviceOwner;
    local ImpactInfo DirectImpact;
    local TraceHitInfo HitInfo;
    local array<ImpactInfo> ImpactInfoList;
    local int I, J;
    local AimData Aim;
    local bool bRet;

    // End:0x2C
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        return false;
    }
    // End:0x3D
    if(m_OwnerFireMode == none)
    {
        return false;
    }
    // End:0x215
    if((Target != none) && m_OwnerFireMode.IsValidTarget(Target,,, m_bInvertTeam))
    {
        DirectImpact.StartTrace = r_vSpawnLocation;
        DirectImpact.HitActor = Target;
        DirectImpact.HitLocation = HitLocation;
        DirectImpact.HitNormal = Normal(-Velocity);
        DirectImpact.RayDir = float(-1) * HitNormal;
        DirectImpact.HitInfo = HitInfo;
        DirectImpact.HitInfo.Item = HitItem;
        DirectImpact.bDirectHit = (!UseAOE() || m_bUseAOEDirectHit) || m_bCountDirectHitForAOE;
        DirectImpact.Projectile = self;
    }
    // End:0x3D5
    if(!UseAOE() || m_bUseAOEDirectHit)
    {
        // End:0x3D5
        if(DirectImpact.HitActor != none)
        {
            m_OwnerFireMode.AddEffectiveRangeReduction(DirectImpact, self, r_vSpawnLocation);
            // End:0x2C8
            if(m_bAltFireHit)
            {
                m_OwnerFireMode.ApplyHitSpecial(Target, DirectImpact);
            }
            bRet = ApplyTheHit(m_OwnerFireMode, DirectImpact, self);
            I = 0;
            J0x2FB:

            // End:0x3CA [Loop If]
            if(I < m_ExtraFireModes.Length)
            {
                // End:0x3BC
                if(m_ExtraFireModes[I].IsValidTarget(Target))
                {
                    ApplyTheHit(m_ExtraFireModes[I], DirectImpact, self);
                    // End:0x3BC
                    if(m_bAltFireHit)
                    {
                        m_ExtraFireModes[I].ApplyHitSpecial(Target, DirectImpact);
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x2FB;
            }
            return bRet;
        }
    }
    // End:0x9DA
    if(UseAOE())
    {
        SetLocation(HitLocation);
        Aim.StartTrace = HitLocation;
        Aim.EndTrace = HitLocation;
        Aim.AimVector = Vector(Rotation);        
        m_OwnerFireMode.CalcWeaponModeFire(self, Aim, ImpactInfoList, false, false, s_fAoeRewindTime);
        // End:0x555
        if((Target != none) && m_bCountDirectHitForAOE)
        {
            I = 0;
            J0x4D2:

            // End:0x555 [Loop If]
            if(I < ImpactInfoList.Length)
            {
                // End:0x547
                if(ImpactInfoList[I].HitActor == Target)
                {
                    ImpactInfoList[I].bDirectHit = true;
                }
                ++I;
                // [Loop Continue]
                goto J0x4D2;
            }
        }
        // End:0x5D6
        if((DirectImpact.HitActor != none) && m_OwnerFireMode.ShouldAddToImpactList(DirectImpact.HitActor, ImpactInfoList))
        {
            ImpactInfoList.AddItem(DirectImpact);
        }
        bRet = ((ImpactInfoList.Length > 0) ? true : false);
        // End:0x625
        if(ImpactInfoList.Length > 0)
        {
            m_bHitValidTarget = true;
            m_nTargetsHitCount = ImpactInfoList.Length;
        }
        DeviceOwner = TgDevice(m_OwnerFireMode.m_Owner);
        // End:0x715
        if(DeviceOwner != none)
        {
            J0x665:

            // End:0x6AF [Loop If]
            if(DeviceOwner.PendingImpactList.Length > 0)
            {
                DeviceOwner.PendingImpactList.Remove(0, 1);
                // [Loop Continue]
                goto J0x665;
            }
            I = 0;
            J0x6BA:

            // End:0x715 [Loop If]
            if(I < ImpactInfoList.Length)
            {
                DeviceOwner.PendingImpactList.AddItem(ImpactInfoList[I]);
                I++;
                // [Loop Continue]
                goto J0x6BA;
            }
        }
        I = 0;
        J0x720:

        // End:0x981 [Loop If]
        if(I < ImpactInfoList.Length)
        {
            ImpactInfoList[I].Projectile = self;
            ImpactInfoList[I].HitInfo.Item = HitItem;
            // End:0x80A
            if(m_bAltFireHit)
            {
                m_OwnerFireMode.ApplyHitSpecial(ImpactInfoList[I].HitActor, ImpactInfoList[I]);
            }
            bRet = (ApplyTheHit(m_OwnerFireMode, ImpactInfoList[I], self)) || bRet;
            J = 0;
            J0x856:

            // End:0x973 [Loop If]
            if(J < m_ExtraFireModes.Length)
            {
                // End:0x965
                if(m_ExtraFireModes[J].IsValidTarget(ImpactInfoList[I].HitActor))
                {
                    // End:0x934
                    if(m_bAltFireHit)
                    {
                        m_ExtraFireModes[J].ApplyHitSpecial(ImpactInfoList[I].HitActor, ImpactInfoList[I]);
                    }
                    ApplyTheHit(m_ExtraFireModes[J], ImpactInfoList[I], self);
                }
                J++;
                // [Loop Continue]
                goto J0x856;
            }
            I++;
            // [Loop Continue]
            goto J0x720;
        }
        // End:0x9DA
        if(DeviceOwner != none)
        {
            J0x990:

            // End:0x9DA [Loop If]
            if(DeviceOwner.PendingImpactList.Length > 0)
            {
                DeviceOwner.PendingImpactList.Remove(0, 1);
                // [Loop Continue]
                goto J0x990;
            }
        }
    }
    return bRet;
    //return ReturnValue;    
}

simulated function Actor CalculateHitActor(Actor Target, Vector HitLocation, Vector HitNormal, out TraceHitInfo HitInfo)
{
    local Vector velocityDirection, offsetLocation, TraceEnd, TraceStart, HitLocationAfter;

    local Actor HitActor;

    velocityDirection = Normal(Velocity);
    offsetLocation = HitLocation + (HitNormal * (m_fExplosionOffsetDistance * float(16)));
    TraceEnd = offsetLocation + (velocityDirection * float(32));
    TraceStart = offsetLocation - (velocityDirection * float(32));
    HitActor = Trace(HitLocationAfter, velocityDirection, TraceEnd, TraceStart, true, vect(0.0000000, 0.0000000, 0.0000000), HitInfo, 1);
    // End:0x13B
    if(Pawn(HitActor) != none)
    {
        CheckHitInfo(HitInfo, Pawn(HitActor).Mesh, -velocityDirection, HitLocationAfter);
    }
    // End:0x154
    if(HitActor == none)
    {
        return Target;
    }
    return HitActor;
    //return ReturnValue;    
}

simulated event Explode(Vector HitLocation, Vector HitNormal)
{
    bForceNetUpdate = true;
    ExplodeOnTarget(none, HitLocation, HitNormal);
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    local TraceHitInfo HitInfo;
    local IMPACT_FX ImpactFx;
    local Actor HitActor;
    local TgPawn InstigatorPawn;
    local TgDevice parentDevice;

    // End:0x0F
    if(bHurtEntry)
    {
        return;
    }
    // End:0x49
    if(bTearOff && int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x98
    if((IsValidTarget(Target)) && Class'TgGame.TgDevice'.static.IsSuccessfulHitImpact(Target))
    {
        m_bHitValidTarget = true;
    }
    bHurtEntry = true;
    // End:0x292
    if(!m_bHasExploded)
    {
        HitActor = CalculateHitActor(Target, HitLocation, HitNormal, HitInfo);
        m_bHasExploded = true;
        // End:0x166
        if(m_OwnerFireMode != none)
        {
            parentDevice = TgDevice(m_OwnerFireMode.m_Owner);
            // End:0x166
            if(parentDevice != none)
            {
                parentDevice.UpdateActiveProjectiles(self);
            }
        }
        InstigatorPawn = TgPawn(Instigator);
        // End:0x1CC
        if(InstigatorPawn != none)
        {
            InstigatorPawn.OnProjectileExploded(self, HitActor, HitLocation, HitNormal);
        }
        // End:0x239
        if(s_nSpawnDeployableId > 0)
        {
            // End:0x236
            if(((int(Role) == int(ROLE_Authority)) && !bTearOff) && !m_bSuppressDeployableSpawn)
            {
                SpawnDeployable(HitLocation, HitActor, HitNormal);
            }            
        }
        else
        {
            // End:0x292
            if(s_nSpawnBotId > 0)
            {
                // End:0x292
                if(((int(Role) == int(ROLE_Authority)) && !bTearOff) && !m_bSuppressDeployableSpawn)
                {
                    SpawnBot(HitLocation, true);
                }
            }
        }
    }
    ApplyHit(Target, HitLocation, HitNormal, HitInfo.Item);
    // End:0x327
    if(c_ImpactFx != none)
    {
        ImpactFx = c_ImpactFx.GetImpactFx(HitInfo.PhysMaterial);
    }
    // End:0x376
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PlayHitTargetFX(Target, HitLocation, HitNormal, true);
    }
    // End:0x3AD
    if(ImpactedActor != none)
    {
        SpawnExplosionEffects(HitLocation, HitNormal, ImpactFx);        
    }
    else
    {
        // End:0x422
        if((ImpactedActor == none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            ImpactedActor = self;
            SpawnExplosionEffects(HitLocation, HitNormal, ImpactFx);
            ImpactedActor = none;
        }
    }
    // End:0x43F
    if(int(Role) == int(ROLE_Authority))
    {
        MakeNoise(1.0000000);
    }
    // End:0x45F
    if(m_fPersistTime == 0.0000000)
    {
        ShutDown();        
    }
    else
    {
        // End:0x49D
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0x493
            if(m_fPersistHitPulse == 0.0000000)
            {
                ShutDown();                
            }
            else
            {
                StartPulse();
            }
        }
        SetPhysics(0);
        HideProjectile();
        SetCollision(false, false);
        Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    }
    //return;    
}

simulated event Fizzle()
{
    PlayFizzleFX(vect(0.0000000, 0.0000000, 1.0000000), false);
    // End:0x38
    if(m_fPersistTime == 0.0000000)
    {
        ShutDown();        
    }
    else
    {
        // End:0x76
        if(int(Role) == int(ROLE_Authority))
        {
            // End:0x6C
            if(m_fPersistHitPulse == 0.0000000)
            {
                ShutDown();                
            }
            else
            {
                StartPulse();
            }
        }
        SetPhysics(0);
        HideProjectile();
        SetCollision(false, false);
        Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    }
    //return;    
}

simulated function ParticleSystemComponent SpawnDebugProximityDistancePSC()
{
    local TgPlayerController TgPC;
    local bool bConfused;
    local editinline ParticleSystemComponent debugPSC;

    debugPSC = new Class'Engine.ParticleSystemComponent';
    debugPSC.SetTemplate(ParticleSystem'fx_gen_particles.Particles.FX_Debug_Collision_Sphere');
    debugPSC.SetScale(m_fProximityDistance);
    // End:0x129
    if(Instigator.IsLocallyControlled())
    {
        debugPSC.m_ParticleChannels.Friendly = false;
        debugPSC.m_ParticleChannels.Enemy = false;
        debugPSC.m_ParticleChannels.LocalOwner = true;        
    }
    else
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x185
        if((TgPC != none) && TgPC.IsConfused())
        {
            bConfused = true;
        }
        // End:0x25F
        if(bConfused || Instigator.IsEnemy(GetALocalPlayerController()))
        {
            debugPSC.m_ParticleChannels.Friendly = false;
            debugPSC.m_ParticleChannels.Enemy = true;
            debugPSC.m_ParticleChannels.LocalOwner = false;            
        }
        else
        {
            debugPSC.m_ParticleChannels.Friendly = true;
            debugPSC.m_ParticleChannels.Enemy = false;
            debugPSC.m_ParticleChannels.LocalOwner = false;
        }
    }
    return debugPSC;
    //return ReturnValue;    
}

simulated event SpawnFlightEffects()
{
    // End:0xC6
    if(((m_fProximityDistance > float(0)) && TgRepInfo_Game(WorldInfo.GRI).r_bShowProjectileProximityDistance) && (int(r_eEquippedAt) == int(1)) || int(r_eEquippedAt) == int(5))
    {
        m_DebugProximityDistancePSC = SpawnDebugProximityDistancePSC();
        AttachComponent(m_DebugProximityDistancePSC);
        m_DebugProximityDistancePSC.ActivateSystem();
    }
    //return;    
}

simulated function SpawnExplosionEffects(Vector HitLocation, Vector HitNormal, optional IMPACT_FX ImpactFx)
{
    // End:0xD0
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0xBC
        if(c_ExplosionFx != none)
        {
            c_ExplosionFx.SpawnEmitter(HitLocation, HitNormal);
            c_ExplosionFx.SpawnSound(HitLocation);
            c_ExplosionFx.PlayCameraShake(HitLocation);
        }
        PlayFizzleFX(HitNormal, true);
    }
    // End:0x134
    if((c_ImpactFx != none) && ImpactedActor != none)
    {
        c_ImpactFx.ApplyImpact(self, ImpactedActor, HitLocation, HitNormal, ImpactFx);
    }
    //return;    
}

simulated function ShutDown()
{
    local TgDevice Dev;

    // End:0x0F
    if(m_bIsShutDown)
    {
        return;
    }
    // End:0x55
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PlayFizzleFX(Normal(Velocity) * -1.0000000, false);
    }
    SetPhysics(0);
    HideProjectile();
    SetCollision(false, false);
    ClearAllTimers();
    // End:0xA7
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.Destroy();
        m_CollisionProxy = none;
    }
    bHurtEntry = true;
    m_bIsShutDown = true;
    // End:0x15C
    if(m_OwnerFireMode != none)
    {
        // End:0xFC
        if(!m_bHitValidTarget)
        {
            m_OwnerFireMode.HandleMiss();
        }
        Dev = TgDevice(m_OwnerFireMode.m_Owner);
        // End:0x15C
        if(Dev != none)
        {
            Dev.OnProjectileShutdown(self);
        }
    }
    LifeSpan = 3.0000000;
    //return;    
}

event TornOff()
{
    ShutDown();
    super(Actor).TornOff();
    //return;    
}

simulated function HideProjectile()
{
    local editinline MeshComponent ComponentIt;

    // End:0x82
    foreach ComponentList(Class'Engine.MeshComponent', ComponentIt)
    {
        ComponentIt.SetHidden(true);
        // End:0x81
        if(SkeletalMeshComponent(ComponentIt) != none)
        {
            SkeletalMeshComponent(ComponentIt).bPauseAnims = true;
        }        
    }    
    // End:0x12C
    if(c_Mesh != none)
    {
        c_Mesh.FxDeactivateGroup('AlwaysOn', 0);
        c_Mesh.FxActivateIndependant('Destroyed', 0, Location, Vector(Rotation));
        // End:0x12C
        if(m_DebugProximityDistancePSC != none)
        {
            m_DebugProximityDistancePSC.DeactivateSystem();
        }
    }
    //return;    
}

simulated function Destroyed()
{
    local TgDevice Dev;
    local Vector HitNormal;

    // End:0x2F
    if(m_fPersistTime == 0.0000000)
    {
        Explode(Location, HitNormal);
    }
    // End:0xAF
    if((m_OwnerFireMode != none) && !m_bIsShutDown)
    {
        Dev = TgDevice(m_OwnerFireMode.m_Owner);
        // End:0xAF
        if(Dev != none)
        {
            Dev.OnProjectileShutdown(self);
        }
    }
    // End:0xE1
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.Destroy();
        m_CollisionProxy = none;
    }
    super(Actor).Destroyed();
    // End:0x11E
    if(m_AkActorUnoccluded != none)
    {
        m_AkActorUnoccluded.LifeSpan = 2.0000000;
    }
    //return;    
}

simulated function MyOnParticleSystemFinished(ParticleSystemComponent PSC)
{
    //return;    
}

simulated function bool ProjectileCalcCamera(float fDeltaTime, out Vector out_CamLoc, out Rotator out_CamRot, out float out_FOV)
{
    local float CollisionHeight;

    CollisionHeight = ((CylinderComponent(CollisionComponent) != none) ? CylinderComponent(CollisionComponent).CollisionHeight : 0.0000000);
    out_CamLoc = Location + (CollisionHeight * vect(0.0000000, 0.0000000, 1.0000000));
    return true;
    //return ReturnValue;    
}

event ServerDetonate()
{
    ImpactedActor = self;
    Explode(Location, vect(0.0000000, 0.0000000, 0.0000000));
    ImpactedActor = none;
    //return;    
}

event ServerFizzle()
{
    Fizzle();
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    super(Actor).ReplicatedEvent(VarName);
    //return;    
}

simulated function PlayFizzleFX(Vector HitNormal, bool bIsExplosionFizzle)
{
    local Vector ProjDir;

    // End:0xE4
    if(((!m_bHasPlayedFizzleFX && !m_bHasPlayedHitWallFX) && !m_bHasPlayedHitTargetFX) && c_Mesh != none)
    {
        ProjDir = Normal(Velocity);
        // End:0x86
        if(IsZero(ProjDir))
        {
            ProjDir = Normal(Location - r_vSpawnLocation);
        }
        c_Mesh.FxActivateIndependant(((bIsExplosionFizzle) ? 'ProjectileExplosionFizzle' : 'ProjectileFizzle'), 0, Location, ProjDir * -1.0000000);
    }
    m_bHasPlayedFizzleFX = true;
    //return;    
}

// Export UTgProjectile::execTraceWorldPhysicalGeometry(FFrame&, void* const)
native simulated function PhysicalMaterial TraceWorldPhysicalGeometry(Vector StartLoc, Vector EndLoc, out Vector TraceHitLocation);

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation)
{
    local bool bCachedHitTargetFX, bCachedHitValidTarget;
    local Vector ProjDir;
    local TgSpecialFx HitWallFx;
    local array<ParticleSysParam> ExplosionParams;
    local Vector NewHitLoc, NewHitNormal;
    local Actor HitActor;
    local TraceHitInfo HitInfo;
    local AkEvent HitAkEvent;
    local SoundCue HitSoundCue;
    local KActor HitKActor;
    local editinline ParticleSystemComponent ImpactPSC;

    // End:0x62
    if(m_CollisionSettings.bHitAndPassThrough)
    {
        bCachedHitTargetFX = m_bHasPlayedHitTargetFX;
        bCachedHitValidTarget = m_bHitValidTarget;
        m_bHasPlayedHitTargetFX = false;
        m_bHitValidTarget = false;
    }
    // End:0x748
    if((!m_bHitValidTarget && !m_bHasPlayedHitWallFX && !m_bHasPlayedHitTargetFX) && c_Mesh != none)
    {
        // End:0xFA
        if(IsZero(c_vHitWallVelocity))
        {
            ProjDir = Normal(Velocity);
            // End:0xF7
            if(IsZero(ProjDir))
            {
                ProjDir = Normal(HitLocation - r_vSpawnLocation);
            }            
        }
        else
        {
            ProjDir = Normal(c_vHitWallVelocity);
        }
        GetExplosionFXParams(ExplosionParams);
        c_Mesh.FxActivateIndependant('ProjectileExplosionHitWall', 0, HitLocation, ProjDir * -1.0000000,,,, ExplosionParams);
        PlayAdditionalHitFX(false, HitLocation, HitNormal, ProjDir * -1.0000000, ExplosionParams);
        HitWallFx = TgSpecialFx(c_Mesh.FxGet('ProjectileExplosionHitWall', 0));
        // End:0x229
        if(HitWallFx != none)
        {
            HitWallFx.SpawnDecalAt(HitLocation, -HitNormal);
        }
        HitActor = Instigator.Trace(NewHitLoc, NewHitNormal, HitLocation + (ProjDir * float(256)), HitLocation, true,, HitInfo);
        // End:0x73C
        if(!IsZero(NewHitLoc))
        {
            // End:0x73C
            if(HitInfo.PhysMaterial != none)
            {
                // End:0x462
                if(HitActor != none)
                {
                    // End:0x406
                    if(HitInfo.PhysMaterial.DeviceImpactSound != none)
                    {
                        HitAkEvent = AkEvent(HitInfo.PhysMaterial.DeviceImpactSound);
                        HitSoundCue = SoundCue(HitInfo.PhysMaterial.DeviceImpactSound);
                        // End:0x3CA
                        if(HitAkEvent != none)
                        {
                            HitActor.PostAkEvent(HitAkEvent);                            
                        }
                        else
                        {
                            // End:0x406
                            if(HitSoundCue != none)
                            {
                                HitActor.PlaySound(HitSoundCue);
                            }
                        }
                    }
                    HitKActor = KActor(HitActor);
                    // End:0x462
                    if(HitKActor != none)
                    {
                        HitKActor.ClientWeaponHitEffects(NewHitLoc, NewHitNormal);
                    }
                }
                // End:0x73C
                if(HitInfo.PhysMaterial.ImpactEffect != none)
                {
                    ImpactPSC = new (self) Class'Engine.ParticleSystemComponent';
                    ImpactPSC.bAutoActivate = false;
                    ImpactPSC.SetTemplate(HitInfo.PhysMaterial.ImpactEffect);
                    ImpactPSC.SetAbsolute(true, true, true);
                    ImpactPSC.SetTranslation(NewHitLoc);
                    ImpactPSC.SetRotation(Rotator(NewHitNormal));
                    // End:0x71C
                    if(((r_Owner != none) && r_Owner.WorldInfo != none) && r_Owner.WorldInfo.MyEmitterPool != none)
                    {
                        ImpactPSC.__OnSystemFinished__Delegate = r_Owner.WorldInfo.MyEmitterPool.OnParticleSystemFinished;
                        r_Owner.WorldInfo.MyEmitterPool.AttachComponent(ImpactPSC);
                        r_Owner.WorldInfo.MyEmitterPool.ActiveComponents.AddItem(ImpactPSC);
                    }
                    ImpactPSC.ActivateSystem(true);
                }
            }
        }
        m_bHasPlayedHitWallFX = true;
    }
    // End:0x792
    if(m_CollisionSettings.bHitAndPassThrough)
    {
        m_bHasPlayedHitTargetFX = bCachedHitTargetFX;
        m_bHitValidTarget = bCachedHitValidTarget;
    }
    //return;    
}

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded)
{
    local Vector ProjDir, FXLocation;
    local array<ParticleSysParam> ExplosionParams;

    // End:0x171
    if((m_bHitValidTarget && !bExploded || !m_bHasPlayedHitWallFX && !m_bHasPlayedHitTargetFX) && c_Mesh != none)
    {
        // End:0x165
        if(!SuppressHitTargetFX(Target, HitLocation, HitNormal, bExploded))
        {
            ProjDir = Normal(Velocity);
            // End:0xC9
            if(IsZero(ProjDir))
            {
                ProjDir = Normal(HitLocation - r_vSpawnLocation);
            }
            FXLocation = HitLocation;
            GetExplosionFXParams(ExplosionParams);
            c_Mesh.FxActivateIndependant('ProjectileExplosionHitTarget', 0, FXLocation, ProjDir,,,, ExplosionParams);
            PlayAdditionalHitFX(true, FXLocation, HitNormal, ProjDir, ExplosionParams);
        }
        m_bHasPlayedHitTargetFX = true;
    }
    // End:0x1F7
    if(m_bExplodeAtMaxRange && IsZero(HitNormal))
    {
        // End:0x1F4
        if(c_Mesh != none)
        {
            GetExplosionFXParams(ExplosionParams);
            c_Mesh.FxActivateIndependant('ProjectileExplosionInAir', 0, HitLocation, vect(0.0000000, 0.0000000, 0.0000000));
        }        
    }
    else
    {
        // End:0x233
        if(!m_bHasPlayedHitWallFX && !m_bHasPlayedHitTargetFX)
        {
            PlayHitWallExplosionFX(HitNormal, HitLocation);
        }
    }
    //return;    
}

simulated function bool SuppressHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded)
{
    local PlayerController PC;
    local TgPawn TargetPawn;
    local TgRepInfo_Player localpri;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return true;
    }
    // End:0x3A
    if(c_bIsAOE)
    {
        return false;
    }
    TargetPawn = TgPawn(Target);
    // End:0x123
    if(TargetPawn != none)
    {
        PC = GetALocalPlayerController();
        localpri = ((PC != none) ? TgRepInfo_Player(PC.PlayerReplicationInfo) : none);
        return ((localpri != none) && TargetPawn.IsEnemy(localpri)) && TargetPawn.IsStealthed(localpri);
    }
    return false;
    //return ReturnValue;    
}

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams)
{
    //return;    
}

// Export UTgProjectile::execGetExplosionFXParams(FFrame&, void* const)
native function GetExplosionFXParams(out array<ParticleSysParam> Params);

simulated function AltFireDetonate()
{
    m_bAltFireHit = true;
    Explode(Location, -Normal(Velocity));
    //return;    
}

simulated event Rotator AlignDeployableByMyRotation(Vector HitNormal)
{
    local Vector X, Y, Z, newY, newZ;

    GetAxes(Rotation, X, Y, Z);
    newZ = HitNormal Cross (Z Cross HitNormal);
    newZ = Normal(newZ);
    newY = newZ Cross HitNormal;
    newY = Normal(newY);
    return OrthoRotation(HitNormal, newY, newZ);
    //return ReturnValue;    
}

// Export UTgProjectile::execCheckOcclusion(FFrame&, void* const)
native function float CheckOcclusion();

defaultproperties
{
    m_fLandZThreshold=0.7000000
    c_bRotationFollowsVelocity=true
    m_bIngoreBehindProjCollisions=true
    m_fBaseDamageMultiplier=-1.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProjectile.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        bEnabled=false
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bPassThroughFriends=true,bPassThroughEnemies=false,bPassThroughShields=false,bPassThroughBlocker=false,bExplodeOnShields=false,bExplodeOnBlockers=false,bHitAndPassThrough=false,bHitOnTick=false,bOnlyHitOnceOnPassThrough=true)
    m_TrackingSettings=(bUsesTracking=false,mTarget=none,fTurnStrength=20.0000000,fVertTurnStrength=20.0000000,bIgnoreNonTargets=false,bIgnoreWorldIfSeeking=false,bIgnoreWorldIfNotSeeking=false)
    // Reference: CylinderComponent'TgGame.Default__TgProjectile.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Projectile.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    bCollideComplex=true
    m_bComplexOccluder=true
    CollisionComponent=CollisionCylinder
    m_fMaxDistForOcclusionPathfinding=1000.0000000
}