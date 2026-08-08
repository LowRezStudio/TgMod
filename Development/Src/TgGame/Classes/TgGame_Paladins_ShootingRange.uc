class TgGame_Paladins_ShootingRange extends TgGame_Paladins
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_bDeckSwappingAlwaysEnabled=true
    m_fBaseRespawnTime=3.0000000
    m_nStartingCredits=9999
    m_fCreditsToGivePerTick=2.0000000
    m_GameType=TGT_CHAOS_SHOOTINGRANGE
}
