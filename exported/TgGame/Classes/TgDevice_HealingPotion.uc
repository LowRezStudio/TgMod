class TgDevice_HealingPotion extends TgDevice
    hidecategories(Navigation);

var bool s_bQueueDetonation;
var bool m_bAttemptingToDetonate;

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return IsTimerActive('FirePreHitDelay') || IsTimerActive('LockOutOtherDevices');
    //return ReturnValue;    
}

simulated function LockOutOtherDevices()
{
    //return;    
}

simulated function DetonationGracePeriod()
{
    //return;    
}

simulated function FireAmmunition()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x7D
    if(FireMode != none)
    {
        SetTimer(FireMode.GetCustomValue1(), false, 'LockOutOtherDevices');
        SetTimer(FireMode.GetCustomValue2(), false, 'DetonationGracePeriod');
    }
    ScaleAbilityRadius();
    super.FireAmmunition();
    //return;    
}

reliable client simulated event ClientStartCooldown(int nMode, float fCooldownTimeOverride)
{
    super.ClientStartCooldown(nMode, fCooldownTimeOverride);
    //return;    
}

reliable client simulated event ClientEndCooldown()
{
    super.ClientEndCooldown();
    //return;    
}

simulated function UpdateActiveProjectiles(optional TgProjectile Proj)
{
    super.UpdateActiveProjectiles(Proj);
    // End:0x5B
    if((m_FiredProjectiles.Length == 0) && IsTimerActive('FirePostHitDelay'))
    {
        ClearTimer('FirePostHitDelay');
        FirePostHitDelay();
    }
    //return;    
}

simulated function bool InterceptSlotPressed(TgPlayerController TgController)
{
    local TgPawn TgP;

    TgP = TgPawn(Instigator);
    // End:0x4D
    if(TgP.IsAliveAndWell())
    {
        // End:0x4D
        if(TryDetonate())
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

singular simulated function bool TryDetonate()
{
    local int I;
    local bool bSuccessfulDetonation;

    // End:0x11
    if(!IsFiring())
    {
        return false;
    }
    // End:0x43
    if(IsTimerActive('FirePreHitDelay') || IsTimerActive('DetonationGracePeriod'))
    {
        return false;
    }
    // End:0x52
    if(IsDeviceCoolingDown())
    {
        return false;
    }
    I = 0;
    J0x5D:

    // End:0x166 [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        // End:0x158
        if(((m_FiredProjectiles[I] != none) && !m_FiredProjectiles[I].m_bHasExploded) && !m_FiredProjectiles[I].m_bIsShutDown)
        {
            m_FiredProjectiles[I].Explode(m_FiredProjectiles[I].Location, vect(0.0000000, 0.0000000, 1.0000000));
            bSuccessfulDetonation = true;
        }
        I++;
        // [Loop Continue]
        goto J0x5D;
    }
    // End:0x1C6
    if(bSuccessfulDetonation)
    {
        // End:0x191
        if(int(Role) < int(ROLE_Authority))
        {
            ServerTryDetonate();
        }
        // End:0x1C6
        if(IsTimerActive('FirePostHitDelay'))
        {
            ClearTimer('FirePostHitDelay');
            FirePostHitDelay();
        }
    }
    return bSuccessfulDetonation;
    //return ReturnValue;    
}

reliable server event ServerTryDetonate()
{
    // End:0x2A
    if(!TryDetonate() && IsFiring())
    {
        s_bQueueDetonation = true;
    }
    //return;    
}

reliable server event InterruptFiring()
{
    TryDetonate();
    super.InterruptFiring();
    //return;    
}

reliable client simulated event ClientInterrupt()
{
    TryDetonate();
    super.ClientInterrupt();
    //return;    
}

function ScaleAbilityRadius()
{
    local TgPawn_Pip pipOwner;
    local TgDeviceFire FireMode;
    local TgProperty EffectRadiusProperty;
    local float fEffectRadius;

    FireMode = GetCurrentFire();
    // End:0x143
    if(FireMode != none)
    {
        EffectRadiusProperty = FireMode.GetProperty(6);
        // End:0x143
        if(EffectRadiusProperty != none)
        {
            fEffectRadius = EffectRadiusProperty.m_fRaw;
            // End:0x143
            if(fEffectRadius > 0.0000000)
            {
                pipOwner = TgPawn_Pip(Owner);
                // End:0x143
                if((pipOwner != none) && Abs(pipOwner.r_fRadiusForHealingPotionFX - fEffectRadius) > 0.0010000)
                {
                    pipOwner.r_fRadiusForHealingPotionFX = fEffectRadius;
                    pipOwner.bNetDirty = true;
                }
            }
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        s_bQueueDetonation = false;
        super.StartFiringLogic();
        //return;        
    }

    simulated function Tick(float DeltaTime)
    {
        // End:0x17
        if(s_bQueueDetonation)
        {
            TryDetonate();
        }
        super(Actor).Tick(DeltaTime);
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        TryDetonate();
        super.FirePostHitDelay();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bAimThroughReticule=true
    m_IndividualOffhandCooldownTime=0.5000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=-35.0000000,Z=-20.0000000)
}