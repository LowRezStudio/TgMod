class TgAnimNotify_AkEvent extends AnimNotify_AkEvent
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

struct native PSE_SkinAk
{
    var() int nSkinId;
    var() AkEvent AkEvent;

    structdefaultproperties
    {
        nSkinId=0
        AkEvent=none
    }
};

var() array<PSE_SkinAk> m_SkinOverrideList;

// Export UTgAnimNotify_AkEvent::execGetAkEventToPlay(FFrame&, void* const)
native function AkEvent GetAkEventToPlay(SkeletalMeshComponent skel);
