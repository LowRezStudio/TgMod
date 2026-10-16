class TgGame_Battle_Conquest_Tc extends TgGame_Battle_Conquest
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle_Conquest_Tc::execGetRespawnTime(FFrame&, void* const)

defaultproperties
{
    m_GameType=TGT_BATTLE_TC
}
