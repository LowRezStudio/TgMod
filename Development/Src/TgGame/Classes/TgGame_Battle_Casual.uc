class TgGame_Battle_Casual extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle_Casual::execGetRespawnTime(FFrame&, void* const)

native function bool ShouldSpawnSuperMinions(TgBotFactory_Minions minionFactory);  // Export UTgGame_Battle_Casual::execShouldSpawnSuperMinions(FFrame&, void* const)

native function StructureDied(TgPawn_Structure theStructure);  // Export UTgGame_Battle_Casual::execStructureDied(FFrame&, void* const)

defaultproperties
{
    m_bRespawnInhibitors=false
    m_nStartingCurrency=3000
    m_MinionKillerBonus=0.0000000
    m_BasePlayerGoldReward=45.0000000
    m_GameType=TGT_BATTLE_CASUAL
}
