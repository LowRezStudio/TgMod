class TgDevice_DoubleCharge extends TgDevice_Charge
    native(Devices)
    hidecategories(Navigation);

var int m_nTotalNumShots;
var int m_nShotsFired;
var bool m_bSetAsTargetingDeviceForMultiFire;

// Export UTgDevice_DoubleCharge::execUpdateTargetingModeStatus(FFrame&, void* const)
native function UpdateTargetingModeStatus(const out AimData Aim);

simulated event bool CanBeCanceled()
{
    return !IsFiring() || IsTimerActive('RefireTimer');
    //return ReturnValue;    
}

simulated event bool Use()
{
    local TgObject.EDeviceFailType failType;

    // End:0x2D
    if(!CanDeviceFireNow(CurrentFireMode, m_CachedAim, false, failType))
    {
        return false;
    }
    // End:0x54
    if(!IsTimerActive('RefireTimer'))
    {
        return super(TgDevice).Use();        
    }
    else
    {
        return RefireTimer(true);
    }
    //return ReturnValue;    
}

simulated function bool RefireTimer(optional bool bRefire)
{
    return false;
    //return ReturnValue;    
}

reliable server function bool ServerRefireTimer(optional bool bRefire, optional AimData ClientAim, optional float EndTraceX = -10000000.0000000, optional float EndTraceY = -10000000.0000000)
{
    // End:0xCE
    if(IsFiring())
    {
        s_ReceivedAim = ClientAim;
        // End:0xCE
        if((EndTraceX > -10000000.0000000) && EndTraceY > -10000000.0000000)
        {
            s_ReceivedAim.EndTrace.X = EndTraceX;
            s_ReceivedAim.EndTrace.Y = EndTraceY;
        }
    }
    return RefireTimer(bRefire);
    //return ReturnValue;    
}

simulated function DeviceConsumePowerPool(byte FireModeNum)
{
    // End:0x22
    if(m_nShotsFired <= 1)
    {
        super(TgDevice).DeviceConsumePowerPool(FireModeNum);
    }
    //return;    
}

simulated function int GetTotalNumberOfShots()
{
    return m_nTotalNumShots;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        m_nShotsFired = 0;
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        ClearTimer('RefireTimer');
        super.EndState(NextStateName);
        //return;        
    }

    simulated function bool RefireTimer(optional bool bRefire)
    {
        local AimData Aim;
        local TgPawn TgP;

        ClearTimer('RefireTimer');
        // End:0x8D
        if(bRefire)
        {
            TgP = TgPawn(Instigator);
            // End:0x8D
            if(TgP != none)
            {
                // End:0x8D
                if(int(Role) == int(ROLE_Authority))
                {
                    // End:0x8D
                    if(ShouldInterruptReloadOnFire())
                    {
                        TgP.InterruptInhandReload();
                    }
                }
            }
        }
        UpdateAimWhileFiring(m_CachedAim);
        GetCachedAim(Aim);
        // End:0x252
        if(Aim.bResult && bRefire)
        {
            // End:0x168
            if(int(Role) < int(ROLE_Authority))
            {
                ServerRefireTimer(true, Aim, Aim.EndTrace.X, Aim.EndTrace.Y);
            }
            // End:0x19D
            if(IsTimerActive('FirePreHitDelay'))
            {
                ClearTimer('FirePreHitDelay');
                FirePreHitDelay();
            }
            // End:0x1D2
            if(IsTimerActive('FirePostHitDelay'))
            {
                ClearTimer('FirePostHitDelay');
                FirePostHitDelay();
            }
            // End:0x1FD
            if(IsTimerActive('RefireTimer'))
            {
                ClearTimer('RefireTimer');
            }
            // End:0x245
            if(IsInState('DeviceFiring'))
            {
                m_fFiringTimer = WorldInfo.TimeSeconds;
                RestartFireLoop(false);
                return true;                
            }
            else
            {
                InterruptFiring();
            }            
        }
        else
        {
            m_nShotsFired = GetTotalNumberOfShots();
            GotoState('Active');
        }
        return false;
        //return ReturnValue;        
    }

    simulated function RestartFireLoop(bool bRefire)
    {
        m_nShotsFired++;
        super.RestartFireLoop(bRefire);
        //return;        
    }

    simulated function bool CanFireAgain()
    {
        return m_nShotsFired < (GetTotalNumberOfShots());
        //return ReturnValue;        
    }

    simulated function FirePostHitDelay()
    {
        local AimData Aim;
        local TgDeviceFire FireMode;
        local WeaponMeshSwapStrategy SwapStrategy;
        local float fRefireTime;

        // End:0x0D
        if(LogDebugInfo())
        {
        }
        FireMode = GetCurrentFire();
        FireMode.RemoveEffectType(Instigator, false, 10456);
        // End:0x80
        if(!FireMode.m_bContinuousFire)
        {
            bPendingFire = false;
        }
        UpdateAimWhileFiring(m_CachedAim);
        GetCachedAim(Aim);
        // End:0x1D8
        if(CanFireAgain())
        {
            EndCharge();
            // End:0xFC
            if(m_bSetAsTargetingDeviceForMultiFire)
            {
                TgPawn(Instigator).SetTargetingDevice(self, SwapStrategy);
            }
            TgPawn(Instigator).FlashStopFire(r_nDeviceInstanceId, int(CurrentFireMode));
            // End:0x171
            if(c_DeviceForm != none)
            {
                c_DeviceForm.StopFire(int(CurrentFireMode));
            }
            fRefireTime = FireMode.GetPropertyValue(53);
            // End:0x1BE
            if(fRefireTime <= 0.0000000)
            {
                fRefireTime = 1.5000000;
            }
            SetTimer(fRefireTime, false, 'RefireTimer');            
        }
        else
        {
            // End:0x22C
            if(((int(Role) == int(ROLE_Authority)) && bPendingFire) && FireMode.m_bContinuousFire)
            {
                InterruptFiring();                
            }
            else
            {
                GotoState('Active');
            }
        }
        SendDeviceChangeEvent(6);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nTotalNumShots=2
    m_bSetAsTargetingDeviceForMultiFire=true
    m_IndividualOffhandCooldownTime=0.0000000
}