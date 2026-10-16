class TgDeviceFire_AstralMark extends TgDeviceFire
    native(ChampAstro)
    config(Engine);

var float m_InitialLifetime;
var float m_OverflowTime;
var float m_BaseLifetime;

native function bool IgnoreTargetForBlocking(Actor Target);  // Export UTgDeviceFire_AstralMark::execIgnoreTargetForBlocking(FFrame&, void* const)

event bool ApplyHit(ImpactInfo Impact, Actor DamageInstigator) { }

defaultproperties
{
    m_bUseTargetingEncroachmentActor=true
    m_bScaleEncroachmentWithRangeMod=true
    m_bEnchroachmentFireLOSCheck=false
    m_nTargetingEncroachmentActorOverride=7075
    m_vActorEncroachmentBaseScale=(X=9.0000000,Y=9.0000000,Z=9.0000000)
}
