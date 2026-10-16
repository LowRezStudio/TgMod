class TgSoundGroup extends Object
    native(FX)
    config(Engine);

enum eTG_SOUNDS {
    TGS_FOOTSTEP,  // 0
    TGS_DODGE,  // 1
    TGS_JUMP,  // 2
    TGS_LAND,  // 3
    TGS_DOUBLEJUMP,  // 4
    TGS_DOUBLELAND,  // 5
    TGS_DYING,  // 6
    TGS_HIT,  // 7
};

struct FootstepSoundInfo {
    var name MaterialType;
    var SoundCue Sound;
    structdefaultproperties {}
};

var const array<SoundCue> c_SoundCues;
var const array<FootstepSoundInfo> c_FootstepSounds;

function PlaySound(TgSoundGroup.eTG_SOUNDS eSound, Pawn P) { }

function PlayFootStepSound(Pawn P, int FootDown, name MaterialType) { }
