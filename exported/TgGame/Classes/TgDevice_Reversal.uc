class TgDevice_Reversal extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation);

var float m_fAccumulatedDamage;
var float m_fVengeanceDamage;

// Export UTgDevice_Reversal::execGetCachedAim(FFrame&, void* const)
native function GetCachedAim(out AimData Aim);

// Export UTgDevice_Reversal::execGetTargetingMode(FFrame&, void* const)
native function TgObject.DeviceTargetMode GetTargetingMode();

// Export UTgDevice_Reversal::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x48
    if((IsFiring()) && Current != none)
    {
        // End:0x48
        if(Current.r_nDeviceId == 12658)
        {
            return true;
        }
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated function TgDeviceFire GetFireModeForFiringProjectile()
{
    return m_FireMode[1];
    //return ReturnValue;    
}

simulated event float GetCurrentDamageAmount()
{
    local TgDeviceFire FireMode;
    local float fMinDamage, fDamageScale;

    FireMode = GetCurrentFire();
    fMinDamage = 0.0000000;
    // End:0x5B
    if(FireMode != none)
    {
        fMinDamage = FireMode.GetCustomValue3();
    }
    fDamageScale = FireMode.GetCustomValue1() / 100.0000000;
    // End:0xAD
    if(fDamageScale <= 0.0000000)
    {
        fDamageScale = 1.0000000;
    }
    return FMax((m_fAccumulatedDamage * fDamageScale) + m_fVengeanceDamage, fMinDamage);
    //return ReturnValue;    
}

simulated function Projectile ProjectileFire(optional int ProjectileIndex = 0)
{
    local Projectile Proj;

    // End:0x1B
    if((GetCurrentDamageAmount()) <= 0.0000000)
    {
        return none;
    }
    Proj = super.ProjectileFire(ProjectileIndex);
    // End:0xB5
    if(((Proj != none) && TgPawn(Owner) != none) && TgProjectile(Proj) != none)
    {
        TgPawn(Owner).ProjectileOnFire(TgProjectile(Proj));
    }
    return Proj;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

function InterruptFiringOnServerInternal(optional bool bSendClientInterrupt = true)
{
    // End:0x34
    if(r_Deployable != none)
    {
        r_Deployable.DestroyIt();
    }
    super.InterruptFiringOnServerInternal(bSendClientInterrupt);
    //return;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        m_fAccumulatedDamage = 0.0000000;
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        local TgDeviceFire FireMode;
        local TgProj_Reversal ReversalProjectile;
        local float fDamageAmount;

        FireMode = GetCurrentFire();
        // End:0xED
        if(FireMode != none)
        {
            fDamageAmount = GetCurrentDamageAmount();
            // End:0xC2
            if(fDamageAmount > 0.0000000)
            {
                // End:0xA4
                if(int(Role) == int(ROLE_Authority))
                {
                    ReversalProjectile = TgProj_Reversal(ProjectileFire());
                    ReversalProjectile.m_fDamageOverride = fDamageAmount;
                }
                m_fAccumulatedDamage = 0.0000000;
                m_fVengeanceDamage = 0.0000000;
            }
            FireMode.ApplyHitSpecial(Owner);
        }
        // End:0x11C
        if(r_Deployable != none)
        {
            r_Deployable.DestroyIt();
        }
        super.FirePostHitDelay();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bAimThroughReticule=true
    m_bForce3PViewWhileFiring=true
    m_fDeployZOffset=-30.0000000
}