class TgDevice_AstroInhand extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation);

simulated event bool StartReload(optional bool bIgnoreCurrentAmmo = false)
{
    local TgPawn_Astro pAstro;

    pAstro = TgPawn_Astro(Instigator);
    // End:0x8B
    if(pAstro != none)
    {
        // End:0x8B
        if(pAstro.HasDeviceCached(19186))
        {
            pAstro.m_LightSpeedDevice.InterruptFiring();
        }
    }
    return super.StartReload(bIgnoreCurrentAmmo);
    //return ReturnValue;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_AstroInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Princess.DeviceInhand'
}