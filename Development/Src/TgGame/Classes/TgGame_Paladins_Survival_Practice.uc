class TgGame_Paladins_Survival_Practice extends TgGame_Paladins_Survival
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nPIESpawnTable=395
    m_nTargetPlayerCountForMercs=10
    m_GameType=TGT_CHAOS_SURVIVAL_PRACTICE
    m_bIsPracticeGametype=true
}
