class TgDeviceFire_Lockdown extends TgDeviceFire
    native(ChampBarik);

// Export UTgDeviceFire_Lockdown::execSpawnPet(FFrame&, void* const)
native function TgPawn SpawnPet(bool bPet);

defaultproperties
{
    m_bAllowMultiplePets=true
}