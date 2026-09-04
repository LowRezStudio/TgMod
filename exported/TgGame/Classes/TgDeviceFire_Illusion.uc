class TgDeviceFire_Illusion extends TgDeviceFire
    native(ChampYing);

// Export UTgDeviceFire_Illusion::execCustomFire(FFrame&, void* const)
native function CustomFire();

defaultproperties
{
    m_bAllowMultiplePets=true
}