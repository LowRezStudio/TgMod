class TgGame_Paladins_Onslaught extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);  // Export UTgGame_Paladins_Onslaught::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)

function int GetGameTypeHelpTipIndex(TgPlayerController TgPC) { }

defaultproperties
{
    m_nWinningScore=1
    m_fWinningTickets=400.0000000
    m_fTicketsForKill=5.0000000
    m_fTicketsPerCaptureTick=1.0000000
    m_fTicketsPerTicketDisparity=10.0000000
    m_fSecondsPerTicketDisparity=1.0000000
    m_fMaximumDisparitySeconds=4.0000000
    m_fRoundLimitDuration=600.0000000
    m_nCreditsForHoldingObjective=4
    m_nCreditsBonusPerContested=0
    m_fCapturePointsPerSecond1=0.0000000
    m_fCapturePointsPerSecond2=0.0000000
    m_fCapturePointsPerSecond3=0.0000000
    m_fCapturePointsPerSecond4=0.0000000
    m_fCapturePointsPerSecond5=0.0000000
    m_SnappedWaypointIndicatorOffset=(X=0.0000000,Y=10.0000000,Z=0.0000000)
    m_fGameTypeReminderTime=15.0000000
    m_fBaseRespawnTime=8.0000000
    m_fCreditsToGivePerTick=5.0000000
    m_GameType=TGT_CHAOS_ONSLAUGHT
}
