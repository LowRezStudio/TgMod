class TgGame_Battle_Practice extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

// Export UTgGame_Battle_Practice::execGetNextVulnerableTowerId(FFrame&, void* const)
native function int GetNextVulnerableTowerId(int nBotId);

// Export UTgGame_Battle_Practice::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Battle_Practice::execMarkAsReady(FFrame&, void* const)
native function MarkAsReady(Player P);

// Export UTgGame_Battle_Practice::execCheckTeamAce(FFrame&, void* const)
native function CheckTeamAce(Controller Killer, Controller Killed);

function float GetSetupTime()
{
    return 45.0000000;
    //return ReturnValue;    
}

event ChangeTimerState(TgObject.GameTimerState eTimerState)
{
    local TgObject.GameTimerState OldState;

    OldState = m_eTimerState;
    super.ChangeTimerState(eTimerState);
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
    m_nStartingLevel=3
    m_GameType=TG_GAME_TYPE.TGT_BATTLE_PRACTICE
}