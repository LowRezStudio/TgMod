class TgDeviceForm_AccursedArmGun extends TgDeviceForm;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    // End:0x89
    if((HitLocation != vect(0.0000000, 0.0000000, 0.0000000)) && ModeDatas[c_nFireMode].c_FxInstantFire)
    {
        PlayImpactEffects(HitLocation, nEquipSlot, nSocketIndex, bSuccessfulHit);
    }
    // End:0xD2
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormFire(c_nEquipSlot, fRefireTime, nFireMode);
    }
    ActivateFxGroup('AccursedArm_MuzzleFlash');
    //return;    
}

defaultproperties
{
    m_bUseImpactFXOverride=true
}