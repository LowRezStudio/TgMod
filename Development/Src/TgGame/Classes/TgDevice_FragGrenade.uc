class TgDevice_FragGrenade extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgTimerManager);

var TgPawn_Viktor m_CachedViktor;
var bool m_bEndCook;
var bool m_bThrownGrenade;
var bool s_bCanPickUpNuggetRefills;
var bool s_bFullCook;

native function bool RequiresAmmoToFire();  // Export UTgDevice_FragGrenade::execRequiresAmmoToFire(FFrame&, void* const)

simulated function SetThrowSpeedMultiplier(float Mult) { }

simulated function DropGrenade() { }

simulated function FireAmmunition() { }

function CooldownTimerExpired(int nTimerId, TgTimerManager.TGT_EVENT eEvent, optional bool bNoBecomeActive) { }

simulated function StartThrowValidation() { }

simulated function StartThrow() { }

simulated function SetGrenadeCookTime(float fCookAmt, optional bool bSendToServer=false) { }

simulated function bool InterceptSlotReleased(TgPlayerController TgController) { }

simulated function SetAndSendGrenadeTimingsViaStartThrowTimer() { }

reliable server function ServerEndCook(float fCookPct) { }

simulated function bool HasCachedViktor() { }

reliable server event InterruptFiring() { }

reliable client simulated event ClientInterrupt() { }

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

simulated event bool ShouldCooldownAfterFire() { }

state DeviceFiring {}

defaultproperties
{
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceFragGrenade'
    m_nAimAssistPriorityWhileFiring=2
}
