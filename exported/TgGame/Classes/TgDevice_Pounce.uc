class TgDevice_Pounce extends TgDevice_Charge
    native(ChampBlades)
    hidecategories(Navigation);

var TgPawn_Blades m_CachedBlades;
var bool m_bHasBounced;

// Export UTgDevice_Pounce::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

simulated function bool HasCachedBlades()
{
    // End:0x38
    if(m_CachedBlades == none)
    {
        m_CachedBlades = TgPawn_Blades(Instigator);
        return m_CachedBlades != none;
    }
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x2A
    if(Current.m_nDeviceType == 11077)
    {
        return false;
    }
    return (IsFiring()) || IsPostHitLockOutActive();
    //return ReturnValue;    
}

simulated function bool IsPostHitLockOutActive()
{
    return IsTimerActive('PostHitLockOut');
    //return ReturnValue;    
}

simulated function PostHitLockOut()
{
    //return;    
}

reliable server function ServerBounceOff(Actor Other)
{
    // End:0x0F
    if(m_bHasBounced)
    {
        return;
    }
    // End:0xC0
    if(ServerValidateChargeHit(Other))
    {
        // End:0xAC
        if(HasCachedBlades())
        {
            ApplyTouchHit(m_CachedBlades, Other.Location, Normal(m_CachedBlades.Location - Other.Location), Other);
        }
        BounceOff();
        InterruptFiring();
    }
    //return;    
}

reliable client simulated function ClientBounceOff()
{
    // End:0x19
    if(!m_bHasBounced)
    {
        BounceOff();
    }
    //return;    
}

simulated function BounceOff()
{
    local Vector NewVel;
    local Rotator adjustedDir;
    local float Angle;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x20D
    if((HasCachedBlades()) && FireMode != none)
    {
        m_bHasBounced = true;
        SetTimer(FireMode.GetCustomValue5(), false, 'PostHitLockOut');
        // End:0xA0
        if(int(m_DeviceEmoteAt) == int(2))
        {
            m_CachedBlades.PlayDeviceEmoteAll(self);
        }
        adjustedDir = Rotator(-Vector(m_rLastChargeDirection));
        Angle = (90.0000000 * float(adjustedDir.Pitch)) / float(16384);
        Angle = float(Clamp(int(Angle + FireMode.GetCustomValue2()), -90, 90));
        adjustedDir.Pitch = int((Angle / 90.0000000) * 16384.0000000);
        NewVel = Vector(adjustedDir);
        NewVel *= FireMode.GetCustomValue1();
        m_CachedBlades.QueueBounceCustom(NewVel, FireMode.GetCustomValue3(), FireMode.GetCustomValue4());
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function OnStoppedChargeOnHit(Actor Other)
    {
        super.OnStoppedChargeOnHit(Other);
        // End:0x58
        if((int(Role) < int(ROLE_Authority)) && !m_bHasBounced)
        {
            ServerBounceOff(Other);
            BounceOff();            
        }
        else
        {
            // End:0x80
            if(int(Role) == int(ROLE_Authority))
            {
                BounceOff();
                ClientBounceOff();
            }
        }
        //return;        
    }

    simulated event StartCharge()
    {
        // End:0x92
        if(HasCachedBlades())
        {
            m_CachedBlades.SetGemEmissiveAnim(2);
            m_CachedBlades.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode), true);
            // End:0x92
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1();
            }
        }
        SetTimer((GetChargeTime()) * 0.8000000, false, 'PreStopCharge');
        m_bHasBounced = false;
        super.StartCharge();
        //return;        
    }

    simulated function PreStopCharge()
    {
        // End:0x71
        if(HasCachedBlades())
        {
            m_CachedBlades.FlashGeneric2(r_nDeviceInstanceId, int(CurrentFireMode), true);
            // End:0x71
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic2();
            }
        }
        //return;        
    }

    simulated event EndCharge()
    {
        // End:0x35
        if(IsTimerActive('PreStopCharge'))
        {
            ClearTimer('PreStopCharge');
            PreStopCharge();
        }
        super.EndCharge();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bStopOnHitType=ChargeStopOnHitType.CSHT_GodOnly
    m_ChargeTimingType=ChargeFiringType.CFT_PreFire
    m_bUsePhysFlying=true
    m_bIgnoreHumanoids=false
    m_vHitProxySizeOffset=(X=0.0000000,Y=12.0000000,Z=0.0000000)
    m_DeviceEmoteAt=DeviceEmoteAt.DEA_Custom
    m_bForce3PViewWhileFiring=false
}