class TgDevice_TurtlePowerSmash extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event OnLinkDevice(TgPawn TgP) { }

simulated event OnUnlinkDevice(TgPawn TgP) { }

simulated event bool PlayHitReactionOverride() { }
