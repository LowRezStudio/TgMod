class TgDeviceFire_Pursuit extends TgDeviceFire
    native(ChampLex);

// Export UTgDeviceFire_Pursuit::execSetProperty(FFrame&, void* const)
native function SetProperty(int nPropertyId, float fNewValue);
