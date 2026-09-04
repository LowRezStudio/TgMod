class TgDeviceForm_FlakInhand extends TgDeviceForm
    native(ChampFlak);

// Export UTgDeviceForm_FlakInhand::execTraceForImpactFX(FFrame&, void* const)
native function TraceForImpactFX();

// Export UTgDeviceForm_FlakInhand::execPlayHitSound(FFrame&, void* const)
native function PlayHitSound(Vector Location, TgPawn Target);

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    TraceForImpactFX();
    //return;    
}

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    super.Hit(nFireMode, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
    // End:0x74
    if(Target != none)
    {
        PlayHitSound(HitLocation, TgPawn(Target));
    }
    //return;    
}
