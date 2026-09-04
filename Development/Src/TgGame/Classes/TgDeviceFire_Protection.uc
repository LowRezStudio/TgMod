class TgDeviceFire_Protection extends TgDeviceFire
    native(ChampGauntlet)
    config(Engine);

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire_Protection::execIgnoreTargetForBlocking(FFrame&, void* const)

defaultproperties
{
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=7075
    m_vActorEncroachmentBaseScale=(X=16.0000000,Y=16.0000000,Z=16.0000000)
}
