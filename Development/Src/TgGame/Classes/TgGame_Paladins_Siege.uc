class TgGame_Paladins_Siege extends TgGame_PaladinsExtended
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);


var config transient int m_nPointsForCapturing;
var config transient int m_nPointsForPayload;
var config transient int m_nPointsForDefending;
var config transient int m_nPointsForPayloadCheckpoint;
var config int m_nCreditsForWinningARound;
var config int m_nCreditsForCapturingPoint;
var config int m_nCreditsForSuccessfulDefend;
var config int m_nCreditsForSuccessfulPush;
var config bool m_bRespawnDeadPlayersAfterRound;
var config bool m_bRespawnLivePlayersAfterRound;
var config bool m_bRoundTreatment;
var config bool m_bCanWinOnDefense;
var bool m_bInCapturePointOvertime;
var bool m_bInPayloadOvertime;
var bool m_bDestroyPayloadCartAfterPayloadPhase;
var config bool m_bDoNotSwitchPoints;
var transient bool m_bHasHitCheckpoint;
var config bool m_bFadeOutAtRoundEnd;
var config float m_fLosingCaptureRateModifier;
var config float m_fDurationUntilCaptureOvertime;
var config float m_fCaptureOvertimeWarningDuration;
var const config float m_fPayloadDuration;
var const config float m_fPayloadOvertimeDuration;
var const config float m_fPayloadDurationCheckpoint;
var const config float m_fRoundEndRespawnDelay;
var int s_nCurrentRound;

function PostBeginPlay(){}
function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType){}
function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName){}

//event LanePusherReachedOuterWall(TgPawn_LanePusher LanePusher){}