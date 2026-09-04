class TgDeviceForm_FlakInhand extends TgDeviceForm
    native(ChampFlak)
    config(Engine)
    dependson(TgObject);

native function TraceForImpactFX();  // Export UTgDeviceForm_FlakInhand::execTraceForImpactFX(FFrame&, void* const)

native function PlayHitSound(Vector Location, TgPawn Target);  // Export UTgDeviceForm_FlakInhand::execPlayHitSound(FFrame&, void* const)

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }
