class TgRepInfo_Game extends GameReplicationInfo
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const TG_MAX_MAP_OBJECTIVES = 75;
const TG_MAX_CAPTURE_POINTS = 5;

enum MissionTimerState
{
    MTS_STOPPED,                    // 0
    MTS_RUNNING,                    // 1
    MTS_PAUSED,                     // 2
    MTS_MAX                         // 3
};

enum MAP_LANE
{
    MAP_LANE_NONE,                  // 0
    MAP_LANE_LEFT,                  // 1
    MAP_LANE_MIDDLE,                // 2
    MAP_LANE_RIGHT,                 // 3
    MAP_LANE_MAX                    // 4
};

enum EFlagState
{
    FLAG_Home,                      // 0
    FLAG_HeldFriendly,              // 1
    FLAG_HeldEnemy,                 // 2
    FLAG_Down,                      // 3
    FLAG_MAX                        // 4
};

struct native GraphData
{
    var int XP;
    var int Gold;
    var int Time;

    structdefaultproperties
    {
        XP=0
        Gold=0
        Time=0
    }
};

struct native BotDifficultyDebugData
{
    var bool CurrentlyActive;
    var bool DisparityDetected;
    var bool ChangesLockedOut;
    var int TimeBeforeTrigger;
    var TgAIController_Behavior.EBotDifficultyLevel TaskForce1BotDifficulty;
    var TgAIController_Behavior.EBotDifficultyLevel TaskForce2BotDifficulty;
    var float TaskForce1Skill;
    var float TaskForce2Skill;
    var SkillLevelPercentageData SkillPercentages[2];

    structdefaultproperties
    {
        CurrentlyActive=false
        DisparityDetected=false
        ChangesLockedOut=false
        TimeBeforeTrigger=0
        TaskForce1BotDifficulty=EBotDifficultyLevel.AIDifficulty_Practice
        TaskForce2BotDifficulty=EBotDifficultyLevel.AIDifficulty_Practice
        TaskForce1Skill=0.0000000
        TaskForce2Skill=0.0000000
        SkillPercentages[0]=(NumDeathsPercentage=0.0000000,DamagePercentage=0.0000000,KillsPercentage=0.0000000,SoloKillsPercentage=0.0000000,AssistsPercentage=0.0000000,HealingPercentage=0.0000000,CreditsPercentage=0.0000000,ObjectiveTimePercentage=0.0000000,ShieldingPercentage=0.0000000,KillstreakMultiplier=0.0000000)
        SkillPercentages[1]=(NumDeathsPercentage=0.0000000,DamagePercentage=0.0000000,KillsPercentage=0.0000000,SoloKillsPercentage=0.0000000,AssistsPercentage=0.0000000,HealingPercentage=0.0000000,CreditsPercentage=0.0000000,ObjectiveTimePercentage=0.0000000,ShieldingPercentage=0.0000000,KillstreakMultiplier=0.0000000)
    }
};

