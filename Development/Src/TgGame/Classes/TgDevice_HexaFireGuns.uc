class TgDevice_HexaFireGuns extends TgDevice_QuadWield
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Ruckus m_CachedRuckusOwner;

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController) { }

simulated function bool InterceptRightMousePressed(TgPlayerController TgController) { }

simulated function bool InterceptRightMouseReleased(TgPlayerController TgController) { }

simulated function bool HasCachedRuckusOwner() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

state DeviceFiring {}

defaultproperties
{
    m_vProjectileSpawnOffset3=(X=5.0000000,Y=2.0000000,Z=11.0000000)
    m_vProjectileSpawnOffset4=(X=5.0000000,Y=-2.0000000,Z=11.0000000)
    m_nWeaponFireNumber=1
    m_vProjectileSpawnOffset2=(X=5.0000000,Y=-6.0000000,Z=5.0000000)
    m_vProjectileSpawnOffset=(X=5.0000000,Y=6.0000000,Z=5.0000000)
}
