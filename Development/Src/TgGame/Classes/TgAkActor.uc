class TgAkActor extends Actor
    native
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool m_bCanCheckOcclusion;

native function float CheckOcclusion();  // Export UTgAkActor::execCheckOcclusion(FFrame&, void* const)

defaultproperties
{
    m_bCanCheckOcclusion=true
    m_bComplexOccluder=true
    LifeSpan=2.0000000
    m_fMaxDistForOcclusionPathfinding=1000.0000000
}
