class TgDevice_Aura extends TgDevice
    abstract
    native(Devices)
    hidecategories(Navigation);

var repnotify float r_fRadiusScale;
var array<Actor> m_TouchingActors;
var array<Actor> m_AffectedActors;
var bool m_bIsAuraActive;
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

// Export UTgDevice_Aura::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nFireModeNum, optional bool ForceSet = false);

// Export UTgDevice_Aura::execApplyEffects(FFrame&, void* const)
native function ApplyEffects(Actor Target);

// Export UTgDevice_Aura::execRemoveEffects(FFrame&, void* const)
native function RemoveEffects(Actor Target);

// Export UTgDevice_Aura::execGetCurrentRadius(FFrame&, void* const)
native function float GetCurrentRadius();

// Export UTgDevice_Aura::execGetDistanceToTarget(FFrame&, void* const)
native function float GetDistanceToTarget(Actor Target);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgDeviceFire FireMode;

    // End:0x89
    if(m_TouchingActors.Find(Other) == -1)
    {
        FireMode = GetCurrentFire();
        // End:0x89
        if((FireMode != none) && FireMode.IsValidTarget(Other))
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
    // End:0x7F
    if(m_AffectedActors.Find(Other) != -1)
    {
        RemoveEffects(Other);
        m_AffectedActors.RemoveItem(Other);
    }
    //return;    
}

simulated event ClearAllAffected()
{
    local Actor NextActor;

    J0x00:
    // End:0x57 [Loop If]
    if(m_AffectedActors.Length > 0)
    {
        NextActor = m_AffectedActors[0];
        // End:0x47
        if(NextActor != none)
        {
            RemoveEffects(NextActor);
        }
        m_AffectedActors.Remove(0, 1);
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

simulated event ClearAllTouched()
{
    ClearAllAffected();
    m_TouchingActors.Remove(0, m_TouchingActors.Length);
    //return;    
}

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns)
{
    DisableAura();
    super.DeviceShutDown(bDeactiveMode, bResetCooldowns);
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
    super.Destroyed();
    //return;    
}

event SpawnCollisionProxy()
{
    local TgDeviceFire FireMode;
    local float Radius;

    // End:0x226
    if((int(Role) == int(ROLE_Authority)) && Owner != none)
    {
        m_bIsAuraActive = false;
        // End:0x6D
        if(m_CollisionProxy != none)
        {
            ClearAllTouched();
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        FireMode = GetCurrentFire();
        // End:0x226
        if(FireMode != none)
        {
            m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', Owner,, Owner.Location,,, true);
            // End:0x226
            if(m_CollisionProxy != none)
            {
                m_CollisionProxy.SetCollision(false, false, true);
                m_CollisionProxy.SetBase(Owner);
                m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
                m_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
                Radius = FireMode.GetDamageRadius() * r_fRadiusScale;
                m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, 2.0000000 * Radius);
                m_CollisionProxy.DelegatesUpdated();
            }
        }
    }
    //return;    
}

event ScaleCollisionProxy()
{
    local TgDeviceFire FireMode;
    local float Radius;

    // End:0x1C
    if(m_CollisionProxy == none)
    {
        SpawnCollisionProxy();        
    }
    else
    {
        // End:0xF3
        if(int(Role) == int(ROLE_Authority))
        {
            FireMode = GetCurrentFire();
            // End:0xF3
            if(FireMode != none)
            {
                Radius = FireMode.GetDamageRadius() * r_fRadiusScale;
                m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, 2.0000000 * Radius);
                m_CollisionProxy.DelegatesUpdated();
            }
        }
    }
    //return;    
}

event EnableAura()
{
    local TgDeviceFire FireMode;

    m_bIsAuraActive = true;
    // End:0xBF
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.SetCollision(true, false, false);
        // End:0xBF
        if(m_TouchingActors.Find(Owner) == -1)
        {
            FireMode = GetCurrentFire();
            // End:0xBF
            if((FireMode != none) && FireMode.IsValidTarget(Owner))
            {
                m_TouchingActors.AddItem(Owner);
            }
        }
    }
    //return;    
}

event DisableAura()
{
    m_bIsAuraActive = false;
    // End:0x36
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.SetCollision(false, false, true);
    }
    ClearAllTouched();
    //return;    
}

simulated event bool CanJumpWhileFiring()
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    r_fRadiusScale=1.0000000
    m_fLastBlockedByBlockersTime=-0.2500000
    m_fMinBlockedByBlockersTime=0.2500000
}