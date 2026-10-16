class TgDeploy_EffectAura extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation);

var repnotify float r_fRadiusScale;
var array<Actor> m_TouchingActors;
var array<Actor> m_AffectedActors;
var float m_fLastBlockedByBlockersTime;
var float m_fMinBlockedByBlockersTime;
var array<Actor> m_BlockedActors;
var TgCollisionProxy_Cylinder m_CollisionProxy;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fRadiusScale;
}

// Export UTgDeploy_EffectAura::execApplyEffects(FFrame&, void* const)
native function ApplyEffects(Actor Target);

// Export UTgDeploy_EffectAura::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(Actor Target);

// Export UTgDeploy_EffectAura::execGetDistanceToTarget(FFrame&, void* const)
native function float GetDistanceToTarget(Actor Target);

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_fRadiusScale')
    {
        ScaleFX();
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x0F
    if(m_bInDestroyedState)
    {
        return;
    }
    // End:0xCB
    if(m_TouchingActors.Find(Other) == -1)
    {
        // End:0xCB
        if((m_FireMode != none) && m_FireMode.IsValidTarget(Other))
        {
            m_TouchingActors.AddItem(Other);
            // End:0xCB
            if(m_FireMode.IsBlockedByBlocker(self, Other) == none)
            {
                m_BlockedActors.AddItem(Other);
            }
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
    // End:0x7F
    if(m_AffectedActors.Find(Other) != -1)
    {
        RemoveEffects(Other);
        m_AffectedActors.RemoveItem(Other);
    }
    //return;    
}

simulated event float GetCurrentRadius()
{
    // End:0x69
    if((m_CollisionProxy != none) && m_CollisionProxy.m_CollisionCylinder != none)
    {
        return m_CollisionProxy.m_CollisionCylinder.CollisionRadius;
    }
    return 0.0000000;
    //return ReturnValue;    
}

simulated event ClearAllTouched()
{
    J0x00:
    // End:0x28 [Loop If]
    if(m_AffectedActors.Length > 0)
    {
        OnProxyUnTouch(m_AffectedActors[0]);
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    super(TgDeployable).DestroyIt(bSkipFx);
    // End:0x5E
    if(m_bInDestroyedState)
    {
        ClearAllTouched();
        // End:0x5E
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
    // End:0x3C
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.Destroy();
        m_CollisionProxy = none;
    }
    super(TgDeployable).Destroyed();
    //return;    
}

simulated event SpawnCollisionProxy()
{
    local float Radius;

    // End:0x1E3
    if((int(Role) == int(ROLE_Authority)) && m_FireMode != none)
    {
        // End:0x61
        if(m_CollisionProxy != none)
        {
            ClearAllTouched();
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, self.Location,,, true);
        // End:0x1E3
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.SetBase(self);
            m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
            m_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
            m_CollisionProxy.DelegatesUpdated();
            Radius = m_FireMode.GetDamageRadius() * r_fRadiusScale;
            m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, 2.0000000 * Radius);
            m_CollisionProxy.DelegatesUpdated();
        }
    }
    //return;    
}

event ScaleCollisionProxy()
{
    local float Radius;

    // End:0x1C
    if(m_CollisionProxy == none)
    {
        SpawnCollisionProxy();        
    }
    else
    {
        // End:0xE1
        if((int(Role) == int(ROLE_Authority)) && m_FireMode != none)
        {
            Radius = m_FireMode.GetDamageRadius() * r_fRadiusScale;
            m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, 2.0000000 * Radius);
            m_CollisionProxy.DelegatesUpdated();
        }
    }
    //return;    
}

simulated event ScaleFX()
{
    //return;    
}

defaultproperties
{
    r_fRadiusScale=1.0000000
    m_fLastBlockedByBlockersTime=-0.2500000
    m_fMinBlockedByBlockersTime=0.2500000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectAura.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_MatchParentFireMode.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}