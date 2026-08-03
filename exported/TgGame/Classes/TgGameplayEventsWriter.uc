class TgGameplayEventsWriter extends GameplayEventsWriter
    native(GameStats);

// Export UTgGameplayEventsWriter::execResolvePlayerIndex(FFrame&, void* const)
native function int ResolvePlayerIndex(Controller Player);

// Export UTgGameplayEventsWriter::execLogPaladinsPlayerKillDeath(FFrame&, void* const)
native function LogPaladinsPlayerKillDeath(int EventID, int KillType, Controller Killer, Class<DamageType> dmgType, Controller Dead);

defaultproperties
{
    SupportedEvents=/* Array type was not detected. */
}