var array<GraphData> m_GraphData;
var GraphData r_LastDataPoint;
var float m_GraphUpdateWaitTime;
var repnotify TgObject.TG_GAME_TYPE r_GameType;
var TgObject.INITIALIZEABLE_BOOL r_eTalentsEnabled;
var TgRepInfo_Game.MissionTimerState r_nMissionTimerState;
var repnotify TgObject.GameTimerState r_eGameTimerState;
var TgRepInfo_Game.MissionTimerState r_nRoundLimitTimerState;
var TgRepInfo_Game.MissionTimerState r_nSecondaryTimerState;
var byte r_nLastRoundAttacker;
var byte r_nLastRoundWinner;
var TgRepInfo_Game.EFlagState r_FlagState[2];
var repnotify TgObject.EGameEnvironmentRule r_GameEnvironmentRule;
var TgObject.EGameRespawnRule r_GameRespawnRule;
var TgObject.EGameMode r_GameMode;
var bool r_bIsMission;
var bool r_bBlockCreditGain;
var bool r_bBlockEnergyGain;
var bool r_bOvertime;
var bool r_bCapturePointOvertime;
var bool r_bRoundEnding;
var bool r_bFadeOutAtRoundEnd;
var repnotify bool r_bIntroPlayed;
var repnotify bool r_bUsePointsMode;
var bool r_bUltimatesLocked;
var bool r_bEnableDistanceFOW;
var repnotify bool r_bSpawnGatesOpen;
var repnotify bool r_bAttackersSpawnGatesOpen;
var repnotify bool r_bDefendersSpawnGatesOpen;
var bool r_bForwardProgress;
var bool r_bServerFlagSprint;
var bool r_bServerFlagMinimapTeamVisibility;
var bool r_bForce3P;
var bool r_bForce1P;
var bool r_bForceOutOfCombatSprint;
var bool r_bAutoMelee;
var bool r_bShowProjectileProximityDistance;
var bool r_bDisableProjectileProximityDistance;
var repnotify bool r_bShowHeadMesh;
var bool m_fFogSettingsSaved;
var config bool r_bUseInstantFireMeshTrace;
var config bool r_bAllowWeaponLagPrediction;
var bool r_bSiegeEngineRequiresAlliesToMove;
var bool r_bSiegeEngineMovementPaused;
var bool r_bSiegeEngineMovementPausedAfterDamagingGate;
var bool r_bFogConverging;
var bool r_bFogEnded;
var bool r_bCheckpoint1Reached;
var bool r_bCheckpoint2Reached;
var private bool r_bEnableHeadshots;
var bool r_bAllowPlayerMounting;
var bool r_bKillCamEnabled;
var bool r_bAttackersKillCamEnabled;
var bool r_bDefendersKillCamEnabled;
var bool r_bBlockKillCam;
var bool r_bIsFirstRound;
var bool r_bGhostMountingEnabled;
var bool r_bSpawnGatesOpenedAtLeastOnce;
var float r_fMissionRemainingTime;
var repnotify int r_nMissionTimerStateChange;
var float r_fMissionTime;
var float c_fMissionTime;
var float c_fMissionTimeSeconds;
var float c_fAIBotDelaySeconds;
var float r_fRoundLimitElapsed;
var float r_fRoundLimitDuration;
var float r_fSecondaryRemainingTime;
var repnotify int r_nSecondaryTimerStateChange;
var float r_fSecondaryTime;
var float c_fSecondaryMissionTime;
var float c_fSecondaryMissionTimeSeconds;
var float r_fCapturePointOvertimeStartDuration;
var repnotify int r_nCapturePointOvertimeStateChange;
var float r_fPayloadOvertimeStartDuration;
var repnotify int r_nPayloadOvertimeStateChange;
var float r_fTF1PayloadPushDistance;
var int r_nPurchaseTime;
var float m_fPurchaseTimer;
var repnotify TgRepInfo_TaskForce r_AttackingTaskForce;
var repnotify TgRepInfo_TaskForce r_CapturingTaskForce;
var int r_nChaosRemainingAttackDefendTime;
var int r_nCapturePoints[5];
var TgRepInfo_TaskForce r_Winner;
var float r_fPhysicsThreshold;
var string r_sQueueName;
var int r_nPlayOfTheGamePawnId;
var int r_nPlayOfTheGameMapLane;
var float r_fPlayOfTheGameTimeStamp;
var TgPlayOfTheGameCamera c_PlayOfTheGameCamera;
var init transient array<init TgDeployable> m_Deployables;
var init transient array<init TgProjectile> m_Projectiles;
var init transient array<init TgDestructible> m_Destructibles;
var init transient array<init TgRepInfo_Deployable> m_DRIArray;
var init transient array<init TgRepInfo_CapturePoint> m_CPRIArray;
var init transient array<init TgChaosCapturePoint> m_CapturePoints;
var init transient array<init TgDeployable> m_MovableProjBlockers;
var repnotify transient int r_nCurrentCheckpoint[2];
var transient int c_nNextClientOnlyProjectileInstanceId;
var TgPawn_LanePusher r_LanePusher;
var TgPawn_LanePusherBase r_LanePusher1;
var TgPawn_LanePusherBase r_LanePusher2;
var TgPawn r_SquadTarget1;
var TgPawn r_SquadTarget2;
var float r_fLastSquadTargetUpdate1;
var float r_fLastSquadTargetUpdate2;
var float r_fSpeedScale;
var float r_fPayloadProgressPercent;
var float r_fCheckpoint1Percent;
var float r_fCheckpoint2Percent;
var float r_fServerFlagDamageMultiplier;
var float r_fServerFlagGroundSpeedModifier;
var float r_fServerFlagAutoHealingMultiplier;
var TgPawn_SiegeWall r_pSiegeWallTF1[3];
var TgPawn_SiegeWall r_pSiegeWallTF2[3];
var float m_fSavedFogDensity;
var float m_fSavedFogStartDistance;
var Color m_SavedFogColor;
var int r_nRemainingObjectiveTime;
var int r_nTotalObjectiveTime;
var float r_fPlayerViewDistance;
var float r_fVisibilityVolumeViewDistance;
var float r_fPushTimer;
var float r_fWeaponMaxLagCompensation;
var float m_fVaultImmuneToSiegeEngineHealth;
var float r_fConvergeDistance;
var float r_fConvergeStartDistance;
var float r_fFogConvergeInterval;
var repnotify int r_nTaskForcePushSuccessful;
var repnotify int r_nTaskForceDefenseSuccessful;
var int r_nMapLane;
var float r_fGlobalFrictionFalling;
var float r_fGlobalFrictionFlying;
var BotDifficultyDebugData r_DifficultyDebugData;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_AttackingTaskForce, r_CapturingTaskForce, 
        r_DifficultyDebugData, r_FlagState, 
        r_GameEnvironmentRule, r_GameMode, 
        r_GameRespawnRule, r_LanePusher, 
        r_LanePusher1, r_LanePusher2, 
        r_Winner, r_bAllowPlayerMounting, 
        r_bAllowWeaponLagPrediction, r_bAttackersKillCamEnabled, 
        r_bAttackersSpawnGatesOpen, r_bAutoMelee, 
        r_bBlockCreditGain, r_bBlockKillCam, 
        r_bCheckpoint1Reached, r_bCheckpoint2Reached, 
        r_bDefendersKillCamEnabled, r_bDefendersSpawnGatesOpen, 
        r_bDisableProjectileProximityDistance, r_bEnableDistanceFOW, 
        r_bEnableHeadshots, r_bFadeOutAtRoundEnd, 
        r_bFogConverging, r_bFogEnded, 
        r_bForce1P, r_bForce3P, 
        r_bForceOutOfCombatSprint, r_bForwardProgress, 
        r_bIntroPlayed, r_bIsFirstRound, 
        r_bKillCamEnabled, r_bRoundEnding, 
        r_bServerFlagMinimapTeamVisibility, r_bServerFlagSprint, 
        r_bShowHeadMesh, r_bShowProjectileProximityDistance, 
        r_bSiegeEngineMovementPaused, r_bSiegeEngineMovementPausedAfterDamagingGate, 
        r_bSiegeEngineRequiresAlliesToMove, r_bSpawnGatesOpen, 
        r_bSpawnGatesOpenedAtLeastOnce, r_bUltimatesLocked, 
        r_bUseInstantFireMeshTrace, r_bUsePointsMode, 
        r_eGameTimerState, r_eTalentsEnabled, 
        r_fCheckpoint1Percent, r_fCheckpoint2Percent, 
        r_fConvergeDistance, r_fConvergeStartDistance, 
        r_fFogConvergeInterval, r_fMissionRemainingTime, 
        r_fMissionTime, r_fPayloadProgressPercent, 
        r_fPlayerViewDistance, r_fRoundLimitDuration, 
        r_fRoundLimitElapsed, r_fSecondaryRemainingTime, 
        r_fSecondaryTime, r_fSpeedScale, 
        r_fTF1PayloadPushDistance, r_fWeaponMaxLagCompensation, 
        r_nChaosRemainingAttackDefendTime, r_nCurrentCheckpoint, 
        r_nLastRoundAttacker, r_nLastRoundWinner, 
        r_nMapLane, r_nMissionTimerState, 
        r_nMissionTimerStateChange, r_nPurchaseTime, 
        r_nRemainingObjectiveTime, r_nRoundLimitTimerState, 
        r_nSecondaryTimerState, r_nSecondaryTimerStateChange, 
        r_nTaskForceDefenseSuccessful, r_nTaskForcePushSuccessful, 
        r_nTotalObjectiveTime, r_pSiegeWallTF1, 
        r_pSiegeWallTF2;

    // Pos:0x011
    if(int(Role) == int(ROLE_Authority))
        r_GameType, r_bIsMission, 
        r_fPhysicsThreshold, r_sQueueName;

    // Pos:0x022
    if((((int(Role) == int(ROLE_Authority)) && !bNetTimelapse) && !bNetTimelapseInit) && !bNetTimelapsePost)
        r_fPlayOfTheGameTimeStamp, r_nPlayOfTheGameMapLane, 
        r_nPlayOfTheGamePawnId;

    // Pos:0x066
    if((int(Role) == int(ROLE_Authority)) && (bNetDirty || bNetTimelapseInit) || bNetTimelapsePost)
        r_bCapturePointOvertime, r_bOvertime, 
        r_fCapturePointOvertimeStartDuration, r_fPayloadOvertimeStartDuration, 
        r_nCapturePointOvertimeStateChange, r_nPayloadOvertimeStateChange;

    // Pos:0x0A4
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_bGhostMountingEnabled, r_fGlobalFrictionFalling, 
        r_fGlobalFrictionFlying;
}

