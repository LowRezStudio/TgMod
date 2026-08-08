class TgGame_Paladins_CaptureOnly extends TgGame_Paladins_Siege
    config(Game)
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    m_nWinningScore=2
    m_bEndRoundWhenPointCaptured=true
    m_fObjectivePickTime=15.0000000
    m_fSetupObjectivePickTime=15.0000000
    m_fSpawnGateOpenTime=15.0000000
    m_fSetupSpawnGateOpenTime=15.0000000
}
