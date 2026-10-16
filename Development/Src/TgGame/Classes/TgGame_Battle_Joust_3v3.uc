class TgGame_Battle_Joust_3v3 extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

native function int GetNextVulnerableTowerId(int nBotId);  // Export UTgGame_Battle_Joust_3v3::execGetNextVulnerableTowerId(FFrame&, void* const)

defaultproperties
{
    m_nStartingLevel=3
    m_GameType=TGT_BATTLE_JOUST
}