// Export UTgRepInfo_Game::execGetDeployableCount(FFrame&, void* const)
native function int GetDeployableCount();

// Export UTgRepInfo_Game::execGetDeployable(FFrame&, void* const)
native function TgDeployable GetDeployable(int nIndex);

// Export UTgRepInfo_Game::execGetProjectile(FFrame&, void* const)
native function TgProjectile GetProjectile(int nIndex);

// Export UTgRepInfo_Game::execGetTaskForceFor(FFrame&, void* const)
native function TgRepInfo_TaskForce GetTaskForceFor(const Actor Actor);

// Export UTgRepInfo_Game::execGetTaskForce(FFrame&, void* const)
native function TgRepInfo_TaskForce GetTaskForce(int nTaskForceNum, optional bool bCreate = false);

// Export UTgRepInfo_Game::execCreateTaskForce(FFrame&, void* const)
native function TgRepInfo_TaskForce CreateTaskForce(int nTaskForceNum);

// Export UTgRepInfo_Game::execTaskForceEnumerate(FFrame&, void* const)
native function bool TaskForceEnumerate(out TgRepInfo_TaskForce rpTaskForce, out int rnTaskForceNum, optional bool bPlayerOnly = true);

// Export UTgRepInfo_Game::execGetNumNearbyPlayers(FFrame&, void* const)
native function int GetNumNearbyPlayers(int nTaskForceNum, Vector vLocation, float fDist);

// Export UTgRepInfo_Game::execGetOpposingTeamsPawns(FFrame&, void* const)
native function GetOpposingTeamsPawns(const TgPawn instigatingPawn, out array<TgPawn_Character> enemyPawns);

// Export UTgRepInfo_Game::execGetAttackingTaskForce(FFrame&, void* const)
native final function TgRepInfo_TaskForce GetAttackingTaskForce();

