class TgDeploy_EffectTrail extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation);

const MAX_TRAIL_POINTS = 20;

var TgPawn r_TrailPawn;
var int m_TrailEffectID;
var TgSpecialFx m_TrailEffects;
var bool m_bHasInitialPoint;
var bool r_bInDeployMode;
var float m_fPointDistance;
var float m_fPointLifetime;
var int m_nNextPointIndex;
var int m_nTailPointIndex;
var Vector m_TrailPoints[20];
var Vector m_ParticleSystemOffsets[20];
var float m_TrailTimes[20];
var TgCollisionProxy_Cylinder m_CollisionProxies[20];
var export editinline DecalComponent m_Decals[20];

replication
{
    // Pos:0x000
    if(bNetInitial && int(Role) == int(ROLE_Authority))
        r_TrailPawn;

    // Pos:0x020
    if(int(Role) == int(ROLE_Authority))
        r_bInDeployMode;
}

// Export UTgDeploy_EffectTrail::execCalculateAndSpawnNextPiece(FFrame&, void* const)
native function bool CalculateAndSpawnNextPiece();

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local ImpactInfo Impact;

    // End:0x1D2
    if((m_FireMode != none) && Other != none)
    {
        // End:0x1D2
        if(m_FireMode.IsValidTarget(Other))
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = m_FireMode;
            Impact.HitActor = Other;
            Impact.HitLocation = Other.Location;
            Impact.HitNormal = Other.Location;
            Impact.StartTrace = Impact.HitLocation;
            Impact.RayDir = Impact.HitNormal;
            m_FireMode.ApplyHit(Impact, Owner);
        }
    }
    //return;    
}

simulated event ConsumeTailPiece()
{
    // End:0x50
    if(m_CollisionProxies[m_nTailPointIndex] != none)
    {
        m_CollisionProxies[m_nTailPointIndex].Destroy();
        m_CollisionProxies[m_nTailPointIndex] = none;
    }
    // End:0xA8
    if(m_Decals[m_nTailPointIndex] != none)
    {
        m_Decals[m_nTailPointIndex].SetHidden(true);
        m_Decals[m_nTailPointIndex] = none;
    }
    m_TrailTimes[m_nTailPointIndex] = 0.0000000;
    // End:0xDE
    if(++m_nTailPointIndex >= 20)
    {
        m_nTailPointIndex = 0;
    }
    //return;    
}

simulated event bool SpawnNewTrailFX(Vector trailLocation, Vector particleOffset)
{
    local int I;
    local float Radius;
    local Vector Forward;
    local MaterialInstanceTimeVarying MITV_Decal;

    // End:0x11
    if(r_TrailPawn == none)
    {
        return false;
    }
    // End:0x32
    if(m_nNextPointIndex == m_nTailPointIndex)
    {
        ConsumeTailPiece();
    }
    m_TrailPoints[m_nNextPointIndex] = trailLocation;
    m_ParticleSystemOffsets[m_nNextPointIndex] = particleOffset;
    m_TrailTimes[m_nNextPointIndex] = m_fPointLifetime;
    m_CollisionProxies[m_nNextPointIndex] = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, trailLocation,,, true);
    // End:0x203
    if(m_CollisionProxies[m_nNextPointIndex] != none)
    {
        m_CollisionProxies[m_nNextPointIndex].SetBase(self);
        m_CollisionProxies[m_nNextPointIndex].__ProxyTouch__Delegate = OnProxyTouch;
        m_CollisionProxies[m_nNextPointIndex].DelegatesUpdated();
        Radius = m_FireMode.GetEffectiveRadius();
        m_CollisionProxies[m_nNextPointIndex].m_CollisionCylinder.SetCylinderSize(Radius, Radius);
        m_CollisionProxies[m_nNextPointIndex].ForceProximityScan();
    }
    // End:0x56E
    if((m_TrailEffects != none) && WorldInfo.MyDecalManager != none)
    {
        I = 0;
        J0x243:

        // End:0x511 [Loop If]
        if(I < m_TrailEffects.c_DecalList.Length)
        {
            MITV_Decal = new Class'Engine.MaterialInstanceTimeVarying';
            MITV_Decal.SetParent(m_TrailEffects.c_DecalList[I].c_MITV);
            m_Decals[m_nNextPointIndex] = WorldInfo.MyDecalManager.SpawnDecal(true, MITV_Decal, trailLocation, rot(-16384, 0, 0), m_TrailEffects.c_DecalList[I].c_fWidth, m_TrailEffects.c_DecalList[I].c_fHeight, m_TrailEffects.c_DecalList[I].c_fThickness, m_TrailEffects.c_DecalList[I].c_bNoClip, (float(-r_TrailPawn.Rotation.Yaw) / 65536.0000000) * 360.0000000,,,,,,, m_fPointLifetime);
            // End:0x503
            if(m_Decals[m_nNextPointIndex] != none)
            {
                m_Decals[m_nNextPointIndex].bMovableDecal = true;
                m_Decals[m_nNextPointIndex].Location = trailLocation;
            }
            I++;
            // [Loop Continue]
            goto J0x243;
        }
        Forward = Vector(r_TrailPawn.Rotation);
        m_TrailEffects.SpawnEmitter(particleOffset, Forward);
    }
    // End:0x58B
    if(++m_nNextPointIndex >= 20)
    {
        m_nNextPointIndex = 0;
    }
    return true;
    //return ReturnValue;    
}

function OnPersistTimerExpire()
{
    // End:0x47
    if(r_bInDeployMode)
    {
        ClearTimer('OnPersistTimerExpire');
        r_bInDeployMode = false;
        SetTimer(m_fPointLifetime, false, 'OnPersistTimerExpire');        
    }
    else
    {
        super(TgDeployable).OnPersistTimerExpire();
    }
    //return;    
}

simulated event ShutdownDeployMode()
{
    // End:0x44
    if(r_bInDeployMode)
    {
        ClearTimer('OnPersistTimerExpire');
        r_bInDeployMode = false;
        SetTimer(m_fPointLifetime, false, 'OnPersistTimerExpire');
    }
    //return;    
}

simulated function Destroyed()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x79 [Loop If]
    if(I < 20)
    {
        // End:0x6B
        if(m_CollisionProxies[I] != none)
        {
            m_CollisionProxies[I].Destroy();
            m_CollisionProxies[I] = none;
        }
        ++I;
        // [Loop Continue]
        goto J0x0B;
    }
    super(TgDeployable).Destroyed();
    //return;    
}

defaultproperties
{
    m_TrailEffectID=6394
    r_bInDeployMode=true
    m_fPointDistance=50.0000000
    m_fPointLifetime=3.0000000
    m_bFireOnDeploy=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectTrail.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_MatchParentFireMode.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
    bAlwaysRelevant=true
    bCollideActors=true
}