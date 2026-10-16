class TgGame_Paladins_Siege extends TgGame_PaladinsExtended
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var config transient int m_nPointsForCapturing;
var config transient int m_nPointsForPayload;
var config transient int m_nPointsForDefending;
var config transient int m_nPointsForPayloadCheckpoint;
var config int m_nCreditsForWinningARound;
var config int m_nCreditsForCapturingPoint;
var config int m_nCreditsForSuccessfulDefend;
var config int m_nCreditsForSuccessfulPush;
var config bool m_bRespawnDeadPlayersAfterRound;
var config bool m_bRespawnLivePlayersAfterRound;
var config bool m_bRoundTreatment;
var config bool m_bCanWinOnDefense;
var bool m_bInCapturePointOvertime;
var bool m_bInPayloadOvertime;
var bool m_bDestroyPayloadCartAfterPayloadPhase;
var config bool m_bDoNotSwitchPoints;
var transient bool m_bHasHitCheckpoint;
var config bool m_bFadeOutAtRoundEnd;
var config float m_fLosingCaptureRateModifier;
var config float m_fDurationUntilCaptureOvertime;
var config float m_fCaptureOvertimeWarningDuration;
var const config float m_fPayloadDuration;
var const config float m_fPayloadOvertimeDuration;
var const config float m_fPayloadDurationCheckpoint;
var const config float m_fRoundEndRespawnDelay;
var int s_nCurrentRound;

// Export UTgGame_Paladins_Siege::execTrackPushAttempt(FFrame&, void* const)
native function TrackPushAttempt(TgRepInfo_TaskForce Taskforce);

// Export UTgGame_Paladins_Siege::execTrackPushSuccess(FFrame&, void* const)
native function TrackPushSuccess(TgRepInfo_TaskForce Taskforce);

// Export UTgGame_Paladins_Siege::execTrackMapLane(FFrame&, void* const)
native function TrackMapLane(int laneID);

// Export UTgGame_Paladins_Siege::execTickOvertime(FFrame&, void* const)
native function TickOvertime(float DeltaSeconds);

function PostBeginPlay()
{
    local TgRepInfo_Game GRI;

    super.PostBeginPlay();
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x80
    if(GRI != none)
    {
        GRI.r_bFadeOutAtRoundEnd = m_bFadeOutAtRoundEnd;
        GRI.bNetDirty = true;
    }
    //return;    
}

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    // End:0x5C
    if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
    {
        GameplayEventsWriter.LogGameIntEvent(1, nTaskForce);
    }
    // End:0x86
    if(int(VictoryType) == int(3))
    {
        TriggerPayloadVictory(nTaskForce);        
    }
    else
    {
        TriggerCapturePointVictory();
    }
    super.TaskforceWin(nTaskForce, VictoryType);
    //return;    
}

function SetOvertime(float fOvertime, float fOvertimeWarning)
{
    m_fDurationUntilCaptureOvertime = fOvertime;
    // End:0x4A
    if(fOvertimeWarning >= 0.0000000)
    {
        m_fCaptureOvertimeWarningDuration = float(Min(int(fOvertimeWarning), int(fOvertime)));
    }
    //return;    
}

function float GetPointCaptureScoreMultiplier(int nTaskForce)
{
    // End:0x62
    if(nTaskForce == 1)
    {
        // End:0x2F
        if(m_nTF1Score < m_nTF2Score)
        {
            return 1.0000000;            
        }
        else
        {
            return 1.0000000 + ((float(m_nTF1Score - m_nTF2Score) / 100.0000000) * m_fLosingCaptureRateModifier);
        }        
    }
    else
    {
        // End:0x82
        if(m_nTF2Score < m_nTF1Score)
        {
            return 1.0000000;            
        }
        else
        {
            return 1.0000000 + ((float(m_nTF2Score - m_nTF1Score) / 100.0000000) * m_fLosingCaptureRateModifier);
        }
    }
    //return ReturnValue;    
}

