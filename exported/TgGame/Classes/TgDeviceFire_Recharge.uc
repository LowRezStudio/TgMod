class TgDeviceFire_Recharge extends TgDeviceFire
    native(ChampGauntlet);

var float s_fLastNoShieldFXPlayTimestamp;
var float s_fTimeBetweenNoShieldFX;

// Export UTgDeviceFire_Recharge::execIsValidTarget(FFrame&, void* const)
native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType = 0, optional bool bIgnoreHealth, optional bool bInvertTeam);

// Export UTgDeviceFire_Recharge::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

// Export UTgDeviceFire_Recharge::execSpecialShieldDestroyed(FFrame&, void* const)
native function SpecialShieldDestroyed();

defaultproperties
{
    s_fTimeBetweenNoShieldFX=4.0000000
    m_bUseAccurateEncroachment=true
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=7073
    m_vActorEncroachmentBaseScale=(X=16.0000000,Y=16.0000000,Z=16.0000000)
}