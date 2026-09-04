class TgDevice_PrincessFSupport extends TgDevice
    native(ChampPrincess)
    hidecategories(Navigation);

var TgPawn_Princess m_CachedLian;

// Export UTgDevice_PrincessFSupport::execCanFiringBeLocked(FFrame&, void* const)
native function bool CanFiringBeLocked();

// Export UTgDevice_PrincessFSupport::execUsesCachedAim(FFrame&, void* const)
native function bool UsesCachedAim();

// Export UTgDevice_PrincessFSupport::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

simulated function bool HasCachedLian()
{
    // End:0x2B
    if(m_CachedLian == none)
    {
        m_CachedLian = TgPawn_Princess(Instigator);
    }
    return m_CachedLian != none;
    //return ReturnValue;    
}

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local int I, nNumTargetsFound;
    local ImpactInfo ii, toReturn;
    local TgCombatActor TgCA;

    toReturn = super.CalcWeaponFire(Aim, ImpactList);
    // End:0x17F
    if(HasCachedLian())
    {
        I = 0;
        J0x3F:

        // End:0x87 [Loop If]
        if(I < 15)
        {
            m_CachedLian.r_GraceTargets[I] = none;
            I++;
            // [Loop Continue]
            goto J0x3F;
        }
        nNumTargetsFound = 0;
        I = 0;
        J0x9D:

        // End:0x17F [Loop If]
        if(I < ImpactList.Length)
        {
            ii = ImpactList[I];
            TgCA = TgCombatActor(ii.HitActor);
            // End:0x171
            if(NotEqual_InterfaceInterface(TgCA, TgCombatActor(none)))
            {
                // End:0x134
                if(nNumTargetsFound >= 15)
                {
                    // [Explicit Break]
                    goto J0x17F;
                }
                m_CachedLian.r_GraceTargets[nNumTargetsFound] = TgCA;
                nNumTargetsFound++;
            }
            I++;
            // [Loop Continue]
            goto J0x9D;
        }
    }
    J0x17F:

    return toReturn;
    //return ReturnValue;    
}

defaultproperties
{
    m_bDisableLagCompensation=true
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Princess.DeviceInhand'
}