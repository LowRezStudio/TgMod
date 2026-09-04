class TgGame_Battle extends TgGame_Mission
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

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

// Export UTgGame_Battle::execUpdateGameWinState(FFrame&, void* const)
native function UpdateGameWinState(TgPawn nexus);

// Export UTgGame_Battle::execSendBonusMinionAlerts(FFrame&, void* const)
native function SendBonusMinionAlerts(TgRepInfo_TaskForce tf, int nLane);

// Export UTgGame_Battle::execSendGameStartAlert(FFrame&, void* const)
native function SendGameStartAlert();

// Export UTgGame_Battle::execStructureDied(FFrame&, void* const)
native function StructureDied(TgPawn_Structure theStructure);

// Export UTgGame_Battle::execPlayerDied(FFrame&, void* const)
native function PlayerDied(TgPlayerController PC);

// Export UTgGame_Battle::execBotDied(FFrame&, void* const)
native function BotDied(TgAIController aic);

// Export UTgGame_Battle::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Battle::execApplyTowerImmunity(FFrame&, void* const)
native function ApplyTowerImmunity();

// Export UTgGame_Battle::execGetNextVulnerableTowerId(FFrame&, void* const)
native function int GetNextVulnerableTowerId(int nBotId);

// Export UTgGame_Battle::execCheckTeamAce(FFrame&, void* const)
native function CheckTeamAce(Controller Killer, Controller Killed);

// Export UTgGame_Battle::execSetInhibitorRespawn(FFrame&, void* const)
native function SetInhibitorRespawn(bool bRespawn);

// Export UTgGame_Battle::execShouldSpawnSuperMinions(FFrame&, void* const)
native function bool ShouldSpawnSuperMinions(TgBotFactory_Minions minionFactory);

// Export UTgGame_Battle::execCheckMercenaries(FFrame&, void* const)
native function CheckMercenaries();

// Export UTgGame_Battle::execForceLoadMercenaries(FFrame&, void* const)
native function ForceLoadMercenaries(int SpawnTableID);

// Export UTgGame_Battle::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

// Export UTgGame_Battle::execSendLanePusherSpawnAlert(FFrame&, void* const)
native function SendLanePusherSpawnAlert(int Taskforce);

// Export UTgGame_Battle::execCalcWeakestLane(FFrame&, void* const)
native function int CalcWeakestLane(TgRepInfo_TaskForce tf);

event NexusWasDestroyed(TgPawn nexus)
{
    UpdateGameWinState(nexus);
    BeginEndMission();
    //return;    
}

event OnBossMonsterKilled(TgPawn BossMonster, TgPawn KillerPawn)
{
    //return;    
}

event TriggerBonusMinions(TgRepInfo_TaskForce tf, int nLane)
{
    //return;    
}

function bool StartGameTimer()
{
    // End:0x36
    if(super.StartGameTimer())
    {
        SetTimer(1.0000000, false, 'ApplyTowerImmunity');
        SetInhibitorRespawn(m_bRespawnInhibitors);
        return true;
    }
    return false;
    //return ReturnValue;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    local TgObject.GameTimerState OldState;
    local TgPlayerController TgPC;

    OldState = m_eTimerState;
    super.ChangeTimerState(eTimerState);
    // End:0xDB
    if(((int(eTimerState) != int(OldState)) && int(eTimerState) == int(3)) && int(OldState) != int(6))
    {
        SendGameStartAlert();
        // End:0xDB
        if(m_bEnableCrowdEvents)
        {
            // End:0xDA
            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
            {
                TgPC.ArenaCrowdEvent(3);                
            }            
        }
    }
    //return;    
}

function CreateMinimapManagers(Class<TgMinimapManager> managerClass)
{
    local TgRepInfo_TaskForce tfri;
    local TgRepInfo_Game GRI;

    super.CreateMinimapManagers(managerClass);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    tfri = GRI.GetTaskForce(3);
    tfri.CreateMinimap(2, managerClass);
    // End:0xDF
    if(tfri.s_MinimapManager != none)
    {
        tfri.s_MinimapManager.m_bSkipWorldGeometryLOS = true;
    }
    //return;    
}

event int GetPlayerCount()
{
    local TgPlayerController TgPC;
    local int PlayerCount;

    PlayerCount = 0;
    // End:0x70
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        // End:0x6F
        if(!TgPC.IsA('TgSpectatorController'))
        {
            ++PlayerCount;
        }        
    }    
    return PlayerCount;
    //return ReturnValue;    
}

function SpawnBots()
{
    SpawnDefaultBotPlayers(m_MercsToSpawn, false);
    //return;    
}

simulated event SendLanePusherUpdateAlert(bool isAlive, int tf)
{
    local int I;
    local array<SequenceObject> KismetEvents;
    local TgSeqEvent_UpdateLanePusherCount SeqEvent;
    local array<int> ActivateIndices;

    // End:0x149
    if(int(Role) == int(ROLE_Authority))
    {
        WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_UpdateLanePusherCount', true, KismetEvents);
        I = 0;
        J0x67:

        // End:0x149 [Loop If]
        if(I < KismetEvents.Length)
        {
            SeqEvent = TgSeqEvent_UpdateLanePusherCount(KismetEvents[I]);
            // End:0x13B
            if((SeqEvent != none) && SeqEvent.Taskforce == tf)
            {
                // End:0xFF
                if(isAlive)
                {
                    ActivateIndices[0] = 1;                    
                }
                else
                {
                    ActivateIndices[0] = 0;
                }
                SeqEvent.CheckActivate(self, self, false, ActivateIndices);
                // [Explicit Break]
                goto J0x149;
            }
            I++;
            // [Loop Continue]
            goto J0x67;
        }
    }
    J0x149:

    //return;    
}

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
    m_GameType=TG_GAME_TYPE.TGT_BATTLE
    m_bStatsIsSymmetric=true
}