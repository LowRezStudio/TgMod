class TgDevice_SelfResurrection extends TgDevice
    native(ChampLazarus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

enum ResurrectionState {
    RS_NONE,  // 0
    RS_STANDBY,  // 1
    RS_BUILDUP,  // 2
    RS_ACTIVE,  // 3
    RS_END,  // 4
};

var repnotify TgDevice_SelfResurrection.ResurrectionState r_mCurrentState;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_mCurrentState;
}

native function bool CanFiringBeLocked();  // Export UTgDevice_SelfResurrection::execCanFiringBeLocked(FFrame&, void* const)

native function bool CanFireWhileMounted();  // Export UTgDevice_SelfResurrection::execCanFireWhileMounted(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_SelfResurrection::execCanDeviceFireNow(FFrame&, void* const)

native function EnterBuildupState();  // Export UTgDevice_SelfResurrection::execEnterBuildupState(FFrame&, void* const)

native function Suicide();  // Export UTgDevice_SelfResurrection::execSuicide(FFrame&, void* const)

native function FinishResurrection();  // Export UTgDevice_SelfResurrection::execFinishResurrection(FFrame&, void* const)

native function ApplyActiveEffects();  // Export UTgDevice_SelfResurrection::execApplyActiveEffects(FFrame&, void* const)

native function UpdateState(byte NewState);  // Export UTgDevice_SelfResurrection::execUpdateState(FFrame&, void* const)

native function OnBecomeActive();  // Export UTgDevice_SelfResurrection::execOnBecomeActive(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function bool ShouldInterruptMount() { }

simulated event bool CanBeCanceled() { }

simulated event bool CanBeInterrupted() { }

simulated function FireAmmunition() { }

simulated function bool ShouldConsumePowerPoolOnStartFire() { }

simulated function bool ShouldConsumePowerPoolAfterFire() { }

state DeviceFiring {}
