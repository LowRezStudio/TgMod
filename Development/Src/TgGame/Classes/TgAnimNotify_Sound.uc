class TgAnimNotify_Sound extends AnimNotify_Sound
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct PSE_Skin {
    var () int nSkinId;
    var () SoundCue SoundCue;
    structdefaultproperties {}
};

var () array<PSE_Skin> m_SkinOverrideList;

native function SoundCue GetSoundCueToPlay(SkeletalMeshComponent skel);  // Export UTgAnimNotify_Sound::execGetSoundCueToPlay(FFrame&, void* const)