function RewardPointCapture(int nTaskForce)
{
    local Controller TheController;
    local TgPaladinsController TgPC;

    super.RewardPointCapture(nTaskForce);
    // End:0xD0
    if(m_nCreditsForCapturingPoint > 0)
    {
        // End:0xCF
        foreach WorldInfo.AllControllers(Class'Engine.Controller', TheController)
        {
            TgPC = TgPaladinsController(TheController);
            // End:0xCE
            if(TgPC.GetTaskForceNumber() == nTaskForce)
            {
                TgPC.SetRewardValues(m_nCreditsForCapturingPoint, 0, self, 10);
            }            
        }        
    }
    //return;    
}

function TgChaosCapturePoint GetCurrentCapturePoint()
{
    // End:0x28
    if(m_bDoNotSwitchPoints && m_LastActiveCapturePoint != none)
    {
        return m_LastActiveCapturePoint;
    }
    return super.GetCurrentCapturePoint();
    //return ReturnValue;    
}

function PickNextObjective()
{
    local float fDurationUntilCaptureOvertime;

    // End:0x2D
    if(!m_bDoNotSwitchPoints || m_LastActiveCapturePoint == none)
    {
        super.PickNextObjective();        
    }
    else
    {
        m_LastActiveCapturePoint.SetStatus(2);
        UpdateObjectiveStates();
        // End:0x75
        if(m_fObjectiveRepickTickets < 1.0000000)
        {
            EndBroadcastTimer();
        }
    }
    SendClientsRequestHelpText(132);
    fDurationUntilCaptureOvertime = m_fDurationUntilCaptureOvertime - m_fCaptureOvertimeWarningDuration;
    // End:0xC9
    if(fDurationUntilCaptureOvertime > 0.0000000)
    {
        SetTimer(fDurationUntilCaptureOvertime, false, 'FogOvertimeWarning');
    }
    //return;    
}

function EnableUltWhenObjectiveStateUpdated()
{
    //return;    
}

function EnableCreditSpoolingWhenObjectiveStateUpdated()
{
    //return;    
}

final function TgPawn_SiegeEngine_Payload GetSiegeEnginePush()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x53
    if(GRI != none)
    {
        return TgPawn_SiegeEngine_Payload(GRI.r_LanePusher);
    }
    return none;
    //return ReturnValue;    
}

event LanePusherReachedInnerWall(TgPawn_LanePusher LanePusher)
{
    local int nTaskForce;

    // End:0x89
    if((LanePusher != none) && !m_bHasHitCheckpoint)
    {
        m_bHasHitCheckpoint = true;
        nTaskForce = int(LanePusher.GetTaskForceNumber());
        GainPoints(nTaskForce, m_nPointsForPayloadCheckpoint, 3);
        SetPayloadTimer(m_fPayloadDurationCheckpoint, false);
    }
    //return;    
}

event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher)
{
    local int nTaskForce;
    local TgRepInfo_Game GRI;

    // End:0x18F
    if(LanePusher != none)
    {
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x62
        if(GRI != none)
        {
            TrackPushSuccess(GRI.r_AttackingTaskForce);
        }
        LanePusher.r_TargetActor = none;
        nTaskForce = int(LanePusher.GetTaskForceNumber());
        GainPoints(nTaskForce, m_nPointsForPayload, 3);
        GRI.r_nLastRoundWinner = byte(nTaskForce);
        OnRoundEnded();
        // End:0x14E
        if(int(Role) == int(ROLE_Authority))
        {
            TriggerSuccessfulPush(nTaskForce);
            GRI.r_nTaskForcePushSuccessful = nTaskForce;
        }
        GRI.bNetDirty = true;
        LanePusher.DestroyIt();
    }
    //return;    
}

function SetPayloadTimer(float fDuration, bool overtime)
{
    //return;    
}

function OnRoundEnded()
{
    local TgRepInfo_Game GRI;

    super.OnRoundEnded();
    // End:0x1CF
    if(int(Role) == int(ROLE_Authority))
    {
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0xF1
        if(GRI != none)
        {
            // End:0x6D
            if(GRI.r_AttackingTaskForce == none)
            {
            }
            GRI.r_nLastRoundAttacker = ((GRI.r_AttackingTaskForce != none) ? GRI.r_AttackingTaskForce.r_nTaskForce : 1);
            AwardTPOnRoundEnded();
        }
        AddPotGEventToAllPlayers(5);
        PointCapturePhaseCleanup();
        PayloadPhaseCleanup();
        // End:0x193
        if(m_bRoundTreatment)
        {
            // End:0x193
            if(GRI != none)
            {
                // End:0x193
                if(GRI.r_Winner == none)
                {
                    GRI.r_bRoundEnding = true;
                    GRI.bNetDirty = true;
                }
            }
        }
        SendClientRoundObjectivesCompleted();
        SetTimer(m_fRoundEndRespawnDelay, false, 'CaptureAndPayloadRoundEnded');
        // End:0x1CF
        if(m_bEndRoundWhenPointCaptured)
        {
            GotoState('RoundEnded');
        }
    }
    //return;    
}

function AwardTPOnRoundEnded()
{
    local TgPlayerController WinningPlayer;
    local TgAIController_BehaviorGod WinningAI;
    local TgRepInfo_Player PRI;
    local array<TgRepInfo_Player> WinningPRIs;
    local TgRepInfo_TaskForce WinningTF;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x58
    if((GRI == none) || int(GRI.r_nLastRoundWinner) == int(0))
    {
        return;
    }
    WinningTF = GRI.GetTaskForce(int(GRI.r_nLastRoundWinner));
    // End:0xB3
    if(WinningTF == none)
    {
        return;
    }
    WinningTF.GetPlayers(WinningPRIs);
    // End:0x384
    foreach WinningPRIs(PRI)
    {
        WinningPlayer = TgPlayerController(PRI.Owner);
        WinningAI = TgAIController_BehaviorGod(PRI.Owner);
        // End:0x1DE
        if(m_nCreditsForWinningARound > 0)
        {
            // End:0x1A2
            if(WinningPlayer != none)
            {
                WinningPlayer.SetRewardValues(m_nCreditsForWinningARound, 0, self, 16);                
            }
            else
            {
                // End:0x1DE
                if(WinningAI != none)
                {
                    WinningAI.SetRewardValues(m_nCreditsForWinningARound, 0, self, 16);
                }
            }
        }
        // End:0x2B2
        if((m_nCreditsForSuccessfulPush > 0) && int(GRI.r_nLastRoundAttacker) == int(WinningTF.r_nTaskForce))
        {
            // End:0x273
            if(WinningPlayer != none)
            {
                WinningPlayer.SetRewardValues(m_nCreditsForSuccessfulPush, 0, self, 18);                
            }
            else
            {
                // End:0x2AF
                if(WinningAI != none)
                {
                    WinningAI.SetRewardValues(m_nCreditsForSuccessfulPush, 0, self, 18);
                }
            }            
        }
        else
        {
            // End:0x383
            if((m_nCreditsForSuccessfulDefend > 0) && int(GRI.r_nLastRoundAttacker) != int(WinningTF.r_nTaskForce))
            {
                // End:0x347
                if(WinningPlayer != none)
                {
                    WinningPlayer.SetRewardValues(m_nCreditsForSuccessfulDefend, 0, self, 17);                    
                }
                else
                {
                    // End:0x383
                    if(WinningAI != none)
                    {
                        WinningAI.SetRewardValues(m_nCreditsForSuccessfulDefend, 0, self, 17);
                    }
                }
            }
        }        
    }    
    //return;    
}

function bool ShouldSelectNextCapturePointForLoading()
{
    // End:0x1A
    if(m_bDoNotSwitchPoints)
    {
        return m_LastActiveCapturePoint == none;
    }
    return true;
    //return ReturnValue;    
}

