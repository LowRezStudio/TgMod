class TgGame_Paladins_Payload extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const TG_DISTANCE_CAP = 100000.0f;

var float s_fCurrentTF1FarthestPushDistance;
var float s_fCurrentTF2FarthestPushDistance;
var float s_fCurrentPushTimer;
var float s_fCurrentTF1FarthestPushDistanceTimestamp;
var float s_fCurrentTF2FarthestPushDistanceTimestamp;
var float s_fTimeTF1HadToPush;
var int m_nPayloadOnlyCurrentAttackingTeam;
var int s_nCurrentTurn;
var Vector s_vPayloadGhostLocation;
var() Vector s_vPayloadGhostOffset;
var Rotator s_PayloadGhostRotation;
var int m_nPayloadGhostID;
var TgDeployable m_PayloadGhost;

// Export UTgGame_Paladins_Payload::execSpawnPayloadGhost(FFrame&, void* const)
native function SpawnPayloadGhost();

// Export UTgGame_Paladins_Payload::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)
native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);

function StartGameMode()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x73
    if(GRI != none)
    {
        GRI.UpdateAttackingTaskforce(GRI.GetTaskForce(m_nPayloadOnlyCurrentAttackingTeam));
    }
    super(TgGame_PaladinsExtended).StartGameMode();
    //return;    
}

function SetSpawnGateTimers(bool bFirstRound)
{
    local float AttackersSpawnGateOpenTime, DefendersSpawnGateOpenTime;

    AttackersSpawnGateOpenTime = (GetAttackersSpawnGateOpenTime()) + ((bFirstRound) ? 0.0000000 : m_fRoundEndRespawnDelay);
    DefendersSpawnGateOpenTime = (GetDefendersSpawnGateOpenTime()) + ((bFirstRound) ? 0.0000000 : m_fRoundEndRespawnDelay);
    SetTimer(AttackersSpawnGateOpenTime, false, 'OpenAttackersSpawnGates');
    SetTimer(DefendersSpawnGateOpenTime, false, 'OpenDefendersSpawnGates');
    //return;    
}

function OpenAttackersSpawnGates()
{
    local TgRepInfo_Game GRI;
    local TgSpawnGate SpawnGate;
    local TgPlayerController TgPC;

    SendClientsRequestHelpText(127);
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_CaptureAndPayloadRoundBegin', self);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xC9
    if(GRI != none)
    {
        GRI.r_bUltimatesLocked = false;
        GRI.UpdateAttackingTaskforce(GRI.GetTaskForce(m_nPayloadOnlyCurrentAttackingTeam));
        PointCaptured(m_nPayloadOnlyCurrentAttackingTeam, true);
    }
    m_bCanSpoolCredits = true;
    // End:0x1A1
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        // End:0x1A0
        if(int(SpawnGate.m_eSpawnGateType) == int(1))
        {
            SpawnGate.Deactivate();
            // End:0x19F
            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
            {
                TgPC.ClientDeactivateAttackersSpawnGates();                
            }            
        }        
    }    
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_SpawnGateDeactivate_Attackers', self);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x245
    if(GRI != none)
    {
        GRI.r_bAttackersSpawnGatesOpen = true;
        GRI.r_bAttackersKillCamEnabled = true;
        GRI.bNetDirty = true;
    }
    //return;    
}

function OpenDefendersSpawnGates()
{
    local TgRepInfo_Game GRI;
    local TgSpawnGate SpawnGate;
    local TgPlayerController TgPC;

    // End:0xCC
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        // End:0xCB
        if(int(SpawnGate.m_eSpawnGateType) == int(2))
        {
            SpawnGate.Deactivate();
            // End:0xCA
            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
            {
                TgPC.ClientDeactivateDefendersSpawnGates();                
            }            
        }        
    }    
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_SpawnGateDeactivate_Defenders', self);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x170
    if(GRI != none)
    {
        GRI.r_bDefendersSpawnGatesOpen = true;
        GRI.r_bDefendersKillCamEnabled = true;
        GRI.bNetDirty = true;
    }
    //return;    
}

function float GetAttackersSpawnGateOpenTime()
{
    // End:0x1E
    if(m_fAttackersSpawnGateOpenTime <= 0.0000000)
    {
        return GetSpawnGateOpenTime();
    }
    return m_fAttackersSpawnGateOpenTime;
    //return ReturnValue;    
}

