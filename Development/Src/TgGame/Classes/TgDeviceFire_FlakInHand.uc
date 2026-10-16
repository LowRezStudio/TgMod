class TgDeviceFire_FlakInHand extends TgDeviceFire
    native(ChampFlak)
    config(Engine);

var int m_BaseKnockback;

native function AddEffectiveRangeReduction(out ImpactInfo Impact, Actor DamageInstigator, Vector OriginLocation, optional bool bUseRadius=false);  // Export UTgDeviceFire_FlakInHand::execAddEffectiveRangeReduction(FFrame&, void* const)

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator) { }

defaultproperties
{
    m_bUseAccurateEncroachment=true
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=7948
    m_vActorEncroachmentBaseScale=(X=13.5000000,Y=30.0000000,Z=20.0000000)
    m_GameplayCurves=TgGameplayCurves'DeviceInhand'
}
