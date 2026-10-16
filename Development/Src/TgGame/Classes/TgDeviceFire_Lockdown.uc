class TgDeviceFire_Lockdown extends TgDeviceFire
    native(ChampBarik)
    config(Engine);

native function TgPawn SpawnPet(bool bPet);  // Export UTgDeviceFire_Lockdown::execSpawnPet(FFrame&, void* const)

defaultproperties
{
    m_bAllowMultiplePets=true
}