function float GetDefendersSpawnGateOpenTime()
{
    // End:0x1E
    if(m_fDefendersSpawnGateOpenTime <= 0.0000000)
    {
        return GetSpawnGateOpenTime();
    }
    return m_fDefendersSpawnGateOpenTime;
    //return ReturnValue;    
}

function SetAutoMountTimers(bool bFirstRound)
{
    local float AttackersSpawnGateOpenTime, DefendersSpawnGateOpenTime;

    AttackersSpawnGateOpenTime = (GetAttackersSpawnGateOpenTime()) + ((bFirstRound) ? 0.0000000 : m_fRoundEndRespawnDelay);
    DefendersSpawnGateOpenTime = (GetDefendersSpawnGateOpenTime()) + ((bFirstRound) ? 0.0000000 : m_fRoundEndRespawnDelay);
    // End:0xA1
    if((AttackersSpawnGateOpenTime - 2.0000000) > 0.0000000)
    {
        SetTimer(AttackersSpawnGateOpenTime - 2.0000000, false, 'AutoMountAttackers');        
    }
    else
    {
        AutoMountAttackers();
    }
    // End:0xE6
    if((DefendersSpawnGateOpenTime - 2.0000000) > 0.0000000)
    {
        SetTimer(DefendersSpawnGateOpenTime - 2.0000000, false, 'AutoMountDefenders');        
    }
    else
    {
        AutoMountDefenders();
    }
    //return;    
}

function SetResetEscapedPlayersTimers(bool bFirstRound)
{
    local float AttackersSpawnGateOpenTime, DefendersSpawnGateOpenTime;

    AttackersSpawnGateOpenTime = (GetAttackersSpawnGateOpenTime()) + ((bFirstRound) ? 0.0000000 : m_fRoundEndRespawnDelay);
    DefendersSpawnGateOpenTime = (GetDefendersSpawnGateOpenTime()) + ((bFirstRound) ? 0.0000000 : m_fRoundEndRespawnDelay);
    // End:0xA1
    if((AttackersSpawnGateOpenTime - 3.0000000) > 0.0000000)
    {
        SetTimer(AttackersSpawnGateOpenTime - 3.0000000, false, 'ResetAttackersNotInSpawnRoom');        
    }
    else
    {
        ResetAttackersNotInSpawnRoom();
    }
    // End:0xE6
    if((DefendersSpawnGateOpenTime - 3.0000000) > 0.0000000)
    {
        SetTimer(DefendersSpawnGateOpenTime - 3.0000000, false, 'ResetDefendersNotInSpawnRoom');        
    }
    else
    {
        ResetDefendersNotInSpawnRoom();
    }
    //return;    
}

event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher)
{
    // End:0x44
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x35
        if(m_nPayloadOnlyCurrentAttackingTeam == 1)
        {
            s_fCurrentTF1FarthestPushDistance = 100000.0000000;            
        }
        else
        {
            s_fCurrentTF2FarthestPushDistance = 100000.0000000;
        }
    }
    super.LanePusherReachedOuterWall(LanePusher);
    //return;    
}

