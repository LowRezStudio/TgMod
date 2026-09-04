class TgGame_Battle extends TgGame_Mission
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgGame, TgObject);

const MAX_GENERAL_PHYSICAL_STAT = 180.0f;

const MAX_GENERAL_MAGICAL_STAT = 540.0f;

const MAX_GENERAL_DEFENSE_STAT = 228.0f;

const MAX_GENERAL_UTILITY_STAT = 318.0f;

var float m_MultiLaneXpBonus;
var bool m_bRespawnInhibitors;
var bool m_bEnableCrowdEvents;
var bool m_bRestrictStoreInteractions;
var bool m_bWinGameOnNexusDestroyed;
var int m_nBumbasMaskId;
var int m_nSupportStarterId;
var array<TgAIBotPlayersToSpawn> m_MercsToSpawn;
var int m_nPIESpawnTable;
var int m_nTargetPlayerCountForMercs;

native function UpdateGameWinState(TgPawn nexus);  // Export UTgGame_Battle::execUpdateGameWinState(FFrame&, void* const)

native function SendBonusMinionAlerts(TgRepInfo_TaskForce tf, int nLane);  // Export UTgGame_Battle::execSendBonusMinionAlerts(FFrame&, void* const)

native function SendGameStartAlert();  // Export UTgGame_Battle::execSendGameStartAlert(FFrame&, void* const)

native function StructureDied(TgPawn_Structure theStructure);  // Export UTgGame_Battle::execStructureDied(FFrame&, void* const)

native function PlayerDied(TgPlayerController PC);  // Export UTgGame_Battle::execPlayerDied(FFrame&, void* const)

native function BotDied(TgAIController aic);  // Export UTgGame_Battle::execBotDied(FFrame&, void* const)

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle::execGetRespawnTime(FFrame&, void* const)

native function ApplyTowerImmunity();  // Export UTgGame_Battle::execApplyTowerImmunity(FFrame&, void* const)

native function int GetNextVulnerableTowerId(int nBotId);  // Export UTgGame_Battle::execGetNextVulnerableTowerId(FFrame&, void* const)

native function CheckTeamAce(Controller Killer, Controller Killed);  // Export UTgGame_Battle::execCheckTeamAce(FFrame&, void* const)

native function SetInhibitorRespawn(bool bRespawn);  // Export UTgGame_Battle::execSetInhibitorRespawn(FFrame&, void* const)

native function bool ShouldSpawnSuperMinions(TgBotFactory_Minions minionFactory);  // Export UTgGame_Battle::execShouldSpawnSuperMinions(FFrame&, void* const)

native function CheckMercenaries();  // Export UTgGame_Battle::execCheckMercenaries(FFrame&, void* const)

native function ForceLoadMercenaries(int SpawnTableID);  // Export UTgGame_Battle::execForceLoadMercenaries(FFrame&, void* const)

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_Battle::execScoreKillGameType(FFrame&, void* const)

native function SendLanePusherSpawnAlert(int Taskforce);  // Export UTgGame_Battle::execSendLanePusherSpawnAlert(FFrame&, void* const)

native function int CalcWeakestLane(TgRepInfo_TaskForce tf);  // Export UTgGame_Battle::execCalcWeakestLane(FFrame&, void* const)

event NexusWasDestroyed(TgPawn nexus) { }

event OnBossMonsterKilled(TgPawn BossMonster, TgPawn KillerPawn) { }

event TriggerBonusMinions(TgRepInfo_TaskForce tf, int nLane) { }

function bool StartGameTimer() { }

event ChangeTimerState(TgObject.GameTimerState eTimerState) { }

function CreateMinimapManagers(Class<TgMinimapManager> managerClass) { }

event int GetPlayerCount() { }

function SpawnBots() { }

simulated event SendLanePusherUpdateAlert(bool isAlive, int tf) { }

defaultproperties
{
    m_MultiLaneXpBonus=0.5000000
    m_bRespawnInhibitors=true
    m_nBumbasMaskId=8987
    m_nSupportStarterId=9089
    m_nStartingCurrency=1500
    m_nWinPlayerXp=20
    m_nLosePlayerXp=20
    m_fGodXpCoefficient=0.2000000
    m_fGodXpCoefficientLoss=0.2000000
    m_fGodXpWinBonus=4.0000000
    m_fBaseTokens=1.5000000
    m_GameType=TGT_BATTLE
    m_bStatsIsSymmetric=true
}
