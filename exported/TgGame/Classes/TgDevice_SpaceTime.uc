class TgDevice_SpaceTime extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation);

var TgCollisionProxy_Mesh m_BeamCollisionProxy;
var array<TgPawn> m_ActorsInRange;

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated function bool ShouldStopActionOnOffhandSlotReleased()
{
    return false;
    //return ReturnValue;    
}

simulated event DeliverHit(ImpactInfo Impact)
{
    return;
    //return;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    local TgPawn_Astro pAstro;

    // End:0x9D
    if(int(Role) == int(ROLE_Authority))
    {
        pAstro = TgPawn_Astro(Owner);
        // End:0x9D
        if(pAstro != none)
        {
            pAstro.r_mUltimateAimRotation = Rotator(Aim.AimVector);
            pAstro.bNetDirty = true;
        }
    }
    super.HandleDeviceFormStartFire(nDeviceModeNum, fRefireTime, Aim);
    //return;    
}

simulated function InterruptOtherDevices(TgPawn TgP)
{
    super.InterruptOtherDevices(TgP);
    // End:0x5F
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x5F
        if(TgP != none)
        {
            TgP.InterruptDeviceFiringByClass(Class'TgGame.TgDevice_Lightspeed', true);
        }
    }
    //return;    
}

simulated function FireAmmunition()
{
    local TgPawn pHitActor;
    local TgDeviceFire FireMode;
    local ImpactInfo pImpact;
    local int I;

    FireMode = GetCurrentFire();
    // End:0x126
    if(FireMode != none)
    {
        I = 0;
        J0x2E:

        // End:0x11C [Loop If]
        if(I < m_ActorsInRange.Length)
        {
            pHitActor = m_ActorsInRange[I];
            // End:0x10E
            if(pHitActor != none)
            {
                pImpact.bDirectHit = true;
                pImpact.DeviceModeReference = FireMode;
                pImpact.HitActor = pHitActor;
                FireMode.ApplyHit(pImpact, Instigator);
            }
            I++;
            // [Loop Continue]
            goto J0x2E;
        }
        ClearTouchedActors();
    }
    super.FireAmmunition();
    //return;    
}

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgDeviceFire pFireMode;
    local ImpactInfo Impact;

    pFireMode = GetCurrentFire();
    // End:0x13F
    if((pFireMode != none) && pFireMode.IsValidTarget(Other))
    {
        // End:0x13F
        if(Other != none)
        {
            // End:0x13F
            if(m_ActorsInRange.Find(Other) == -1)
            {
                m_ActorsInRange.AddItem(TgPawn(Other));
                Impact.bDirectHit = true;
                Impact.DeviceModeReference = pFireMode;
                Impact.HitActor = Other;
                pFireMode.ApplyHitSpecial(Other, Impact);
            }
        }
    }
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    local TgDeviceFire pFireMode;

    pFireMode = GetCurrentFire();
    // End:0xC3
    if((pFireMode != none) && pFireMode.IsValidTarget(Other))
    {
        // End:0xC3
        if(Other != none)
        {
            // End:0xC3
            if(m_ActorsInRange.Find(Other) != -1)
            {
                m_ActorsInRange.RemoveItem(Other);
                pFireMode.RemoveHitSpecial(Other, true);
            }
        }
    }
    //return;    
}

simulated function ClearTouchedActors()
{
    local TgPawn pPawn;
    local TgDeviceFire pFireMode;

    pFireMode = GetCurrentFire();
    // End:0x9B
    if(pFireMode != none)
    {
        J0x23:

        // End:0x9B [Loop If]
        if(m_ActorsInRange.Length > 0)
        {
            pPawn = m_ActorsInRange[0];
            // End:0x82
            if(pPawn != none)
            {
                pFireMode.RemoveHitSpecial(pPawn, true);
            }
            m_ActorsInRange.RemoveItem(pPawn);
            // [Loop Continue]
            goto J0x23;
        }
    }
    //return;    
}

simulated event SpawnCollisionProxy()
{
    local AimData Aim;
    local TgPawn_Astro pAstro;
    local TgDeviceFire pFireMode;
    local Vector NewScale, SpawnOffset;

    pAstro = TgPawn_Astro(Instigator);
    pFireMode = GetCurrentFire();
    GetCachedAim(Aim);
    // End:0x2C1
    if((int(Role) == int(ROLE_Authority)) && pAstro != none)
    {
        SpawnOffset = Aim.AimVector * 60.0000000;
        m_BeamCollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Mesh', self,, Instigator.Location + SpawnOffset, Rotator(Aim.AimVector),, true);
        m_BeamCollisionProxy.SpawnMesh(8086);
        // End:0x21E
        if(m_BeamCollisionProxy != none)
        {
            // End:0x21E
            if(pFireMode != none)
            {
                NewScale.X = pFireMode.GetRange();
                NewScale.Y = pFireMode.GetCustomValue1() * float(16);
                NewScale.Z = NewScale.Y;
                m_BeamCollisionProxy.ScaleCollisionMesh(NewScale);
            }
        }
        m_BeamCollisionProxy.SetBase(Instigator);
        m_BeamCollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
        m_BeamCollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
        m_BeamCollisionProxy.DelegatesUpdated();
    }
    //return;    
}

simulated function DestroyCollisionProxy()
{
    m_BeamCollisionProxy.Destroy();
    m_BeamCollisionProxy = none;
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        super.StartFiringLogic();
        Instigator.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        Instigator.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        SpawnCollisionProxy();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        DestroyCollisionProxy();
        ClearTouchedActors();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bAimThroughReticule=true
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}