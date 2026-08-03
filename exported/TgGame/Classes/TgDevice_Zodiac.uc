class TgDevice_Zodiac extends TgDevice
    native(ChampAstro)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var array<float> m_EffectRemainingTime;

// Export UTgDevice_Zodiac::execApplyBuff(FFrame&, void* const)
native function ApplyBuff();

// Export UTgDevice_Zodiac::execRemoveBuff(FFrame&, void* const)
native function RemoveBuff();

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

// Export UTgDevice_Zodiac::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();
