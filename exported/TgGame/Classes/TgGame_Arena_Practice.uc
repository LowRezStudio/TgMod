class TgGame_Arena_Practice extends TgGame_Arena
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    local TgObject.GameTimerState OldState;

    OldState = m_eTimerState;
    super(TgGame_Battle).ChangeTimerState(eTimerState);
    // End:0x81
    if(((int(eTimerState) != int(OldState)) && int(eTimerState) == int(1)) && int(OldState) != int(6))
    {
        CheckMercenaries();
        SpawnBots();
    }
    //return;    
}

function SpawnBots()
{
    // End:0x2B
    if(SpawnDefaultBotPlayers(m_MercsToSpawn, false))
    {
        s_nReadyMercs = m_MercsToSpawn.Length;
    }
    //return;    
}

defaultproperties
{
    m_GameType=TG_GAME_TYPE.TGT_ARENA_PRACTICE
}