class TgDeviceFire_LazarusInhand extends TgDeviceFire
    native(ChampLazarus);

// Export UTgDeviceFire_LazarusInhand::execIgnoreTargetForBlocking(FFrame&, void* const)
native function bool IgnoreTargetForBlocking(Actor Target);

defaultproperties
{
    m_bUseTargetingEncroachmentActor=true
    m_bScaleEncroachmentWithRangeMod=true
    m_nTargetingEncroachmentActorOverride=7075
    m_vActorEncroachmentBaseScale=(X=1.0000000,Y=1.5000000,Z=1.0000000)
}