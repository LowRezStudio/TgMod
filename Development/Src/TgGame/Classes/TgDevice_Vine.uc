class TgDevice_Vine extends TgDevice
    native(ChampGrover)
    hidecategories(Navigation)
    config(Engine);

var Actor m_PullTarget;
var Vector m_vPullLocation;
var float m_fPullSpeed;
var float m_fTruePostfireTime;
var float m_fPullEndOffset;
var bool m_bCanBeCanceled;
var bool m_bMissedPull;
var bool m_bIsPulling;
var bool m_bHasPulledOnce;
var bool m_bTeleportedAfterFiring;
var float m_fMomentumAfterPull;

event PullToTarget(Actor Target, Vector targetPos) { }

event MissPull() { }

function EndPull() { }

reliable client simulated function ClientEndPull() { }

function SetIsPullingHitSpecial(bool bIsPulling) { }

simulated function Tick(float DeltaSeconds) { }

simulated event bool ShouldCooldownAfterFire() { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

simulated event bool CanBeCanceled() { }

state DeviceFiring {}

defaultproperties
{
    m_fPullSpeed=2000.0000000
    m_fTruePostfireTime=0.3000000
    m_fPullEndOffset=7.0000000
    m_fMomentumAfterPull=1.0000000
}