function BroadcastTimer()
{
    local TgPlayerController TgPC;
    local float timeTotal, TimeRemaining;

    timeTotal = GetTimerRate('OpenAttackersSpawnGates');
    TimeRemaining = timeTotal - GetTimerCount('OpenAttackersSpawnGates');
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

function UpdateAttackingTaskforceForRoundTransition()
{
    //return;    
}

event UpdatePayloadProgress()
{
    local TgRepInfo_Game GRI;
    local float fSplineLength;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x53
    if((GRI == none) || GRI.r_LanePusher == none)
    {
        return;
    }
    fSplineLength = GetDistanceToEndOfSpline();
    // End:0x1B7
    if(fSplineLength > 0.0000000)
    {
        // End:0x129
        if(int(GRI.r_AttackingTaskForce.GetTeamNum()) == int(1))
        {
            // End:0xF3
            if(s_fCurrentTF1FarthestPushDistance >= 100000.0000000)
            {
                GRI.r_fPayloadProgressPercent = 1.0000000;                
            }
            else
            {
                GRI.r_fPayloadProgressPercent = s_fCurrentTF1FarthestPushDistance / fSplineLength;
            }            
        }
        else
        {
            // End:0x163
            if(s_fCurrentTF2FarthestPushDistance >= 100000.0000000)
            {
                GRI.r_fPayloadProgressPercent = 1.0000000;                
            }
            else
            {
                GRI.r_fPayloadProgressPercent = s_fCurrentTF2FarthestPushDistance / fSplineLength;
            }
        }
        GRI.bNetDirty = true;
    }
    //return;    
}

function float GetDistanceToEndOfSpline()
{
    // End:0x6A
    if((m_LastActiveCapturePoint != none) && m_LastActiveCapturePoint.m_Taskforce1PathStart != none)
    {
        return m_LastActiveCapturePoint.m_Taskforce1PathStart.DistanceToEndOfSplineChain();
    }
    return 0.0000000;
    //return ReturnValue;    
}

function TF2PushesPastTF1()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x79
    if((GRI != none) && GRI.r_LanePusher != none)
    {
        LanePusherReachedOuterWall(GRI.r_LanePusher);
    }
    //return;    
}

function TF2ReachesTF1Faster()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x79
    if((GRI != none) && GRI.r_LanePusher != none)
    {
        LanePusherReachedOuterWall(GRI.r_LanePusher);
    }
    //return;    
}

function TF2TakesLongerThanTF1()
{
    local TgRepInfo_Game GRI;
    local TgPawn_SiegeEngine_Payload Payload;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2D
    if(GRI == none)
    {
        return;
    }
    GRI.r_bOvertime = false;
    GRI.r_nLastRoundWinner = 0;
    // End:0xF9
    if(GRI.r_AttackingTaskForce != none)
    {
        GRI.r_nLastRoundWinner = ((int(GRI.r_AttackingTaskForce.r_nTaskForce) == int(1)) ? 2 : 1);        
    }
    else
    {
        Payload = TgPawn_SiegeEngine_Payload(GRI.r_LanePusher);
        // End:0x188
        if(Payload != none)
        {
            GRI.r_nLastRoundWinner = ((int(Payload.GetTaskForceNumber()) == int(1)) ? 2 : 1);
        }
    }
    // End:0x1B4
    if(int(GRI.r_nLastRoundWinner) == int(0))
    {        
    }
    else
    {
        TriggerSuccessfulDefense(int(GRI.r_nLastRoundWinner));
        GainPoints(int(GRI.r_nLastRoundWinner), m_nPointsForDefending, 2);
    }
    OnRoundEnded();
    //return;    
}

function ManageComparativeScoring()
{
    // End:0x98
    if(s_fCurrentTF1FarthestPushDistance == s_fCurrentTF2FarthestPushDistance)
    {
        // End:0x3F
        if(s_fCurrentTF1FarthestPushDistanceTimestamp < s_fCurrentTF2FarthestPushDistanceTimestamp)
        {
            GainPoints(1, 1, 3);            
        }
        else
        {
            // End:0x68
            if(s_fCurrentTF2FarthestPushDistanceTimestamp < s_fCurrentTF1FarthestPushDistanceTimestamp)
            {
                GainPoints(2, 1, 3);                
            }
            else
            {
                // End:0x86
                if((Rand(2) + 1) == 1)
                {
                    GainPoints(1, 1, 3);                    
                }
                else
                {
                    GainPoints(2, 1, 3);
                }
            }
        }        
    }
    else
    {
        // End:0xC0
        if(s_fCurrentTF1FarthestPushDistance > s_fCurrentTF2FarthestPushDistance)
        {
            GainPoints(1, 1, 3);            
        }
        else
        {
            GainPoints(2, 1, 3);
        }
    }
    //return;    
}

