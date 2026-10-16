class TgDeviceFire_IllusoryRift extends TgDeviceFire
    native(ChampYing)
    config(Engine);

native function CustomFire();  // Export UTgDeviceFire_IllusoryRift::execCustomFire(FFrame&, void* const)

defaultproperties
{
    m_bAllowMultiplePets=true
}
