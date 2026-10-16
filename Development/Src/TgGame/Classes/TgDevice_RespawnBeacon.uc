class TgDevice_RespawnBeacon extends TgDevice
    hidecategories(Navigation)
    config(Engine)
    dependson(TgClientSettings);

var TgRespawnBeaconExit s_BeaconExit;
var repnotify bool r_bHasBeacon;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasBeacon;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController) { }

simulated function bool ShouldInterruptMount() { }

simulated function FireAmmunition() { }

function HandlePickUpAndDrop(bool bPickedUp) { }

simulated function bool ShouldSwitchBackToBasicAttackTargeting(TgClientSettings.ECastMode CastMode) { }

simulated function DeviceShutDown(optional bool bDeactiveMode, optional bool bResetCooldowns) { }

defaultproperties
{
    r_OverrideUsesTargetingModeAsFalse=true
    m_bDisableLagCompensation=true
    m_fBottomlessPitCheck=48.0000000
}
