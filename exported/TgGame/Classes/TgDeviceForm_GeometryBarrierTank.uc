class TgDeviceForm_GeometryBarrierTank extends TgDeviceForm
    native(ChampBarrierTank);

// Export UTgDeviceForm_GeometryBarrierTank::execUpdateTargetingModeLocation(FFrame&, void* const)
native function UpdateTargetingModeLocation(Vector NewLocation, Rotator NewRotation, optional float DistanceScale = 1.0000000);

// Export UTgDeviceForm_GeometryBarrierTank::execUpdateTargetingModeStatusForFX(FFrame&, void* const)
native function UpdateTargetingModeStatusForFX(TgSpecialFx Fx, TgDevice.ETargetingModeStatus Status, const out AimData Aim);
