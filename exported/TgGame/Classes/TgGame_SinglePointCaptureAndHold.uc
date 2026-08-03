class TgGame_SinglePointCaptureAndHold extends TgGame_PointCapture
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_nCurrentActiveCapturePointIndex;
var int m_nNumTicketsForCapturingPoint;
var int m_nNumTicketsForHoldingPoint;
var float m_fNewPointTime;
var float m_fDefendingTeamRespawnTime;

// Export UTgGame_SinglePointCaptureAndHold::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

function SpawnNeutralBots()
{
    local TgRepInfo_Game GRI;
    local int NewPointIndex, I;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x1EF
    if(GRI != none)
    {
        NewPointIndex = Rand(GRI.m_CPRIArray.Length);
        // End:0xB0
        if(NewPointIndex == m_nCurrentActiveCapturePointIndex)
        {
            NewPointIndex++;
            // End:0xB0
            if(NewPointIndex >= GRI.m_CPRIArray.Length)
            {
                NewPointIndex = 0;
            }
        }
        I = 0;
        J0xBB:

        // End:0x189 [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            GRI.m_CPRIArray[I].r_bIsLocked = NewPointIndex != I;
            GRI.m_CPRIArray[I].bNetDirty = true;
            I++;
            // [Loop Continue]
            goto J0xBB;
        }
        GRI.m_CPRIArray[NewPointIndex].r_OwningCapturePoint.SpawnNeutralBot();
        m_nCurrentActiveCapturePointIndex = NewPointIndex;
    }
    //return;    
}

function OnPointCaptureOwnershipChanged(TgCapturePoint Point, int NewTaskForceOwner, int PreviousTaskForceOwner)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce tf;
    local int I;
    local TgPlayerController TgPC;
    local float RespawnTime;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x3D2
    if(GRI != none)
    {
        // End:0x3D2
        if((NewTaskForceOwner == 1) || NewTaskForceOwner == 2)
        {
            tf = GRI.GetTaskForce(((NewTaskForceOwner == 1) ? 2 : 1));
            // End:0xEE
            if(tf != none)
            {
                tf.r_nScore = Max(0, tf.r_nScore - m_nNumTicketsForCapturingPoint);
                CheckWinCondition();
            }
            // End:0x3CF
            if((PreviousTaskForceOwner == 1) || PreviousTaskForceOwner == 2)
            {
                // End:0x25A
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {
                    // End:0x18F
                    if(TgPC.GetTaskForceNumber() == NewTaskForceOwner)
                    {
                        TgPC.GivePlayerFullVitals();
                    }
                    RespawnTime = TgPC.GetTimerRate('Revive') - GetTimerCount('Revive');
                    // End:0x259
                    if(RespawnTime > 0.0000000)
                    {
                        RespawnTime = RespawnTime / 2.0000000;
                        TgPC.SetTimer(RespawnTime, false, 'Revive');
                        TgPC.UpdateReviveTimeRemaining(RespawnTime);
                    }                    
                }                
                Point.r_RepInfo.r_nControlledByTaskForce = 0;
                Point.r_RepInfo.r_fOwnershipPct = 0.5000000;
                Point.OnPointCaptureOwnershipChanged(0, PreviousTaskForceOwner);
                SetTimer(m_fNewPointTime, false, 'SpawnNeutralBots');
                I = 0;
                J0x314:

                // End:0x3CF [Loop If]
                if(I < GRI.m_CPRIArray.Length)
                {
                    GRI.m_CPRIArray[I].r_bIsLocked = true;
                    GRI.m_CPRIArray[I].bNetDirty = true;
                    I++;
                    // [Loop Continue]
                    goto J0x314;
                }
            }            
        }
    }
    //return;    
}

function CheckTickets()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce tf;
    local int CurrentTaskForceNum, OpposingTaskForceNum, OldScore;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x2AB
    if(GRI != none)
    {
        CurrentTaskForceNum = GRI.m_CPRIArray[m_nCurrentActiveCapturePointIndex].r_nControlledByTaskForce;
        // End:0x2AB
        if((CurrentTaskForceNum == 1) || CurrentTaskForceNum == 2)
        {
            OpposingTaskForceNum = ((CurrentTaskForceNum == 1) ? 2 : 1);
            tf = GRI.GetTaskForce(OpposingTaskForceNum);
            OldScore = tf.r_nScore;
            tf.r_nScore = Max(0, tf.r_nScore - m_nNumTicketsForHoldingPoint);
            tf.r_nScorePercent = int((float(tf.r_nScore) / float(WorldInfo.Game.GoalScore)) * 100.0000000);
            tf.bNetDirty = true;
            // End:0x23F
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                tf.ReceivedScoringChanges();
            }
            // End:0x297
            if((OldScore > s_nAboutToLoseThreshold) && tf.r_nScore < s_nAboutToLoseThreshold)
            {
                AlertAboutToLose(OpposingTaskForceNum);
            }
            CheckWinCondition();
            CheckWinState();
        }
    }
    //return;    
}

function UpdateLockedPointStatus()
{
    local TgRepInfo_Game GRI;
    local int I;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xED
    if(GRI != none)
    {
        I = 0;
        J0x36:

        // End:0xED [Loop If]
        if(I < GRI.m_CPRIArray.Length)
        {
            // End:0xDF
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                GRI.m_CPRIArray[I].r_OwningCapturePoint.UpdateLockEffects();
            }
            I++;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}

defaultproperties
{
    m_nCurrentActiveCapturePointIndex=-1
    m_nNumTicketsForHoldingPoint=1
    m_fNewPointTime=5.0000000
    m_fDefendingTeamRespawnTime=40.0000000
    m_GameType=TG_GAME_TYPE.TGT_SINGLEPOINTCAPTUREANDHOLD
    GoalScore=100
}