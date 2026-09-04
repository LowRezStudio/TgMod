class TgProj_Simulated extends TgProjectile
    native(Projectiles)
    hidecategories(Navigation);

const LERP_FROM_CLIENT_POSITION_DURATION = 0.2;

enum eSimProjEvent
{
    Proj_Spawn,                     // 0
    Proj_Exploded,                  // 1
    Proj_ExplodedSpecial,           // 2
    Proj_Shutdown,                  // 3
    Proj_Hit,                       // 4
    Proj_Target,                    // 5
    Proj_HitWall,                   // 6
    Proj_HideProjectile,            // 7
    Proj_Fizzle,                    // 8
    Proj_MAX                        // 9
};

var bool m_bHasFlashedShutdown;
var bool m_bHasFlashExploded;
var bool m_bIgnoreClientHits;
var bool m_bShouldQueueServerHits;
var bool m_bHasQueuedServerHit;
var bool m_bNeedsFrictionOverride;
var bool m_bFlashSpecialExplosion;
var bool m_bTrackProjectileForTimelapse;
var bool s_bTrackingInitialized;
var const bool m_bRequireAccurateTicksForPrediction;
var int m_nProjectileInstanceId;
var int m_nClientFireRequestId;
var Vector m_LerpFromClientOffset;
var float m_LerpTimeRemaining;
var Actor m_QueuedExplodeTarget;
var Vector m_QueuedExplodeLocation;
var Vector m_QueuedExplodeNormal;
var Vector m_vSpawnVelocity;
var Vector m_vSpawnAcceleration;
var Rotator m_rSpawnRotator;
var float m_fAllowedClientMovementTime;
var float m_fSpawnTimeStamp;
var float m_fGravityScale;
var float m_fFrictionOverride;
var array<TgPlayerController> s_InterestedPlayers;
var int m_nShadowFXID;
var TgSpecialFx m_ShadowFX;
var export editinline DecalComponent m_ShadowDecal;
var float m_fShadowBaseWidth;
var float m_fMaxDecalHeight;
var Rotator m_CachedRotation;
var float m_fTrackingUpdateRate;
var float s_fTrackingUpdateTimer;
var TgGameplayCurves m_GameplayCurves;
var int m_nDeployableOverlayDisplayMask;
var TgObject.DeployableOverlayIcon m_eDeployableOverlayIcon;
var TgObject.DeployableOverlayState m_eDeployableOverlayState;
var float m_fDeployableOverlayEnemyViewDist;
var float m_fDeployableActiveLifeTime;

// Export UTgProj_Simulated::execCompleteInitialization(FFrame&, void* const)
native function CompleteInitialization();

// Export UTgProj_Simulated::execFlashNotifySpawn(FFrame&, void* const)
native function FlashNotifySpawn();

// Export UTgProj_Simulated::execFlashNotifyShutdown(FFrame&, void* const)
native function FlashNotifyShutdown();

// Export UTgProj_Simulated::execFlashNotifyFizzle(FFrame&, void* const)
native function FlashNotifyFizzle();

// Export UTgProj_Simulated::execFlashNotifyExploded(FFrame&, void* const)
native function FlashNotifyExploded(Actor Target, Vector HitLocation, Vector HitNormal);

// Export UTgProj_Simulated::execFlashNotifyExplodedSpecial(FFrame&, void* const)
native function FlashNotifyExplodedSpecial(Actor Target, Vector HitLocation, Vector HitNormal);

// Export UTgProj_Simulated::execFlashNotifyHit(FFrame&, void* const)
native function FlashNotifyHit(Actor Target, Vector HitLocation, Vector HitNormal);

// Export UTgProj_Simulated::execFlashNotifyHitWall(FFrame&, void* const)
native function FlashNotifyHitWall(Actor Wall, Vector HitNormal, Vector HitLocation);

// Export UTgProj_Simulated::execFlashNotifyTarget(FFrame&, void* const)
native function FlashNotifyTarget(Actor TargetActor, Vector TargetLocation);

// Export UTgProj_Simulated::execSetLocationFromServer(FFrame&, void* const)
native function SetLocationFromServer(Vector InLocation);

// Export UTgProj_Simulated::execCheckFirstWorldExplosion(FFrame&, void* const)
native function bool CheckFirstWorldExplosion(Vector StartPos, Vector EndPos);

