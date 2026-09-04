class TgDeviceForm_Valor extends TgDeviceForm
    config(Engine)
    dependson(TgObject);

simulated event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }
