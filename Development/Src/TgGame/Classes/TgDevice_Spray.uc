class TgDevice_Spray extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var bool m_bMissedSpray;

simulated event bool ShouldCooldownAfterFire() { }

function AuthStartCooldown(optional int nMode=-1, optional float fCooldownTimeOverride=-1.0000000) { }

simulated function PlayClientFireFx(Vector HitLocation, int nSocketIndex, bool bSuccessfulHit, float fRefireTime) { }

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact) { }

defaultproperties
{
    m_bStartFireShouldEnterCombat=false
    m_bFireShouldEnterCombat=false
}
