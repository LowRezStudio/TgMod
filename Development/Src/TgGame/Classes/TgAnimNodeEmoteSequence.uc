class TgAnimNodeEmoteSequence extends AnimNodeSequenceBlendBase
    native(Anim)
    hidecategories(Object,Object,Object)
    config(Engine)
    dependson(TgPawn);

var TgPawn.EEmote ActiveEmote;
var () float BlendSpeed;
var bool InterpWeights;

native function bool SetActiveEmote(name FullBody, name Moving, TgPawn.EEmote Emote, optional bool bResetSynchGroup=true);  // Export UTgAnimNodeEmoteSequence::execSetActiveEmote(FFrame&, void* const)

defaultproperties
{
    BlendSpeed=4.0000000
    Anims=/* Array type was not detected. */
    m_bIgnoreBlendBySpeedScaling=true
}
