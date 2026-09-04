class TgAnimNotify_AkEvent extends AnimNotify_AkEvent
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct PSE_SkinAk {
    var () int nSkinId;
    var () AkEvent AkEvent;
    structdefaultproperties {}
};

var () array<PSE_SkinAk> m_SkinOverrideList;

native function AkEvent GetAkEventToPlay(SkeletalMeshComponent skel);  // Export UTgAnimNotify_AkEvent::execGetAkEventToPlay(FFrame&, void* const)
