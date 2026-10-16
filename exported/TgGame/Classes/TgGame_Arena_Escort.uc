class TgGame_Arena_Escort extends TgGame_Arena
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_nSpawnEscortTime;
var int m_nEscortSuccessValue;
var TgSeqEvent_SpawnWise s_pEvt[2];
var TgSeqEvent_Escort_Despawn_Success s_pDespawnEvt[2];

// Export UTgGame_Arena_Escort::execSendEscortSpawnAlert(FFrame&, void* const)
native function SendEscortSpawnAlert(TgRepInfo_TaskForce tfri);

function OnEscortDespawn(int Taskforce)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce tf;
    local TgSeqEvent_Escort_Despawn_Success SeqEvent;
    local int Idx, DefenderTF;
    local array<int> ActivateIndices;
    local array<SequenceObject> KismetEvents;

    DefenderTF = ((Taskforce == 2) ? 1 : 2);
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x387
    if(GRI != none)
    {
        tf = GRI.GetTaskForce(DefenderTF);
        // End:0x387
        if(tf != none)
        {
            tf.r_nScore -= m_nEscortSuccessValue;
            tf.r_nScorePercent = int((float(tf.r_nScore) / float(WorldInfo.Game.GoalScore)) * float(100));
            tf.bNetDirty = true;
            // End:0x1B8
            if(tf.r_nScore < 0)
            {
                tf.r_nScore = 0;
                tf.r_nScorePercent = 0;
            }
            // End:0x37D
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                tf.ReceivedScoringChanges();
                // End:0x31B
                if(s_pDespawnEvt[DefenderTF - 1] == none)
                {
                    WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_Escort_Despawn_Success', true, KismetEvents);
                    Idx = 0;
                    J0x26F:

                    // End:0x31B [Loop If]
                    if(Idx < KismetEvents.Length)
                    {
                        SeqEvent = TgSeqEvent_Escort_Despawn_Success(KismetEvents[Idx]);
                        // End:0x30D
                        if((SeqEvent != none) && SeqEvent.DefendersTaskForce == DefenderTF)
                        {
                            s_pDespawnEvt[DefenderTF - 1] = SeqEvent;
                            // [Explicit Break]
                            goto J0x31B;
                        }
                        Idx++;
                        // [Loop Continue]
                        goto J0x26F;
                    }
                }
                J0x31B:

                // End:0x37D
                if(s_pDespawnEvt[DefenderTF - 1] == none)
                {
                    ActivateIndices[0] = 0;
                    s_pDespawnEvt[DefenderTF - 1].CheckActivate(self, self, false, ActivateIndices);
                }
            }
            CheckGameState();
        }
    }
    //return;    
}

defaultproperties
{
    m_nEscortSuccessValue=14
    m_GameType=TG_GAME_TYPE.TGT_ARENA_ESCORT
}