class TgDeviceForm_DarklordInhand extends TgDeviceForm_Inhand
    native(ChampDarklord)
    config(Engine);

var TgPawn_Darklord m_CachedDarklord;
var const float m_fFadeParamMin;
var const float m_fFadeParamMax;
var const float m_fAmmoParamMin;
var const float m_fAmmoParamMax;
var const float m_fMaskParamMin;
var const float m_fMaskParamMax;
var float m_fPreviousAppliedAmmoPerc;
var float m_fCurrentAppliedAmmoPerc;
var const float m_fAnimatedReloadStartNormalizedTime;
var const float m_fAnimatedReloadEndNormalizedTime;
var float m_fReloadDuration;
var float m_fReloadTimer;

simulated function bool HasCachedDarklord() { }

simulated function OnReload(float fReloadTime) { }

simulated event ForceUpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc) { }

simulated function UpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc) { }

native simulated function UpdateSpecialFxMaterials(TgSpecialFx Fx, float fPerc);  // Export UTgDeviceForm_DarklordInhand::execUpdateSpecialFxMaterials(FFrame&, void* const)

simulated function UpdateMeshMaterials(TgSkeletalMeshComponent_Weapon Mesh, float fPerc) { }

defaultproperties
{
    m_fFadeParamMin=0.5000000
    m_fFadeParamMax=1.0000000
    m_fAmmoParamMin=0.1000000
    m_fAmmoParamMax=1.0000000
    m_fMaskParamMin=0.1000000
    m_fMaskParamMax=1.0000000
    m_fAnimatedReloadStartNormalizedTime=0.3500000
    m_fAnimatedReloadEndNormalizedTime=0.5500000
    m_fReloadTimer=-1.0000000
}
