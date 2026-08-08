class TgPawn_Drogoz extends TgPawn_Character
    native(ChampDrogoz)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var bool m_bIsInBooster;
var bool m_bThrusterIsBlocking;
var bool m_bDragonSlamIsBlocking;
var bool m_bDragonSlamHasHit;
var bool m_bUseDragonSlamRetrieve;
var bool m_bInBoosterLockout;
var bool r_bSalvoActiveFlag;
var bool r_bCombustibleActive;
var (DrogozBooster) bool m_bBoosterUseConstantSpeedReduction;
var float m_fBoosterEndTime;
var TgDevice m_CachedBoosterDevice;
var float m_fBoosterLockoutTime;
var float m_fBoosterKnockbackLockoutTime;
var float m_fBoosterKnockbackLockoutTimestamp;
var int r_nInhandAmmoRemaining;
var (DrogozBooster) float m_fBoosterSpeedReductionRate;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bCombustibleActive, r_bSalvoActiveFlag, r_nInhandAmmoRemaining;
}

native function DeviceOnStartBuildup(TgDevice Dev);  // Export UTgPawn_Drogoz::execDeviceOnStartBuildup(FFrame&, void* const)

native function bool ShouldBeFirstPersonThisTick();  // Export UTgPawn_Drogoz::execShouldBeFirstPersonThisTick(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event Knock(bool bKnocked, optional float fKnockbackFrictionOverride=-1.0000000, optional Vector vKnockbackVelocityOverride=vect(0.0000000, 0.0000000, 0.0000000)) { }

simulated function StartKnockbackLockout() { }

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote) { }

simulated event bool CanFlyWithoutHover() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated function OnStartTimelapseNewDeviceState() { }

defaultproperties
{}
