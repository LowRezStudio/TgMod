class TgGame_JeffPrototype extends TgGame_Paladins_Siege
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nWinningScore=3
    m_fWinningTickets=300.0000000
    m_bAutoMountAtRoundBegin=false
    m_bResetPlayersNotInSpawnRoom=false
    m_fTicketsPerCaptureTick=1.0000000
    m_fTicketsBonusPerMultiCapture=0.2500000
    m_fTicketsPerPointCapture=150.0000000
    m_fObjectivePickTime=15.0000000
    m_fSetupObjectivePickTime=15.0000000
    m_fSpawnGateOpenTime=15.0000000
    m_fSetupSpawnGateOpenTime=15.0000000
}
