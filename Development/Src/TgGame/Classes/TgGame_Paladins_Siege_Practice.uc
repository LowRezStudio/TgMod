class TgGame_Paladins_Siege_Practice extends TgGame_Paladins_Siege
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nPIESpawnTable=402
    m_nTargetPlayerCountForMercs=10
    m_GameType=TGT_CHAOS_CAPTUREANDPAYLOAD_PRACTICE
    m_bIsPracticeGametype=true
}
