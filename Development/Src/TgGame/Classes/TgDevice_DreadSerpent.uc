class TgDevice_DreadSerpent extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var bool s_bQueueVoodooDeploy;

simulated function bool TryDeployVoodoo() { }

simulated function UpdateActiveProjectiles(optional TgProjectile Proj) { }

reliable server event ServerDeployVoodoo() { }

reliable server event InterruptFiring() { }

reliable client simulated event ClientInterrupt() { }

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptSlotPressed(TgPlayerController TgController) { }

simulated function float GetLockoutExtensionTime() { }

state DeviceFiring {}
