class TgDevice_WarpStep extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var bool m_bRolledBackward;

simulated event bool ShouldCooldownAfterFire() { }

simulated function bool IsUltActive() { }

simulated function UpdateDesiredFireMode() { }

simulated function Rotator GetChargeDirection() { }

simulated function FireAmmunition() { }

defaultproperties
{
    m_IndividualOffhandCooldownTime=0.3000000
}