function CaptureAndPayloadRoundEnded()
{
    local TgRepInfo_Game GRI;

    // End:0x5D
    if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
    {
        GameplayEventsWriter.LogGameIntEvent(3, s_nCurrentRound);
    }
    s_nCurrentRound++;
    // End:0x161
    if(m_bRoundTreatment)
    {
        CloseSpawnGates();
        // End:0x161
        if(int(Role) == int(ROLE_Authority))
        {
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0x161
            if(GRI != none)
            {
                GRI.r_bUltimatesLocked = true;
                GRI.r_bRoundEnding = false;
                GRI.r_nTaskForcePushSuccessful = 0;
                GRI.r_nTaskForceDefenseSuccessful = 0;
                GRI.bNetDirty = true;
            }
        }
    }
    // End:0x19D
    if(m_bRespawnLivePlayersAfterRound || m_bRespawnDeadPlayersAfterRound)
    {
        RespawnAllPlayers(m_bRespawnLivePlayersAfterRound, m_bRespawnDeadPlayersAfterRound, true, true);
    }
    // End:0x200
    if((m_CapturePointQueue.Length > 0) && ShouldSelectNextCapturePointForLoading())
    {
        // End:0x200
        if(m_CapturePointQueue[s_nCurrentCapturePointQueueIndex] != none)
        {
            m_CapturePointQueue[s_nCurrentCapturePointQueueIndex].SetStatus(2);
        }
    }
    m_bCanSpoolCredits = false;
    SendClientRoundEnded();
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadRoundEnd', self);
    ResetScores();
    // End:0x24C
    if(m_bEndRoundWhenPointCaptured)
    {
        TransitionToNextRound();
    }
    //return;    
}

function OpenSpawnGates()
{
    // End:0x5D
    if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
    {
        GameplayEventsWriter.LogGameIntEvent(2, s_nCurrentRound);
    }
    super.OpenSpawnGates();
    SendClientsRequestHelpText(127);
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadRoundBegin', self);
    //return;    
}

function BroadcastTimer()
{
    local TgPlayerController TgPC;
    local float timeTotal, TimeRemaining;

    timeTotal = GetTimerRate('OpenSpawnGates');
    TimeRemaining = timeTotal - GetTimerCount('OpenSpawnGates');
    // End:0xC1
    if(IsTimerActive('PickNextObjective'))
    {
        // End:0xC0
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientUpdateRoundSetupTimer(TimeRemaining + float(1));            
        }        
    }
    CaptureSpawnAlert(TimeRemaining);
    //return;    
}

function PointCapturePhaseCleanup()
{
    ClearTimer('FogOvertimeWarning');
    ClearTimer('FogOvertime');
    ClearTimer('ResumeConvergeCompletely');
    ClearTimer('StartFogConverging');
    ClearTimer('ConvergeFog');
    ClearTimer('ResumeConvergeCompletely');
    // End:0x8F
    if(m_bInCapturePointOvertime)
    {
        FogOvertimeEnd();
    }
    //return;    
}

function PayloadPhaseCleanup()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce1, Taskforce2;

    ClearTimer('OvertimeExpired');
    ClearTimer('PayloadExpired');
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x414
    if(GRI != none)
    {
        Taskforce1 = GRI.GetTaskForce(1);
        // End:0xCF
        if(Taskforce1 != none)
        {
            Taskforce1.r_bIsAttacking = false;
            Taskforce1.bNetDirty = true;
        }
        Taskforce2 = GRI.GetTaskForce(2);
        // End:0x14C
        if(Taskforce2 != none)
        {
            Taskforce2.r_bIsAttacking = false;
            Taskforce2.bNetDirty = true;
        }
        // End:0x264
        if(m_bDestroyPayloadCartAfterPayloadPhase)
        {
            // End:0x1B1
            if(GRI.r_LanePusher != none)
            {
                GRI.r_LanePusher.Suicide();
            }
            // End:0x209
            if(GRI.r_LanePusher1 != none)
            {
                GRI.r_LanePusher1.Suicide();
            }
            // End:0x261
            if(GRI.r_LanePusher2 != none)
            {
                GRI.r_LanePusher2.Suicide();
            }            
        }
        else
        {
            // End:0x2F4
            if(GRI.r_LanePusher != none)
            {
                GRI.r_LanePusher.r_bAsleep = true;
                GRI.r_LanePusher.bNetDirty = true;
            }
            // End:0x384
            if(GRI.r_LanePusher1 != none)
            {
                GRI.r_LanePusher1.r_bAsleep = true;
                GRI.r_LanePusher1.bNetDirty = true;
            }
            // End:0x414
            if(GRI.r_LanePusher2 != none)
            {
                GRI.r_LanePusher2.r_bAsleep = true;
                GRI.r_LanePusher2.bNetDirty = true;
            }
        }
    }
    //return;    
}

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
{
    local PlayerStart Start;

    Start = FindPlayerStartForCapturePoint(GetCurrentCapturePoint(), Player, false);
    // End:0x46
    if(Start != none)
    {
        return Start;        
    }
    return super(TgGame).FindPlayerStart(Player, InTeam, IncomingName);
    //return ReturnValue;    
}

