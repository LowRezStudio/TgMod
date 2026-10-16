class TgGame_Paladins_Payload_Practice extends TgGame_Paladins_Payload
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nPIESpawnTable=402
    m_nTargetPlayerCountForMercs=10
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_PAYLOAD_PRACTICE
    m_bIsPracticeGametype=true
}