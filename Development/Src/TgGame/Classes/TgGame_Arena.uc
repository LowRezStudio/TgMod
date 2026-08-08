class TgGame_Arena extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgObject);

var float s_fLastDespawnTime[2];
var float s_fDespawnNotificationDelay;
var int m_nKillValueHero;
var int m_nKillValueMinion;
var int m_nKillValueTower;
var int m_MinScoreToTrackMinionKills;
var int m_nSpawnWaveTime;
var int m_nSpawnWaveDominatingTime;
var int m_nMaxDominatingPoints;
var transient bool m_bIsCrowdOnFeet;

native function ScoreKillGameType(out ScoreKillData Data);  // Export UTgGame_Arena::execScoreKillGameType(FFrame&, void* const)

native function MarkAsReady(Player P);  // Export UTgGame_Arena::execMarkAsReady(FFrame&, void* const)

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Arena::execGetRespawnTime(FFrame&, void* const)

native function EndGameBySurrender(int SurrenderingTaskForce);  // Export UTgGame_Arena::execEndGameBySurrender(FFrame&, void* const)

native function bool BeginEndMission(optional bool bClearNextMapGame=false, optional Actor EndMissionFocus, optional float fDelayOverride=0.0000000);  // Export UTgGame_Arena::execBeginEndMission(FFrame&, void* const)

native function ApplyTowerImmunity();  // Export UTgGame_Arena::execApplyTowerImmunity(FFrame&, void* const)

native function SendDespawnAlert(TgRepInfo_TaskForce tfri);  // Export UTgGame_Arena::execSendDespawnAlert(FFrame&, void* const)

function float GetSetupTime() { }

function bool StartGameTimer() { }

function OnMinionDespawn(int Taskforce) { }

event CheckGameState() { }

event Actor GetEndFocusActor() { }

function SpawnWaveTeam1Timer() { }

function SpawnWaveTeam2Timer() { }

function float GetTaskForceDominatingFactor(int TaskForceNum) { }

defaultproperties
{
    s_fDespawnNotificationDelay=10.0000000
    m_nKillValueHero=5
    m_nKillValueMinion=1
    m_nKillValueTower=15
    m_MinScoreToTrackMinionKills=10
    m_nSpawnWaveTime=20
    m_nSpawnWaveDominatingTime=40
    m_nMaxDominatingPoints=150
    m_bRespawnInhibitors=false
    m_bEnableCrowdEvents=true
    m_fCreditsToGivePerTick=10.0000000
    m_nStartingLevel=3
    m_MinionKillerBonus=0.2500000
    m_fFirstBloodGoldReward=100.0000000
    m_fBasePlayerAssistXpRewardMultipler=1.0000000
    m_fBaseNPCAssistXpRewardMultipler=2.0000000
    m_GameType=TGT_ARENA
    GoalScore=500
}
