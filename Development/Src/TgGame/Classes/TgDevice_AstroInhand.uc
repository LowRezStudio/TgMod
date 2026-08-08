class TgDevice_AstroInhand extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    config(Engine);

simulated event bool StartReload(optional bool bIgnoreCurrentAmmo=false) { }

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_AstroInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
}
