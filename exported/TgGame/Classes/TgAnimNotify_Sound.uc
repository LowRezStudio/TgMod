class TgAnimNotify_Sound extends AnimNotify_Sound
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

struct native PSE_Skin
{
    var() int nSkinId;
    var() SoundCue SoundCue;

    structdefaultproperties
    {
        nSkinId=0
        SoundCue=none
    }
};

var() array<PSE_Skin> m_SkinOverrideList;

// Export UTgAnimNotify_Sound::execGetSoundCueToPlay(FFrame&, void* const)
native function SoundCue GetSoundCueToPlay(SkeletalMeshComponent skel);
