class TgDevice_ShellShield extends TgDevice
    native(ChampMakoa)
    hidecategories(Navigation);

var bool r_bHasHalfshell;
var bool c_bHalfShellFXOn;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bHasHalfshell;
}

// Export UTgDevice_ShellShield::execSetFireMode(FFrame&, void* const)
native function SetFireMode(int nFireModeNum, optional bool ForceSet = false);

simulated event OnDeployableSpawned(TgDeployable deployable)
{
    local TgDeviceFire FireMode;
    local ImpactInfo selfImpact;

    // End:0x113
    if(r_bHasHalfshell && deployable == r_Deployable)
    {
        // End:0x113
        if(!c_bHalfShellFXOn && Owner != none)
        {
            FireMode = GetCurrentFire();
            // End:0x113
            if(FireMode != none)
            {
                selfImpact.bDirectHit = true;
                selfImpact.DeviceModeReference = FireMode;
                selfImpact.HitActor = Owner;
                FireMode.ApplyHitSpecial(Owner, selfImpact);
                c_bHalfShellFXOn = true;
            }
        }
    }
    //return;    
}

event OnDeployableDestroyed(TgDeployable deployable)
{
    local TgDeviceFire FireMode;
    local TgPawn PawnOwner;

    // End:0x138
    if(deployable == r_Deployable)
    {
        // End:0x12E
        if(r_bHasHalfshell)
        {
            // End:0x9C
            if(c_bHalfShellFXOn && Owner != none)
            {
                FireMode = GetCurrentFire();
                // End:0x9C
                if(FireMode != none)
                {
                    FireMode.RemoveHitSpecial(Owner, true);
                    c_bHalfShellFXOn = false;
                }
            }
            // End:0xCB
            if(c_DeviceForm != none)
            {
                c_DeviceForm.Generic1();
            }
            PawnOwner = TgPawn(Owner);
            // End:0x12B
            if(PawnOwner != none)
            {
                PawnOwner.FlashGeneric1(r_nDeviceInstanceId, int(CurrentFireMode));
            }            
        }
        else
        {
            InterruptFiring();
        }
    }
    super.OnDeployableDestroyed(deployable);
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x67
    if((Current != none) && Current.r_nDeviceId == 14191)
    {
        return IsTimerActive('FirePreHitDelay') || IsTimerActive('ShellShieldFireLockout');
    }
    return (IsFiring()) || IsTimerActive('ShellShieldFireLockout');
    //return ReturnValue;    
}

simulated function ShellShieldFireLockout()
{
    //return;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return IsTimerActive('FirePostHitDelay');
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        local TgPawn_Makoa makoaOwner;

        // End:0xF3
        if(!r_bHasHalfshell)
        {
            makoaOwner = TgPawn_Makoa(Instigator);
            // End:0xF3
            if(makoaOwner != none)
            {
                makoaOwner.m_fShellShieldSpeedModifier = GetCurrentFire().GetCustomValue1();
                makoaOwner.m_fShellShieldZoomOverride = 1.5000000;
                // End:0xF3
                if(int(Role) == int(ROLE_Authority))
                {
                    makoaOwner.r_bShellShieldIsActive = true;
                    makoaOwner.bNetDirty = true;
                }
            }
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn_Makoa makoaOwner;
        local float fLockOutTime;

        makoaOwner = TgPawn_Makoa(Instigator);
        // End:0xC9
        if(makoaOwner != none)
        {
            makoaOwner.m_fShellShieldSpeedModifier = 1.0000000;
            makoaOwner.m_fShellShieldZoomOverride = 0.0000000;
            // End:0xC9
            if(int(Role) == int(ROLE_Authority))
            {
                makoaOwner.r_bShellShieldIsActive = false;
                makoaOwner.bNetDirty = true;
            }
        }
        super.EndState(NextStateName);
        // End:0x130
        if((int(Role) == int(ROLE_Authority)) && !r_bHasHalfshell)
        {
            // End:0x130
            if(r_Deployable != none)
            {
                r_Deployable.DestroyIt();
            }
        }
        fLockOutTime = GetCurrentFire().GetCustomValue2();
        // End:0x184
        if(fLockOutTime > 0.0000000)
        {
            SetTimer(fLockOutTime, false, 'ShellShieldFireLockout');
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bDeployAtFeetOnFailure=true
    m_bCooldownAfterDeployDeath=true
    m_fDeployZForgiveness=0.0000000
    m_fBottomlessPitCheck=0.0000000
    m_fDeployZOffset=-40.0000000
}