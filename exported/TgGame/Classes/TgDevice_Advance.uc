class TgDevice_Advance extends TgDevice_Charge
    native(ChampRuckus)
    hidecategories(Navigation);

var bool m_bHasCharged;
var repnotify bool r_bHasAerialAssault;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasAerialAssault;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x3A
    if(VarName == 'r_bHasAerialAssault')
    {
        m_fMinTimeBetweenAmmoCharges = ((r_bHasAerialAssault) ? 0.0000000 : 0.5000000);
    }
    super(TgDevice).ReplicatedEvent(VarName);
    //return;    
}

simulated function Rotator GetChargeDirection()
{
    // End:0xB3
    if((Instigator.Acceleration.X == float(0)) && Instigator.Acceleration.Y == float(0))
    {
        // End:0x91
        if(r_bHasAerialAssault)
        {
            return Rotator(vect(0.0000000, 0.0000000, 1.0000000));
        }
        return Instigator.Rotation;        
    }
    else
    {
        return Rotator(Normal2D(Instigator.Acceleration));
    }
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x9E
    if(super.ShouldLockFiring(Current))
    {
        // End:0x9C
        if(Current != none)
        {
            // End:0x4F
            if(Current.m_nDeviceType == 11077)
            {
                return false;
            }
            switch(Current.r_nDeviceId)
            {
                // End:0x7F
                case 11460:
                // End:0x87
                case 14581:
                // End:0x8F
                case 11434:
                // End:0x99
                case 14582:
                    return false;
                // End:0xFFFF
                default:
                    break;
                }
        }
        else
        {
            return true;
        }/* !MISMATCHING REMOVE, tried If got Type:Else Position:0x09C! */
        return false;
        //return ReturnValue;        
    }/* !MISMATCHING REMOVE, tried Else got Type:If Position:0x000! */
}

simulated event bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

function bool ShouldApplyHitSpecialOnTouch(Actor Target)
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated event StartCharge()
    {
        local TgDeviceFire FireMode;
        local TgPawn_Ruckus Ruckus;

        super.StartCharge();
        // End:0x202
        if(m_bCharging)
        {
            m_bHasCharged = true;
            // End:0x52
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic2();
            }
            Ruckus = TgPawn_Ruckus(Instigator);
            // End:0x202
            if(Ruckus != none)
            {
                Ruckus.FlashGeneric2(r_nDeviceInstanceId, int(CurrentFireMode));
                FireMode = GetCurrentFire();
                // End:0x202
                if(FireMode != none)
                {
                    Ruckus.m_bForceHover = true;
                    Ruckus.m_fDesiredHeight = FireMode.GetCustomValue2() * float(16);
                    Ruckus.m_fKx = FireMode.GetCustomValue3();
                    Ruckus.m_fKv = FireMode.GetCustomValue4();
                    SetTimer((GetChargeTime()) / 2.0000000, false, 'EndHovering');
                    SetTimer(FireMode.GetCustomValue5(), false, 'EndCharge');
                }
            }
        }
        //return;        
    }

    function EndHovering()
    {
        local TgPawn_Ruckus Ruckus;

        Ruckus = TgPawn_Ruckus(Instigator);
        // End:0x4C
        if(Ruckus != none)
        {
            Ruckus.m_bForceHover = false;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bUsePhysFlying=true
    m_bCanLeftClickCancel=false
    m_bForce3PViewWhileFiring=false
}