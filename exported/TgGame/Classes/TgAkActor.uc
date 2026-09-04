class TgAkActor extends Actor
    native
    notplaceable
    hidecategories(Navigation);

var bool m_bCanCheckOcclusion;

// Export UTgAkActor::execCheckOcclusion(FFrame&, void* const)
native function float CheckOcclusion();

defaultproperties
{
    m_bCanCheckOcclusion=true
    m_bComplexOccluder=true
    LifeSpan=2.0000000
    m_fMaxDistForOcclusionPathfinding=1000.0000000
}