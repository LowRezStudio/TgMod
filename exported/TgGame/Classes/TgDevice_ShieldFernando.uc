class TgDevice_ShieldFernando extends TgDevice_Toggle
    native(ChampFernando)
    hidecategories(Navigation);

// Export UTgDevice_ShieldFernando::execHasEnoughPowerPool(FFrame&, void* const)
native function bool HasEnoughPowerPool(byte FireModeNum);

// Export UTgDevice_ShieldFernando::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

function InitMaxHealth()
{
    local TgPawn TgPOwner;
    local TgEffectManager em;
    local TgDeploy_ShieldFernando ShieldDeployable;
    local TgDeviceFire ShieldDeviceFire;
    local TgDevice CardDevice;
    local TgEffect HealthBonusEffect;
    local int I, J;
    local float baseHealth, extraHealth, maxHealth;

    TgPOwner = TgPawn(Owner);
    // End:0x522
    if(TgPOwner != none)
    {
        ShieldDeviceFire = GetCurrentFire();
        // End:0x77
        if(ShieldDeviceFire != none)
        {
            baseHealth = ShieldDeviceFire.GetCustomValue1();
        }
        extraHealth = 0.0000000;
        em = TgPOwner.r_EffectManager;
        // End:0x32C
        if(em != none)
        {
            I = 0;
            J0xC8:

            // End:0x32C [Loop If]
            if(I < em.s_AppliedEffectGroups.Length)
            {
                // End:0x31E
                if((em.s_AppliedEffectGroups[I] != none) && em.s_AppliedEffectGroups[I].m_nType == 261)
                {
                    J = 0;
                    J0x177:

                    // End:0x31E [Loop If]
                    if(J < em.s_AppliedEffectGroups[I].m_Effects.Length)
                    {
                        HealthBonusEffect = em.s_AppliedEffectGroups[I].m_Effects[J];
                        // End:0x310
                        if((HealthBonusEffect != none) && HealthBonusEffect.m_nPropertyId == 304)
                        {
                            CardDevice = TgPOwner.GetDeviceById(em.s_AppliedEffectGroups[I].m_nSourceItemId);
                            // End:0x310
                            if((CardDevice != none) && CardDevice.IsCard())
                            {
                                extraHealth += HealthBonusEffect.GetProratedValue();
                            }
                        }
                        ++J;
                        // [Loop Continue]
                        goto J0x177;
                    }
                }
                ++I;
                // [Loop Continue]
                goto J0xC8;
            }
        }
        ShieldDeployable = TgDeploy_ShieldFernando(r_Deployable);
        // End:0x3AD
        if(ShieldDeployable != none)
        {
            extraHealth += float(ShieldDeployable.r_nToweringBarrierHealth);
            extraHealth += float(ShieldDeployable.r_nAegisBonusHealth);
        }
        maxHealth = baseHealth + extraHealth;
        // End:0x522
        if(r_Deployable.GetMaxHealth() != maxHealth)
        {
            // End:0x522
            if(r_Deployable.r_DRI != none)
            {
                r_Deployable.r_DRI.r_nHealthMaximum = int(maxHealth);
                r_Deployable.r_DRI.r_nHealthCurrent = int(maxHealth);
                r_Deployable.r_nHealth = r_Deployable.r_DRI.r_nHealthMaximum;
                r_Deployable.r_DRI.bNetDirty = true;
            }
        }
    }
    //return;    
}

function CancelSafetyPeriodTimer()
{
    //return;    
}

simulated event bool CanBeCanceled()
{
    // End:0x32
    if(IsTimerActive('FirePostHitDelay'))
    {
        // End:0x32
        if(!IsTimerActive('CancelSafetyPeriodTimer'))
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PrevStateName)
    {
        local TgPawn TgPOwner;
        local TgPawn_Fernando Fernando;

        super.BeginState(PrevStateName);
        // End:0x4F
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            SetTimer(0.5000000, false, 'CancelSafetyPeriodTimer');
        }
        // End:0xF1
        if(int(Role) == int(ROLE_Authority))
        {
            TgPOwner = TgPawn(Owner);
            // End:0xA7
            if(r_Deployable != none)
            {
                // End:0xA7
                if(TgPOwner != none)
                {
                    InitMaxHealth();
                }
            }
            Fernando = TgPawn_Fernando(Owner);
            // End:0xF1
            if(Fernando != none)
            {
                Fernando.ShowShield();
            }
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0x50
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            ClearTimer('CancelSafetyPeriodTimer');
        }
        //return;        
    }

    simulated event OnDeployableDestroyed(TgDeployable deployable)
    {
        local TgPawn_Fernando Fernando;

        // End:0x21
        if(deployable == r_Deployable)
        {
            InterruptFiring();
        }
        Fernando = TgPawn_Fernando(Owner);
        // End:0x6B
        if(Fernando != none)
        {
            Fernando.HideShield();
        }
        super(TgDevice).OnDeployableDestroyed(deployable);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bForce3PViewWhileFiring=true
    m_fDeployZOffset=-30.0000000
}