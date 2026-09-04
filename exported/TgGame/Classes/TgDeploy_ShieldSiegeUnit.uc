class TgDeploy_ShieldSiegeUnit extends TgDeployable
    native(ChampFlak)
    notplaceable
    hidecategories(Navigation);

var Rotator m_InitRotation;
var export editinline MeshComponent m_VFXCollisionMesh;
var TgCollisionProxy_Cylinder m_CollisionProxy;
var TgDeviceFire m_WatchtowerFiremode;
var TgDevice m_CachedWatchtowerCard;
var float m_GroundSpeed;
var bool m_bOnlyHitOnce;
var array<Actor> m_TouchingPawns;

simulated event Landed(Vector HitNormal, Actor FloorActor)
{
    super(Actor).Landed(HitNormal, FloorActor);
    SetPhysics(1);
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    local ImpactInfo Impact;

    // End:0xFD
    if(m_TouchingPawns.Find(Other) != -1)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = m_WatchtowerFiremode;
        Impact.HitActor = Other;
        m_WatchtowerFiremode.RemoveHitSpecial(Other, true);
        m_WatchtowerFiremode.ApplyHit(Impact, r_Owner);
        m_TouchingPawns.RemoveItem(Other);
    }
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local ImpactInfo Impact;

    // End:0x113
    if(m_TouchingPawns.Find(Other) == -1)
    {
        // End:0x113
        if((m_WatchtowerFiremode != none) && m_WatchtowerFiremode.IsValidTarget(Other))
        {
            Impact.bDirectHit = true;
            Impact.DeviceModeReference = m_WatchtowerFiremode;
            Impact.HitActor = Other;
            m_WatchtowerFiremode.ApplyHitSpecial(Other, Impact);
            m_TouchingPawns.AddItem(Other);
        }
    }
    //return;    
}

simulated event SpawnCollisionProxy(TgDeviceFire FireMode)
{
    local float Radius;

    // End:0x1CF
    if(r_Owner != none)
    {
        // End:0x1CF
        if(FireMode != none)
        {
            m_WatchtowerFiremode = FireMode;
            // End:0x63
            if(m_CollisionProxy != none)
            {
                m_CollisionProxy.Destroy();
                m_CollisionProxy = none;
            }
            m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, self.Location,,, true);
            // End:0x1CF
            if(m_CollisionProxy != none)
            {
                m_CollisionProxy.SetBase(self);
                m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
                m_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
                m_CollisionProxy.DelegatesUpdated();
                Radius = FireMode.GetRange();
                m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, 500.0000000);
                m_CollisionProxy.DelegatesUpdated();
            }
        }
    }
    //return;    
}

simulated event DestroyIt(optional bool bSkipFx)
{
    super.DestroyIt(bSkipFx);
    ClearAllTouched();
    // End:0x51
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.Destroy();
        m_CollisionProxy = none;
    }
    //return;    
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
    m_TouchingPawns.Length = 0;
    //return;    
}

// Export UTgDeploy_ShieldSiegeUnit::execIsFortressBreakerEquipped(FFrame&, void* const)
native simulated function bool IsFortressBreakerEquipped();

simulated event name GetWhileAliveDisplayGroup()
{
    return ((IsFortressBreakerEquipped()) ? 'WhileAliveAlternate' : 'WhileAlive');
    //return ReturnValue;    
}

simulated event name GetDestroyedDisplayGroup()
{
    return ((IsFortressBreakerEquipped()) ? 'DestroyedAlternate' : 'Destroyed');
    //return ReturnValue;    
}

defaultproperties
{
    m_bOnlyHitOnce=true
    m_bMovableProjBlocker=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_ShieldSiegeUnit.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(mCollisionMode=AdvancedCollisionMode.ACM_Shield)
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_ShieldSiegeUnit.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        BlockZeroExtent=false
        BlockNonZeroExtent=false
    end object
    Components[1]=CollisionCylinder
    bUpdateSimulatedPosition=true
    bCollideActors=true
    bCollideWorld=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}