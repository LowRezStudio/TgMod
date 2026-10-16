class TgGame_Battle_Expert extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

event TriggerBonusMinions(TgRepInfo_TaskForce tf, int nLane)
{
    local TgBotFactory_Minions Factory;
    local int I;

    // End:0x10C
    if(tf != none)
    {
        I = 0;
        J0x1A:

        // End:0xF0 [Loop If]
        if(I < tf.GetMinionFactoryCount())
        {
            Factory = tf.GetMinionFactory(I);
            // End:0xE2
            if(Factory.nLane == nLane)
            {
                Factory.m_fLastBonusActivationTime = WorldInfo.TimeSeconds;
            }
            ++I;
            // [Loop Continue]
            goto J0x1A;
        }
        SendBonusMinionAlerts(tf, nLane);
    }
    //return;    
}

defaultproperties
{
    m_GameType=TG_GAME_TYPE.TGT_BATTLE_EXPERT
}