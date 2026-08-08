class TgDeviceForm_TyraInhand extends TgDeviceForm
    config(Engine)
    dependson(TgObject);

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }
