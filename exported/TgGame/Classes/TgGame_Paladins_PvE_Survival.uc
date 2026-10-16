class TgGame_Paladins_PvE_Survival extends TgGame_Paladins_Survival
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nStartingCredits=2000
    m_nPIESpawnTable=395
    m_nTargetPlayerCountForMercs=10
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_PVE_SURVIVAL
    m_bIsPracticeGametype=true
}