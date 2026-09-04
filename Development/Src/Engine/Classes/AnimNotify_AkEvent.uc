class AnimNotify_AkEvent extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

var () AkEvent AkEvent;
var () bool bFollowActor;
var () bool m_bIgnoreIfMeshHidden;
var () bool m_bIgnoreIfActorHidden;
var () name BoneName;

native function AkEvent GetAkEventToPlay(SkeletalMeshComponent skel);  // Export UAnimNotify_AkEvent::execGetAkEventToPlay(FFrame&, void* const)

defaultproperties
{
    bFollowActor=true
    m_bIgnoreIfActorHidden=true
}
