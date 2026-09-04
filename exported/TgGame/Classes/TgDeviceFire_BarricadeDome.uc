class TgDeviceFire_BarricadeDome extends TgDeviceFire
    native(ChampBarik);

// Export UTgDeviceFire_BarricadeDome::execSpawnPet(FFrame&, void* const)
native function TgPawn SpawnPet(bool bPet);

defaultproperties
{
    m_bAllowMultiplePets=true
}