// Export UTgRepInfo_Game::execGetDefendingTaskForce(FFrame&, void* const)
native final function TgRepInfo_TaskForce GetDefendingTaskForce();

// Export UTgRepInfo_Game::execCheckIsEnemy(FFrame&, void* const)
native simulated function bool CheckIsEnemy(const Actor A, const Actor B);

// Export UTgRepInfo_Game::execUpdateGameClockUI(FFrame&, void* const)
native function UpdateGameClockUI();

// Export UTgRepInfo_Game::execUpdateGameScoreUI(FFrame&, void* const)
native function UpdateGameScoreUI();

// Export UTgRepInfo_Game::execUpdateGameTransitionUI(FFrame&, void* const)
native function UpdateGameTransitionUI();

// Export UTgRepInfo_Game::execGameStateChanged(FFrame&, void* const)
native function GameStateChanged();

// Export UTgRepInfo_Game::execGameTypeSet(FFrame&, void* const)
native function GameTypeSet();

// Export UTgRepInfo_Game::execSpawnGatesOpenChanged(FFrame&, void* const)
native function SpawnGatesOpenChanged();

// Export UTgRepInfo_Game::execAttackersSpawnGatesOpenChanged(FFrame&, void* const)
native function AttackersSpawnGatesOpenChanged();

// Export UTgRepInfo_Game::execDefendersSpawnGatesOpenChanged(FFrame&, void* const)
native function DefendersSpawnGatesOpenChanged();

// Export UTgRepInfo_Game::execGetClientSpawnedProjectile(FFrame&, void* const)
native final function TgProj_Simulated GetClientSpawnedProjectile(int ClientFireRequestId);

// Export UTgRepInfo_Game::execGetSimulatedProjectile(FFrame&, void* const)
native final function TgProj_Simulated GetSimulatedProjectile(int nProjectileId);

// Export UTgRepInfo_Game::execSpawnSimulatedProjectile(FFrame&, void* const)
native function TgProj_Simulated SpawnSimulatedProjectile(int nProjectileInstanceId, int nFireModeId, Actor pOwner, Vector vLocation, Vector vRotation, optional int nProjectileIdOverride = 0, optional bool bPredictStartLocationBasedOnPing = false);

// Export UTgRepInfo_Game::execGetLane(FFrame&, void* const)
native function TgRepInfo_Game.MAP_LANE GetLane(int nLane, TgRepInfo_TaskForce tfri);

// Export UTgRepInfo_Game::execSiegeEngineRequiresAlliesToMove(FFrame&, void* const)
native function bool SiegeEngineRequiresAlliesToMove();

// Export UTgRepInfo_Game::execRecalcRespawnTimers(FFrame&, void* const)
native final function RecalcRespawnTimers();

// Export UTgRepInfo_Game::execAllowHeadShots(FFrame&, void* const)
native final function bool AllowHeadShots();

// Export UTgRepInfo_Game::execGetActiveCapturePoint(FFrame&, void* const)
native function TgChaosCapturePoint GetActiveCapturePoint();

