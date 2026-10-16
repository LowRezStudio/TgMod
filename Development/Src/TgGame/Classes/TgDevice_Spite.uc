class TgDevice_Spite extends TgDevice_Charge
    native(ChampDarklord)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

enum SpiteAnimState {
    SAS_Intro,  // 0
    SAS_HitChain,  // 1
    SAS_MissOutro,  // 2
    SAS_BounceOffOutro,  // 3
    SAS_InterruptOutro,  // 4
};

var TgPawn_Darklord m_CachedDarklord;
var bool m_bWaitingForServerHit;
var bool m_bHasStartedChainAttacks;
var bool m_bHasBounced;
var bool m_bHasRefundedEnergy;
var bool r_bApplyPercentDamage;
var int m_nNumHits;
var TgPawn_Character m_HitCharacter;
var const float m_fJoinViewLerpTime;
var const float m_fJoinSeparationDistance;
var const float m_fJoinMoveTweenTime;
var const float m_fJoinMinGroundOffset;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bApplyPercentDamage;
}

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Spite::execGetTargetingAim(FFrame&, void* const)

native function bool ShouldForce3P(TgDeviceForm DeviceForm, optional bool bOnlyCheckDeviceForm=false);  // Export UTgDevice_Spite::execShouldForce3P(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_Spite::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool ShouldLiftInterrupt();  // Export UTgDevice_Spite::execShouldLiftInterrupt(FFrame&, void* const)

native function float GetCachedFiringPostHitDelay();  // Export UTgDevice_Spite::execGetCachedFiringPostHitDelay(FFrame&, void* const)

simulated function bool HasCachedDarklord() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldAbortChainAttacks() { }

reliable server function ServerStartChainAttacks(Actor Other) { }

simulated function OnInterruptEvent() { }

function AbortChainAttacks() { }

function CheckForRefund() { }

simulated function BounceOff() { }

reliable client simulated function ClientStartChainAttacks(Actor Other) { }

simulated function StartChainAttacks(Actor Other) { }

function ApplyHitToTarget(int nHitSpecialSituationalType) { }

simulated function ApplyStunHit() { }

function RemoveStunHit() { }

simulated function ApplyChainHit() { }

reliable client simulated function ClientAbortWaitingForServerHit() { }

reliable client simulated function ClientFinishChainAttacks(bool bBounceOff, bool bApplyFinalHit) { }

simulated function FinishChainAttacks(bool bBounceOff, bool bApplyFinalHit) { }

simulated function ApplyFinalHit() { }

function RefundEnergy() { }

state DeviceBuildup {}

state DeviceFiring {}

defaultproperties
{
    m_fJoinViewLerpTime=0.4000000
    m_fJoinSeparationDistance=75.0000000
    m_fJoinMoveTweenTime=0.2500000
    m_fJoinMinGroundOffset=160.0000000
    m_bStopOnHitType=CSHT_GodOnly
    m_ChargeTimingType=CFT_PreFire
    m_bUsePhysFlying=true
    m_bIgnoreHumanoids=false
    m_bIgnoreMovementCorrection=true
    m_vHitProxySizeOffset=(X=0.0000000,Y=12.0000000,Z=0.0000000)
    s_fServerValidationSizeMultiplier=3.0000000
    s_bIgnoreReceivedAim=true
}
