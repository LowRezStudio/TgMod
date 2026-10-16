class TgAnimNodeBlendByIntroduction extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var bool m_bIsRelevant;

native function PrepareIntroduction();  // Export UTgAnimNodeBlendByIntroduction::execPrepareIntroduction(FFrame&, void* const)

native function PlayIntroduction();  // Export UTgAnimNodeBlendByIntroduction::execPlayIntroduction(FFrame&, void* const)

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
