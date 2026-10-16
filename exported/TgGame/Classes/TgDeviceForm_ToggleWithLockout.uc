class TgDeviceForm_ToggleWithLockout extends TgDeviceForm
    native(Devices);

event Generic1(optional byte byExtraData)
{
    SetToggleState(false);
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    SetToggleState(true);
    //return;    
}

event Generic2(optional byte byExtraData)
{
    SetToggleState(true);
    //return;    
}

defaultproperties
{
    c_bDisableDefaultTimelapseRecovery=true
}