class AnimNotify_Sound extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() SoundCue SoundCue;
var() bool bFollowActor;
var() bool bIgnoreIfMeshHidden;
var() bool bIgnoreIfActorHidden;
var() name BoneName;
var() float PercentToPlay;
var() float VolumeMultiplier;
var() float PitchMultiplier;

// Export UAnimNotify_Sound::execGetSoundCueToPlay(FFrame&, void* const)
native function SoundCue GetSoundCueToPlay(SkeletalMeshComponent skel);

defaultproperties
{
    bFollowActor=true
    bIgnoreIfActorHidden=true
    PercentToPlay=1.0000000
    VolumeMultiplier=1.0000000
    PitchMultiplier=1.0000000
    ShouldDeferIssue=true
}