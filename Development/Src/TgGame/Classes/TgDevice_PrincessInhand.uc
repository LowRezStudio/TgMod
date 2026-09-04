class TgDevice_PrincessInhand extends TgDevice
    hidecategories(Navigation)
    config(Engine);

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_LianInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=8.0000000,fRecoilCenterDelay=0.6000000)
}
