class TgGame_Paladins_Survival extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgGame_PaladinsExtended);

var int m_nWinningTaskforceThisRound;
var float m_fRoundStartTime;

native function float GetRespawnTime(int TaskForceNum);  // Export UTgGame_Paladins_Survival::execGetRespawnTime(FFrame&, void* const)

native function SendStartRoundOnePointFromWinningAlert(int nTaskForceNum);  // Export UTgGame_Paladins_Survival::execSendStartRoundOnePointFromWinningAlert(FFrame&, void* const)

event PostBeginPlay() { }

function CheckAwardObjectiveScore(byte TaskForceNum, TgChaosCapturePoint capturePoint, int NumOnPoint, int NumContested) { }

function bool ShouldNextRoundBeASurvivalRound() { }

function float GetSpawnGateOpenTime() { }

function float GetPickNextObjectiveTime() { }

function OnPawnDied(TgPawn Victim) { }

function SurvivalModeRoundWon(TgRepInfo_TaskForce RoundWinningTF) { }

function SurvivalModeRoundEnded() { }

function bool ShouldSelectNextCapturePointForLoading() { }

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

function StartNewObjectiveRound(bool bFirstRound) { }

function SetCapturePointActive(TgObjective Objective) { }

defaultproperties
{
    m_nWinningScore=5
    m_bEndRoundWhenPointCaptured=true
    m_fSetupObjectivePickTime=30.0000000
    m_fSpawnGateOpenTime=0.0000000
    m_fSetupSpawnGateOpenTime=0.0000000
    m_nStartingCredits=1500
    m_fCreditsToGivePerTick=2.0000000
    m_GameType=TGT_CHAOS_SURVIVAL
    SupportedEvents=/* Array type was not detected. */
}
