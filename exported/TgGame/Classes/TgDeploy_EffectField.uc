class TgDeploy_EffectField extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation);

var float m_fEffectFieldHeight;
var repnotify float r_fRadiusScale;
var array<Actor> m_TouchingPawns;
var array<Actor> m_HitActors;
var bool m_bOnlyHitOnce;
var TgCollisionProxy_Cylinder m_CollisionProxy;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_fRadiusScale;
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x0F
    if(m_bInDestroyedState)
    {
        return;
    }
    // End:0xDE
    if(m_TouchingPawns.Find(Other) == -1)
    {
        // End:0x60
        if(m_bOnlyHitOnce && m_HitActors.Find(Other) != -1)
        {
            return;
        }
        // End:0xDE
        if((m_FireMode != none) && m_FireMode.IsValidTarget(Other))
        {
            ProxyTouchHit(Other);
            m_TouchingPawns.AddItem(Other);
            m_HitActors.AddItem(Other);
        }
    }
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    // End:0x49
    if(m_TouchingPawns.Find(Other) != -1)
    {
        ProxyUnTouchHit(Other);
        m_TouchingPawns.RemoveItem(Other);
    }
    //return;    
}

function ProxyTouchHit(Actor Other)
{
    local TgPawn PawnOwner;
    local ImpactInfo Impact;

    // End:0x131
    if((m_FireMode != none) && m_FireMode.IsValidTarget(Other))
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = m_FireMode;
        Impact.HitActor = Other;
        m_FireMode.ApplyHitSpecial(Other, Impact);
        PawnOwner = TgPawn(Instigator);
        // End:0x131
        if(PawnOwner != none)
        {
            PawnOwner.DeployableOnApplyEffect(self, Other);
        }
    }
    //return;    
}

function ProxyUnTouchHit(Actor Other)
{
    local TgPawn PawnOwner;

    // End:0x8E
    if(m_FireMode != none)
    {
        m_FireMode.RemoveHitSpecial(Other, true);
        PawnOwner = TgPawn(Instigator);
        // End:0x8E
        if(PawnOwner != none)
        {
            PawnOwner.DeployableOnRemoveEffect(self, Other);
        }
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
    local Actor NextPawn;

    J0x00:
    // End:0x80 [Loop If]
    if(m_TouchingPawns.Length > 0)
    {
        NextPawn = m_TouchingPawns[0];
        // End:0x7D
        if(NextPawn != none)
        {
            OnProxyUnTouch(NextPawn);
            // End:0x7D
            if(m_TouchingPawns.Find(NextPawn) != -1)
            {
                m_TouchingPawns.RemoveItem(NextPawn);
            }
        }
        // [Loop Continue]
        goto J0x00;
    }
    m_HitActors.Length = 0;
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
    local TgDeviceFire ownerFireMode;
    local float Radius;

    // End:0x1FE
    if(r_Owner != none)
    {
        ownerFireMode = r_Owner.GetCurrentFire();
        // End:0x1FE
        if(ownerFireMode != none)
        {
            // End:0x83
            if(m_CollisionProxy != none)
            {
                ClearAllTouched();
                m_CollisionProxy.Destroy();
                m_CollisionProxy = none;
            }
            m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, self.Location,,, true);
            // End:0x1FE
            if(m_CollisionProxy != none)
            {
                m_CollisionProxy.SetBase(self);
                m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
                m_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
                m_CollisionProxy.DelegatesUpdated();
                Radius = ownerFireMode.GetEffectiveRadius() * r_fRadiusScale;
                m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, m_fEffectFieldHeight);
                m_CollisionProxy.DelegatesUpdated();
            }
        }
    }
    //return;    
}

event ScaleCollisionProxy()
{
    local TgDeviceFire ownerFireMode;
    local float Radius;

    // End:0x1C
    if(m_CollisionProxy == none)
    {
        SpawnCollisionProxy();        
    }
    else
    {
        // End:0xFC
        if(r_Owner != none)
        {
            ownerFireMode = r_Owner.GetCurrentFire();
            // End:0xFC
            if(ownerFireMode != none)
            {
                Radius = ownerFireMode.GetEffectiveRadius() * r_fRadiusScale;
                m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, m_fEffectFieldHeight);
                m_CollisionProxy.DelegatesUpdated();
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_fEffectFieldHeight=124.0000000
    r_fRadiusScale=1.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectField.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_MatchParentFireMode.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}