// Export UTgProj_Simulated::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

// Export UTgProj_Simulated::execPredictStartLocationBasedOnPing(FFrame&, void* const)
native function PredictStartLocationBasedOnPing(float Ping);

// Export UTgProj_Simulated::execGetIndexForTimelapseTracking(FFrame&, void* const)
native function int GetIndexForTimelapseTracking();

// Export UTgProj_Simulated::execInitTrackingForTimelapse(FFrame&, void* const)
native function InitTrackingForTimelapse();

// Export UTgProj_Simulated::execShutDownTrackingForTimelapse(FFrame&, void* const)
native function ShutDownTrackingForTimelapse();

simulated event HandleQueuedFirstWorldExplosion()
{
    HideProjectile();
    //return;    
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
    // End:0x0F
    if(m_bIgnoreClientHits)
    {
        return;
    }
    super.ProcessTouch(Other, HitLocation, HitNormal);
    //return;    
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
    // End:0x146
    if(!m_CollisionSettings.bHitOnTick && m_PassThroughTargets.Find(Target) != -1)
    {
        // End:0x120
        if(int(WorldInfo.NetMode) == int(NM_Client))
        {
            SendExplodeToServer(Target, HitLocation, HitNormal);            
        }
        else
        {
            ApplyHit(Target, HitLocation, HitNormal);
        }
    }
    //return;    
}

simulated function SendExplodeToServer(Actor Other, Vector HitLocation, Vector HitNormal)
{
    local TgDevice OwningDevice;
    local TgPawn HitPawn;
    local float HitPawnServerTimeStamp, ProjectileAliveTime;

    // End:0x26B
    if(((r_Owner != none) && int(r_Owner.Role) < int(ROLE_Authority)) && m_nProjectileInstanceId == 0)
    {
        // End:0x26B
        if(m_OwnerFireMode != none)
        {
            OwningDevice = TgDevice(m_OwnerFireMode.m_Owner);
            // End:0x26B
            if(OwningDevice != none)
            {
                HitPawn = TgPawn(Other);
                // End:0xED
                if(HitPawn != none)
                {
                    HitPawnServerTimeStamp = HitPawn.c_fServerTimeStamp;
                }
                ProjectileAliveTime = WorldInfo.TimeSeconds - m_fSpawnTimeStamp;
                // End:0x180
                if(false)
                {
                    m_fAllowedClientMovementTime = 3.0000000;
                    OwningDevice.ValidateClientProjectileImpact(self, ProjectileAliveTime, Other, HitPawnServerTimeStamp, HitLocation, HitNormal);
                }
                OwningDevice.ServerQueueProjectileExplode(m_nClientFireRequestId, ProjectileAliveTime, Other, HitPawnServerTimeStamp, HitLocation.X, HitLocation.Y, HitLocation.Z, HitNormal.X, HitNormal.Y, HitNormal.Z);
            }
        }
    }
    //return;    
}

simulated event SendSpawnAckToServer()
{
    local TgDevice OwningDevice;

    // End:0xB3
    if(((r_Owner != none) && int(r_Owner.Role) < int(ROLE_Authority)) && m_OwnerFireMode != none)
    {
        OwningDevice = TgDevice(m_OwnerFireMode.m_Owner);
        // End:0xB3
        if(OwningDevice != none)
        {
            OwningDevice.ServerAckProjectileSpawn(m_nClientFireRequestId);
        }
    }
    //return;    
}

simulated event Explode(Vector HitLocation, Vector HitNormal)
{
    ExplodeOnTarget(none, HitLocation, HitNormal);
    //return;    
}

