class TgGame_Paladins_PvE extends TgGame_Paladins_Siege
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nPointsForDefending=0
    m_nWinningScore=2
    m_bEndRoundWhenPointCaptured=true
    m_nStartingCredits=3200
    m_nPIESpawnTable=418
    m_nTargetPlayerCountForMercs=10
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_PVE
    m_bIsPracticeGametype=true
}