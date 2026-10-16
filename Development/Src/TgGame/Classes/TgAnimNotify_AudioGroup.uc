class TgAnimNotify_AudioGroup extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

enum TG_MESH_SOURCE {
    TG_MESH_SOURCE_PAWN,  // 0
    TG_MESH_SOURCE_IN_HAND_DEVICE,  // 1
};

var () SoundCue c_PreviewSound;
var () name c_SoundCueName;
var () TgAnimNotify_AudioGroup.TG_MESH_SOURCE c_eMeshSource;