function TriggerSuccessfulDefense(int nTaskForce)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xD1
    if(GRI != none)
    {
        GRI.r_nTaskForceDefenseSuccessful = nTaskForce;
        // End:0xD1
        if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
        {
            GameplayEventsWriter.LogTeamIntEvent(51, GRI.GetTaskForce(nTaskForce), 1);
        }
    }
    //return;    
}

function TriggerSuccessfulPush(int nTaskForce)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xD1
    if(GRI != none)
    {
        GRI.r_nTaskForcePushSuccessful = nTaskForce;
        // End:0xD1
        if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
        {
            GameplayEventsWriter.LogTeamIntEvent(51, GRI.GetTaskForce(nTaskForce), 1);
        }
    }
    //return;    
}

simulated function TriggerCapturePointVictory()
{
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadCapturePointVictory', self);
    //return;    
}

simulated function TriggerPayloadVictory(int nTaskForce)
{
    // End:0x27
    if(nTaskForce == 1)
    {
        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadWinTF1', self);        
    }
    else
    {
        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadWinTF2', self);
    }
    //return;    
}

function FogOvertimeWarning()
{
    // End:0x2F
    if(m_LastActiveCapturePoint != none)
    {
        m_LastActiveCapturePoint.r_nFogAboutToBeActive++;
    }
    // End:0x5C
    if(m_fCaptureOvertimeWarningDuration > 0.0000000)
    {
        SetTimer(m_fCaptureOvertimeWarningDuration, false, 'FogOvertime');        
    }
    else
    {
        FogOvertime();
    }
    //return;    
}

function FogOvertime()
{
    local TgRepInfo_Game GRI;

    BeginPlayConverge();
    RespawnAllPlayers(false, true, true, false);
    m_bInCapturePointOvertime = true;
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xC0
    if(GRI != none)
    {
        GRI.r_fConvergeStartDistance = m_fConvergeStartDistance;
        GRI.r_fConvergeDistance = m_fConvergeStartDistance;
        GRI.bNetDirty = true;
    }
    StartFogConverging();
    //return;    
}

function FogOvertimeEnd()
{
    GlobalRespawnTimeUpdate(m_fBaseRespawnTime, true);
    m_bInCapturePointOvertime = false;
    ClearTimer('ConvergeFog');
    ClearTimer('ResumeConvergeCompletely');
    EndPlayConverge();
    //return;    
}

function int GetGameSpawnPhase(TgPawn TgP)
{
    // End:0x5F
    if(IsInState(m_AttackDefendState) && int(GetAttackingTaskForce().GetTeamNum()) == int(TgP.GetTaskForceNumber()))
    {
        return 1;        
    }
    else
    {
        return 0;
    }
    //return ReturnValue;    
}

function int GetCurrentLane()
{
    return ((m_LastActiveCapturePoint != none) ? m_LastActiveCapturePoint.m_nLaneNumber : 0);
    //return ReturnValue;    
}

