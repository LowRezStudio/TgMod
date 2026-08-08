class TgDeviceForm_ToggleWithLockout extends TgDeviceForm
    native(Devices)
    config(Engine);

event Generic1(optional byte byExtraData) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Generic2(optional byte byExtraData) { }

defaultproperties
{
    c_bDisableDefaultTimelapseRecovery=true
}
