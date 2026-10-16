class AnimNotify_PlayParticleEffect extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() ParticleSystem PSTemplate;
var() bool bIsExtremeContent;
var() bool bAttach;
var() editoronly bool bPreview;
var() bool bSkipIfOwnerIsHidden;
var() bool ShouldDilateTimeByPlayRate;
var() bool m_bReuse;
var() ParticleSystem PSNonExtremeContentTemplate;
var() name SocketName;
var() name BoneName;
var() name BoneSocketModuleActorName;
var() float TimeDilationFactor;

// Export UAnimNotify_PlayParticleEffect::execGetParticleSystemToPlay(FFrame&, void* const)
native function ParticleSystem GetParticleSystemToPlay(SkeletalMeshComponent skel);

// Export UAnimNotify_PlayParticleEffect::execGetParticleChannels(FFrame&, void* const)
native function ParticleChannelContainer GetParticleChannels(SkeletalMeshComponent skel);

defaultproperties
{
    bSkipIfOwnerIsHidden=true
    BoneSocketModuleActorName="BoneSocketActor"
    TimeDilationFactor=1.0000000
    ShouldDeferIssue=true
}