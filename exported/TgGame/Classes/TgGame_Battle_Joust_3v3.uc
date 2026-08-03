class TgGame_Battle_Joust_3v3 extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

// Export UTgGame_Battle_Joust_3v3::execGetNextVulnerableTowerId(FFrame&, void* const)
native function int GetNextVulnerableTowerId(int nBotId);

defaultproperties
{
    m_nStartingLevel=3
    m_GameType=TG_GAME_TYPE.TGT_BATTLE_JOUST
}