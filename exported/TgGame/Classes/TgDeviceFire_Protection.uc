class TgDeviceFire_Protection extends TgDeviceFire
    native(ChampGauntlet);

// Export UTgDeviceFire_Protection::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

defaultproperties
{
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=7075
    m_vActorEncroachmentBaseScale=(X=16.0000000,Y=16.0000000,Z=16.0000000)
}