simulated event ReplicatedEvent(name VarName)
{
    local TgPlayerController TgPC;
    local TgInventoryManager tginv;

    // End:0x26
    if(VarName == 'r_nMissionTimerStateChange')
    {
        InitMissionTime();
        return;        
    }
    else
    {
        // End:0x4C
        if(VarName == 'r_nSecondaryTimerStateChange')
        {
            InitSecondaryMissionTime();
            return;            
        }
        else
        {
            // End:0x1AB
            if(VarName == 'r_bIntroPlayed')
            {
                UpdateGameTransitionUI();
                // End:0x1A6
                if((int(WorldInfo.NetMode) == int(NM_Client)) && r_bIntroPlayed)
                {
                    TgPC = TgPlayerController(GetALocalPlayerController());
                    // End:0x1A6
                    if(((TgPC != none) && TgPC.Pawn != none) && TgPC.Pawn.InvManager != none)
                    {
                        tginv = TgInventoryManager(TgPC.Pawn.InvManager);
                        // End:0x1A6
                        if(tginv != none)
                        {
                            tginv.ServerSetInventoryDirty();
                        }
                    }
                }
                return;                
            }
            else
            {
                // End:0x1D1
                if(VarName == 'r_eGameTimerState')
                {
                    GameStateChanged();
                    return;                    
                }
                else
                {
                    // End:0x1F7
                    if(VarName == 'r_GameType')
                    {
                        GameTypeSet();
                        return;                        
                    }
                    else
                    {
                        // End:0x226
                        if(VarName == 'r_AttackingTaskForce')
                        {
                            UpdateAttackingTaskforce(r_AttackingTaskForce);
                            return;                            
                        }
                        else
                        {
                            // End:0x24A
                            if(VarName == 'r_GameEnvironmentRule')
                            {
                                GameEnvironmentRuleUpdated();                                
                            }
                            else
                            {
                                // End:0x26E
                                if(VarName == 'r_bSpawnGatesOpen')
                                {
                                    SpawnGatesOpenChanged();                                    
                                }
                                else
                                {
                                    // End:0x292
                                    if(VarName == 'r_bAttackersSpawnGatesOpen')
                                    {
                                        AttackersSpawnGatesOpenChanged();                                        
                                    }
                                    else
                                    {
                                        // End:0x2B6
                                        if(VarName == 'r_bDefendersSpawnGatesOpen')
                                        {
                                            DefendersSpawnGatesOpenChanged();                                            
                                        }
                                        else
                                        {
                                            // End:0x31C
                                            if(VarName == 'r_nTaskForcePushSuccessful')
                                            {
                                                // End:0x2F4
                                                if(r_nTaskForcePushSuccessful == 1)
                                                {
                                                    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadSuccessfulPushTF1', self);                                                    
                                                }
                                                else
                                                {
                                                    // End:0x319
                                                    if(r_nTaskForcePushSuccessful == 2)
                                                    {
                                                        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadSuccessfulPushTF2', self);
                                                    }
                                                }                                                
                                            }
                                            else
                                            {
                                                // End:0x382
                                                if(VarName == 'r_nTaskForceDefenseSuccessful')
                                                {
                                                    // End:0x35A
                                                    if(r_nTaskForceDefenseSuccessful == 1)
                                                    {
                                                        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadSuccessfulDefenseTF1', self);                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x37F
                                                        if(r_nTaskForceDefenseSuccessful == 2)
                                                        {
                                                            TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadSuccessfulDefenseTF2', self);
                                                        }
                                                    }                                                    
                                                }
                                                else
                                                {
                                                    // End:0x3C0
                                                    if(VarName == 'r_bShowHeadMesh')
                                                    {
                                                        // End:0x3B3
                                                        if(r_bShowHeadMesh)
                                                        {
                                                            ShowHeadMesh();                                                            
                                                        }
                                                        else
                                                        {
                                                            HideHeadMesh();
                                                        }                                                        
                                                    }
                                                    else
                                                    {
                                                        // End:0x3FD
                                                        if(VarName == 'r_bOvertime')
                                                        {
                                                            // End:0x3FD
                                                            if(r_bOvertime)
                                                            {
                                                                self.AddPotGEventToAllPlayers(3);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function ShowHeadMesh()
{
    local TgPawn_Character TgPC;

    // End:0x56
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', TgPC)
    {
        TgPC.ShowHeadMesh();        
    }    
    //return;    
}

simulated function HideHeadMesh()
{
    local TgPawn_Character TgPC;

    // End:0x56
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', TgPC)
    {
        TgPC.HideHeadMesh();        
    }    
    //return;    
}

simulated function SetGameEnvironmentRule(TgObject.EGameEnvironmentRule Rule)
{
    r_GameEnvironmentRule = Rule;
    GameEnvironmentRuleUpdated();
    //return;    
}

simulated function SetGameRespawnRule(TgObject.EGameRespawnRule Rule)
{
    local bool bRecalcRespawnTimers;

    bRecalcRespawnTimers = (int(Role) == int(ROLE_Authority)) && int(r_GameRespawnRule) != int(Rule);
    r_GameRespawnRule = Rule;
    // End:0x63
    if(bRecalcRespawnTimers)
    {
        RecalcRespawnTimers();
    }
    //return;    
}

simulated function SetGameMode(TgObject.EGameMode Mode)
{
    r_GameMode = Mode;
    //return;    
}

simulated function OnFogAdded(ExponentialHeightFog Fog)
{
    UpdateFog(Fog);
    //return;    
}

simulated function GameEnvironmentRuleUpdated()
{
    UpdateFog();
    //return;    
}

simulated function UpdateFog(optional ExponentialHeightFog Fog)
{
    local ExponentialHeightFog HeightFog;

    // End:0x2C
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    // End:0x6C
    if(Fog == none)
    {
        // End:0x6B
        foreach DynamicActors(Class'Engine.ExponentialHeightFog', HeightFog)
        {
            Fog = HeightFog;
            // End:0x6B
            break;            
        }        
    }
    // End:0x478
    if((Fog != none) && Fog.Component != none)
    {
        // End:0x33E
        if(int(r_GameEnvironmentRule) == int(2))
        {
            m_fFogSettingsSaved = true;
            m_fSavedFogDensity = Fog.Component.FogDensity;
            m_fSavedFogStartDistance = Fog.Component.StartDistance;
            m_SavedFogColor = Fog.Component.OppositeLightColor;
            Fog.Component.FogDensity = 1.0000000;
            Fog.Component.StartDistance = 1500.0000000;
            Fog.Component.OppositeLightColor.R *= 0.4000000;
            Fog.Component.OppositeLightColor.G *= 0.4000000;
            Fog.Component.OppositeLightColor.B *= 0.4000000;
            Fog.Component.SetEnabled(false);
            Fog.Component.SetEnabled(true);            
        }
        else
        {
            // End:0x478
            if(m_fFogSettingsSaved)
            {
                m_fFogSettingsSaved = false;
                Fog.Component.FogDensity = m_fSavedFogDensity;
                Fog.Component.StartDistance = m_fSavedFogStartDistance;
                Fog.Component.OppositeLightColor = m_SavedFogColor;
                Fog.Component.SetEnabled(false);
                Fog.Component.SetEnabled(true);
            }
        }
    }
    //return;    
}

simulated function UpdateAttackingTaskforce(TgRepInfo_TaskForce NewAttackingTaskForce)
{
    // End:0x27
    if(int(Role) == int(ROLE_Authority))
    {
        r_AttackingTaskForce = NewAttackingTaskForce;
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local TgChaosCapturePoint pPoint;
    local TgRepInfo_CapturePoint CPRI;
    local TgDestructible destructible;
    local TgRepInfo_Deployable DRI;
    local TgPlayerController TgPC;
    local TgPlayOfTheGameCamera PotGCamera;

    super.PostBeginPlay();
    // End:0x37
    foreach DynamicActors(Class'TgGame.TgRepInfo_CapturePoint', CPRI)
    {
        AddCPRI(CPRI);        
    }    
    // End:0x65
    foreach DynamicActors(Class'TgGame.TgChaosCapturePoint', pPoint)
    {
        AddCapturePoint(pPoint);        
    }    
    // End:0x93
    foreach DynamicActors(Class'TgGame.TgDestructible', destructible)
    {
        AddDestructible(destructible);        
    }    
    // End:0xC1
    foreach DynamicActors(Class'TgGame.TgRepInfo_Deployable', DRI)
    {
        AddDRI(DRI);        
    }    
    // End:0xEF
    foreach DynamicActors(Class'TgGame.TgPlayOfTheGameCamera', PotGCamera)
    {
        c_PlayOfTheGameCamera = PotGCamera;        
    }    
    // End:0x14F
    if(int(Role) != int(ROLE_Authority))
    {
        TgPC = TgPlayerController(GetALocalPlayerController());
        // End:0x14F
        if(TgPC != none)
        {
            TgPC.ServerRequestGraphData();
        }
    }
    UpdateFog();
    SetRTPCValue('IsPosition3D', 0.0000000);
    //return;    
}

simulated function InitMissionTime()
{
    c_fMissionTime = r_fMissionRemainingTime;
    c_fMissionTimeSeconds = WorldInfo.TimeSeconds;
    // End:0x7B
    if((int(r_nMissionTimerState) == int(1)) || int(r_nSecondaryTimerState) == int(1))
    {
        SetTimer(0.5000000, false, 'UpdateMissionTimer');        
    }
    else
    {
        UpdateMissionTimer();
        ClearTimer('UpdateMissionTimer');
    }
    //return;    
}

simulated function InitSecondaryMissionTime()
{
    c_fSecondaryMissionTime = r_fSecondaryRemainingTime;
    c_fSecondaryMissionTimeSeconds = WorldInfo.TimeSeconds;
    // End:0x7B
    if((int(r_nMissionTimerState) == int(1)) || int(r_nSecondaryTimerState) == int(1))
    {
        SetTimer(0.5000000, false, 'UpdateMissionTimer');        
    }
    else
    {
        UpdateMissionTimer(true);
        ClearTimer('UpdateMissionTimer');
    }
    //return;    
}

simulated function UpdateMissionTimer(optional bool bForcePrimary, optional bool bForceSecondary)
{
    local float fTimeRemaining;

    // End:0x9A
    if((int(r_nMissionTimerState) == int(1)) || bForcePrimary)
    {
        fTimeRemaining = r_fMissionRemainingTime - (WorldInfo.TimeSeconds - c_fMissionTimeSeconds);
        c_fMissionTime = ((fTimeRemaining > 0.0000000) ? fTimeRemaining : 0.0000000);
        UpdateGameClockUI();
    }
    // End:0x128
    if((int(r_nSecondaryTimerState) == int(1)) || bForceSecondary)
    {
        fTimeRemaining = r_fSecondaryRemainingTime - (WorldInfo.TimeSeconds - c_fSecondaryMissionTimeSeconds);
        c_fSecondaryMissionTime = ((fTimeRemaining > 0.0000000) ? fTimeRemaining : 0.0000000);
    }
    //return;    
}

function MissionTimeUpdateAllClients()
{
    TgGame_Mission(WorldInfo.Game).SendMissionTimerNotify(r_nMissionTimerState, TgGame_Mission(WorldInfo.Game).MissionTimeRemaining());
    //return;    
}

simulated function AddDRI(TgRepInfo_Deployable DRI)
{
    // End:0xAA
    if(m_DRIArray.Find(DRI) < 0)
    {
        m_DRIArray[m_DRIArray.Length] = DRI;
        // End:0xAA
        if(int(Role) == int(ROLE_Authority))
        {
            DRI.r_nUniqueDeployableId = TgGame(WorldInfo.Game).GetNextActorInstanceId();
        }
    }
    //return;    
}

simulated function RemoveDRI(TgRepInfo_Deployable DRI)
{
    m_DRIArray.RemoveItem(DRI);
    //return;    
}

simulated function AddCPRI(TgRepInfo_CapturePoint CPRI)
{
    // End:0xCB
    if(m_CPRIArray.Find(CPRI) < 0)
    {
        m_CPRIArray[m_CPRIArray.Length] = CPRI;
        // End:0xCB
        if(int(Role) == int(ROLE_Authority))
        {
            CPRI.r_nUniqueCapturePointId = TgGame(WorldInfo.Game).GetNextActorInstanceId();
            CPRI.bNetDirty = true;
        }
    }
    //return;    
}

simulated function RemoveCPRI(TgRepInfo_CapturePoint CPRI)
{
    m_CPRIArray.RemoveItem(CPRI);
    //return;    
}

simulated function AddCapturePoint(TgChaosCapturePoint pPoint)
{
    // End:0xCB
    if(m_CapturePoints.Find(pPoint) < 0)
    {
        m_CapturePoints[m_CapturePoints.Length] = pPoint;
        // End:0xCB
        if(int(Role) == int(ROLE_Authority))
        {
            pPoint.r_nUniqueCapturePointId = TgGame(WorldInfo.Game).GetNextActorInstanceId();
            pPoint.bNetDirty = true;
        }
    }
    //return;    
}

simulated function RemoveCapturePoint(TgChaosCapturePoint pPoint)
{
    m_CapturePoints.RemoveItem(pPoint);
    //return;    
}

simulated function AddDestructible(TgDestructible Dest)
{
    // End:0xC3
    if(m_Destructibles.Find(Dest) < 0)
    {
        m_Destructibles.AddItem(Dest);
        // End:0xC3
        if(int(Role) == int(ROLE_Authority))
        {
            Dest.r_nActorInstanceId = TgGame(WorldInfo.Game).GetNextActorInstanceId();
            Dest.bNetDirty = true;
        }
    }
    //return;    
}

simulated function RemoveDestructible(TgDestructible Dest)
{
    m_Destructibles.RemoveItem(Dest);
    //return;    
}

simulated event int GetNextClientOnlyProjectileInstanceId()
{
    // End:0x2B
    if(--c_nNextClientOnlyProjectileInstanceId < (-1 * (1 << 23)))
    {
        c_nNextClientOnlyProjectileInstanceId = -1;
    }
    return c_nNextClientOnlyProjectileInstanceId;
    //return ReturnValue;    
}

function SetFlagHome(int TeamIndex)
{
    r_FlagState[TeamIndex - 1] = 0;
    bForceNetUpdate = true;
    //return;    
}

simulated function bool FlagIsHome(int TeamIndex)
{
    return int(r_FlagState[TeamIndex - 1]) == int(0);
    //return ReturnValue;    
}

simulated function bool FlagsAreHome()
{
    return (int(r_FlagState[0]) == int(0)) && int(r_FlagState[1]) == int(0);
    //return ReturnValue;    
}

function SetFlagHeldFriendly(int TeamIndex)
{
    r_FlagState[TeamIndex - 1] = 1;
    //return;    
}

simulated function bool FlagIsHeldFriendly(int TeamIndex)
{
    return int(r_FlagState[TeamIndex - 1]) == int(1);
    //return ReturnValue;    
}

function SetFlagHeldEnemy(int TeamIndex)
{
    // End:0x2C
    if((TeamIndex - 1) < 2)
    {
        r_FlagState[TeamIndex - 1] = 2;
    }
    //return;    
}

simulated function bool FlagIsHeldEnemy(int TeamIndex)
{
    return int(r_FlagState[TeamIndex - 1]) == int(2);
    //return ReturnValue;    
}

function SetFlagDown(int TeamIndex)
{
    // End:0x2C
    if((TeamIndex - 1) < 2)
    {
        r_FlagState[TeamIndex - 1] = 3;
    }
    //return;    
}

simulated function bool FlagIsDown(int TeamIndex)
{
    return int(r_FlagState[TeamIndex - 1]) == int(3);
    //return ReturnValue;    
}

event SetCheckpoint(int NewCheckpoint, int Taskforce)
{
    local TgGame_Siege SiegeGame;

    r_nCurrentCheckpoint[Taskforce - 1] = NewCheckpoint;
    SiegeGame = TgGame_Siege(WorldInfo.Game);
    // End:0x91
    if(SiegeGame != none)
    {
        SiegeGame.ReachedCheckpoint(Taskforce, NewCheckpoint);
    }
    //return;    
}

function SetUsePointsMode(bool bValue, int nValue)
{
    local int I;
    local TgRepInfo_TaskForce pTRI;

    r_bUsePointsMode = bValue;
    I = 0;
    J0x20:

    // End:0xB4 [Loop If]
    if(I < 3)
    {
        pTRI = GetTaskForce(I);
        // End:0xA6
        if(pTRI != none)
        {
            pTRI.r_nScore = nValue;
            pTRI.bNetDirty = true;
        }
        I++;
        // [Loop Continue]
        goto J0x20;
    }
    bNetDirty = true;
    //return;    
}

function DecrementPoints(int nTaskForce, int nValue)
{
    local TgRepInfo_TaskForce pTRI;

    pTRI = GetTaskForce(nTaskForce);
    // End:0x77
    if(pTRI != none)
    {
        pTRI.r_nScore -= nValue;
        pTRI.bNetDirty = true;
    }
    //return;    
}

simulated event float GetMissionTime()
{
    local TgGame_Mission Game;

    // End:0xE6
    if(int(Role) == int(ROLE_Authority))
    {
        Game = TgGame_Mission(WorldInfo.Game);
        // End:0xDD
        if(Game != none)
        {
            // End:0xBD
            if(int(Game.m_eTimerState) > int(2))
            {
                return Game.m_fMissionTime - Game.MissionTimeRemaining();
            }
            return Game.MissionTimeRemaining();
        }
        return 0.0000000;        
    }
    else
    {
        // End:0x10F
        if(int(r_eGameTimerState) > int(2))
        {
            return r_fMissionTime - c_fMissionTime;
        }
        return c_fMissionTime;
    }
    //return ReturnValue;    
}

function SendPayloadMissionEvent(int nEventId, TgRepInfo_TaskForce attackingTaskForce, TgRepInfo_TaskForce WinningTaskForce)
{
    local TgPlayerController TgPC;
    local byte nAttacking, nWinning;

    nAttacking = ((attackingTaskForce != none) ? attackingTaskForce.r_nTaskForce : 255);
    nWinning = ((WinningTaskForce != none) ? WinningTaskForce.r_nTaskForce : 255);
    // End:0x125
    if((int(Role) == int(ROLE_Authority)) && int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        // End:0x124
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientSendPayloadMissionEvent(nEventId, nAttacking, nWinning);            
        }        
    }
    ProcessMissionTimerEvent(nEventId, nAttacking, nWinning);
    //return;    
}

simulated function ProcessMissionTimerEvent(int nEventId, byte nAttackingTaskForce, byte nWinningTaskForce)
{
    local int I;
    local Sequence GameSeq;
    local array<SequenceObject> AllSeqEvents;
    local array<int> ActivateIndices;

    GameSeq = WorldInfo.GetGameSequence();
    // End:0x165
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_PayloadMissionEvents', true, AllSeqEvents);
        ActivateIndices[0] = nEventId;
        I = 0;
        J0x8A:

        // End:0x165 [Loop If]
        if(I < AllSeqEvents.Length)
        {
            TgSeqEvent_PayloadMissionEvents(AllSeqEvents[I]).UpdateTaskForceAttackValue(nAttackingTaskForce);
            TgSeqEvent_PayloadMissionEvents(AllSeqEvents[I]).UpdateTaskForceWonValue(nWinningTaskForce);
            TgSeqEvent_PayloadMissionEvents(AllSeqEvents[I]).CheckActivate(self, self, false, ActivateIndices);
            I++;
            // [Loop Continue]
            goto J0x8A;
        }
    }
    //return;    
}

function SetEnableHeadshots(bool bEnable)
{
    r_bEnableHeadshots = bEnable;
    //return;    
}

event AddPotGEventToAllPlayers(TgObject.EPlayOfTheGameEventType potgEvent)
{
    local int I;
    local TgRepInfo_Player PRI;

    I = 0;
    J0x0B:

    // End:0x8F [Loop If]
    if(I < PRIArray.Length)
    {
        PRI = TgRepInfo_Player(PRIArray[I]);
        // End:0x81
        if(PRI != none)
        {
            PRI.AddPlayOfTheGameEvent(potgEvent);
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

// Export UTgRepInfo_Game::execAllowPlayerMounting(FFrame&, void* const)
native function bool AllowPlayerMounting();

defaultproperties
{
    r_bIsMission=true
    r_bEnableDistanceFOW=true
    r_bServerFlagSprint=true
    r_bServerFlagMinimapTeamVisibility=true
    r_bAutoMelee=true
    r_bShowHeadMesh=true
    r_bAllowWeaponLagPrediction=true
    r_bKillCamEnabled=true
    c_fAIBotDelaySeconds=30.0000000
    r_nPurchaseTime=120
    m_fPurchaseTimer=120.0000000
    r_nPlayOfTheGameMapLane=-1
    c_nNextClientOnlyProjectileInstanceId=-1
    r_fSpeedScale=1.0000000
    r_fServerFlagDamageMultiplier=1.0000000
    r_fServerFlagGroundSpeedModifier=1.0000000
    r_fServerFlagAutoHealingMultiplier=1.0000000
    r_fWeaponMaxLagCompensation=0.3000000
    m_fVaultImmuneToSiegeEngineHealth=1.0000000
    r_fFogConvergeInterval=1.0000000
    r_DifficultyDebugData=(CurrentlyActive=true,DisparityDetected=false,ChangesLockedOut=false,TimeBeforeTrigger=0,TaskForce1BotDifficulty=EBotDifficultyLevel.AIDifficulty_Medium1,TaskForce2BotDifficulty=EBotDifficultyLevel.AIDifficulty_Medium1,TaskForce1Skill=0.0000000,TaskForce2Skill=0.0000000,SkillPercentages=(NumDeathsPercentage=0.0000000,DamagePercentage=0.0000000,KillsPercentage=0.0000000,SoloKillsPercentage=0.0000000,AssistsPercentage=0.0000000,HealingPercentage=0.0000000,CreditsPercentage=0.0000000,ObjectiveTimePercentage=0.0000000,ShieldingPercentage=0.0000000,KillstreakMultiplier=0.0000000),SkillPercentages[1]=(NumDeathsPercentage=0.0000000,DamagePercentage=0.0000000,KillsPercentage=0.0000000,SoloKillsPercentage=0.0000000,AssistsPercentage=0.0000000,HealingPercentage=0.0000000,CreditsPercentage=0.0000000,ObjectiveTimePercentage=0.0000000,ShieldingPercentage=0.0000000,KillstreakMultiplier=0.0000000))
    bReplicateMovement=false
}