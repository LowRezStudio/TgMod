class TgGame_Paladins_TeamDeathMatch extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_lastPointTF;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Paladins_TeamDeathMatch::execGetRespawnTime(FFrame&, void* const)

function OpenSpawnGates() { }

defaultproperties
{
    m_lastPointTF=1
    m_nWinningScore=1
    m_fWinningTickets=50.0000000
    m_fTicketsForKill=1.0000000
    m_bCanPurchaseItemsAnywhere=true
    m_bAutoMountOnRespawn=false
    m_fBaseRespawnTime=5.0000000
    m_fCreditsToGivePerTick=5.0000000
    m_GameType=TGT_CHAOS_TEAM_DEATH_MATCH
}
