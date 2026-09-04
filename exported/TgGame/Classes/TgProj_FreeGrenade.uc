class TgProj_FreeGrenade extends TgProj_Simulated
    native(Projectiles)
    hidecategories(Navigation);

var bool m_bShieldTouched;
var bool m_bExplodeOnTouch;
var bool m_bExplodeOnGeometry;
var bool m_bExplodeOnFloor;
var bool m_bUseBilinearInterpolationForBounceDamping;
var bool m_bUseGravityZOverride;
var TgDeployable m_TouchedShield;
var float m_fToleranceZ;
var float m_fBounceDampingVertMin;
var float m_fBounceDampingVertMax;
var float m_fBounceDampingHorizMin;
var float m_fBounceDampingHorizMax;
var float m_fBounceDamping;
var float m_fSpeedToActivateBounceFX;
var float m_fGravityZOverride;
var int m_nBounceCount;
var int m_nBouncesToExplode;
var float m_fBounceDistinctionDuration;
var int m_fLastBounceTime;
var Vector m_vRecentHitNormal;
var float m_fRecentHitTime;

// Export UTgProj_FreeGrenade::execGetGravityZ(FFrame&, void* const)
native function float GetGravityZ();

simulated function PostBeginPlay()
{
    super(TgProjectile).PostBeginPlay();
    SetTimer(0.1000000, true);
    //return;    
}

simulated function ShutDown()
{
    super.ShutDown();
    ClearTimer();
    //return;    
}

simulated function Timer()
{
    // End:0x1A
    if(!CheckProjectileRange())
    {
        RangeReached();
    }
    //return;    
}

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation)
{
    // End:0x71
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && (m_fRecentHitTime + 0.4000000) > WorldInfo.TimeSeconds)
    {
        HitNormal = m_vRecentHitNormal;
    }
    super(TgProjectile).PlayHitWallExplosionFX(HitNormal, HitLocation);
    //return;    
}

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded)
{
    local bool bOldHitValidTarget;

    // End:0xC6
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && (m_fRecentHitTime + 0.4000000) > WorldInfo.TimeSeconds)
    {
        bOldHitValidTarget = m_bHitValidTarget;
        m_bHitValidTarget = false;
        HitNormal = m_vRecentHitNormal;
        PlayHitWallExplosionFX(HitNormal, HitLocation);
        m_bHitValidTarget = bOldHitValidTarget;        
    }
    else
    {
        super(TgProjectile).PlayHitTargetFX(Target, HitLocation, HitNormal, bExploded);
    }
    //return;    
}

function float GetPostLandDuration()
{
    return m_fPostLandDuration;
    //return ReturnValue;    
}

function StartLandExplodeTimer()
{
    // End:0x45
    if(((GetPostLandDuration()) > float(0)) && !IsTimerActive('TimerExplode'))
    {
        SetTimer(GetPostLandDuration(), false, 'TimerExplode');
    }
    //return;    
}

function OnLand()
{
    // End:0x21
    if(m_nBounceCount >= m_nBouncesToExplode)
    {
        StartLandExplodeTimer();
    }
    //return;    
}

simulated event HitWall(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    // End:0x49
    if(!ShouldHitBounce(Wall, HitNormal))
    {
        super.HitWall(HitNormal, Wall, WallComp);        
    }
    else
    {
        // End:0xB7
        if((WorldInfo.TimeSeconds - float(m_fLastBounceTime)) >= m_fBounceDistinctionDuration)
        {
            m_fLastBounceTime = int(WorldInfo.TimeSeconds);
            m_nBounceCount++;
        }
        // End:0xEB
        if(HitNormal.Z >= m_fLandZThreshold)
        {
            OnLand();
        }
        ApplyBounce(HitNormal, Wall, WallComp);
        // End:0x17F
        if(((Speed < float(20)) && Wall.bWorldGeometry) && HitNormal.Z >= 0.7000000)
        {
            bBounce = false;
            SetPhysics(0);
        }
        // End:0x19D
        if(m_bStickToWalls)
        {
            bBounce = false;
            SetPhysics(0);
        }
        m_fRecentHitTime = WorldInfo.TimeSeconds + ((bBounce) ? 0.0000000 : 100.0000000);
        m_vRecentHitNormal = HitNormal;
    }
    //return;    
}

