class TgDeviceFire_BarricadeDome extends TgDeviceFire
    native(ChampBarik)
    config(Engine);

native function TgPawn SpawnPet(bool bPet);  // Export UTgDeviceFire_BarricadeDome::execSpawnPet(FFrame&, void* const)

defaultproperties
{
    m_bAllowMultiplePets=true
}