function OnRoundEnded()
{
    local TgSplineActor_Payload PayloadSplineActor;
    local TgRepInfo_Game GRI;

    // End:0x16
    if(int(Role) != int(ROLE_Authority))
    {
        return;
    }
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x9C
    if((GRI != none) && GRI.r_LanePusher != none)
    {
        GRI.r_LanePusher.DestroyIt();
    }
    // End:0x136
    if(m_bRoundTreatment && s_nCurrentTurn == 1)
    {
        m_bKeepThisPointForNextRound = false;
        AddPotGEventToAllPlayers(5);
        PointCapturePhaseCleanup();
        PayloadPhaseCleanup();
        SendClientRoundObjectivesCompleted();
        // End:0x11D
        if(m_fRoundEndRespawnDelay > 0.0000000)
        {
            SetTimer(m_fRoundEndRespawnDelay, false, 'CaptureAndPayloadRoundEnded');            
        }
        else
        {
            CaptureAndPayloadRoundEnded();
        }
        s_nCurrentTurn = 2;        
    }
    else
    {
        m_bKeepThisPointForNextRound = true;
        ManageComparativeScoring();
        super.OnRoundEnded();
        s_fCurrentTF1FarthestPushDistance = 0.0000000;
        s_fCurrentTF2FarthestPushDistance = 0.0000000;
        s_nCurrentTurn = 1;
    }
    // End:0x1CF
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSplineActor_Payload', PayloadSplineActor)
    {
        PayloadSplineActor.m_bReached = false;        
    }    
    ClearCheckpointsReached();
    //return;    
}

function OvertimeExpired()
{
    //return;    
}

function PayloadExpired()
{
    //return;    
}

function float GetPayloadTimer()
{
    // End:0x38
    if(m_bInPayloadOvertime)
    {
        return GetTimerRate('OvertimeExpired') - GetTimerCount('OvertimeExpired');
    }
    return GetTimerRate('PayloadExpired') - GetTimerCount('PayloadExpired');
    //return ReturnValue;    
}

function PayloadCheckpointReached(TgSplineActor_Payload Checkpoint)
{
    // End:0x8C
    if(Checkpoint.m_fSecondsToAdd > 0.0000000)
    {
        SetPayloadTimer(((!m_bInPayloadOvertime) ? (GetPayloadTimer()) + Checkpoint.m_fSecondsToAdd : Checkpoint.m_fSecondsToAdd), false);
    }
    // End:0xC2
    if(int(Checkpoint.m_ActionPoint) == int(4))
    {
        SetCheckpoint1Reached();        
    }
    else
    {
        // End:0xF5
        if(int(Checkpoint.m_ActionPoint) == int(5))
        {
            SetCheckpoint2Reached();
        }
    }
    //return;    
}

simulated function SetCheckpoint1Reached()
{
    local TgRepInfo_Game GRI;
    local TgPlayerController TgPC;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2D
    if(GRI == none)
    {
        return;
    }
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_PayloadCP1Reached', self);
    GRI.r_bCheckpoint1Reached = true;
    GRI.r_bCheckpoint2Reached = false;
    // End:0x156
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        // End:0x134
        if(GRI.GetAttackingTaskForce().r_nTeamId == TgPC.GetTaskForceNumber())
        {
            TgPC.ClientRequestHelpText(157);
            // End:0x155
            continue;
        }
        TgPC.ClientRequestHelpText(158);        
    }    
    //return;    
}

simulated function SetCheckpoint2Reached()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2D
    if(GRI == none)
    {
        return;
    }
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_PayloadCP2Reached', self);
    GRI.r_bCheckpoint1Reached = true;
    GRI.r_bCheckpoint2Reached = true;
    //return;    
}

simulated function ClearCheckpointsReached()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2D
    if(GRI == none)
    {
        return;
    }
    GRI.r_bCheckpoint1Reached = false;
    GRI.r_bCheckpoint2Reached = false;
    //return;    
}

function ToggleAttackingTaskforce()
{
    local TgRepInfo_Game GRI;
    local TgPlayerController TgPC;

    m_nPayloadOnlyCurrentAttackingTeam = ((m_nPayloadOnlyCurrentAttackingTeam == 1) ? 2 : 1);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x91
    if(GRI != none)
    {
        GRI.UpdateAttackingTaskforce(GRI.GetTaskForce(m_nPayloadOnlyCurrentAttackingTeam));
    }
    // End:0xE5
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientToggleSpawnGateTeamColors();        
    }    
    //return;    
}

