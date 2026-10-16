class TgDevice_Emitter extends TgDevice
    native(ChampRuckus)
    hidecategories(Navigation);

var array<Actor> m_PawnsInRange;
var TgCollisionProxy_Cylinder m_CollisionProxy;
var bool m_bHasProjector;
var bool m_bIsOnOwner;
var float m_fProjectorPercent;
var TgPawn m_CachedPawnOwner;

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanJumpWhileFiring()
{
    return true;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgDevice_EmitterMod modDevice;
    local int I;

    // End:0x27
    if(!Other.IsA('TgPawn'))
    {
        return;
    }
    // End:0x13B
    if(m_PawnsInRange.Find(Other) == -1)
    {
        m_PawnsInRange.AddItem(Other);
        // End:0x13B
        if(m_bHasProjector && m_CachedPawnOwner != none)
        {
            I = 0;
            J0x86:

            // End:0x13B [Loop If]
            if(I < 33)
            {
                modDevice = TgDevice_EmitterMod(m_CachedPawnOwner.m_EquippedDevices[I]);
                // End:0x12D
                if((modDevice != none) && modDevice.m_bIsOnOthers)
                {
                    modDevice.ApplyTouchEffect(Other, self);
                }
                ++I;
                // [Loop Continue]
                goto J0x86;
            }
        }
    }
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    local TgDevice_EmitterMod modDevice;
    local int I;

    // End:0x114
    if(m_PawnsInRange.Find(Other) != -1)
    {
        // End:0xFE
        if(m_bHasProjector && m_CachedPawnOwner != none)
        {
            I = 0;
            J0x49:

            // End:0xFE [Loop If]
            if(I < 33)
            {
                modDevice = TgDevice_EmitterMod(m_CachedPawnOwner.m_EquippedDevices[I]);
                // End:0xF0
                if((modDevice != none) && modDevice.m_bIsOnOthers)
                {
                    modDevice.RemoveTouchEffect(Other, self);
                }
                ++I;
                // [Loop Continue]
                goto J0x49;
            }
        }
        m_PawnsInRange.RemoveItem(Other);
    }
    //return;    
}

simulated event ClearAllTouched()
{
    J0x00:
    // End:0x73 [Loop If]
    if(m_PawnsInRange.Length > 0)
    {
        // End:0x70
        if(m_PawnsInRange[0] != none)
        {
            OnProxyUnTouch(m_PawnsInRange[0]);
            // End:0x70
            if(m_PawnsInRange.Find(m_PawnsInRange[0]) != -1)
            {
                m_PawnsInRange.RemoveItem(m_PawnsInRange[0]);
            }
        }
        // [Loop Continue]
        goto J0x00;
    }
    //return;    
}

simulated event SpawnCollisionProxy()
{
    local TgDeviceFire FireMode;
    local float Radius;

    FireMode = GetCurrentFire();
    // End:0x1F9
    if((FireMode != none) && Owner != none)
    {
        // End:0x70
        if(m_CollisionProxy != none)
        {
            ClearAllTouched();
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        m_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', Owner,, Owner.Location,,, true);
        // End:0x1F9
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.SetBase(Owner);
            m_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
            m_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
            m_CollisionProxy.DelegatesUpdated();
            Radius = FireMode.GetDamageRadius();
            m_CollisionProxy.m_CollisionCylinder.SetCylinderSize(Radius, Radius);
            m_CollisionProxy.ForceProximityScan();
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PrevStateName)
    {
        local TgPawn_Ruckus TgP;
        local TgDeviceFire FireMode;
        local ImpactInfo selfImpact;

        // End:0xA3
        if((int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || int(WorldInfo.NetMode) == int(NM_Standalone))
        {
            TgP = TgPawn_Ruckus(Instigator);
            // End:0xA3
            if(TgP != none)
            {
                TgP.m_fDamageAccumulator = 0.0000000;
            }
        }
        SpawnCollisionProxy();
        // End:0x19A
        if(!m_bIsOnOwner)
        {
            FireMode = GetCurrentFire();
            // End:0x19A
            if((FireMode != none) && Owner != none)
            {
                selfImpact.bDirectHit = true;
                selfImpact.DeviceModeReference = FireMode;
                selfImpact.HitActor = Owner;
                FireMode.ApplyHitSpecial(Owner, selfImpact);
                m_bIsOnOwner = true;
            }
        }
        super.BeginState(PrevStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgDeviceFire FireMode;

        super.EndState(NextStateName);
        // End:0x8B
        if(m_bIsOnOwner)
        {
            FireMode = GetCurrentFire();
            // End:0x8B
            if((FireMode != none) && Owner != none)
            {
                FireMode.RemoveHitSpecial(Owner, true);
                m_bIsOnOwner = false;
            }
        }
        ClearAllTouched();
        // End:0xC7
        if(m_CollisionProxy != none)
        {
            m_CollisionProxy.Destroy();
            m_CollisionProxy = none;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bAbilityRequiresInhandResync=false
}