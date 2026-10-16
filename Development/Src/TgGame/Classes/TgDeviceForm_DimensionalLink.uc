class TgDeviceForm_DimensionalLink extends TgDeviceForm
    config(Engine);

var TgPawn_Ying m_CachedYingPawn;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

simulated function bool HasCachedYingPawn() { }
