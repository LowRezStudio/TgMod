class TgDevice_LongReach extends TgDevice
    native(Devices)
    hidecategories(Navigation);

struct native NuggetPullVals
{
    var Actor nugget;
    var float fPullTime;
    var float fCheckTime;

    structdefaultproperties
    {
        nugget=none
        fPullTime=0.0000000
        fCheckTime=0.0000000
    }
};

var float m_fMinPullSpeed;
var float m_fMaxPullSpeed;
var float m_fTimeToMaxPullSpeed;
var float m_fPullSpeedInterpExp;
var TgPawn m_CachedTgP;
var array<NuggetPullVals> s_TouchingNuggets;
var float m_fBlockedByBlockersRecheckTime;
var TgCollisionProxy_Cylinder s_CollisionProxy;
var bool s_bIsAuraActive;
var bool m_bAutoActivateAura;

// Export UTgDevice_LongReach::execIsNuggetValid(FFrame&, void* const)
native function bool IsNuggetValid(Actor Target);

function OnProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local NuggetPullVals newNugget;
    local TgDeploy_HealthNugget nugget;
    local int I;

    nugget = TgDeploy_HealthNugget(Other);
    // End:0x78
    if((nugget == none) || !nugget.IsFriendlyWithLocalPawn() && nugget.IsA('TgDeploy_HealthNugget_TeamOnly'))
    {
        return;
    }
    I = 0;
    J0x83:

    // End:0xDF [Loop If]
    if(I < s_TouchingNuggets.Length)
    {
        // End:0xD1
        if(s_TouchingNuggets[I].nugget == nugget)
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x83;
    }
    nugget.bUpdateSimulatedPosition = true;
    newNugget.nugget = nugget;
    newNugget.fPullTime = ((IsNuggetValid(nugget)) ? 0.0000000 : -1.0000000);
    newNugget.fCheckTime = m_fBlockedByBlockersRecheckTime;
    s_TouchingNuggets.AddItem(newNugget);
    //return;    
}

function OnProxyUnTouch(Actor Other)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xF1 [Loop If]
    if(I < s_TouchingNuggets.Length)
    {
        // End:0xE3
        if(s_TouchingNuggets[I].nugget == Other)
        {
            // End:0xCC
            if(s_TouchingNuggets[I].nugget != none)
            {
                s_TouchingNuggets[I].nugget.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
            }
            s_TouchingNuggets.Remove(I, 1);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function ClearAllTouched()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0xA6 [Loop If]
    if(I < s_TouchingNuggets.Length)
    {
        // End:0x98
        if(s_TouchingNuggets[I].nugget != none)
        {
            s_TouchingNuggets[I].nugget.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    s_TouchingNuggets.Remove(0, s_TouchingNuggets.Length);
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
    if(s_CollisionProxy != none)
    {
        s_CollisionProxy.Destroy();
        s_CollisionProxy = none;
    }
    super.Destroyed();
    //return;    
}

event SpawnCollisionProxy()
{
    local TgDeviceFire FireMode;

    // End:0x23F
    if((int(Role) == int(ROLE_Authority)) && Owner != none)
    {
        s_bIsAuraActive = false;
        // End:0x6D
        if(s_CollisionProxy != none)
        {
            ClearAllTouched();
            s_CollisionProxy.Destroy();
            s_CollisionProxy = none;
        }
        FireMode = GetCurrentFire();
        // End:0x23F
        if(FireMode != none)
        {
            s_CollisionProxy = Spawn(Class'TgGame.TgCollisionProxy_Cylinder', Owner,, Owner.Location,,, true);
            // End:0x23F
            if(s_CollisionProxy != none)
            {
                s_CollisionProxy.m_bForwardOwnerOnly = true;
                s_CollisionProxy.SetCollision(false, false, true);
                s_CollisionProxy.SetBase(Owner);
                s_CollisionProxy.__ProxyTouch__Delegate = OnProxyTouch;
                s_CollisionProxy.__ProxyUnTouch__Delegate = OnProxyUnTouch;
                s_CollisionProxy.m_CollisionCylinder.SetCylinderSize(FireMode.GetDamageRadius(), 2.0000000 * FireMode.GetDamageRadius());
                s_CollisionProxy.DelegatesUpdated();
            }
        }
    }
    //return;    
}

event EnableAura()
{
    s_bIsAuraActive = true;
    // End:0x25
    if(s_CollisionProxy == none)
    {
        SpawnCollisionProxy();
    }
    // End:0x4F
    if(s_CollisionProxy != none)
    {
        s_CollisionProxy.SetCollision(true, false, false);
    }
    //return;    
}

event DisableAura()
{
    s_bIsAuraActive = false;
    // End:0x36
    if(s_CollisionProxy != none)
    {
        s_CollisionProxy.SetCollision(false, false, true);
    }
    ClearAllTouched();
    //return;    
}

defaultproperties
{
    m_fMinPullSpeed=256.0000000
    m_fMaxPullSpeed=1024.0000000
    m_fTimeToMaxPullSpeed=1.0000000
    m_fPullSpeedInterpExp=2.0000000
    m_fBlockedByBlockersRecheckTime=0.2500000
    m_bAutoActivateAura=true
}