simulated event ClientExplode(Actor Target, Vector HitLocation, Vector HitNormal)
{
    ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

simulated event ClientExplodeSpecial(Actor Target, Vector HitLocation, Vector HitNormal)
{
    ExplodeOnTarget(Target, HitLocation, HitNormal);
    //return;    
}

simulated event SetShouldQueueServerHits(bool bShouldQueue)
{
    m_bShouldQueueServerHits = bShouldQueue;
    // End:0x89
    if(!m_bShouldQueueServerHits && m_bHasQueuedServerHit)
    {
        m_bHasQueuedServerHit = false;
        FudgeProjectileHitLocationForShields(m_QueuedExplodeTarget, m_QueuedExplodeLocation, m_QueuedExplodeNormal);
        ExplodeOnTarget(m_QueuedExplodeTarget, m_QueuedExplodeLocation, m_QueuedExplodeNormal);
    }
    //return;    
}

simulated function FudgeProjectileHitLocationForShields(Actor Other, out Vector HitLocation, out Vector HitNormal)
{
    local Vector NewHitLoc, newHitNorm;
    local TgDeployable shield;

    // End:0x128
    if(UseAOE())
    {
        shield = TgDeployable(Other);
        // End:0x128
        if(((shield != none) && shield.CollisionComponent != none) && int(shield.m_CollisionSettings.mCollisionMode) != int(0))
        {
            // End:0x128
            if(TraceComponent(NewHitLoc, newHitNorm, shield.CollisionComponent, HitLocation, HitLocation - (Normal(Velocity) * 64.0000000)))
            {
                HitLocation = NewHitLoc;
                HitNormal = newHitNorm;
            }
        }
    }
    //return;    
}

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    SendExplodeToServer(Target, HitLocation, HitNormal);
    // End:0x89
    if(m_bShouldQueueServerHits)
    {
        // End:0x86
        if(!m_bHasQueuedServerHit)
        {
            m_bHasQueuedServerHit = true;
            m_QueuedExplodeTarget = Target;
            m_QueuedExplodeLocation = HitLocation;
            m_QueuedExplodeNormal = HitNormal;
        }        
    }
    else
    {
        // End:0xF4
        if(!bHurtEntry)
        {
            // End:0xCF
            if(!m_bFlashSpecialExplosion)
            {
                FlashNotifyExploded(Target, HitLocation, HitNormal);                
            }
            else
            {
                FlashNotifyExplodedSpecial(Target, HitLocation, HitNormal);
            }
        }
        super.ExplodeOnTarget(Target, HitLocation, HitNormal);
    }
    // End:0x153
    if(m_ShadowDecal != none)
    {
        m_ShadowDecal.SetHidden(true);
        m_ShadowDecal = none;
    }
    //return;    
}

event ClientHitUpdate(Actor Target, Vector HitLocation, Vector HitNormal)
{
    // End:0x4F
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PlayHitTargetFX(Target, HitLocation, HitNormal, false);
    }
    //return;    
}

simulated function ShutDown()
{
    // End:0x0F
    if(m_bIsShutDown)
    {
        return;
    }
    ShutDownTrackingForTimelapse();
    super.ShutDown();
    //return;    
}

simulated event Fizzle()
{
    super.Fizzle();
    FlashNotifyFizzle();
    //return;    
}

simulated function Destroyed()
{
    local TgPlayerController TgPC;

    // End:0x3A
    if(m_ShadowDecal != none)
    {
        m_ShadowDecal.SetHidden(true);
        m_ShadowDecal = none;
    }
    // End:0x74
    if(m_ShadowFX != none)
    {
        m_ShadowFX.Deactivate(true);
        m_ShadowFX = none;
    }
    // End:0x223
    if(Instigator != none)
    {
        TgPC = TgPlayerController(Instigator.Controller);
        // End:0x223
        if((TgPC != none) && TgPC.bDebugProjectileLagCompensation)
        {
            // End:0x19B
            if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
            {
                TgPC.ClientDrawDebugBox(Location.X, Location.Y, Location.Z, 5.0000000, 5.0000000, 5.0000000, 0, 0, 255);                
            }
            else
            {
                TgPC.ClientDrawDebugBox(Location.X, Location.Y, Location.Z, 5.0000000, 5.0000000, 5.0000000, 255, 0, 0);
            }
        }
    }
    super.Destroyed();
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    super.Tick(DeltaSeconds);
    // End:0x55
    if(m_bIsInitialized && !m_bIsShutDown)
    {
        // End:0x4B
        if(!CheckProjectileRange())
        {
            RangeReached();
        }
        CheckShieldPassthrough();
    }
    //return;    
}

