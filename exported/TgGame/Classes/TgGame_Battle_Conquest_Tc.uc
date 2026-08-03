class TgGame_Battle_Conquest_Tc extends TgGame_Battle_Conquest
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

// Export UTgGame_Battle_Conquest_Tc::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

defaultproperties
{
    m_GameType=TG_GAME_TYPE.TGT_BATTLE_TC
}