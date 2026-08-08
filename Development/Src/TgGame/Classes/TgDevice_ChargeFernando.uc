class TgDevice_ChargeFernando extends TgDevice_Charge
    hidecategories(Navigation)
    config(Engine);

var float m_fCooldownReduction;

simulated event bool CanBeCanceled() { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }
