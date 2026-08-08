class AnimNotify_PlayFaceFXAnim extends AnimNotify_Scripted
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

var () FaceFXAnimSet FaceFXAnimSetRef;
var () string GroupName;
var () string AnimName;
var () SoundCue SoundCueToPlay;
var () AkEvent AkEventToPlay;
var () bool bOverridePlayingAnim;
var () float PlayFrequency;

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator) { }

defaultproperties
{
    bOverridePlayingAnim=true
    PlayFrequency=1.0000000
}
