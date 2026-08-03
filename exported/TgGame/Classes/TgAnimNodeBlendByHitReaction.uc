class TgAnimNodeBlendByHitReaction extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

// Export UTgAnimNodeBlendByHitReaction::execOnMinorHit(FFrame&, void* const)
native function OnMinorHit(Vector DirectionFromHit);

// Export UTgAnimNodeBlendByHitReaction::execOnMajorHit(FFrame&, void* const)
native function OnMajorHit(Vector DirectionFromHit);

defaultproperties
{
    bPlayActiveChild=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}