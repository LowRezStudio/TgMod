class TgAnimBlendByEmote extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var name nmEmotePrefix;
var name mnEmoteMovingSuffix;
var name nmEmoteFullMovingSuffix;
var() bool bForceTreatAsMovingEmoteNode;
var array<TgAnimNodeEmoteSequence> EmoteSequenceChildren;
var array<AnimNodeBlendPerBone> PerBoneChildren;
var array<AnimNodeBlendList> FullMovingBlendLists;

// Export UTgAnimBlendByEmote::execPlayEmote(FFrame&, void* const)
native function float PlayEmote(TgPawn.EEmote Emote);

// Export UTgAnimBlendByEmote::execCancelEmote(FFrame&, void* const)
native function CancelEmote(optional bool bNoBlend);

// Export UTgAnimBlendByEmote::execIsFullBody(FFrame&, void* const)
native function bool IsFullBody();

defaultproperties
{
    nmEmotePrefix="EMOTE_"
    mnEmoteMovingSuffix="_Moving"
    nmEmoteFullMovingSuffix="_FullMoving"
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}