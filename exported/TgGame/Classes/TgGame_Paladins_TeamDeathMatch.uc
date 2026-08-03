class TgGame_Paladins_TeamDeathMatch extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

var int m_lastPointTF;

// Export UTgGame_Paladins_TeamDeathMatch::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

function OpenSpawnGates()
{
    local TgRepInfo_Game TgGRI;

    super.OpenSpawnGates();
    TgGRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x37
    if(TgGRI == none)
    {
        return;
    }
    TgGRI.r_bKillCamEnabled = false;
    TgGRI.r_bAttackersKillCamEnabled = false;
    TgGRI.r_bDefendersKillCamEnabled = false;
    //return;    
}

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
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_TEAM_DEATH_MATCH
}