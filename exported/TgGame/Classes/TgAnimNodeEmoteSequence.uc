class TgAnimNodeEmoteSequence extends AnimNodeSequenceBlendBase
    native(Anim)
    hidecategories(Object,Object,Object);

var TgPawn.EEmote ActiveEmote;
var() float BlendSpeed;
var bool InterpWeights;

// Export UTgAnimNodeEmoteSequence::execSetActiveEmote(FFrame&, void* const)
native function bool SetActiveEmote(name FullBody, name Moving, TgPawn.EEmote Emote, optional bool bResetSynchGroup = true);

defaultproperties
{
    BlendSpeed=4.0000000
    Anims=/* Array type was not detected. */
    m_bIgnoreBlendBySpeedScaling=true
}