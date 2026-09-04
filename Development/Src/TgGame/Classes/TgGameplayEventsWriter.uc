class TgGameplayEventsWriter extends GameplayEventsWriter
    native(GameStats)
    config(Engine);

native function native int ResolvePlayerIndex(Controller Player);  // Export UTgGameplayEventsWriter::execResolvePlayerIndex(FFrame&, void* const)

native function LogPaladinsPlayerKillDeath(int EventID, int KillType, Controller Killer, Class<DamageType> dmgType, Controller Dead);  // Export UTgGameplayEventsWriter::execLogPaladinsPlayerKillDeath(FFrame&, void* const)

defaultproperties
{
    SupportedEvents=/* Array type was not detected. */
}
