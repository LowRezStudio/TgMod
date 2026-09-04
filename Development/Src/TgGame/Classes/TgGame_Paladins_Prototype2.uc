class TgGame_Paladins_Prototype2 extends TgGame_Paladins_Siege
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_bDoNotSwitchPoints=false
    m_nWinningScore=1
    m_fWinningTickets=500.0000000
    m_fTicketsForKill=3.0000000
    m_fTicketsPerCaptureTick=1.0000000
    m_fTicketsBonusPerMultiCapture=0.2500000
    m_fObjectiveRepickTickets=100.0000000
    m_fCapturePointsPerSecond1=0.0000000
    m_fCapturePointsPerSecond2=0.0000000
    m_fCapturePointsPerSecond3=0.0000000
    m_fCapturePointsPerSecond4=0.0000000
    m_fCapturePointsPerSecond5=0.0000000
    m_bDeckSwappingAlwaysEnabled=true
    m_fBaseRespawnTime=10.0000000
}
