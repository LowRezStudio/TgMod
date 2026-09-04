class AnimNotify_PlayFaceFXAnim extends AnimNotify_Scripted
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() FaceFXAnimSet FaceFXAnimSetRef;
var() string GroupName;
var() string AnimName;
var() SoundCue SoundCueToPlay;
var() AkEvent AkEventToPlay;
var() bool bOverridePlayingAnim;
var() float PlayFrequency;

event Notify(Actor Owner, AnimNodeSequence AnimSeqInstigator)
{
    // End:0x28
    if(PlayFrequency < 1.0000000)
    {
        // End:0x25
        if(FRand() > PlayFrequency)
        {
            return;
        }        
    }
    else
    {
        // End:0x3B
        if(PlayFrequency > 1.0000000)
        {
        }
    }
    // End:0xF1
    if(Owner != none)
    {
        // End:0xF1
        if(Owner.CanActorPlayFaceFXAnim())
        {
            // End:0xF1
            if(bOverridePlayingAnim || !Owner.IsActorPlayingFaceFXAnim())
            {
                // End:0xF1
                if(Owner.PlayActorFaceFXAnim(FaceFXAnimSetRef, GroupName, AnimName, SoundCueToPlay, AkEventToPlay) == false)
                {
                }
            }
        }
    }
    //return;    
}

defaultproperties
{
    bOverridePlayingAnim=true
    PlayFrequency=1.0000000
}