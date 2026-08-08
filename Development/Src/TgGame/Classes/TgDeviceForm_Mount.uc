class TgDeviceForm_Mount extends TgDeviceForm
    native(Devices)
    config(Engine)
    dependson(TgObject);

var int m_FadeMaterialFXId;
var array<MaterialInstanceConstant> m_FadeMICs;
var float m_fFadeInTime;
var float m_fRemainingFadeInTime;
var float m_fFadeOutTime;
var float m_fRemainingFadeOutTime;
var Vector m_CameraOffset;
var TgObject.EMountType m_MountType;
var array<AnimSet> m_LoadedAnimSets;

simulated event string GetAnimSetStringForBot(int PlayerBotId) { }

native function PlaySummonEffects(float SummonTime, bool bIsDismounting);  // Export UTgDeviceForm_Mount::execPlaySummonEffects(FFrame&, void* const)

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_CameraOffset=(X=-142.0000000,Y=0.0000000,Z=25.0000000)
}
