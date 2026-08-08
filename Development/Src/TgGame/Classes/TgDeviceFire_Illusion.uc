class TgDeviceFire_Illusion extends TgDeviceFire
    native(ChampYing)
    config(Engine);

native function CustomFire();  // Export UTgDeviceFire_Illusion::execCustomFire(FFrame&, void* const)

defaultproperties
{
    m_bAllowMultiplePets=true
}
