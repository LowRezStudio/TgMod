class TgDeviceFire_GauntletInhand extends TgDeviceFire
    native(ChampGauntlet);

var TgPawn_Gauntlet m_CachedGauntlet;
var const float m_fLockOnScale;

// Export UTgDeviceFire_GauntletInhand::execIsValidTarget(FFrame&, void* const)
native function bool IsValidTarget(Actor P, optional TgDeviceFire.DeviceTargeterType eTargeterType = 0, optional bool bIgnoreHealth, optional bool bInvertTeam);

defaultproperties
{
    m_fLockOnScale=1.1000000
    m_bUseAccurateEncroachment=true
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=7073
    m_vActorEncroachmentBaseScale=(X=16.0000000,Y=16.0000000,Z=16.0000000)
}