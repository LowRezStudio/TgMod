class TgAnimNodeBlendByHitReaction extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

native function OnMinorHit(Vector DirectionFromHit);  // Export UTgAnimNodeBlendByHitReaction::execOnMinorHit(FFrame&, void* const)

native function OnMajorHit(Vector DirectionFromHit);  // Export UTgAnimNodeBlendByHitReaction::execOnMajorHit(FFrame&, void* const)

defaultproperties
{
    bPlayActiveChild=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
