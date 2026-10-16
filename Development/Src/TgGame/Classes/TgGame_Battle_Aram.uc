class TgGame_Battle_Aram extends TgGame_Battle_Conquest
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Battle_Aram::execGetRespawnTime(FFrame&, void* const)

defaultproperties
{
    m_bRestrictStoreInteractions=true
    m_nStartingCurrency=3000
    m_nStartingLevel=5
    m_fGodXpCoefficient=0.2000000
    m_fGodXpCoefficientLoss=0.2000000
    m_fGodXpWinBonus=4.0000000
    m_GameType=TGT_BATTLE_ARAM
}
