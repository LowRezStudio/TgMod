class TgGame_Paladins_Survival extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_nWinningTaskforceThisRound;
var float m_fRoundStartTime;

// Export UTgGame_Paladins_Survival::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Paladins_Survival::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)
native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);

event PostBeginPlay()
{
    super.PostBeginPlay();
    BeginPlayConverge();
    m_fRoundStartTime = WorldInfo.TimeSeconds;
    //return;    
}

function CheckAwardObjectiveScore(byte TaskForceNum, TgChaosCapturePoint capturePoint, int NumOnPoint, int NumContested)
{
    //return;    
}

function bool ShouldNextRoundBeASurvivalRound()
{
    return true;
    //return ReturnValue;    
}

function float GetSpawnGateOpenTime()
{
    // End:0x5C
    if((m_nTF1Score == m_nWinningScore) && m_nTF2Score == m_nWinningScore)
    {
        return ((m_fSetupSpawnGateOpenTime > 0.0000000) ? m_fSetupSpawnGateOpenTime : GetPickNextObjectiveTime());        
    }
    else
    {
        return ((m_fSpawnGateOpenTime > 0.0000000) ? m_fSpawnGateOpenTime : GetPickNextObjectiveTime());
    }
    //return ReturnValue;    
}

function float GetPickNextObjectiveTime()
{
    // End:0x3D
    if((m_nTF1Score == m_nWinningScore) && m_nTF2Score == m_nWinningScore)
    {
        return m_fSetupObjectivePickTime;        
    }
    else
    {
        return m_fObjectivePickTime;
    }
    //return ReturnValue;    
}

function OnPawnDied(TgPawn Victim)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce VictimTaskForce, killerTaskForce;

    super(TgGame_PaladinsExtended).OnPawnDied(Victim);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x1E5
    if(((GRI != none) && Victim.IsGod()) && !IsTimerActive('SurvivalModeRoundEnded'))
    {
        VictimTaskForce = GRI.GetTaskForce(int(Victim.GetTaskForceNumber()));
        killerTaskForce = GRI.GetTaskForce(((int(Victim.GetTaskForceNumber()) == int(1)) ? 2 : 1));
        // End:0x1E5
        if((VictimTaskForce.GetNumAlivePlayers() == 0) && killerTaskForce.GetNumAlivePlayers() > 0)
        {
            SurvivalModeRoundWon(((int(VictimTaskForce.r_nTaskForce) == int(1)) ? GRI.GetTaskForce(2) : GRI.GetTaskForce(1)));
        }
    }
    //return;    
}

function SurvivalModeRoundWon(TgRepInfo_TaskForce RoundWinningTF)
{
    local TgRepInfo_Game GRI;
    local int nWinningTaskForce;

    // End:0x3A
    if(RoundWinningTF != none)
    {
        nWinningTaskForce = int(RoundWinningTF.GetTeamNum());
    }
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xD1
    if(GRI != none)
    {
        GRI.r_nLastRoundWinner = byte(nWinningTaskForce);
        GRI.r_bFogEnded = true;
        GRI.r_bFogConverging = false;
    }
    EndPlayConverge();
    m_nWinningTaskforceThisRound = nWinningTaskForce;
    ClearTimer('StartFogConverging');
    ClearTimer('ConvergeFog');
    ClearTimer('ResumeConvergeCompletely');
    SurvivalModeRoundEnded();
    // End:0x164
    if(m_LastActiveCapturePoint != none)
    {
        m_LastActiveCapturePoint.SetStatus(0);
    }
    //return;    
}

function SurvivalModeRoundEnded()
{
    SendClientRoundEnded();
    GainPoints(m_nWinningTaskforceThisRound, m_nPointsForCapturing, 5);
    OnRoundEnded();
    //return;    
}

function bool ShouldSelectNextCapturePointForLoading()
{
    return true;
    //return ReturnValue;    
}

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    super.TaskforceWin(nTaskForce, VictoryType);
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_SurvivalGameEnd', self);
    //return;    
}

function StartNewObjectiveRound(bool bFirstRound)
{
    local TgChaosCapturePoint_ParticleStorm CapPoint;

    // End:0x4E
    foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint_ParticleStorm', CapPoint)
    {
        CapPoint.ResetFog();        
    }    
    m_fRoundStartTime = WorldInfo.TimeSeconds;
    super(TgGame_PaladinsExtended).StartNewObjectiveRound(bFirstRound);
    //return;    
}

function SetCapturePointActive(TgObjective Objective)
{
    local TgRepInfo_Game GRI;
    local TgChaosCapturePoint_ParticleStorm SurvivalCaptureObjective;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    SurvivalCaptureObjective = TgChaosCapturePoint_ParticleStorm(Objective);
    // End:0xA5
    if((GRI != none) && SurvivalCaptureObjective != none)
    {
        GRI.bNetDirty = true;
        SetTimer(SurvivalCaptureObjective.m_fSecondsBeforeFogConverge, false, 'StartFogConverging');
    }
    super(TgGame_PaladinsExtended).SetCapturePointActive(Objective);
    //return;    
}

defaultproperties
{
    m_nWinningScore=5
    m_bEndRoundWhenPointCaptured=true
    m_fSetupObjectivePickTime=30.0000000
    m_fSpawnGateOpenTime=0.0000000
    m_fSetupSpawnGateOpenTime=0.0000000
    m_nStartingCredits=1500
    m_fCreditsToGivePerTick=2.0000000
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_SURVIVAL
    SupportedEvents=/* Array type was not detected. */
}