simulated function bool ShouldHitBounce(Actor Target, Vector HitNormal)
{
    return !m_bExplodeOnGeometry || m_bExplodeOnFloor && HitNormal.Z > m_fToleranceZ;
    //return ReturnValue;    
}

simulated function ApplyBounce(Vector HitNormal, Actor Wall, PrimitiveComponent WallComp)
{
    local float wallAngle, bounceAngle, bounceDamping;

    // End:0x119
    if(m_bUseBilinearInterpolationForBounceDamping)
    {
        wallAngle = Acos(Abs(HitNormal Dot vect(0.0000000, 0.0000000, 1.0000000))) / (3.1415930 / float(2));
        bounceAngle = Acos(Abs(HitNormal Dot Normal(Velocity))) / (3.1415930 / float(2));
        bounceDamping = Lerp(Lerp(m_fBounceDampingHorizMin, m_fBounceDampingHorizMax, bounceAngle), Lerp(m_fBounceDampingVertMin, m_fBounceDampingVertMax, bounceAngle), wallAngle);
        Velocity = bounceDamping * ((((Velocity Dot HitNormal) * HitNormal) * -2.0000000) + Velocity);        
    }
    else
    {
        Velocity = m_fBounceDamping * ((((Velocity Dot HitNormal) * HitNormal) * -2.0000000) + Velocity);
    }
    PlayBounceSound();
    //return;    
}

simulated function PlayBounceSound()
{
    Speed = VSize(Velocity);
    // End:0x95
    if((c_Mesh != none) && Speed > m_fSpeedToActivateBounceFX)
    {
        c_Mesh.FxDeactivateGroup('ProjectileBounce', 0);
        c_Mesh.FxActivateGroup('ProjectileBounce', 0);
    }
    //return;    
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
    local TgDeployable hitDeployable;
    local Vector Vel2D;

    // End:0x18
    if(ForcefieldExclusionCheck(Other))
    {
        return;
    }
    // End:0x4F
    if(m_bExplodeOnTouch)
    {
        super.ProcessTouch(Other, HitLocation, HitNormal);
        return;        
    }
    else
    {
        // End:0x79
        if(HandleOnProjectileHitTarget(Other, HitLocation, HitNormal))
        {
            return;
        }
    }
    hitDeployable = TgDeployable(Other);
    // End:0x12F
    if(hitDeployable != none)
    {
        // End:0x12D
        if(int(hitDeployable.m_CollisionSettings.mCollisionMode) != int(0))
        {
            // End:0x10B
            if(m_bShieldTouched && hitDeployable == m_TouchedShield)
            {
                return;                
            }
            else
            {
                m_TouchedShield = hitDeployable;
                m_bShieldTouched = true;
            }            
        }
        else
        {
            return;
        }
    }
    // End:0x160
    if((Other == Instigator) || CheckTeamPassThrough(Other))
    {
        return;
    }
    // End:0x1DD
    if((Pawn(Other) != none) && Vehicle(Other) == none)
    {
        Vel2D = Velocity;
        Vel2D.Z = 0.0000000;
        // End:0x1DD
        if(VSize(Vel2D) < float(200))
        {
            return;
        }
    }
    SetLocation(HitLocation);
    HitWall(HitNormal, Other, none);
    //return;    
}

simulated event Landed(Vector HitNormal, Actor FloorActor)
{
    HitWall(HitNormal, FloorActor, none);
    //return;    
}

simulated function Destroyed()
{
    ImpactedActor = self;
    super.Destroyed();
    //return;    
}

defaultproperties
{
    m_bExplodeOnTouch=true
    m_fToleranceZ=0.7000000
    m_fBounceDamping=0.2500000
    m_fSpeedToActivateBounceFX=200.0000000
    m_fBounceDistinctionDuration=0.1000000
    m_fLastBounceTime=-1000
    m_bCanSpawnOnClientFirst=false
    m_fTossZ=200.0000000
    m_nPostRenderIcon=1
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_fExplosionOffsetDistance=1.5000000
    // Reference: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    Physics=EPhysics.PHYS_Falling
    bNetTemporary=false
    bBounce=true
    CollisionComponent=CollisionCylinder
}