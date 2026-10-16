class TgGame_Battle_Conquest_Erez extends TgGame_Battle_Conquest
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const LANE_PUSHER_BOT_ID = 2004;

var int m_nSpawnSiegeWeaponThreshold;

// Export UTgGame_Battle_Conquest_Erez::execGetNextVulnerableTowerId(FFrame&, void* const)
native function int GetNextVulnerableTowerId(int nBotId);

// Export UTgGame_Battle_Conquest_Erez::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

// Export UTgGame_Battle_Conquest_Erez::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

event PostBeginPlay()
{
    local int I;
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce tf;

    super(TgGame_Mission).PostBeginPlay();
    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0xC0
    if(GRI != none)
    {
        I = 1;
        J0x40:

        // End:0xC0 [Loop If]
        if(I <= 2)
        {
            tf = GRI.GetTaskForce(I);
            // End:0xB2
            if(tf != none)
            {
                tf.r_nScorePercent = 0;
            }
            I++;
            // [Loop Continue]
            goto J0x40;
        }
    }
    //return;    
}

event TriggerLanePusher(TgRepInfo_TaskForce tf, int nLane)
{
    local TgBotFactory_Minions Factory;
    local int I;

    // End:0x17E
    if(tf != none)
    {
        I = 0;
        J0x1A:

        // End:0x17E [Loop If]
        if(I < tf.GetMinionFactoryCount())
        {
            Factory = tf.GetMinionFactory(I);
            // End:0x170
            if(Factory.nLane == nLane)
            {
                // End:0xF6
                if(int(tf.r_nTaskForce) == int(1))
                {
                    Factory.SpawnBotId(2004, 0);                    
                }
                else
                {
                    Factory.SpawnBotId(2004, 0);
                }
                SendLanePusherSpawnAlert(int(tf.r_nTaskForce));
                SendLanePusherUpdateAlert(true, int(tf.r_nTaskForce));
            }
            ++I;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

defaultproperties
{
    m_nSpawnSiegeWeaponThreshold=100
    m_MultiLaneXpBonus=0.0000000
    m_nStartingCurrency=2000
    m_nStartingLevel=3
}