class TgDevice_BarricadeDome extends TgDevice
    native(ChampBarik)
    hidecategories(Navigation);

var Vector m_TurretSpawnLocation;
var int m_FlameTurretID;

// Export UTgDevice_BarricadeDome::execGetCachedAim(FFrame&, void* const)
native function GetCachedAim(out AimData Aim);

// Export UTgDevice_BarricadeDome::execGetPetIDOverride(FFrame&, void* const)
native function int GetPetIDOverride(int PetIndex);

function InitMaxHealth()
{
    local TgPawn TgPOwner;
    local TgEffectManager em;
    local TgDevice CardDevice;
    local TgEffect HealthBonusEffect;
    local int I, J;
    local float baseHealth, extraHealth, maxHealth;

    TgPOwner = TgPawn(Owner);
    // End:0x4AE
    if(TgPOwner != none)
    {
        // End:0x63
        if(r_Deployable != none)
        {
            baseHealth = r_Deployable.GetMaxHealth();
        }
        extraHealth = 0.0000000;
        em = TgPOwner.r_EffectManager;
        // End:0x318
        if(em != none)
        {
            I = 0;
            J0xB4:

            // End:0x318 [Loop If]
            if(I < em.s_AppliedEffectGroups.Length)
            {
                // End:0x30A
                if((em.s_AppliedEffectGroups[I] != none) && em.s_AppliedEffectGroups[I].m_nType == 261)
                {
                    J = 0;
                    J0x163:

                    // End:0x30A [Loop If]
                    if(J < em.s_AppliedEffectGroups[I].m_Effects.Length)
                    {
                        HealthBonusEffect = em.s_AppliedEffectGroups[I].m_Effects[J];
                        // End:0x2FC
                        if((HealthBonusEffect != none) && HealthBonusEffect.m_nPropertyId == 304)
                        {
                            CardDevice = TgPOwner.GetDeviceById(em.s_AppliedEffectGroups[I].m_nSourceItemId);
                            // End:0x2FC
                            if((CardDevice != none) && CardDevice.IsCard())
                            {
                                extraHealth += HealthBonusEffect.GetProratedValue();
                            }
                        }
                        ++J;
                        // [Loop Continue]
                        goto J0x163;
                    }
                }
                ++I;
                // [Loop Continue]
                goto J0xB4;
            }
        }
        maxHealth = baseHealth + extraHealth;
        // End:0x4AE
        if(r_Deployable.GetMaxHealth() != maxHealth)
        {
            // End:0x4AE
            if(r_Deployable.r_DRI != none)
            {
                r_Deployable.r_DRI.r_nHealthMaximum = int(maxHealth);
                r_Deployable.r_DRI.r_nHealthCurrent = int(maxHealth);
                r_Deployable.r_nHealth = r_Deployable.r_DRI.r_nHealthMaximum;
                r_Deployable.bNetDirty = true;
                r_Deployable.r_DRI.bNetDirty = true;
            }
        }
    }
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
            TgP.InterruptDeviceFiringByClass(Class'TgGame.TgDevice_RocketBoots');
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        local TgPawn TgPOwner;

        super.FirePreHitDelay();
        // End:0x62
        if(int(Role) == int(ROLE_Authority))
        {
            TgPOwner = TgPawn(Owner);
            // End:0x62
            if(r_Deployable != none)
            {
                // End:0x62
                if(TgPOwner != none)
                {
                    InitMaxHealth();
                }
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_FlameTurretID=2230
    m_bDeployAtFeetOnFailure=true
    m_fBottomlessPitCheck=5000.0000000
}