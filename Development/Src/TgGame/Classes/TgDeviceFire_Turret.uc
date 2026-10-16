class TgDeviceFire_Turret extends TgDeviceFire
    native(ChampBarik)
    config(Engine);

native function TgPawn SpawnPet(bool bPet);  // Export UTgDeviceFire_Turret::execSpawnPet(FFrame&, void* const)

defaultproperties
{
    m_bAllowMultiplePets=true
}
