class TgDevice_Drag extends TgDevice
    native(ChampMakoa)
    hidecategories(Navigation)
    config(Engine);

const DRAG_END_LOCATION_LOCK_DIST_SQ = 16384;

var TgPawn m_PullTarget;
var Rotator m_TargetInitialRotation;
var float m_fPullStartTime;
var TgPawn m_StunnedTarget;
var TgPawn r_ClientPullTarget;
var float m_fTruePostfireTime;
var float m_fPullVelocityBreakFactor;
var const float m_fPullVerticalEndOffset;
var const float m_fMaxPullTime;
var float m_fPrePullTime;
var float m_fPullEndOffset;
var float m_fPullSpeed;
var float m_fPullEndStunDuration;
var float m_fPullInterruptDistance;
var bool m_bCanStillPull;
var bool m_bNeedsDelayedServerEndPull;
var bool m_bNeedsDelayedClientEndPull;
var bool m_bHasPulledOnce;
var bool m_bSpecialUnlockInterrupt;
var Vector m_vEndLocation;
var TgPawn m_CachedPawnOwner;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_ClientPullTarget;
}

simulated event StartFire(byte FireModeNum) { }

function bool PullTarget(Actor Target, Vector HitLocation) { }

function PrePullTimer() { }

function MissPull() { }

function MissInvalidTarget() { }

event BreakPull() { }

event EndPull() { }

function ServerEndPull() { }

reliable client simulated function ClientEndPull() { }

function SetPullTargetNoServerCorrectCameraSmoothing(bool bDisallowSmoothing) { }

function SetPullTarget(TgPawn Target) { }

function ClearPullTarget() { }

event EndPostPullStun() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

state DeviceFiring {}

defaultproperties
{
    m_fTruePostfireTime=0.3000000
    m_fPullVelocityBreakFactor=0.1000000
    m_fPullVerticalEndOffset=16.0000000
    m_fMaxPullTime=1.5000000
    m_fPrePullTime=0.5000000
    m_fPullEndOffset=7.0000000
    m_fPullSpeed=1000.0000000
    m_fPullEndStunDuration=0.2000000
    m_fPullInterruptDistance=200.0000000
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=39.2000000,Y=-33.6000000,Z=42.5000000)
    m_nLinkedDeviceIDs[0]=14182
    m_nLinkedDeviceIDs[1]=14191
    m_nLinkedDeviceIDs[2]=14602
    m_nLinkedDeviceIDs[3]=14843
    m_nLinkedDeviceIDs[4]=14844
}
