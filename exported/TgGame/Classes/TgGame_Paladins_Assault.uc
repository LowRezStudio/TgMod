class TgGame_Paladins_Assault extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var config float m_fAttackDuration;
var const config float m_fAttackPhaseOvertimeDuration;
var config float m_fAttackCaptureRateMultiplier;
var TgChaosCapturePoint m_AttackPoint;
var bool m_bInAttackPhaseOvertime;
var float m_fTakeoverSecondPhaseInstructionDelay;

// Export UTgGame_Paladins_Assault::execSendAssaultPointCapturedAlert(FFrame&, void* const)
native function SendAssaultPointCapturedAlert(int Taskforce);

function ActivateTaskforceSpecificCapturePoint(int TaskForceId)
{
    local TgChaosCapturePoint capturePoint;

    // End:0xC7
    foreach WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
    {
        // End:0xC6
        if((capturePoint.m_nTaskForce == TaskForceId) && capturePoint.m_nLaneNumber == m_CapturedPoint.m_nLaneNumber)
        {
            m_AttackPoint = capturePoint;
            SetCapturePointActive(capturePoint);
            // End:0xC7
            break;
        }        
    }    
    //return;    
}

function float GetPointCaptureScoreMultiplier(int nTaskForce)
{
    local float CaptureRateModifier;
    local TgRepInfo_Game GRI;

    CaptureRateModifier = super.GetPointCaptureScoreMultiplier(nTaskForce);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xC8
    if(((GRI != none) && GRI.r_AttackingTaskForce != none) && int(GRI.r_AttackingTaskForce.GetTeamNum()) == nTaskForce)
    {
        CaptureRateModifier *= m_fAttackCaptureRateMultiplier;
    }
    return CaptureRateModifier;
    //return ReturnValue;    
}

function NotifyPlayersOfPointCapture()
{
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;

    // End:0x108
    if(!IsInState('AttackDefend'))
    {
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x108
        if(GRI != none)
        {
            // End:0xF0
            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
            {
                TgPC.ClientPlayPointCapturedEffects(m_CapturedPoint, TgPC.GetTaskForceNumber() == int(GRI.r_AttackingTaskForce.r_nTaskForce));                
            }            
            SetTimer(m_fTakeoverSecondPhaseInstructionDelay, false, 'InstructClientsOnTakeoverSecondPhase');
        }
    }
    //return;    
}

function InstructClientsOnTakeoverSecondPhase()
{
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xD6
    if(GRI != none)
    {
        // End:0xD5
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientPlayTakeoverSecondPhaseInstructions(TgPC.GetTaskForceNumber() == int(GRI.r_AttackingTaskForce.r_nTaskForce));            
        }        
    }
    //return;    
}

function bool ShouldHandlePointCaptureBacksliding()
{
    return IsInState('AttackDefend');
    //return ReturnValue;    
}

function TgChaosCapturePoint GetCurrentCapturePoint()
{
    // End:0x5C
    if((m_LastActiveCapturePoint != none) && m_LastActiveCapturePoint == m_AttackPoint)
    {
        // End:0x45
        if(IsInState('AttackDefend'))
        {
            return m_AttackPoint;            
        }
        else
        {
            return m_CapturePointQueue[s_nCurrentCapturePointQueueIndex];
        }        
    }
    else
    {
        return super.GetCurrentCapturePoint();
    }
    //return ReturnValue;    
}

function CaptureAndPayloadRoundEnded()
{
    super.CaptureAndPayloadRoundEnded();
    // End:0x45
    if(m_AttackPoint != none)
    {
        m_AttackPoint.SetStatus(0);
        m_AttackPoint = none;
    }
    m_bEndRoundWhenPointCaptured = false;
    //return;    
}

function bool AttackersOnPoint()
{
    // End:0x3C
    if((m_AttackPoint == none) || int(m_AttackPoint.r_eStatus) != int(1))
    {
        return false;
    }
    // End:0x70
    if(m_nAttackingTaskforce == 1)
    {
        return m_AttackPoint.m_nNumTF1OnPoint > 0;        
    }
    else
    {
        return m_AttackPoint.m_nNumTF2OnPoint > 0;
    }
    //return ReturnValue;    
}

state GameRunning
{
    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {
        local TgRepInfo_Game GRI;
        local TgRepInfo_TaskForce TF1, TF2;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0xF5
        if(GRI != none)
        {
            GRI.r_nLastRoundWinner = byte(nTaskForce);
            TF1 = GRI.GetTaskForce(1);
            TF2 = GRI.GetTaskForce(2);
            TF1.r_fSecondaryScore = 0.0000000;
            TF2.r_fSecondaryScore = 0.0000000;
        }
        SendAssaultPointCapturedAlert(int(GRI.r_AttackingTaskForce.r_nTaskForce));
        super.PointCaptured(nTaskForce, bSuppressPointsForCapture);
        //return;        
    }
    stop;    
}

