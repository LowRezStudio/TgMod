class GameplayEventsWriter extends GameplayEventsWriterBase
    native;

// Export UGameplayEventsWriter::execResolvePlayerIndex(FFrame&, void* const)
native function int ResolvePlayerIndex(Controller Player);

// Export UGameplayEventsWriter::execOpenStatsFile(FFrame&, void* const)
native function bool OpenStatsFile(string Filename);

// Export UGameplayEventsWriter::execCloseStatsFile(FFrame&, void* const)
native function CloseStatsFile();

// Export UGameplayEventsWriter::execSerializeHeader(FFrame&, void* const)
protected native function bool SerializeHeader();

// Export UGameplayEventsWriter::execSerializeFooter(FFrame&, void* const)
protected native function bool SerializeFooter();

// Export UGameplayEventsWriter::execStartLogging(FFrame&, void* const)
native function StartLogging(optional float HeartbeatDelta);

// Export UGameplayEventsWriter::execResetLogging(FFrame&, void* const)
native function ResetLogging(optional float HeartbeatDelta);

// Export UGameplayEventsWriter::execEndLogging(FFrame&, void* const)
native function EndLogging();

// Export UGameplayEventsWriter::execLogGameIntEvent(FFrame&, void* const)
native function LogGameIntEvent(int EventID, int Value);

// Export UGameplayEventsWriter::execLogGameStringEvent(FFrame&, void* const)
native function LogGameStringEvent(int EventID, string Value);

// Export UGameplayEventsWriter::execLogGameFloatEvent(FFrame&, void* const)
native function LogGameFloatEvent(int EventID, float Value);

// Export UGameplayEventsWriter::execLogGamePositionEvent(FFrame&, void* const)
native function LogGamePositionEvent(int EventID, const out Vector Position, float Value);

// Export UGameplayEventsWriter::execLogTeamIntEvent(FFrame&, void* const)
native function LogTeamIntEvent(int EventID, TeamInfo Team, int Value);

// Export UGameplayEventsWriter::execLogTeamFloatEvent(FFrame&, void* const)
native function LogTeamFloatEvent(int EventID, TeamInfo Team, float Value);

// Export UGameplayEventsWriter::execLogTeamStringEvent(FFrame&, void* const)
native function LogTeamStringEvent(int EventID, TeamInfo Team, string Value);

// Export UGameplayEventsWriter::execLogPlayerIntEvent(FFrame&, void* const)
native function LogPlayerIntEvent(int EventID, Controller Player, int Value);

// Export UGameplayEventsWriter::execLogPlayerFloatEvent(FFrame&, void* const)
native function LogPlayerFloatEvent(int EventID, Controller Player, float Value);

// Export UGameplayEventsWriter::execLogPlayerStringEvent(FFrame&, void* const)
native function LogPlayerStringEvent(int EventID, Controller Player, string EventString);

// Export UGameplayEventsWriter::execLogPlayerSpawnEvent(FFrame&, void* const)
native function LogPlayerSpawnEvent(int EventID, Controller Player, Class<Pawn> PawnClass, int TeamID);

// Export UGameplayEventsWriter::execLogPlayerLoginChange(FFrame&, void* const)
native function LogPlayerLoginChange(int EventID, Controller Player, string PlayerName, UniqueNetId PlayerID, bool bSplitScreen);

// Export UGameplayEventsWriter::execLogAllPlayerPositionsEvent(FFrame&, void* const)
native function LogAllPlayerPositionsEvent(int EventID);

// Export UGameplayEventsWriter::execLogPlayerKillDeath(FFrame&, void* const)
native function LogPlayerKillDeath(int EventID, int KillType, Controller Killer, Class<DamageType> dmgType, Controller Dead);

// Export UGameplayEventsWriter::execLogPlayerPlayerEvent(FFrame&, void* const)
native function LogPlayerPlayerEvent(int EventID, Controller Player, Controller Target);

// Export UGameplayEventsWriter::execLogWeaponIntEvent(FFrame&, void* const)
native function LogWeaponIntEvent(int EventID, Controller Player, Class<Weapon> WeaponClass, int Value);

// Export UGameplayEventsWriter::execLogDamageEvent(FFrame&, void* const)
native function LogDamageEvent(int EventID, Controller Player, Class<DamageType> dmgType, Controller Target, int Amount);

// Export UGameplayEventsWriter::execLogProjectileIntEvent(FFrame&, void* const)
native function LogProjectileIntEvent(int EventID, Controller Player, Class<Projectile> Proj, int Value);

// Export UGameplayEventsWriter::execLogSystemPollEvents(FFrame&, void* const)
native function LogSystemPollEvents();

// Export UGameplayEventsWriter::execGetGenericParamListEntry(FFrame&, void* const)
native function GenericParamListStatEntry GetGenericParamListEntry();

function RecordAIPathFail(Controller AI, coerce string Reason, Vector Dest)
{
    //return;    
}

function int RecordCoverLinkFireLinks(CoverLink Link, Controller Player)
{
    return 0;
    //return ReturnValue;    
}
