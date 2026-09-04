class TgSoundGroup extends Object
    native(FX);

enum eTG_SOUNDS
{
    TGS_FOOTSTEP,                   // 0
    TGS_DODGE,                      // 1
    TGS_JUMP,                       // 2
    TGS_LAND,                       // 3
    TGS_DOUBLEJUMP,                 // 4
    TGS_DOUBLELAND,                 // 5
    TGS_DYING,                      // 6
    TGS_HIT,                        // 7
    TGS_MAX                         // 8
};

struct native FootstepSoundInfo
{
    var name MaterialType;
    var SoundCue Sound;

    structdefaultproperties
    {
        MaterialType="None"
        Sound=none
    }
};

var const array<SoundCue> c_SoundCues;
var const array<FootstepSoundInfo> c_FootstepSounds;

function PlaySound(TgSoundGroup.eTG_SOUNDS eSound, Pawn P)
{
    // End:0x84
    if((int(eSound) >= int(0)) && int(eSound) < c_SoundCues.Length)
    {
        // End:0x84
        if(c_SoundCues[int(eSound)] != none)
        {
            P.super(TgSoundGroup).PlaySound(c_SoundCues[int(eSound)], false, true);
        }
    }
    //return;    
}

function PlayFootStepSound(Pawn P, int FootDown, name MaterialType)
{
    local int I;

    I = c_FootstepSounds.Find('MaterialType', MaterialType);
    // End:0x54
    if(I == -1)
    {
        PlaySound(0, P);        
    }
    else
    {
        P.PlaySound(c_FootstepSounds[I].Sound, false, true);
    }
    //return;    
}
