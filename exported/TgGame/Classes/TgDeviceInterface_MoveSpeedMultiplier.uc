interface TgDeviceInterface_MoveSpeedMultiplier extends Interface
    abstract
    native(Devices);

// Export UTgDeviceInterface_MoveSpeedMultiplier::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();
