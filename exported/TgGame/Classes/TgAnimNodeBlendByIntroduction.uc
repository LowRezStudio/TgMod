class TgAnimNodeBlendByIntroduction extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var bool m_bIsRelevant;

// Export UTgAnimNodeBlendByIntroduction::execPrepareIntroduction(FFrame&, void* const)
native function PrepareIntroduction();

// Export UTgAnimNodeBlendByIntroduction::execPlayIntroduction(FFrame&, void* const)
native function PlayIntroduction();

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}