state AttackDefend
{
    event BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        ActivateTaskforceSpecificCapturePoint(m_nAttackingTaskforce);
        m_bEndRoundWhenPointCaptured = true;
        SetAttackPhaseTimer(m_fAttackDuration, false);
        //return;        
    }

    function bool CapturePointContestDurationEnabled()
    {
        return false;
        //return ReturnValue;        
    }

    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {
        local TgRepInfo_Game GRI;
        local TgRepInfo_TaskForce TF1, TF2;

        ClearTimer('DefenseWin');
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x109
        if(GRI != none)
        {
            GRI.r_nLastRoundWinner = byte(nTaskForce);
            TF1 = GRI.GetTaskForce(1);
            TF2 = GRI.GetTaskForce(2);
            TF1.r_fSecondaryScore = 0.0000000;
            TF2.r_fSecondaryScore = 0.0000000;
        }
        GainPoints(nTaskForce, m_nPointsForCapturing, 1);
        OnRoundEnded();
        //return;        
    }

    function SetAttackPhaseTimer(float fDuration, bool overtime)
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x2D
        if(GRI == none)
        {
            return;
        }
        // End:0x60
        if(overtime)
        {
            m_bInAttackPhaseOvertime = true;
            SetTimer(fDuration, false, 'OvertimeExpired');            
        }
        else
        {
            m_bInPayloadOvertime = false;
            ClearTimer('OvertimeExpired');
            SetTimer(fDuration, false, 'DefenseWin');
        }
        GRI.r_bCapturePointOvertime = m_bInAttackPhaseOvertime;
        GRI.r_fCapturePointOvertimeStartDuration = m_fPointOvertimeDuration;
        GRI.r_nCapturePointOvertimeStateChange++;
        GRI.bNetDirty = true;
        //return;        
    }

    event Tick(float DeltaTime)
    {
        super.Tick(DeltaTime);
        // End:0x41
        if(m_bInAttackPhaseOvertime)
        {
            // End:0x41
            if(AttackersOnPoint())
            {
                SetAttackPhaseTimer(m_fAttackPhaseOvertimeDuration, true);
            }
        }
        //return;        
    }

    function OvertimeExpired()
    {
        DefenseWin(true);
        //return;        
    }

    function DefenseWin(optional bool bForce)
    {
        local TgRepInfo_Game GRI;
        local int currentScore, localPointsForDefending;

        ClearTimer('DefenseWin');
        // End:0x4A
        if(!bForce && AttackersOnPoint())
        {
            SetAttackPhaseTimer(m_fAttackPhaseOvertimeDuration, true);            
        }
        else
        {
            GRI = TgRepInfo_Game(GameReplicationInfo);
            // End:0x126
            if(GRI != none)
            {
                // End:0xFC
                if(GRI.r_AttackingTaskForce != none)
                {
                    GRI.r_nLastRoundWinner = ((int(GRI.r_AttackingTaskForce.r_nTaskForce) == int(1)) ? 2 : 1);
                }
                TriggerSuccessfulDefense(int(GRI.r_nLastRoundWinner));
            }
            currentScore = ((int(GRI.r_nLastRoundWinner) == int(1)) ? m_nTF1Score : m_nTF2Score);
            // End:0x1B1
            if(!m_bCanWinOnDefense && (currentScore - m_nPointsForDefending) <= 0)
            {
                localPointsForDefending = currentScore - 1;                
            }
            else
            {
                localPointsForDefending = m_nPointsForDefending;
            }
            // End:0x208
            if(localPointsForDefending > 0)
            {
                GainPoints(int(GRI.r_nLastRoundWinner), localPointsForDefending, 2);
            }
            OnRoundEnded();
        }
        //return;        
    }

    function EndState(name NextStateName)
    {
        local TgRepInfo_Game GRI;

        m_bInAttackPhaseOvertime = false;
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0xBB
        if(GRI != none)
        {
            // End:0xBB
            if(GRI.r_bCapturePointOvertime)
            {
                GRI.r_bCapturePointOvertime = false;
                GRI.r_nCapturePointOvertimeStateChange++;
                GRI.bNetDirty = true;
            }
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fAttackDuration=180.0000000
    m_fAttackPhaseOvertimeDuration=6.0000000
    m_fAttackCaptureRateMultiplier=2.0000000
    m_fTakeoverSecondPhaseInstructionDelay=3.0000000
    m_fPayloadDuration=180.0000000
    m_nWinningScore=5
    m_bSpawnLanePusherWhenPointCaptured=false
    m_fSetupObjectivePickTime=30.0000000
    m_fSpawnGateOpenTime=30.0000000
    m_fSetupSpawnGateOpenTime=30.0000000
    m_fBackslidePercent=75.0000000
    m_fBackslideDelay=5.0000000
    m_fBackslideRate=2.5000000
}