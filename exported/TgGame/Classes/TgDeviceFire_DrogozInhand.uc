class TgDeviceFire_DrogozInhand extends TgDeviceFire
    native(ChampDrogoz);

// Export UTgDeviceFire_DrogozInhand::execCheckValidTarget(FFrame&, void* const)
native function bool CheckValidTarget(Actor Target, bool bPredicting);
