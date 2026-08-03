class TgDeviceFire_Turret extends TgDeviceFire
    native(ChampBarik);

// Export UTgDeviceFire_Turret::execSpawnPet(FFrame&, void* const)
native function TgPawn SpawnPet(bool bPet);

defaultproperties
{
    m_bAllowMultiplePets=true
}