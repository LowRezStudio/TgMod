class TgDeploy_EffectSpots extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation);

const MAX_SPOT_POINTS = 100;

struct native EffectSpotInfo
{
    var bool bIsActive;
    var Vector vLocation;
    var Rotator rRotation;
    var float fRadius;
    var float fHeight;
    var int nFXIndex;
    var int nIntensityLevel;

    structdefaultproperties
    {
        bIsActive=false
        vLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        rRotation=(Pitch=0,Yaw=0,Roll=0)
        fRadius=0.0000000
        fHeight=0.0000000
        nFXIndex=0
        nIntensityLevel=0
    }
};

struct native EffectSpotTarget
{
    var Actor Target;
    var bool bNeedsRefresh;

    structdefaultproperties
    {
        Target=none
        bNeedsRefresh=false
    }
};

struct native EffectSpotFXInfo
{
    var TgSpecialFx Fx;
    var int nFXIndex;

    structdefaultproperties
    {
        Fx=none
        nFXIndex=0
    }
};

var repnotify EffectSpotInfo r_EffectSpots[100];
var int m_nNewSpotIndex;
var TgCollisionProxy_Cylinder m_CollisionProxy;
var float m_fFirstPassRadius;
var array<Actor> m_TouchingActors;
var array<EffectSpotTarget> m_AffectedActors;
var bool m_bUsesEffectRefresh;
var float m_fLastRefreshTime;
var float m_fMinRefreshTime;
var EffectSpotFXInfo c_SpotFX[100];

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_EffectSpots;
}

// Export UTgDeploy_EffectSpots::execApplyEffects(FFrame&, void* const)
native function ApplyEffects(Actor Target);

// Export UTgDeploy_EffectSpots::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(Actor Target);

