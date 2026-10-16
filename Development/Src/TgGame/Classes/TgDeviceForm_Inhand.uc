class TgDeviceForm_Inhand extends TgDeviceForm
    native(Devices)
    config(Engine);

var int m_nAmmoCount;
var int m_nMaxAmmoCount;
var float m_fPreviousAmmoPerc;
var float m_fCurrentAmmoPerc;

simulated function OnAmmoCountUpdated(int nAmmoCount, int nMaxAmmoCount) { }

simulated function UpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc) { }

simulated function OnWeaponMeshUpdated() { }
