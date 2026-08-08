class TgAnimBlendByEmote extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgPawn);

var name nmEmotePrefix;
var name mnEmoteMovingSuffix;
var name nmEmoteFullMovingSuffix;
var () bool bForceTreatAsMovingEmoteNode;
var array<TgAnimNodeEmoteSequence> EmoteSequenceChildren;
var array<AnimNodeBlendPerBone> PerBoneChildren;
var array<AnimNodeBlendList> FullMovingBlendLists;

native function float PlayEmote(TgPawn.EEmote Emote);  // Export UTgAnimBlendByEmote::execPlayEmote(FFrame&, void* const)

native function CancelEmote(optional bool bNoBlend);  // Export UTgAnimBlendByEmote::execCancelEmote(FFrame&, void* const)

native function bool IsFullBody();  // Export UTgAnimBlendByEmote::execIsFullBody(FFrame&, void* const)

defaultproperties
{
    nmEmotePrefix="EMOTE_"
    mnEmoteMovingSuffix="_Moving"
    nmEmoteFullMovingSuffix="_FullMoving"
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
