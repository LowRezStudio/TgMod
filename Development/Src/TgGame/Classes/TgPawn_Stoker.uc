class TgPawn_Stoker extends TgPawn_Viktor
    native(ChampViktor)
    config(Game)
    hidecategories(Navigation);

var Vector m_vCurrentWallRunNormal;
var bool m_bIsWallRunning;
var bool r_bWantsWallRun;
var bool m_bHasDoubleJumped;
var (Stoker) float m_fWallMagnetMovePerSec;
var (Stoker) float m_fWallRunStickinessDuration;
var float m_fWallRunStickinessTimer;
var (Stoker) float m_fWallRunLockoutJumpDuration;
var float m_fWallRunLockoutJumpTimer;
var (Stoker) float m_fWallJumpZSpeed;
var (Stoker) float m_fDoubleJumpZSpeed;
var (Stoker) float m_fNewWallAllowableRunAngle;
var float m_fWallRunTime;

function bool DoJump(bool bUpdating) { }

function bool CannotJumpNow() { }

function UpdateWallRun(bool bWantsWallRun) { }

simulated function Tick(float DeltaSeconds) { }

native function float GetGravityZ();  // Export UTgPawn_Stoker::execGetGravityZ(FFrame&, void* const)

defaultproperties
{}
