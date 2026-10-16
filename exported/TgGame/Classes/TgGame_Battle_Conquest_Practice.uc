class TgGame_Battle_Conquest_Practice extends TgGame_Battle_Conquest
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

defaultproperties
{
    m_GameType=TG_GAME_TYPE.TGT_BATTLE_PRACTICE
}