state AttackDefend
{
    event BeginState(name PreviousStateName)
    {
        local TgRepInfo_Game GRI;

        super.BeginState(PreviousStateName);
        m_bHasHitCheckpoint = false;
        SetPayloadTimer(GetPayloadStartingDuration(), false);
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x87
        if(GRI != none)
        {
            TrackPushAttempt(GRI.r_AttackingTaskForce);
        }
        //return;        
    }

    function float GetPayloadStartingDuration()
    {
        return ((ShouldUsePayloadCheckpointDuration()) ? m_fPayloadDurationCheckpoint : m_fPayloadDuration);
        //return ReturnValue;        
    }

    function bool ShouldUsePayloadCheckpointDuration()
    {
        local int I;
        local array<SplineActor> Splines;
        local TgSplineActor TgSpline;
        local TgPawn_SiegeEngine_Payload LanePusher;

        LanePusher = GetSiegeEnginePush();
        // End:0x119
        if((LanePusher != none) && LanePusher.r_StartSpline != none)
        {
            LanePusher.r_StartSpline.GetAllConnectedSplineActors(Splines);
            I = 0;
            J0x91:

            // End:0x119 [Loop If]
            if(I < Splines.Length)
            {
                TgSpline = TgSplineActor(Splines[I]);
                // End:0x10B
                if((TgSpline != none) && int(TgSpline.m_ActionPoint) == int(2))
                {
                    return true;
                }
                I++;
                // [Loop Continue]
                goto J0x91;
            }
        }
        return false;
        //return ReturnValue;        
    }

    function float GetOvertimeDuration()
    {
        return FMax(1.0000000, m_fPayloadOvertimeDuration - ((m_fPayloadOvertimeDuration * (m_fPointOvertimeDrainPercPerSec / 100.0000000)) * m_fOvertimeActiveTime));
        //return ReturnValue;        
    }

    function float GetPickNextObjectiveTime()
    {
        return super.GetPickNextObjectiveTime() + m_fRoundEndRespawnDelay;
        //return ReturnValue;        
    }

    function float GetSpawnGateOpenTime()
    {
        return super.GetSpawnGateOpenTime() + m_fRoundEndRespawnDelay;
        //return ReturnValue;        
    }

    function EndState(name NextStateName)
    {
        local TgRepInfo_Game GRI;

        m_fOvertimeActiveTime = 0.0000000;
        m_bInPayloadOvertime = false;
        SendSecondaryMissionTimerNotify(0, 0.0000000);
        super(Object).EndState(NextStateName);
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x8B
        if(GRI != none)
        {
            GRI.r_bOvertime = false;
        }
        //return;        
    }

    function TgBotFactory_Minions GetCurrentBotFactory(TgChaosCapturePoint CapturePointToSpawn)
    {
        local TgRepInfo_Game GRI;
        local array<TgBotFactory_Minions> Factories;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x2D
        if(GRI == none)
        {
            return none;
        }
        Factories = ((int(GRI.r_AttackingTaskForce.GetTeamNum()) == int(2)) ? CapturePointToSpawn.m_Taskforce2Factories : CapturePointToSpawn.m_Taskforce1Factories);
        // End:0xC9
        if(Factories.Length < 1)
        {
            return none;            
        }
        else
        {
            // End:0xE9
            if(Factories.Length < 2)
            {
                return Factories[0];                
            }
            else
            {
                return Factories[1];
            }
        }
        //return ReturnValue;        
    }

    function SpawnLanePusher()
    {
        local TgRepInfo_Game GRI;
        local TgChaosCapturePoint CapturePointToSpawn;
        local TgSplineActor StartSpline;
        local TgBotFactory_Minions Factory;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x69
        if(((GRI == none) || GRI.r_AttackingTaskForce == none) || int(m_GameWinState) != int(0))
        {
            return;
        }
        CapturePointToSpawn = GetCapturePointToSpawnSiegeEngineAt();
        // End:0x309
        if(CapturePointToSpawn != none)
        {
            Factory = GetCurrentBotFactory(CapturePointToSpawn);
            // End:0x309
            if(Factory != none)
            {
                // End:0xEE
                if(m_bOverrideSpawnTableID)
                {
                    Factory.nSpawnTableId = GetNextSpawnTableId();
                }
                Factory.ResetQueue();
                GRI.r_LanePusher = TgPawn_LanePusher(Factory.UseSpawnTable());
                StartSpline = ((int(GRI.r_AttackingTaskForce.GetTeamNum()) == int(2)) ? CapturePointToSpawn.m_Taskforce2PathStart : CapturePointToSpawn.m_Taskforce1PathStart);
                GRI.r_LanePusher.SetSpline(StartSpline, true);
                // End:0x309
                if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
                {
                    GameplayEventsWriter.LogPlayerSpawnEvent(102, GRI.r_LanePusher.Controller, GRI.r_LanePusher.Class, int(GRI.r_AttackingTaskForce.GetTeamNum()));
                }
            }
        }
        SendLanePusherSpawnAlert(int(GRI.r_AttackingTaskForce.r_nTaskForce));
        SendLanePusherUpdateAlert(true, int(GRI.r_AttackingTaskForce.r_nTaskForce));
        //return;        
    }

    event Tick(float DeltaTime)
    {
        local TgPawn_SiegeEngine_Payload Payload;
        local bool bAlliesNearby;

        super(Actor).Tick(DeltaTime);
        Payload = GetSiegeEnginePush();
        // End:0x60
        if(Payload != none)
        {
            bAlliesNearby = Payload.HasFriendlyPlayersNearby();
        }
        // End:0xC4
        if(m_bInPayloadOvertime)
        {
            // End:0xC4
            if(((Payload != none) && Payload.IsAliveAndWell()) && bAlliesNearby)
            {
                SetPayloadTimer(GetOvertimeDuration(), true);
            }
        }
        //return;        
    }

    function SetPayloadTimer(float fDuration, bool overtime)
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x2D
        if(GRI == none)
        {
            return;
        }
        // End:0x13D
        if(overtime)
        {
            m_bInPayloadOvertime = true;
            SetTimer(fDuration, false, 'OvertimeExpired');
            // End:0x13A
            if((GRI.r_bOvertime != true) || GRI.r_fPayloadOvertimeStartDuration != fDuration)
            {
                GRI.r_bOvertime = true;
                GRI.r_fPayloadOvertimeStartDuration = fDuration;
                GRI.r_nPayloadOvertimeStateChange++;
                GRI.bNetDirty = true;
            }            
        }
        else
        {
            m_bInPayloadOvertime = false;
            ClearTimer('OvertimeExpired');
            SetTimer(fDuration, false, 'PayloadExpired');
            // End:0x1FB
            if(GRI.r_bOvertime != false)
            {
                GRI.r_bOvertime = false;
                GRI.r_nPayloadOvertimeStateChange++;
                GRI.bNetDirty = true;
            }
        }
        SetSecondaryMissionTime(fDuration);
        SendSecondaryMissionTimerNotify(1, fDuration);
        //return;        
    }

    function bool OvertimePreventsPayloadExpiring()
    {
        local TgRepInfo_Game GRI;
        local TgPawn_SiegeEngine_Payload Payload;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x8B
        if(GRI != none)
        {
            Payload = TgPawn_SiegeEngine_Payload(GRI.r_LanePusher);
            // End:0x8B
            if(Payload != none)
            {
                return Payload.HasFriendlyPlayersNearby();
            }
        }
        return false;
        //return ReturnValue;        
    }

    function PayloadExpired(optional bool bForce)
    {
        local TgRepInfo_Game GRI;
        local TgPawn_SiegeEngine_Payload Payload;
        local int currentScore, localPointsForDefending;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x2E
        if(GRI == none)
        {
            return;
        }
        Payload = TgPawn_SiegeEngine_Payload(GRI.r_LanePusher);
        // End:0x2B4
        if(Payload != none)
        {
            // End:0xA4
            if(!bForce && OvertimePreventsPayloadExpiring())
            {
                SetPayloadTimer(GetOvertimeDuration(), true);                
            }
            else
            {
                GRI.r_bOvertime = false;
                // End:0x14F
                if(GRI.r_AttackingTaskForce != none)
                {
                    GRI.r_nLastRoundWinner = ((int(GRI.r_AttackingTaskForce.r_nTaskForce) == int(1)) ? 2 : 1);                    
                }
                else
                {
                    GRI.r_nLastRoundWinner = ((int(Payload.GetTaskForceNumber()) == int(1)) ? 2 : 1);
                }
                TriggerSuccessfulDefense(int(GRI.r_nLastRoundWinner));
                currentScore = ((int(GRI.r_nLastRoundWinner) == int(1)) ? m_nTF1Score : m_nTF2Score);
                // End:0x253
                if(!m_bCanWinOnDefense && (currentScore - m_nPointsForDefending) <= 0)
                {
                    localPointsForDefending = currentScore - 1;                    
                }
                else
                {
                    localPointsForDefending = m_nPointsForDefending;
                }
                // End:0x2AA
                if(localPointsForDefending > 0)
                {
                    GainPoints(int(GRI.r_nLastRoundWinner), localPointsForDefending, 2);
                }
                OnRoundEnded();
            }
        }
        //return;        
    }

    function OvertimeExpired()
    {
        PayloadExpired(true);
        //return;        
    }

    function KeepClientsInSync()
    {
        local float fTimeRemaining;

        super(TgGame_Mission).KeepClientsInSync();
        fTimeRemaining = ((m_bInPayloadOvertime) ? GetRemainingTimeForTimer('OvertimeExpired') : GetRemainingTimeForTimer('PayloadExpired'));
        SendSecondaryMissionTimerNotify(TgRepInfo_Game(GameReplicationInfo).r_nSecondaryTimerState, fTimeRemaining);
        //return;        
    }

    function Timer()
    {
        super(GameInfo).Timer();
        ScorePayload();
        //return;        
    }
    stop;    
}

