class GameplayEventsUploadAnalytics extends GameplayEventsWriterBase
    native;

// Export UGameplayEventsUploadAnalytics::execStartLogging(FFrame&, void* const)
native function StartLogging(optional float HeartbeatDelta);

// Export UGameplayEventsUploadAnalytics::execResetLogging(FFrame&, void* const)
native function ResetLogging(optional float HeartbeatDelta);

// Export UGameplayEventsUploadAnalytics::execEndLogging(FFrame&, void* const)
native function EndLogging();

// Export UGameplayEventsUploadAnalytics::execLogGameIntEvent(FFrame&, void* const)
native function LogGameIntEvent(int EventID, int Value);

// Export UGameplayEventsUploadAnalytics::execLogGameStringEvent(FFrame&, void* const)
native function LogGameStringEvent(int EventID, string Value);

// Export UGameplayEventsUploadAnalytics::execLogGameFloatEvent(FFrame&, void* const)
native function LogGameFloatEvent(int EventID, float Value);

// Export UGameplayEventsUploadAnalytics::execLogGamePositionEvent(FFrame&, void* const)
native function LogGamePositionEvent(int EventID, const out Vector Position, float Value);

// Export UGameplayEventsUploadAnalytics::execLogTeamIntEvent(FFrame&, void* const)
native function LogTeamIntEvent(int EventID, TeamInfo Team, int Value);

// Export UGameplayEventsUploadAnalytics::execLogTeamFloatEvent(FFrame&, void* const)
native function LogTeamFloatEvent(int EventID, TeamInfo Team, float Value);

// Export UGameplayEventsUploadAnalytics::execLogTeamStringEvent(FFrame&, void* const)
native function LogTeamStringEvent(int EventID, TeamInfo Team, string Value);

// Export UGameplayEventsUploadAnalytics::execLogPlayerIntEvent(FFrame&, void* const)
native function LogPlayerIntEvent(int EventID, Controller Player, int Value);

// Export UGameplayEventsUploadAnalytics::execLogPlayerFloatEvent(FFrame&, void* const)
native function LogPlayerFloatEvent(int EventID, Controller Player, float Value);

// Export UGameplayEventsUploadAnalytics::execLogPlayerStringEvent(FFrame&, void* const)
native function LogPlayerStringEvent(int EventID, Controller Player, string EventString);

// Export UGameplayEventsUploadAnalytics::execLogPlayerSpawnEvent(FFrame&, void* const)
native function LogPlayerSpawnEvent(int EventID, Controller Player, Class<Pawn> PawnClass, int TeamID);

// Export UGameplayEventsUploadAnalytics::execLogPlayerLoginChange(FFrame&, void* const)
native function LogPlayerLoginChange(int EventID, Controller Player, string PlayerName, UniqueNetId PlayerID, bool bSplitScreen);

// Export UGameplayEventsUploadAnalytics::execLogAllPlayerPositionsEvent(FFrame&, void* const)
native function LogAllPlayerPositionsEvent(int EventID);

// Export UGameplayEventsUploadAnalytics::execLogPlayerKillDeath(FFrame&, void* const)
native function LogPlayerKillDeath(int EventID, int KillType, Controller Killer, Class<DamageType> dmgType, Controller Dead);

// Export UGameplayEventsUploadAnalytics::execLogPlayerPlayerEvent(FFrame&, void* const)
native function LogPlayerPlayerEvent(int EventID, Controller Player, Controller Target);

// Export UGameplayEventsUploadAnalytics::execLogWeaponIntEvent(FFrame&, void* const)
native function LogWeaponIntEvent(int EventID, Controller Player, Class<Weapon> WeaponClass, int Value);

// Export UGameplayEventsUploadAnalytics::execLogDamageEvent(FFrame&, void* const)
native function LogDamageEvent(int EventID, Controller Player, Class<DamageType> dmgType, Controller Target, int Amount);

// Export UGameplayEventsUploadAnalytics::execLogProjectileIntEvent(FFrame&, void* const)
native function LogProjectileIntEvent(int EventID, Controller Player, Class<Projectile> Proj, int Value);

function GenericParamListStatEntry GetGenericParamListEntry()
{
    //return ReturnValue;    
}

function RecordAIPathFail(Controller AI, coerce string Reason, Vector Dest)
{
    //return;    
}

function int RecordCoverLinkFireLinks(CoverLink Link, Controller Player)
{
    //return ReturnValue;    
}