// Export UTgDeploy_EffectSpots::execInitializeSpecialFX(FFrame&, void* const)
native function InitializeSpecialFX(int spotIndex);

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_EffectSpots')
    {
        UpdateEffectSpots();
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

simulated function Tick(float DeltaSeconds)
{
    local int I;

    super(TgDeployable).Tick(DeltaSeconds);
    // End:0x130
    if(((int(Role) == int(ROLE_Authority)) && !m_bInDestroyedState) && m_bUsesEffectRefresh)
    {
        // End:0x130
        if((m_fLastRefreshTime + m_fMinRefreshTime) <= WorldInfo.TimeSeconds)
        {
            I = 0;
            J0x89:

            // End:0x108 [Loop If]
            if(I < m_AffectedActors.Length)
            {
                m_AffectedActors[I].bNeedsRefresh = true;
                ApplyEffects(m_AffectedActors[I].Target);
                ++I;
                // [Loop Continue]
                goto J0x89;
            }
            m_fLastRefreshTime = WorldInfo.TimeSeconds;
        }
    }
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x0F
    if(m_bInDestroyedState)
    {
        return;
    }
    // End:0x84
    if(m_TouchingActors.Find(Other) == -1)
    {
        // End:0x84
        if((m_FireMode != none) && m_FireMode.IsValidTarget(Other))
        {
            m_TouchingActors.AddItem(Other);
        }
    }
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    // End:0x36
    if(m_TouchingActors.Find(Other) != -1)
    {
        m_TouchingActors.RemoveItem(Other);
    }
    RemoveEffects(Other);
    //return;    
}

event int SpawnNewSpot(Vector vLocation, Rotator rRotation, optional float fRadius = 0.0000000, optional float fHeight = 0.0000000, optional int nFXIndex = 0, optional int nIntensityLevel = 0)
{
    local int nNewSpotIndex, I;
    local float fLargestDistance, fDistance;

    // End:0x45
    if(m_bInDestroyedState || int(Role) != int(ROLE_Authority))
    {
        return -1;
    }
    // End:0x71
    if((m_nNewSpotIndex < 0) || m_nNewSpotIndex >= 100)
    {
        m_nNewSpotIndex = 0;
    }
    nNewSpotIndex = m_nNewSpotIndex;
    r_EffectSpots[nNewSpotIndex].bIsActive = true;
    r_EffectSpots[nNewSpotIndex].vLocation = vLocation;
    r_EffectSpots[nNewSpotIndex].rRotation = rRotation;
    r_EffectSpots[nNewSpotIndex].nFXIndex = nFXIndex;
    r_EffectSpots[nNewSpotIndex].nIntensityLevel = nIntensityLevel;
    // End:0x1B1
    if(fRadius > float(0))
    {
        r_EffectSpots[nNewSpotIndex].fRadius = fRadius;        
    }
    else
    {
        // End:0x209
        if(m_FireMode != none)
        {
            r_EffectSpots[nNewSpotIndex].fRadius = m_FireMode.GetDamageRadius();            
        }
        else
        {
            r_EffectSpots[nNewSpotIndex].fRadius = 1.0000000;
        }
    }
    // End:0x279
    if(fHeight > float(0))
    {
        r_EffectSpots[nNewSpotIndex].fHeight = fHeight;        
    }
    else
    {
        r_EffectSpots[nNewSpotIndex].fHeight = 80.0000000;
    }
    // End:0x2C2
    if(++m_nNewSpotIndex >= 100)
    {
        m_nNewSpotIndex = 0;
    }
    // End:0x301
    if((nNewSpotIndex < 0) || !r_EffectSpots[0].bIsActive)
    {
        return nNewSpotIndex;
    }
    fLargestDistance = r_EffectSpots[0].fRadius;
    I = 0;
    J0x334:

    // End:0x419 [Loop If]
    if(I < 100)
    {
        // End:0x373
        if(!r_EffectSpots[I].bIsActive)
        {            
        }
        else
        {
            fDistance = VSize(r_EffectSpots[I].vLocation - Location);
            fDistance += r_EffectSpots[I].fRadius;
            // End:0x40B
            if(fDistance > fLargestDistance)
            {
                fLargestDistance = fDistance;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x334;
    }
    // End:0x449
    if(fLargestDistance > 0.0000000)
    {
        m_fFirstPassRadius = fLargestDistance;
        ScaleCollisionProxy();
    }
    UpdateEffectSpots();
    return nNewSpotIndex;
    //return ReturnValue;    
}

simulated function UpdateEffectSpots()
{
    local int I;

    // End:0x19
    if(m_bInDestroyedState)
    {
        ClearEffectSpots();
        return;
    }
    I = 0;
    J0x24:

    // End:0x12C [Loop If]
    if(I < 100)
    {
        // End:0x74
        if(r_EffectSpots[I].bIsActive)
        {
            UpdateSpotFX(I);            
        }
        else
        {
            // End:0x11E
            if((c_SpotFX[I].Fx != none) && c_SpotFX[I].Fx.c_bActive)
            {
                c_SpotFX[I].Fx.Deactivate(false);
            }
        }
        ++I;
        // [Loop Continue]
        goto J0x24;
    }
    //return;    
}

simulated event SpawnCollisionProxy()
{
    // End:0x1B3
    if((int(Role) == int(ROLE_Authority)) && m_fFirstPassRadius > 0.0000000)
    {
        // End:0x65
        if(m_CollisionProxy != none)
        {
            ClearAllTouched();
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, self.Location,,, true);
        // End:0x1B3
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.SetBase(self);
            m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
            m_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
            m_CollisionProxy.DelegatesUpdated();
            m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(m_fFirstPassRadius, 2.0000000 * m_fFirstPassRadius);
            m_CollisionProxy.DelegatesUpdated();
        }
    }
    //return;    
}

event ScaleCollisionProxy()
{
    // End:0x1C
    if(m_CollisionProxy == none)
    {
        SpawnCollisionProxy();        
    }
    else
    {
        // End:0xB1
        if((int(Role) == int(ROLE_Authority)) && m_fFirstPassRadius > 0.0000000)
        {
            m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(m_fFirstPassRadius, 2.0000000 * m_fFirstPassRadius);
            m_CollisionProxy.DelegatesUpdated();
        }
    }
    //return;    
}

simulated function UpdateSpotFX(int spotIndex)
{
    // End:0x23
    if((spotIndex < 0) || spotIndex >= 100)
    {
        return;
    }
    // End:0x4E
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x178
    if(r_EffectSpots[spotIndex].bIsActive)
    {
        // End:0xB7
        if(c_SpotFX[spotIndex].Fx == none)
        {
            InitializeSpecialFX(spotIndex);
        }
        // End:0x175
        if(c_SpotFX[spotIndex].Fx != none)
        {
            UpdateParticleParams(spotIndex);
            // End:0x175
            if(!c_SpotFX[spotIndex].Fx.c_bActive)
            {
                c_SpotFX[spotIndex].Fx.Activate();
            }
        }        
    }
    else
    {
        // End:0x222
        if((c_SpotFX[spotIndex].Fx != none) && c_SpotFX[spotIndex].Fx.c_bActive)
        {
            c_SpotFX[spotIndex].Fx.Deactivate(false);
        }
    }
    //return;    
}

simulated function UpdateParticleParams(int spotIndex)
{
    local int I;
    local editinline ParticleSystemComponent PSC;

    // End:0x51
    if(((spotIndex < 0) || spotIndex >= 100) || c_SpotFX[spotIndex].Fx == none)
    {
        return;
    }
    // End:0x7C
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    I = 0;
    J0x87:

    // End:0x298 [Loop If]
    if(I < c_SpotFX[spotIndex].Fx.c_PSCList.Length)
    {
        PSC = c_SpotFX[spotIndex].Fx.c_PSCList[I].c_PSC;
        // End:0x28A
        if(PSC != none)
        {
            PSC.SetAbsolute(true, true, true);
            PSC.SetTranslation(r_EffectSpots[spotIndex].vLocation);
            PSC.SetRotation(r_EffectSpots[spotIndex].rRotation);
            PSC.SetFloatParameter('DamageRadius', r_EffectSpots[spotIndex].fRadius);
            PSC.SetFloatParameter('DamageRadiusUU', r_EffectSpots[spotIndex].fRadius);
        }
        I++;
        // [Loop Continue]
        goto J0x87;
    }
    //return;    
}

simulated function ClearEffectSpots()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x52 [Loop If]
    if(I < 100)
    {
        r_EffectSpots[I].bIsActive = false;
        ++I;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated event ClearAllTouched()
{
    J0x00:
    // End:0x3B [Loop If]
    if(m_AffectedActors.Length > 0)
    {
        OnProxyUnTouch(m_AffectedActors[0].Target);
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    super(TgDeployable).DestroyIt(bSkipFx);
    // End:0x68
    if(m_bInDestroyedState)
    {
        ClearAllTouched();
        ClearEffectSpots();
        // End:0x68
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
    }
    //return;    
}

simulated event Destroyed()
{
    ClearAllTouched();
    ClearEffectSpots();
    // End:0x46
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.Destroy();
        m_CollisionProxy = none;
    }
    super(TgDeployable).Destroyed();
    //return;    
}

defaultproperties
{
    m_fMinRefreshTime=0.2000000
    m_bFireOnDeploy=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectSpots.MyLightEnvironment'
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