state RoundEnded
{    stop;    
}

state GameRunning
{
    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {
        local TgRepInfo_Game GRI;
        local TgRepInfo_TaskForce Taskforce1, Taskforce2;
        local TgPlayerController TgPC;

        TrackMapLane(GetCurrentLane());
        PointCapturePhaseCleanup();
        GRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x20E
        if(GRI != none)
        {
            Taskforce1 = GRI.GetTaskForce(1);
            // End:0xE6
            if(Taskforce1 != none)
            {
                Taskforce1.r_bIsAttacking = nTaskForce == 1;
                Taskforce1.bNetDirty = true;
            }
            Taskforce2 = GRI.GetTaskForce(2);
            // End:0x16F
            if(Taskforce2 != none)
            {
                Taskforce2.r_bIsAttacking = nTaskForce == 2;
                Taskforce2.bNetDirty = true;
            }
            GRI.bNetDirty = true;
            // End:0x20E
            if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
            {
                GameplayEventsWriter.LogTeamIntEvent(51, GRI.GetTaskForce(nTaskForce), 1);
            }
        }
        // End:0x2B5
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            // End:0x293
            if(TgPC.GetTaskForceNumber() == nTaskForce)
            {
                TgPC.ClientRequestHelpText(129);
                // End:0x2B4
                continue;
            }
            TgPC.ClientRequestHelpText(130);            
        }        
        // End:0x2E3
        if(!bSuppressPointsForCapture)
        {
            GainPoints(nTaskForce, m_nPointsForCapturing, 1);
        }
        super.PointCaptured(nTaskForce);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nPointsForCapturing=1
    m_nPointsForPayload=1
    m_nPointsForDefending=1
    m_nPointsForPayloadCheckpoint=1
    m_nCreditsForCapturingPoint=300
    m_bRespawnDeadPlayersAfterRound=true
    m_bRespawnLivePlayersAfterRound=true
    m_bRoundTreatment=true
    m_bDestroyPayloadCartAfterPayloadPhase=true
    m_bDoNotSwitchPoints=true
    m_fLosingCaptureRateModifier=15.0000000
    m_fPayloadDuration=150.0000000
    m_fPayloadOvertimeDuration=6.0000000
    m_fPayloadDurationCheckpoint=120.0000000
    m_fRoundEndRespawnDelay=5.0000000
    s_nCurrentRound=1
    m_nWinningScore=4
    m_bCanCaptureDuringSurvival=true
    m_bRevivePlayersWhenSiegeEngineDies=false
    m_bAutoMountAtRoundBegin=true
    m_bResetPlayersNotInSpawnRoom=true
    m_fObjectivePickTime=30.0000000
    m_fSetupObjectivePickTime=25.0000000
    m_fSpawnGateOpenTime=40.0000000
    m_fSetupSpawnGateOpenTime=50.0000000
    m_fDefenseRespawnIncrease=2.0000000
    m_fAttackRespawnIncrease=-4.0000000
    m_fCapturePointsPerSecond1=3.0000000
    m_fCapturePointsPerSecond2=3.0000000
    m_fCapturePointsPerSecond3=3.0000000
    m_fCapturePointsPerSecond4=3.0000000
    m_fCapturePointsPerSecond5=3.0000000
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_CAPTUREANDPAYLOAD
    SupportedEvents=/* Array type was not detected. */
}