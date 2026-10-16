class TgDevice_DragonSlam extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation);

var bool m_bHasHitTarget;
var TgPawn_Drogoz m_CachedDrogozOwner;
var TgCollisionProxy_Cylinder m_CollisionProxy;

simulated function bool InterceptRightMousePressed(TgPlayerController TgController)
{
    // End:0x30
    if(IsFiring())
    {
        TgController.bPressingRightMouseButton = false;
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function CustomFire()
{
    local AimData Aim;

    UpdateIndex();
    GetCachedAim(Aim);
    PlayClientFireFx(Aim.EndTrace, m_nSocketIndex, false, GetRefireTime());
    // End:0x8C
    if(int(Role) == int(ROLE_Authority))
    {
        GetCurrentFire().CustomFire();
    }
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn PawnTarget;
    local TgDeviceFire FireMode;
    local float fPostHitDelay;

    FireMode = GetCurrentFire();
    // End:0x194
    if(((!m_bHasHitTarget && FireMode != none) && Other != none) && FireMode.IsValidTarget(Other))
    {
        PawnTarget = TgPawn(Other);
        // End:0xF1
        if((PawnTarget != none) && (PawnTarget.GetPropCurrentValue(132) > float(0)) || PawnTarget.IsImmuneToDamage())
        {
            return;
        }
        ClearTimer('FirePostHitDelay');
        m_bHasHitTarget = true;
        fPostHitDelay = FireMode.GetCustomValue5();
        // End:0x165
        if(fPostHitDelay > float(0))
        {
            SetTimer(fPostHitDelay, false, 'FirePostHitDelay');            
        }
        else
        {
            FirePostHitDelay();
        }
        ServerImpactTarget(Other, HitLocation, HitNormal);
    }
    //return;    
}

reliable client simulated function ClientImpactTarget()
{
    local TgDeviceFire FireMode;
    local float fPostHitDelay;

    ClearTimer('FirePostHitDelay');
    m_bHasHitTarget = true;
    FireAmmunition();
    FireMode = GetCurrentFire();
    // End:0x76
    if(FireMode != none)
    {
        fPostHitDelay = FireMode.GetCustomValue5();
    }
    // End:0xA1
    if(fPostHitDelay > float(0))
    {
        SetTimer(fPostHitDelay, false, 'FirePostHitDelay');        
    }
    else
    {
        FirePostHitDelay();
    }
    //return;    
}

reliable server function ServerImpactTarget(Actor Target, Vector HitLocation, Vector HitNormal)
{
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;

    m_bHasHitTarget = true;
    FireMode = GetCurrentFire();
    // End:0x180
    if(((FireMode != none) && Target != none) && FireMode.IsValidTarget(Target))
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = FireMode;
        Impact.HitActor = Target;
        Impact.HitLocation = HitLocation;
        Impact.HitNormal = HitNormal;
        Impact.RayDir = -HitNormal;
        FireMode.ApplyHit(Impact, m_CachedDrogozOwner);
    }
    ClientImpactTarget();
    //return;    
}

function RefundEnergy()
{
    local TgDeviceFire FireMode;
    local ImpactInfo Impact;

    FireMode = GetCurrentFire();
    // End:0xC1
    if(FireMode != none)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = FireMode;
        Impact.HitActor = Instigator;
        FireMode.ApplyHitSpecial(Instigator, Impact);
    }
    //return;    
}

simulated event Destroyed()
{
    // End:0x32
    if(m_CollisionProxy != none)
    {
        m_CollisionProxy.Destroy();
        m_CollisionProxy = none;
    }
    super.Destroyed();
    //return;    
}

simulated event SpawnCollisionProxy()
{
    local float Height, Radius;

    // End:0x1C9
    if(m_CachedDrogozOwner != none)
    {
        // End:0x41
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', self,, m_CachedDrogozOwner.Location,,, true);
        // End:0x1C9
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.SetBase(m_CachedDrogozOwner);
            m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
            m_CollisionProxy.DelegatesUpdated();
            Height = m_CachedDrogozOwner.NativeGetCollisionHeight() * 0.9000000;
            Radius = m_CachedDrogozOwner.NativeGetCollisionRadius() * 1.4000000;
            m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, Height);
            m_CollisionProxy.ForceProximityScan();
        }
    }
    //return;    
}

simulated function FireAmmunition()
{
    // End:0x19
    if(!m_bHasHitTarget)
    {
        super.FireAmmunition();
    }
    //return;    
}

simulated event bool CanBeCanceled()
{
    // End:0x2A
    if(IsTimerActive('FirePostHitDelay') && !m_bHasHitTarget)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x93
    if(((IsFiring()) && Current != none) && (Current.m_bHandDevice || Current.IsAbility()) || Current.m_nDeviceType == 11077)
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        // End:0x43
        if(m_CachedDrogozOwner != none)
        {
            m_CachedDrogozOwner.m_bDragonSlamIsBlocking = true;
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        m_bHasHitTarget = false;
        super.FirePreHitDelay();
        // End:0x2F
        if(m_CollisionProxy == none)
        {
            SpawnCollisionProxy();
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x32
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        // End:0x61
        if((int(Role) == int(ROLE_Authority)) && !m_bHasHitTarget)
        {
            RefundEnergy();
        }
        // End:0x91
        if(m_CachedDrogozOwner != none)
        {
            m_CachedDrogozOwner.m_bDragonSlamIsBlocking = false;
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
}