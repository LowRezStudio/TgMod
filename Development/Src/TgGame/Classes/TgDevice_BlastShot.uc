class TgDevice_BlastShot extends TgDevice
    native(ChampCassie)
    hidecategories(Navigation)
    config(Engine);

event ScaleAbilityRadius() { }

defaultproperties
{
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=15.0000000,Y=7.0000000,Z=-13.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceBlastShot'
}