function CaptureAndPayloadRoundEnded()
{
    local TgRepInfo_Game GRI;

    ToggleAttackingTaskforce();
    super.CaptureAndPayloadRoundEnded();
    // End:0xA2
    if(m_bRoundTreatment)
    {
        // End:0xA2
        if(int(Role) == int(ROLE_Authority))
        {
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0xA2
            if(GRI != none)
            {
                GRI.r_bFadeOutAtRoundEnd = false;
                GRI.bNetDirty = true;
            }
        }
    }
    RemoveAllBurnCards();
    ResetUltForAllPlayers();
    ResetCreditsForAllPlayers();
    ResetKillstreaksForAllPlayers();
    //return;    
}

state GameRunning
{
    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {
        local PlayerStart Start;
        local TgChaosCapturePoint PointToSpawnAt;

        // End:0x44
        if(s_nCurrentTurn == 1)
        {
            // End:0x41
            if(m_CapturePointQueue.Length > 0)
            {
                PointToSpawnAt = m_CapturePointQueue[s_nCurrentCapturePointQueueIndex];                
            }            
        }
        else
        {
            // End:0x67
            if(s_nCurrentTurn == 2)
            {
                PointToSpawnAt = m_LastActiveCapturePoint;
            }
        }
        // End:0xB6
        if(PointToSpawnAt != none)
        {
            Start = FindPlayerStartForCapturePoint(PointToSpawnAt, Player);
            // End:0xB6
            if(Start != none)
            {
                return Start;
            }
        }
        return super(TgGame_Paladins_Siege).FindPlayerStart(Player, InTeam, IncomingName);
        //return ReturnValue;        
    }

    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {
        super.PointCaptured(nTaskForce, bSuppressPointsForCapture);
        m_nPayloadOnlyCurrentAttackingTeam = nTaskForce;
        //return;        
    }
    stop;    
}

