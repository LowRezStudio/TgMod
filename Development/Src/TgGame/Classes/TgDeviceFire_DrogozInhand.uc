class TgDeviceFire_DrogozInhand extends TgDeviceFire
    native(ChampDrogoz)
    config(Engine);

native function bool CheckValidTarget(Actor Target, bool bPredicting);  // Export UTgDeviceFire_DrogozInhand::execCheckValidTarget(FFrame&, void* const)