simulated function CheckShieldPassthrough()
{
    local TgRepInfo_Game GRI;
    local int I;
    local Vector vShieldHitLocation, vShieldHitNormal, vStartTrace;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x1BB
    if(GRI != none)
    {
        vStartTrace = Location - (Normal(Velocity) * 32.0000000);
        // End:0xAC
        if(((r_vSpawnLocation - vStartTrace) Dot (r_vSpawnLocation - Location)) <= float(0))
        {
            vStartTrace = r_vSpawnLocation;
        }
        I = 0;
        J0xB7:

        // End:0x1BB [Loop If]
        if(I < GRI.m_MovableProjBlockers.Length)
        {
            // End:0x1AD
            if(TraceComponent(vShieldHitLocation, vShieldHitNormal, GRI.m_MovableProjBlockers[I].CollisionComponent, Location, Location - (Normal(Velocity) * 32.0000000)))
            {
                ProcessTouch(GRI.m_MovableProjBlockers[I], vShieldHitLocation, vShieldHitNormal);
            }
            I++;
            // [Loop Continue]
            goto J0xB7;
        }
    }
    //return;    
}

simulated function bool CheckProjectileRange(optional Vector vLocOverride)
{
    // End:0x13
    if(m_bShouldQueueServerHits)
    {
        return true;        
    }
    else
    {
        // End:0x34
        if(m_bIsInitialized)
        {
            return super.CheckProjectileRange(vLocOverride);
        }
    }
    return true;
    //return ReturnValue;    
}

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem)
{
    local bool bRet;

    bRet = super.ApplyHit(Target, HitLocation, HitNormal, HitItem);
    FlashNotifyHit(Target, HitLocation, HitNormal);
    // End:0xAE
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        PlayHitTargetFX(Target, HitLocation, HitNormal, false);
    }
    return bRet;
    //return ReturnValue;    
}

simulated event HitWall(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    local TgDeployable hitDeployable;

    // End:0x36
    if(m_bIgnoreClientHits)
    {
        // End:0x34
        if(IsZero(c_vHitWallVelocity))
        {
            c_vHitWallVelocity = Velocity;
            SetPhysics(0);
        }
        return;
    }
    hitDeployable = TgDeployable(Wall);
    // End:0xB9
    if(((hitDeployable != none) && int(hitDeployable.m_CollisionSettings.mCollisionMode) != int(0)) && CheckTeamPassThrough(hitDeployable))
    {
        return;
    }
    super.HitWall(HitNormal, Wall, WallComp);
    //return;    
}

event ClientTargetUpdate(Actor TargetActor, Vector TargetLocation)
{
    SetTarget(TargetActor, TargetLocation);
    //return;    
}

event SetTarget(Actor TargetActor, optional Vector TargetLocation)
{
    super.SetTarget(TargetActor, TargetLocation);
    FlashNotifyTarget(TargetActor, TargetLocation);
    //return;    
}

simulated event DecalComponent SpawnShadowDecal()
{
    local MaterialInstanceTimeVarying MITV_Decal;

    // End:0x1E2
    if((m_ShadowFX != none) && WorldInfo.MyDecalManager != none)
    {
        MITV_Decal = new Class'Engine.MaterialInstanceTimeVarying';
        MITV_Decal.SetParent(m_ShadowFX.c_DecalList[0].c_MITV);
        m_ShadowDecal = WorldInfo.MyDecalManager.SpawnDecal(true, MITV_Decal, Location, rot(-16384, 0, 0), m_ShadowFX.c_DecalList[0].c_fWidth, m_ShadowFX.c_DecalList[0].c_fHeight, m_fMaxDecalHeight, m_ShadowFX.c_DecalList[0].c_bNoClip, 0.0000000,,,,,,, m_ShadowFX.c_DecalList[0].c_fLifetime);
    }
    return m_ShadowDecal;
    //return ReturnValue;    
}

// Export UTgProj_Simulated::execTickAhead(FFrame&, void* const)
native simulated function TickAhead(float tickAmount);

defaultproperties
{
    m_nClientFireRequestId=-1
    m_fGravityScale=1.0000000
    m_fMaxDecalHeight=4000.0000000
    m_fDeployableOverlayEnemyViewDist=1600.0000000
    m_fDeployableActiveLifeTime=1.5000000
    m_bCanSpawnOnClientFirst=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProjectile.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProjectile.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    RemoteRole=ENetRole.ROLE_None
    CollisionComponent=CollisionCylinder
}