state AttackDefend
{
    function BeginState(name PreviousStateName)
    {
        local TgRepInfo_Game GRI;
        local float fSplineLength;

        // End:0x15D
        if(m_nPayloadOnlyCurrentAttackingTeam != 1)
        {
            s_fTimeTF1HadToPush = s_fCurrentPushTimer;
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0x150
            if(GRI != none)
            {
                fSplineLength = GetDistanceToEndOfSpline();
                // End:0x150
                if(fSplineLength > 0.0000000)
                {
                    GRI.r_fTF1PayloadPushDistance = s_fCurrentTF1FarthestPushDistance / fSplineLength;
                    GRI.r_fTF1PayloadPushDistance = FMin(GRI.r_fTF1PayloadPushDistance, 1.0000000);
                    GRI.r_fTF1PayloadPushDistance = FMax(GRI.r_fTF1PayloadPushDistance, 0.0000000);
                    GRI.bNetDirty = true;
                }
            }
            SpawnPayloadGhost();            
        }
        else
        {
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0x233
            if((GRI != none) && GRI.r_LanePusher != none)
            {
                s_vPayloadGhostLocation = GRI.r_LanePusher.Location + s_vPayloadGhostOffset;
                s_PayloadGhostRotation = GRI.r_LanePusher.Rotation;
            }
        }
        super.BeginState(PreviousStateName);
        s_fCurrentPushTimer = 0.0000000;
        //return;        
    }

    function float GetPayloadStartingDuration()
    {
        // End:0x1D
        if(m_nPayloadOnlyCurrentAttackingTeam == 1)
        {
            return super.GetPayloadStartingDuration();            
        }
        else
        {
            // End:0x3D
            if(s_fCurrentTF1FarthestPushDistance >= 100000.0000000)
            {
                return s_fCurrentTF1FarthestPushDistanceTimestamp;                
            }
            else
            {
                // End:0x5B
                if(s_fTimeTF1HadToPush > float(0))
                {
                    return s_fTimeTF1HadToPush;                    
                }
                else
                {
                    return super.GetPayloadStartingDuration();
                }
            }
        }
        //return ReturnValue;        
    }

    function float GetOvertimeDuration()
    {
        // End:0x18
        if(m_nPayloadOnlyCurrentAttackingTeam == 1)
        {
            return 0.0000000;            
        }
        else
        {
            return 0.0000000;
        }
        //return ReturnValue;        
    }

    function bool OvertimePreventsPayloadExpiring()
    {
        // End:0x14
        if(m_nPayloadOnlyCurrentAttackingTeam == 1)
        {
            return false;            
        }
        else
        {
            return false;
        }
        //return ReturnValue;        
    }

    function TgChaosCapturePoint GetCapturePointToSpawnSiegeEngineAt()
    {
        // End:0x19
        if(m_LastActiveCapturePoint != none)
        {
            return m_LastActiveCapturePoint;
        }
        return super.GetCapturePointToSpawnSiegeEngineAt();
        //return ReturnValue;        
    }

    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {
        local PlayerStart Start;

        Start = FindPlayerStartForCapturePoint(m_LastActiveCapturePoint, Player);
        // End:0x42
        if(Start != none)
        {
            return Start;
        }
        return super.FindPlayerStart(Player, InTeam, IncomingName);
        //return ReturnValue;        
    }

    function Tick(float DeltaTime)
    {
        local TgRepInfo_Game GRI;
        local float fDist;

        super.Tick(DeltaTime);
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x66
        if((GRI == none) || GRI.r_LanePusher == none)
        {
            return;
        }
        s_fCurrentPushTimer += DeltaTime;
        // End:0xBD
        if(m_nPayloadOnlyCurrentAttackingTeam != 1)
        {
            // End:0xBD
            if(s_fCurrentTF1FarthestPushDistance >= 100000.0000000)
            {
                // End:0xBD
                if(s_fCurrentPushTimer > s_fCurrentTF1FarthestPushDistanceTimestamp)
                {
                    TF2TakesLongerThanTF1();
                }
            }
        }
        fDist = (GetDistanceToEndOfSpline()) - GRI.r_LanePusher.GetDistanceToEndOfSpline();
        // End:0x1DB
        if(m_nPayloadOnlyCurrentAttackingTeam == 1)
        {
            // End:0x1D8
            if(fDist > s_fCurrentTF1FarthestPushDistance)
            {
                s_fCurrentTF1FarthestPushDistance = fDist;
                s_fCurrentTF1FarthestPushDistanceTimestamp = s_fCurrentPushTimer;
                s_vPayloadGhostLocation = GRI.r_LanePusher.Location + s_vPayloadGhostOffset;
                s_PayloadGhostRotation = GRI.r_LanePusher.Rotation;
            }            
        }
        else
        {
            // End:0x28B
            if(fDist > s_fCurrentTF2FarthestPushDistance)
            {
                s_fCurrentTF2FarthestPushDistance = fDist;
                s_fCurrentTF2FarthestPushDistanceTimestamp = s_fCurrentPushTimer;
                // End:0x23C
                if(s_fCurrentTF2FarthestPushDistance > s_fCurrentTF1FarthestPushDistance)
                {
                    TF2PushesPastTF1();                    
                }
                else
                {
                    // End:0x28B
                    if(((s_fCurrentTF2FarthestPushDistance == s_fCurrentTF1FarthestPushDistance) && s_fCurrentTF1FarthestPushDistance < 100000.0000000) && s_fCurrentTF2FarthestPushDistanceTimestamp < s_fCurrentTF1FarthestPushDistanceTimestamp)
                    {
                        TF2ReachesTF1Faster();
                    }
                }
            }
            s_fCurrentTF2FarthestPushDistance = float(Max(int(s_fCurrentTF2FarthestPushDistance), int(fDist)));
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nPayloadOnlyCurrentAttackingTeam=1
    s_nCurrentTurn=1
    s_vPayloadGhostOffset=(X=0.0000000,Y=0.0000000,Z=-60.0000000)
    m_nPayloadGhostID=828
    m_nPointsForCapturing=0
    m_nPointsForPayload=0
    m_nPointsForDefending=0
    m_bFadeOutAtRoundEnd=true
    m_fPayloadDuration=420.0000000
    m_nWinningScore=1
    m_bKeepThisPointForNextRound=true
    m_fObjectivePickTime=50.0000000
    m_fSetupObjectivePickTime=50.0000000
    m_fSpawnGateOpenTime=50.0000000
    m_fAttackersSpawnGateOpenTime=50.0000000
    m_fDefendersSpawnGateOpenTime=10.0000000
    m_fSpeedScale=0.4000000
    m_nStartingCredits=1000
    m_fCreditsToGivePerTick=2.0000000
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_PAYLOAD
    SupportedEvents=/* Array type was not detected. */
}