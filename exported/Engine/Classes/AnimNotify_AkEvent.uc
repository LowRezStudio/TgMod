class AnimNotify_AkEvent extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() AkEvent AkEvent;
var() bool bFollowActor;
var() bool m_bIgnoreIfMeshHidden;
var() bool m_bIgnoreIfActorHidden;
var() name BoneName;

// Export UAnimNotify_AkEvent::execGetAkEventToPlay(FFrame&, void* const)
native function AkEvent GetAkEventToPlay(SkeletalMeshComponent skel);

defaultproperties
{
    bFollowActor=true
    m_bIgnoreIfActorHidden=true
}