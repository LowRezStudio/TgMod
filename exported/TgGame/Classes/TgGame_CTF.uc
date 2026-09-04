class TgGame_CTF extends TgGame_Mission
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var transient TgCTFFlagBase m_FlagBases[2];
var float m_fRoundTime;
var float m_fRoundSetupTime;
var float m_fEndOfRoundTime;
var transient int m_nCurrentRound;
var int m_nNumRounds;
var int m_nSpawnWaveTime;

// Export UTgGame_CTF::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_CTF::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

function float GetSetupTime()
{
    return m_fRoundSetupTime;
    //return ReturnValue;    
}

function bool StartGameTimer()
{
    m_fGameMissionTime = m_fRoundTime;
    return super.StartGameTimer();
    //return ReturnValue;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    ScriptTrace();
    super.ChangeTimerState(eTimerState);
    // End:0x76
    if(int(eTimerState) == int(3))
    {
        m_FlagBases[0].SpawnFlag();
        m_FlagBases[1].SpawnFlag();        
    }
    else
    {
        // End:0xCC
        if(int(eTimerState) == int(2))
        {
            m_FlagBases[0].DestroyFlag();
            m_FlagBases[1].DestroyFlag();
        }
    }
    //return;    
}

event MissionTimer()
{
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;

    SendMissionTimerNotify(0, 0.0000000);
    // End:0x75
    if(int(m_eTimerState) == int(2))
    {
        SetMissionTime(m_fGameMissionTime);
        MissionTimerStart();
        ChangeTimerState(3);
        SendMissionTimerEvent(1);
        SetTimer(float(m_nSpawnWaveTime), true, 'SpawnWaveTimer');        
    }
    else
    {
        // End:0x204
        if((m_nCurrentRound < m_nNumRounds) && int(m_eTimerState) == int(3))
        {
            SetMissionTime(m_fEndOfRoundTime);
            ChangeTimerState(8);
            MissionTimerStart();
            // End:0x166
            if((m_FlagBases[0].m_SpawnedFlag != none) && m_FlagBases[0].m_SpawnedFlag.m_Holder != none)
            {
                m_FlagBases[0].m_SpawnedFlag.Drop();
            }
            // End:0x201
            if((m_FlagBases[1].m_SpawnedFlag != none) && m_FlagBases[1].m_SpawnedFlag.m_Holder != none)
            {
                m_FlagBases[1].m_SpawnedFlag.Drop();
            }            
        }
        else
        {
            // End:0x479
            if(int(m_eTimerState) == int(8))
            {
                m_nCurrentRound++;
                SetMissionTime(GetSetupTime());
                ChangeTimerState(2);
                MissionTimerStart();
                // End:0x46A
                foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                {
                    TgPC.ResetPlayer();
                    // End:0x386
                    if(m_nCurrentRound == 2)
                    {
                        TgPC.SetLevel(15);
                        TgPC.r_nCurrency += 2500;
                        TgPC.bNetDirty = true;
                        // End:0x383
                        if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && TgPC.IsLocalPlayerController())
                        {
                            TgPC.SendUICurrencyChange();
                        }
                        // End:0x469
                        continue;
                    }
                    // End:0x469
                    if(m_nCurrentRound == 3)
                    {
                        TgPC.SetLevel(20);
                        TgPC.r_nCurrency += 2500;
                        TgPC.bNetDirty = true;
                        // End:0x469
                        if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && TgPC.IsLocalPlayerController())
                        {
                            TgPC.SendUICurrencyChange();
                        }
                    }                    
                }                
                SendMissionTimerEvent(0);                
            }
            else
            {
                // End:0x49A
                if(int(m_eTimerState) == int(1))
                {
                    AllPlayersReady();                    
                }
                else
                {
                    // End:0x6FE
                    if(int(m_eTimerState) == int(3))
                    {
                        GRI = TgRepInfo_Game(GameReplicationInfo);
                        // End:0x6FE
                        if(GRI != none)
                        {
                            // End:0x59A
                            if(GRI.GetTaskForce(1).r_nScore > GRI.GetTaskForce(2).r_nScore)
                            {
                                m_GameWinState = 2;
                                GRI.r_Winner = GRI.GetTaskForce(1);                                
                            }
                            else
                            {
                                // End:0x65C
                                if(GRI.GetTaskForce(1).r_nScore < GRI.GetTaskForce(2).r_nScore)
                                {
                                    m_GameWinState = 1;
                                    GRI.r_Winner = GRI.GetTaskForce(2);                                    
                                }
                                else
                                {
                                    m_GameWinState = 3;
                                }
                            }
                            GRI.bNetDirty = true;
                            // End:0x6E6
                            foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
                            {
                                TgPC.SendClientSetGameWinState(m_GameWinState);                                
                            }                            
                            UpdateMissionTimerEventWinVar();
                            BeginEndMission();
                        }
                    }
                }
            }
        }
    }
    //return;    
}

function RegisterFlagBase(TgCTFFlagBase FlagBase)
{
    // End:0x3C
    if(FlagBase.m_nDefenderTaskForce == 1)
    {
        m_FlagBases[0] = FlagBase;        
    }
    else
    {
        // End:0x79
        if(FlagBase.m_nDefenderTaskForce == 2)
        {
            m_FlagBases[1] = FlagBase;            
        }
    }
    //return;    
}

function ScoreFlag(TgPawn_Character FlagCarrier)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x6A
    if(GRI != none)
    {
        GRI.GetTaskForceFor(FlagCarrier).r_nScore++;
    }
    //return;    
}

function SpawnWaveTimer()
{
    //return;    
}

defaultproperties
{
    m_fRoundTime=300.0000000
    m_fRoundSetupTime=45.0000000
    m_fEndOfRoundTime=5.0000000
    m_nCurrentRound=1
    m_nNumRounds=3
    m_nSpawnWaveTime=60
    m_nStartingCurrency=5000
    m_nStartingLevel=10
    m_nWinPlayerXp=20
    m_nLosePlayerXp=20
    m_fBaseTokens=1.5000000
    m_fFirstBloodGoldReward=100.0000000
    m_GameType=TG_GAME_TYPE.TGT_POINTCAPTURE
}